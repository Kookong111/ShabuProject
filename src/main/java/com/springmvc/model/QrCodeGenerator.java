package com.springmvc.model; // หรือ com.springmvc.util;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

public class QrCodeGenerator {
    
    // URL พื้นฐานของแอปพลิเคชัน (ต้องเปลี่ยนตาม ngrok หรือโดเมนจริง)
    private static final String BASE_URL = "https://subbranchial-triboluminescent-hallie.ngrok-free.dev/Zproject_shabu2/viewmenu";

    /**
     * สร้าง URL เต็มรูปแบบสำหรับการสั่งอาหารของโต๊ะนั้น
     * @param qrToken โทเคนที่ไม่ซ้ำกันของโต๊ะ
     * @return URL เต็ม
     */
    public static String generateQrUrl(String qrToken) {
        return BASE_URL + "?qrToken=" + qrToken;
    }

    /**
     * สร้างภาพ QR Code ในรูปแบบ PNG byte array
     * @param text ข้อความ (URL) ที่จะเข้ารหัส
     * @param width ความกว้างของภาพ
     * @param height ความสูงของภาพ
     * @return byte array ของภาพ PNG
     */
    public static byte[] generateQrCodeImage(String text, int width, int height) throws Exception {
        try (ByteArrayOutputStream os = new ByteArrayOutputStream()) {
            
            // 1. สร้าง BitMatrix จากข้อความ
            QRCodeWriter writer = new QRCodeWriter();
            BitMatrix bitMatrix = writer.encode(text, BarcodeFormat.QR_CODE, width, height);
            
            // 2. แปลง BitMatrix เป็นภาพ PNG และเขียนลง OutputStream
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", os);
            
            return os.toByteArray();
        } catch (IOException ex) {
            ex.printStackTrace();
            throw new Exception("Error generating QR code image.", ex);
        }
    }
}