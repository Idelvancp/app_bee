package com.example.app_bee;

public class StandardScaler{

    private static float[] calculateMean(float[][] data) {
        System.out.println("Normalizando dodos dos MFFCs");
        int rows = data.length;
        int cols = data[0].length;
        float[] mean = new float[cols];

        for (int j = 0; j < cols; j++) {
            float sum = 0;
            for (int i = 0; i < rows; i++) {
                sum += data[i][j];
            }
            mean[j] = sum / rows;
        }
        return mean;
    }

    private static float[] calculateStdDev(float[][] data, float[] mean) {
        int rows = data.length;
        int cols = data[0].length;
        float[] stdDev = new float[cols];

        for (int j = 0; j < cols; j++) {
            float sum = 0;
            for (int i = 0; i < rows; i++) {
                sum += Math.pow(data[i][j] - mean[j], 2);
            }
            stdDev[j] = (float) Math.sqrt(sum / rows);
        }
        return stdDev;
    }

    public static float[][] normalizeMFCC(float[][] mfccMatrix) {
        float[] mean = calculateMean(mfccMatrix);
        float[] stdDev = calculateStdDev(mfccMatrix, mean);

        int rows = mfccMatrix.length;
        int cols = mfccMatrix[0].length;
        float[][] normalizedMFCCs = new float[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                normalizedMFCCs[i][j] = (stdDev[j] != 0) ? (mfccMatrix[i][j] - mean[j]) / stdDev[j] : 0;
            }
        }
        return normalizedMFCCs;
    }
}
