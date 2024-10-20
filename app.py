from flask import Flask, render_template_string
import os
import datetime
import subprocess

app = Flask(__name__)

FULL_NAME = "Mohammed Waseem"

@app.route('/htop')
def htop():
    # The system username
    try:
        username = "codespace"
    except Exception as e:
        username = f"Error fetching username: {str(e)}"

    # The current server time in IST
    server_time = datetime.datetime.now(datetime.timezone(datetime.timedelta(hours=5, minutes=30)))

    # Fetching system process information based on OS
    try:
        if os.name == 'nt':
            # For Windows, use tasklist instead of top
            top_output = subprocess.check_output(['tasklist']).decode('utf-8')
        else:
            # For Unix-based systems like Linux, use top command
            top_output = subprocess.check_output(['top', '-b', '-n', '1']).decode('utf-8')
    except Exception as e:
        top_output = f"Error fetching system output: {str(e)}"

    # HTML Template
    html_template = f"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HTOP Info</title>
        <style>
            body {{ font-family: Arial, sans-serif; }}
            pre {{ white-space: pre-wrap; }}
        </style>
    </head>
    <body>
        <h1>System Info</h1>
        <p><strong>Full Name:</strong> {FULL_NAME}</p>
        <p><strong>Username:</strong> {username}</p>
        <p><strong>Server Time (IST):</strong> {server_time.strftime("%Y-%m-%d %H:%M:%S")}</p>
        <h2>System Process Output:</h2>
        <pre>{top_output}</pre>
    </body>
    </html>
    """

    return render_template_string(html_template)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)  # Ensure the app is accessible externally
