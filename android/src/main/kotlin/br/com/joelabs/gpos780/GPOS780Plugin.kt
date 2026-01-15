package br.com.joelabs.gpos780

import android.content.Context
import android.util.Log
import br.com.gertec.gedi.GEDI
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GPOS780Plugin */
class GPOS780Plugin: FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel : MethodChannel
    private lateinit var context: Context
    private lateinit var printerManager: GPOS780PrinterManager

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "gpos780")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        GEDI.init(context)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        try {
            when (call.method) {
                "initPrinter" -> {
                    printerManager = GPOS780PrinterManager(context)
                    result.success("Impressora inicializada")
                }

                "printText" -> {
                    if (!isPrinterInitialized(result)) return
                    val text = call.argument<String>("text") ?: ""
                    val fontSize = call.argument<Int>("fontSize") ?: 30
                    val isBold = call.argument<Boolean>("isBold") ?: false
                    val isUnderscore = call.argument<Boolean>("isUnderscore") ?: false
                    val alignment = call.argument<String>("alignment") ?: "CENTER"
                    val lineSpacing = call.argument<Int>("lineSpacing") ?: 6

                    printerManager.printText(
                        text = text,
                        fontSize = fontSize,
                        isBold = isBold,
                        isUnderscore = isUnderscore,
                        alignment = alignment,
                        lineSpacing = lineSpacing
                    )
                    result.success("Texto impresso com sucesso")
                }

                "printMultipleLines" -> {
                    if (!isPrinterInitialized(result)) return
                    val lines = call.argument<List<String>>("lines") ?: emptyList()
                    val alignment = call.argument<String>("alignment") ?: "LEFT"

                    printerManager.printMultipleLines(lines, alignment)
                    result.success("Múltiplas linhas impressas com sucesso")
                }

                "printImageFromBase64" -> {
                    if (!isPrinterInitialized(result)) return
                    val base64Image = call.argument<String>("base64") ?: ""

                    if (base64Image.isNotEmpty()) {
                        printerManager.printImageFromBase64(base64Image)
                        result.success("Imagem impressa com sucesso")
                    } else {
                        result.error("INVALID_ARGUMENT", "Base64 image not provided", null)
                    }
                }

                "printImageFromBytes" -> {
                    if (!isPrinterInitialized(result)) return
                    val bytes = call.argument<ByteArray>("bytes")

                    if (bytes != null && bytes.isNotEmpty()) {
                        printerManager.printImageFromBytes(bytes)
                        result.success("Imagem impressa com sucesso")
                    } else {
                        result.error("INVALID_ARGUMENT", "Bytes not provided", null)
                    }
                }

                "printHtml" -> {
                    if (!isPrinterInitialized(result)) return
                    val htmlContent = call.argument<String>("html") ?: ""

                    if (htmlContent.isNotEmpty()) {
                        printerManager.printHtml(htmlContent, context)
                        result.success("HTML impresso com sucesso")
                    } else {
                        result.error("INVALID_ARGUMENT", "HTML content not provided", null)
                    }
                }

                "scrollPaper" -> {
                    if (!isPrinterInitialized(result)) return
                    val lines = call.argument<Int>("lines") ?: 100
                    printerManager.scrollPaper(lines)
                    result.success("Papel enrolado com sucesso")
                }

                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            Log.e("PrinterError", "Erro ao executar método: ${call.method}", e)
            result.error("ERROR", e.message, e.stackTrace.toString())
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun isPrinterInitialized(result: MethodChannel.Result): Boolean {
        return if (::printerManager.isInitialized) {
            true
        } else {
            result.error("NOT_INITIALIZED", "Chame initPrinter antes de imprimir", null)
            false
        }
    }
}
