package com.example.calculator;

import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private TextView resultTextView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        resultTextView = findViewById(R.id.result_textview);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        int itemId = item.getItemId();
        if (itemId == R.id.action_add) {
            showInputDialog("add");
        } else if (itemId == R.id.action_subtract) {
            showInputDialog("subtract");
        } else if (itemId == R.id.action_multiply) {
            showInputDialog("multiply");
        } else if (itemId == R.id.action_divide) {
            showInputDialog("divide");
        } else if (itemId == R.id.action_exit) {
            showExitDialog();
        }
        return super.onOptionsItemSelected(item);
    }

    private void showInputDialog(final String operation) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Enter two numbers");

        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);

        final EditText input1 = new EditText(this);
        input1.setHint("Number 1");
        input1.setInputType(android.text.InputType.TYPE_CLASS_NUMBER | android.text.InputType.TYPE_NUMBER_FLAG_SIGNED);
        layout.addView(input1);

        final EditText input2 = new EditText(this);
        input2.setHint("Number 2");
        input2.setInputType(android.text.InputType.TYPE_CLASS_NUMBER | android.text.InputType.TYPE_NUMBER_FLAG_SIGNED);
        layout.addView(input2);

        builder.setView(layout);

        builder.setPositiveButton("OK", (dialog, which) -> {
            try {
                int num1 = Integer.parseInt(input1.getText().toString());
                int num2 = Integer.parseInt(input2.getText().toString());
                double result = 0;

                switch (operation) {
                    case "add":
                        result = num1 + num2;
                        break;
                    case "subtract":
                        result = num1 - num2;
                        break;
                    case "multiply":
                        result = num1 * num2;
                        break;
                    case "divide":
                        if (num2 == 0) {
                            Toast.makeText(MainActivity.this, "Cannot divide by zero", Toast.LENGTH_SHORT).show();
                            return;
                        }
                        result = (double) num1 / num2;
                        break;
                }
                resultTextView.setText(String.valueOf(result));
            } catch (NumberFormatException e) {
                Toast.makeText(MainActivity.this, "Please enter valid numbers", Toast.LENGTH_SHORT).show();
            }
        });
        builder.setNegativeButton("Cancel", (dialog, which) -> dialog.cancel());

        builder.show();
    }

    private void showExitDialog() {
        new AlertDialog.Builder(this)
                .setTitle("Exit")
                .setMessage("Are you sure you want to exit?")
                .setPositiveButton("Yes", (dialog, which) -> finish())
                .setNegativeButton("No", null)
                .show();
    }
}