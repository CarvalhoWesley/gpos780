package br.com.joelabs.gpos780

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Base64
import android.util.Log
import br.com.gertec.easylayer.printer.*
import java.io.ByteArrayOutputStream

class GPOS780PrinterManager(context: Context) : Printer.Listener {
    private val printer: Printer = Printer.getInstance(context, this)
    private val TAG = "GPOS780Printer"

    /**
     * Imprime texto com formatação
     * @param text Texto a ser impresso
     * @param fontSize Tamanho da fonte (padrão: 30)
     * @param isBold Se o texto deve estar em negrito (padrão: false)
     * @param isUnderscore Se o texto deve estar sublinhado (padrão: false)
     * @param alignment Alinhamento (CENTER, LEFT, RIGHT - padrão: CENTER)
     * @param lineSpacing Espaçamento de linha (padrão: 6)
     */
    fun printText(
        text: String,
        fontSize: Int = 30,
        isBold: Boolean = false,
        isUnderscore: Boolean = false,
        alignment: String = "CENTER",
        lineSpacing: Int = 6
    ) {
        try {
            val textFormat = TextFormat().apply {
                setBold(isBold)
                setUnderscore(isUnderscore)
                setFontSize(fontSize)
                setLineSpacing(lineSpacing)
                setAlignment(parseAlignment(alignment))
            }
            printer.printText(textFormat, text)
            Log.i(TAG, "Texto impresso com sucesso: $text")
        } catch (e: Exception) {
            Log.e(TAG, "Erro ao imprimir texto: ${e.message}", e)
            throw e
        }
    }

    /**
     * Imprime múltiplas linhas de texto
     * @param lines Lista de textos a imprimir
     * @param alignment Alinhamento (CENTER, LEFT, RIGHT - padrão: LEFT)
     */
    fun printMultipleLines(
        lines: List<String>,
        alignment: String = "LEFT"
    ) {
        try {
            lines.forEach { line ->
                val textFormat = TextFormat().apply {
                    setAlignment(parseAlignment(alignment))
                    setFontSize(30)
                }
                printer.printText(textFormat, line)
            }
            Log.i(TAG, "Múltiplas linhas impressas com sucesso")
        } catch (e: Exception) {
            Log.e(TAG, "Erro ao imprimir múltiplas linhas: ${e.message}", e)
            throw e
        }
    }

    /**
     * Imprime uma imagem
     * @param bitmap Bitmap da imagem
     * @param width Largura da imagem (padrão: 400)
     * @param height Altura da imagem (padrão: 100)
     * @param alignment Alinhamento (CENTER, LEFT, RIGHT - padrão: CENTER)
     */
    fun printImage(
        bitmap: Bitmap,
        alignment: String = "LEFT"
    ) {
        try {
            val printConfig = PrintConfig()
            printConfig.setAlignment(parseAlignment(alignment))
            printer.printImage(printConfig, bitmap)
            Log.i(TAG, "Imagem impressa com sucesso")
        } catch (e: PrinterException) {
            Log.e(TAG, "Erro ao imprimir imagem: ${e.message}", e)
            throw e
        }
    }

    /**
     * Imprime uma imagem a partir de um Base64
     * @param base64Image String da imagem em Base64
     * @param width Largura (padrão: 400)
     * @param height Altura (padrão: 100)
     */
    fun printImageFromBase64(
        base64Image: String
    ) {
        try {
            val decodedBytes = Base64.decode(base64Image, Base64.DEFAULT)
            val bitmap = BitmapFactory.decodeByteArray(decodedBytes, 0, decodedBytes.size)
            printImage(bitmap)
        } catch (e: Exception) {
            Log.e(TAG, "Erro ao imprimir imagem Base64: ${e.message}", e)
            throw e
        }
    }

    /**
     * Imprime uma imagem a partir de bytes (Uint8List do Dart)
     * @param bytes ByteArray da imagem
     * @param width Largura (padrão: 400)
     * @param height Altura (padrão: 100)
     */
    fun printImageFromBytes(
        bytes: ByteArray
    ) {
        try {
            val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
            printImage(bitmap)
        } catch (e: Exception) {
            Log.e(TAG, "Erro ao imprimir imagem de bytes: ${e.message}", e)
            throw e
        }
    }

    /**
     * Imprime HTML
     * @param htmlContent Conteúdo HTML a imprimir
     * @param context Context da aplicação
     */
    fun printHtml(
        htmlContent: String,
        context: Context
    ) {
        try {
            printer.printHtml(context, htmlContent)
            Log.i(TAG, "HTML impresso com sucesso")
        } catch (e: PrinterException) {
            Log.e(TAG, "Erro ao imprimir HTML: ${e.message}", e)
            throw e
        }
    }

    /**
     * Enrola o papel
     * @param lines Número de linhas a enrolar
     */
    fun scrollPaper(lines: Int = 100) {
        try {
            printer.scrollPaper(lines)
            Log.i(TAG, "Papel enrolado: $lines linhas")
        } catch (e: PrinterException) {
            Log.e(TAG, "Erro ao enrolar papel: ${e.message}", e)
            throw e
        }
    }

    /**
     * Obtém o status da impressora
     * @return Status da impressora como String
     */
    fun getPrinterStatus(): String {
        return try {
            printer.status.toString()
        } catch (e: PrinterException) {
            Log.e(TAG, "Erro ao obter status: ${e.message}", e)
            "ERRO: ${e.message}"
        }
    }

    // Métodos auxiliares privados

    private fun parseAlignment(alignment: String): Alignment {
        return when (alignment.uppercase()) {
            "CENTER" -> Alignment.CENTER
            "RIGHT" -> Alignment.RIGHT
            else -> Alignment.LEFT
        }
    }

    private fun parseBarcodeType(type: String): BarcodeType {
        return when (type.uppercase()) {
            "AZTEC" -> BarcodeType.AZTEC
            "CODABAR" -> BarcodeType.CODABAR
            "CODE_39" -> BarcodeType.CODE_39
            "CODE_128" -> BarcodeType.CODE_128
            "EAN_8" -> BarcodeType.EAN_8
            "EAN_13" -> BarcodeType.EAN_13
            "ITF" -> BarcodeType.ITF
            "UPC_A" -> BarcodeType.UPC_A
            "QR_CODE" -> BarcodeType.QR_CODE
            else -> BarcodeType.QR_CODE
        }
    }

    private fun parseBarcodeSize(size: String): BarcodeFormat.Size {
        return when (size.uppercase()) {
            "FULL_PAPER" -> BarcodeFormat.Size.FULL_PAPER
            else -> BarcodeFormat.Size.HALF_PAPER
        }
    }

    // Implementação de Printer.Listener

    override fun onPrinterError(printerError: PrinterError) {
        Log.e(
            TAG,
            "Erro de impressão - Causa: ${printerError.cause}, Código: ${printerError.code}, Request ID: ${printerError.requestId}"
        )
    }

    override fun onPrinterSuccessful(requestId: Int) {
        Log.i(TAG, "Requisição de impressão ID $requestId executada com sucesso")
    }
}
