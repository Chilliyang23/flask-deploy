# flask_app.py
import os
from flask import Flask
from dotenv import load_dotenv  # Import the function
from prometheus_flask_exporter import PrometheusMetrics

# Load environment variables from a .env file if it exists
load_dotenv()

app = Flask(__name__)
metrics = PrometheusMetrics(app)

metrics.info("app_info", "A sample Flask application with Prometheus metrics", version="1.0.0")

# Read configuration from environment variables, with defaults
# This is a common pattern in DevOps: ENV_VAR_NAME || default_value
HOST = os.getenv('HOST', '0.0.0.0')
PORT = int(os.getenv('PORT', 5000))  # Convert to int
DEBUG_MODE = os.getenv('DEBUG', 'False').lower() == 'true'  # Convert "True"/"False" string to boolean

@app.route('/')
def hello_devops():
    return f"""
    <!DOCTYPE html>
    <html>
    <head><title>Configurable Flask App</title></head>
    <body>
        <h1>Hello from a Configurable App!</h1>
        <p>Host: {HOST}</p>
        <p>Port: {PORT}</p>
        <p>Debug Mode: {DEBUG_MODE}</p>
    </body>
    </html>
    """

@app.route('/status')
def status():
    return {"status": "OK"}

@app.route('/health')
def health():
    # This is a simple health check.
    # You could add logic here to check dependencies (e.g., database connection).
    return "", 200

# The __main__ block now uses our config variables
if __name__ == '__main__':
    app.run(host=HOST, port=PORT, debug=DEBUG_MODE)