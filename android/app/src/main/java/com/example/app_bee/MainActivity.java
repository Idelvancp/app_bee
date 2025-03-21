    package com.example.app_bee;

    import android.util.Log;
    import androidx.annotation.NonNull;
    import io.flutter.embedding.android.FlutterActivity;
    import io.flutter.embedding.engine.FlutterEngine;
    import io.flutter.plugin.common.MethodChannel;
    import com.jlibrosa.audio.JLibrosa;
    import com.jlibrosa.audio.wavFile.WavFile;
    import com.jlibrosa.audio.wavFile.WavFileException;
    import com.jlibrosa.audio.exception.FileFormatNotSupportedException;

    import java.io.BufferedWriter;
    import java.io.File;
    import java.io.FileWriter;
    import java.nio.FloatBuffer;
    import java.io.IOException;
    import java.io.InputStream;
    import java.io.InputStreamReader;
    import java.util.ArrayList;
    import java.util.List;
    import java.util.Map;

    import ai.onnxruntime.OnnxTensor;
    import ai.onnxruntime.OrtEnvironment;
    import ai.onnxruntime.OrtSession;
    import ai.onnxruntime.OrtSession.Result;

    import io.flutter.embedding.android.FlutterActivity;
    import io.flutter.embedding.engine.FlutterEngine;
    import io.flutter.plugin.common.MethodChannel;
    import androidx.annotation.NonNull;
    import android.util.Log;

    import java.io.BufferedReader;
    import java.io.InputStream;
    import java.io.InputStreamReader;
    import java.io.FileInputStream;
    import java.nio.FloatBuffer;
    import java.util.ArrayList;
    import java.util.List;
    import java.util.Map;

    import ai.onnxruntime.OnnxTensor;
    import ai.onnxruntime.OrtEnvironment;
    import ai.onnxruntime.OrtSession;
    import ai.onnxruntime.OrtSession.Result;
    
    public class MainActivity extends FlutterActivity {
        private static final String CHANNEL = "com.example.audio/audio_processor";

        @Override
        public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
            super.configureFlutterEngine(flutterEngine);

            new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                    .setMethodCallHandler(
                            (call, result) -> {
                                System.out.println("Deintrooooooooooooooooooooooooo");
                                switch (call.method) {
                                    case "extractMFCCs":

                                //if (call.method.equals("extractMFCCs")) {
                                    String audioFilePath = call.argument("path");
                                    //String audioFilePath = "/storage/emulated/0/Android/data/com.example.app_bee/files/rl.wav";


                                    try {
                                        JLibrosa jLibrosa = new JLibrosa();
                                        File sourceFile = new File(audioFilePath);
                                        WavFile wavFile = WavFile.openWavFile(sourceFile);
                                        int sampleRate = (int) wavFile.getSampleRate();
                                        int numFrames = (int) wavFile.getNumFrames();
                                        int numChannels = wavFile.getNumChannels();
                                        wavFile.close();

                                        float audioFeatureValues [] = jLibrosa.loadAndRead(audioFilePath, sampleRate, 20);

                                        // Definir parâmetros de frame e sobreposição
                                        int nMFCC = 13; // Número de coeficientes MFCC, conforme desejado
                                        int n_fft = (int) Math.ceil(sampleRate * 0.025);
                                        int hop_length = (int) Math.ceil(sampleRate * 0.0125);
                                        float[][] mfccValues = jLibrosa.generateMFCCFeatures(audioFeatureValues, sampleRate, nMFCC, 400, 40, 200);

                                        // Transpor a matriz para que as linhas representem os frames e as colunas os coeficientes
                                        float[][] transposedMatrix = new float[mfccValues[0].length][mfccValues.length];

                                        for (int i = 0; i < mfccValues.length; i++) {
                                            for (int j = 0; j < mfccValues[i].length; j++) {
                                                transposedMatrix[j][i] = mfccValues[i][j];
                                            }
                                        }


                                        System.out.println(".......");
                                        System.out.println("Size of MFCC Feature Values: (" + mfccValues.length + " , " + mfccValues[0].length + " )");

                                        for(int i=0;i<1;i++) {
                                            for(int j=0;j<12;j++) {
                                                System.out.printf("%.6f%n", transposedMatrix[i][j]);
                                            }
                                        }
                                        String directoryPath = sourceFile.getParent();
                                        saveMFCCToCSV(transposedMatrix, directoryPath, "mfcc_segment.csv");

                                        result.success("MFCCs saved to CSV successfully!");

                                    } catch (IOException | WavFileException | FileFormatNotSupportedException e) {
                                        e.printStackTrace();
                                        result.error("IOException", "Erro ao processar o arquivo WAV", e.getMessage());
                                    }


                               // } else {
                               //     result.notImplemented();
                               // }
                                        break;
                                    case "mlpClassifier":
                                        try {
                                            // Configurar o ambiente ONNX
                                            OrtEnvironment ortEnvironment = OrtEnvironment.getEnvironment();
                                            InputStream modelStream = getResources().openRawResource(R.raw.mpl_model);
                                            byte[] modelBytes = new byte[modelStream.available()];
                                            modelStream.read(modelBytes);
                                            modelStream.close();
                                            OrtSession ortSession = ortEnvironment.createSession(modelBytes);

                                            // Ler os dados do arquivo CSV
                                            // Caminho do arquivo salvo na pasta de arquivos do app
                                            String csvFilePath = getExternalFilesDir(null) + "/mfcc_segment.csv";
                                            File csvFile = new File(csvFilePath);
                                            if (!csvFile.exists()) {
                                                result.error("FILE_NOT_FOUND", "O arquivo mfcc_segment.csv não foi encontrado", null);
                                                return;
                                            }
                                            InputStream csvStream = new FileInputStream(csvFile);
                                            BufferedReader reader = new BufferedReader(new InputStreamReader(csvStream));
                                            List<float[]> inputDataList = new ArrayList<>();
                                            List<Integer> trueLabels = new ArrayList<>();

                                            String line;
                                            while ((line = reader.readLine()) != null) {
                                                String[] values = line.split(",");
                                                float[] sample = new float[values.length - 1];
                                                for (int i = 0; i < values.length - 1; i++) {
                                                    sample[i] = Float.parseFloat(values[i]);
                                                }
                                                inputDataList.add(sample);
                                                trueLabels.add(Integer.parseInt(values[values.length - 1]));
                                            }
                                            reader.close();

                                            // Preparar os dados para o modelo com processamento em batches
                                            int numSamples = inputDataList.size();
                                            int numFeatures = inputDataList.get(0).length;
                                            int batchSize = 64; // Tamanho do batch

                                            List<Long> predictionsList = new ArrayList<>();
                                            for (int start = 0; start < numSamples; start += batchSize) {
                                                int end = Math.min(start + batchSize, numSamples);
                                                int currentBatchSize = end - start;

                                                float[] batchData = new float[currentBatchSize * numFeatures];
                                                for (int i = 0; i < currentBatchSize; i++) {
                                                    System.arraycopy(inputDataList.get(start + i), 0, batchData, i * numFeatures, numFeatures);
                                                }

                                                FloatBuffer inputBuffer = FloatBuffer.allocate(batchData.length);
                                                inputBuffer.put(batchData);
                                                inputBuffer.rewind();

                                                OnnxTensor tensor = OnnxTensor.createTensor(ortEnvironment, inputBuffer, new long[]{currentBatchSize, numFeatures});

                                                // Fazer a predição para o batch atual
                                                String inputName = ortSession.getInputNames().iterator().next();
                                                Result output = ortSession.run(Map.of(inputName, tensor));

                                                long[] batchPredictions = (long[]) output.get(0).getValue();
                                                for (long pred : batchPredictions) {
                                                    predictionsList.add(pred);
                                                }

                                                tensor.close();
                                                output.close();

                                                // Extração dos valores previstos
                                                long[] predictions = predictionsList.stream().mapToLong(Long::longValue).toArray();
                                                System.out.println("Predições: " + java.util.Arrays.toString(predictions));

                                                // Calcular métricas de avaliação
                                                int tp = 0, fp = 0, fn = 0, tn = 0;
                                                for (int i = 0; i < predictions.length; i++) {
                                                    int actual = trueLabels.get(i);
                                                    int predicted = (int) predictions[i];

                                                    if (predicted == 1 && actual == 1) tp++;
                                                    else if (predicted == 1 && actual == 0) fp++;
                                                    else if (predicted == 0 && actual == 1) fn++;
                                                    else if (predicted == 0 && actual == 0) tn++;
                                                }

                                                double precision = tp / (double) (tp + fp);
                                                double recall = tp / (double) (tp + fn);
                                                double f1Score = 2 * (precision * recall) / (precision + recall);
                                                double accuracy = (tp + tn) / (double) (tp + fp + fn + tn);

                                                System.out.println("Acurácia: " + accuracy);
                                                System.out.println("Precisão: " + precision);
                                                System.out.println("Recall: " + recall);
                                                System.out.println("F1-Score: " + f1Score);

                                                // Imprimir o número de amostras classificadas
                                                System.out.println("Quantidade de amostras classificadas: " + numSamples);

                                                // Liberar os recursos do tensor, sessão e ambiente
                                                ortSession.close();
                                                ortEnvironment.close();

                                                // Retornar o resultado
                                                result.success("Amostras classificadas: " + numSamples
                                                        + ", Acurácia: " + accuracy
                                                        + ", Precisão: " + precision
                                                        + ", Recall: " + recall
                                                        + ", F1-Score: " + f1Score
                                                        + ", TP: " + tp
                                                        + ", FP: " + fp
                                                        + ", FN: " + fn
                                                        + ", TN: " + tn);
                                                break;

                                            }
                                        } catch (Exception e) {
                                            Log.e("MainActivity", "Erro ao executar tarefa", e);
                                            result.error("TASK_ERROR", "Erro ao executar tarefa", e.getMessage());
                                        }
                                    default:
                                        result.notImplemented();
                                        break;
                                }
                            }
                    );
        }

        // Função para extrair um segmento de áudio sem usar seekFrame
        private static float[] extractSegment(WavFile wavFile, int startFrame, int framesPerSegment) throws IOException, WavFileException {
            int numChannels = wavFile.getNumChannels();
            float[] buffer = new float[framesPerSegment * numChannels];
            float[] tempBuffer = new float[numChannels];
            // Ignorar frames até o início do segmento
            for (int i = 0; i < startFrame; i++) {
                wavFile.readFrames(tempBuffer, 1);
            }
            // Ler o segmento desejado
            wavFile.readFrames(buffer, framesPerSegment);
            return buffer;
        }


        private static float[][] calculateMFCCs(float[] audioSegment, int sampleRate, int n_fft, int hop_length) {
            JLibrosa jLibrosa = new JLibrosa();
            int nMFCC = 13; // Número de coeficientes MFCC, conforme desejado

            // Obtém os MFCCs com a função do JLibrosa
            float[][] mfccMatrix = jLibrosa.generateMFCCFeatures(audioSegment, sampleRate, nMFCC, n_fft, 40, hop_length);

            // Transpor a matriz para que as linhas representem os frames e as colunas os coeficientes
            float[][] transposedMatrix = new float[mfccMatrix[0].length][mfccMatrix.length];

            for (int i = 0; i < mfccMatrix.length; i++) {
                for (int j = 0; j < mfccMatrix[i].length; j++) {
                    transposedMatrix[j][i] = mfccMatrix[i][j];
                }
            }

            return transposedMatrix;
        }



        // Função para salvar MFCCs em CSV
        private void saveMFCCToCSV(float[][] mfccMatrix, String directoryPath, String fileName) {
            File csvFile = new File(directoryPath, fileName);
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(csvFile))) {
                for (float[] mfccs : mfccMatrix) {
                    StringBuilder sb = new StringBuilder();
                    for (int i = 0; i < mfccs.length; i++) {
                        sb.append(mfccs[i]);
                        if (i < mfccs.length - 1) {
                            sb.append(",");
                        }
                    }
                    writer.write(sb.toString());
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
