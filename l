import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import org.vosk.Model;
import org.vosk.Recognizer;
import org.vosk.android.RecognitionListener;
import org.vosk.android.SpeechService;

import java.io.IOException;

public class VoiceCalculator extends AppCompatActivity implements RecognitionListener {

    private SpeechService speechService;
    private TextView resultText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        resultText = findViewById(R.id.resultText);

        new Thread(() -> {
            try {
                Model model = new Model("model"); // folder under assets
                Recognizer recognizer = new Recognizer(model, 16000.0f);
                speechService = new SpeechService(recognizer, 16000.0f);
                speechService.startListening(this);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }).start();
    }

    @Override
    public void onPartialResult(String hypothesis) {
        parseCommand(hypothesis);
    }

    @Override
    public void onResult(String hypothesis) {
        parseCommand(hypothesis);
    }

    private void parseCommand(String text) {
        text = text.toLowerCase();
        Log.d("VoiceInput", "Command: " + text);

        if (text.contains("multiply") || text.contains("into")) {
            text = text.replace("multiply", "").replace("into", "").trim();
            String[] nums = text.split("and| ");
            int[] numbers = new int[2];
            int count = 0;

            for (String s : nums) {
                try {
                    numbers[count++] = Integer.parseInt(s.trim());
                    if (count == 2) break;
                } catch (NumberFormatException ignored) {}
            }

            if (count == 2) {
                int result = numbers[0] * numbers[1];
                String resText = numbers[0] + " × " + numbers[1] + " = " + result;
                runOnUiThread(() -> resultText.setText(resText));
            }
        }
    }

    @Override
    public void onFinalResult(String hypothesis) {}
    @Override
    public void onError(Exception e) {}
    @Override
    public void onTimeout() {}
}