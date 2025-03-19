package com.example.app_bee;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.engine.FlutterEngine;
import com.jlibrosa.audio.JLibrosa;
import com.jlibrosa.audio.wavFile.WavFile;
import com.jlibrosa.audio.wavFile.WavFileException;
import com.jlibrosa.audio.exception.FileFormatNotSupportedException;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.audio/audio_processor";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            System.out.println("Deintrooooooooooooooooooooooooo");
                            if (call.method.equals("extractMFCCs")) {
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
                            } else {
                                result.notImplemented();
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
