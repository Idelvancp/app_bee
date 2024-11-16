import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioFilterScreen extends StatefulWidget {
  final String filePath; // Adiciona o parâmetro filePath

  AudioFilterScreen({required this.filePath}); // Modifica o construtor

  @override
  _AudioFilterScreenState createState() => _AudioFilterScreenState();
}

class _AudioFilterScreenState extends State<AudioFilterScreen> {
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  String _filterStatus = 'Idle';
  String _filteredAudioPath = '';

  Future<void> _applyAudioFilter() async {
    try {
      // Defina o caminho de saída do arquivo filtrado
      String outputPath = widget.filePath.replaceAll('.wav', '_filtered.wav');

      // Comando FFmpeg para aplicar o filtro passa-banda (600 Hz a 1000 Hz)
      String ffmpegCommand =
          '-y -i ${widget.filePath} -af "bandpass=f=600:w=400" $outputPath';

      // Executar o comando FFmpeg
      int rc = await _flutterFFmpeg.execute(ffmpegCommand);

      if (rc == 0) {
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
    } catch (e) {
      setState(() {
        _filterStatus = "Falha ao aplicar o filtro: '${e.toString()}'";
      });
    }
  }

  // Função para reproduzir o áudio filtrado
  void _playFilteredAudio() async {
    if (_filteredAudioPath.isNotEmpty) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(DeviceFileSource(_filteredAudioPath));
    } else {
      setState(() {
        _filterStatus = 'Nenhum áudio filtrado disponível para reprodução.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtro de Áudio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Status do Filtro: $_filterStatus',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _applyAudioFilter, // Agora o filtro usa o filePath
              child: Text('Aplicar Filtro Passa-Banda'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _playFilteredAudio, // Botão para reproduzir o áudio filtrado
              child: Text('Reproduzir Áudio Filtrado'),
            ),
          ],
        ),
      ),
    );
  }
}
