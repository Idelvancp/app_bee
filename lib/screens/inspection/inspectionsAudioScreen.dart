import 'dart:io' as io;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/models/typeInspection.dart';
import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';
import 'package:intl/intl.dart'; // Importe para formatação de data
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class InspectionAudioScreen extends StatefulWidget {
  const InspectionAudioScreen(
      {Key? key, this.localFileSystem = const LocalFileSystem()})
      : super(key: key); // Usando super para passar o key
  final LocalFileSystem localFileSystem;

  @override
  State<InspectionAudioScreen> createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionAudioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  // final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  String _filterStatus = 'Idle';
  String _filteredAudioPath = '';

  final TextEditingController _dateController =
      TextEditingController(); // Controller para o campo de data
  DateTime? _selectedDateTime; // Variável para armazenar a data selecionada
  AnotherAudioRecorder? _recorder;
  Recording? _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  static const platform = MethodChannel("com.example.audio/audio_processor");

  @override
  void initState() {
    super.initState();
    _init();
  }

  void dispose() {
    _dateController.dispose(); // Dispose do controller de data
    super.dispose();
  }

  void _toPagePopulationData(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Navigator.of(context).pushNamed(
        AppRoutes.INSPECTION_FORM2,
        arguments: _formData,
      );
    }
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
          _dateController.text = dateFormat.format(_selectedDateTime!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspeção Sonora'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GridView(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            children: [],
          ),
          Center(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Para centralizar a coluna verticalmente
              children: [
                _buildText(_currentStatus),
                SizedBox(height: 20), // Espaço entre o texto e o botão
                SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: FloatingActionButton(
                    onPressed: () {
                      switch (_currentStatus) {
                        case RecordingStatus.Initialized:
                          {
                            _start();
                            break;
                          }
                        case RecordingStatus.Recording:
                          {
                            _stop();
                            break;
                          }
                        case RecordingStatus.Paused:
                          {
                            _resume();
                            break;
                          }
                        case RecordingStatus.Stopped:
                          {
                            _init();
                            break;
                          }
                        default:
                          break;
                      }
                    },
                    shape: CircleBorder(),
                    child: Icon(
                      _currentStatus == RecordingStatus.Initialized ||
                              _currentStatus == RecordingStatus.Stopped
                          ? Icons.mic
                          : Icons.stop_circle,
                      size: buttonSize * 0.4, // Ícone proporcional ao botão,
                      color: Colors.white,
                    ),
                    backgroundColor:
                        _currentStatus == RecordingStatus.Initialized ||
                                _currentStatus == RecordingStatus.Stopped
                            ? Colors.teal
                            : Colors.redAccent,
                  ),
                ),
                SizedBox(height: 20), // Espaço entre o texto e o botão
                new Text(
                    "Audio recording duration : ${_current?.duration.toString()}"),

                // Adicionando o novo botão para extrair MFCCs
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _filteredAudioPath.isNotEmpty
                      ? _getMfccs // Chama o método _getMfccs se o caminho do áudio filtrado não estiver vazio
                      : null, // Desabilita o botão se não houver áudio filtrado
                  child: Text("Extrair MFCCs"),
                ),
                SizedBox(height: 20),
                Text(_filterStatus),
              ],
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _init() async {
    try {
      if (await AnotherAudioRecorder.hasPermissions) {
        String customPath = '/another_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = (await getExternalStorageDirectory())!;
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder = AnotherAudioRecorder(customPath,
            audioFormat: AudioFormat.WAV, sampleRate: 48000);

        await _recorder?.initialized;
        // after initialization
        var current = await _recorder?.current(channel: 0);
        print(' Valor de current ${current}');
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current!.status!;
          print(' Valor de currentStatus ${_currentStatus}');
        });
      } else {
        return SnackBar(content: Text("You must accept permissions"));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder?.start();
      var recording = await _recorder?.current(channel: 0);
      setState(() {
        _current = recording;
      });
      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder?.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current!.status!;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await _recorder?.resume();
    setState(() {});
  }

  _pause() async {
    await _recorder?.pause();
    setState(() {});
  }

  _stop() async {
    var result = await _recorder?.stop();
    print("Stop recording: ${result?.path}");
    print("Stop recording: ${result?.duration}");
    File file = widget.localFileSystem.file(result?.path);
    print("File length: ${await file.length()}");
    setState(() {
      _current = result;
      _currentStatus = _current!.status!;
    });
    // Aplica o filtro de áudio após a gravação parar
    await _applyAudioFilter(result!.path!);
  }

  Future<void> _applyAudioFilter(String filePath) async {
    try {
      // Defina o caminho de saída do arquivo filtrado
      String outputPath = filePath.replaceAll('.wav', '_filtered.wav');

      // Comando FFmpeg para aplicar o filtro passa-banda (600 Hz a 1000 Hz)
      //String ffmpegCommand =
      //    '-y -i $filePath -af "bandpass=f=600:w=400" $outputPath';

      // Executar o comando FFmpeg
      // int rc = await _flutterFFmpeg.execute(ffmpegCommand);
      String command =
          "-i $filePath -acodec pcm_s16le -ar 16000 -ac 1 $outputPath";

      FFmpegKit.execute(command).then((session) async {
        final returnCode = await session.getReturnCode();

        if (returnCode?.getValue() == 0) {
          setState(() {
            _filterStatus = 'Filtro aplicado com sucesso!';
            _filteredAudioPath =
                outputPath; // Armazena o caminho do arquivo filtrado
          });
        } else {
          setState(() {
            _filterStatus = 'Erro ao aplicar o filtro!';
          });
        }
      });
    } catch (e) {
      setState(() {
        _filterStatus = "Falha ao aplicar o filtro: '${e.toString()}'";
      });
    }
  }

  Future<void> _getMfccs() async {
    try {
      if (_filteredAudioPath.isNotEmpty) {
        // Passa o caminho do arquivo filtrado como argumento
        final result = await platform.invokeMethod<String>(
          'extractMFCCs',
          {'path': _filteredAudioPath},
        );
        print('MFCCs salvos no CSV com sucesso: $result');
      } else {
        print('Erro: O caminho do arquivo de áudio filtrado está vazio.');
      }
    } on PlatformException catch (e) {
      print('Falha ao extrair MFCCs: ${e.message}');
    }
  }

  Widget _buildText(RecordingStatus status) {
    var text = "";
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          text = 'Iniciar Gravação';
          break;
        }
      case RecordingStatus.Recording:
        {
          text = 'Pause';
          break;
        }
      case RecordingStatus.Paused:
        {
          text = 'Resume';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = 'Gravar Novo Áudio';
          break;
        }
      default:
        break;
    }
    return Text(text, style: TextStyle(color: Colors.black, fontSize: 18));
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    Source source = DeviceFileSource(_current!.path!);
    await audioPlayer.play(source);
  }
}
