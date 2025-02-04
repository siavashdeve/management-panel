from flask import Flask, render_template, request, jsonify

app = Flask(__name__)

# Sample configuration (you can replace this with a config file)
config = {
    "panel_name": "Management Panel",
    "version": "1.0"
}

@app.route('/')
def index():
    return render_template('index.html', config=config)

@app.route('/start_service', methods=['POST'])
def start_service():
    service_name = request.form.get('service_name')
    # Add your logic to start the service here
    return jsonify({'status': 'success', 'message': f'Service {service_name} started successfully'})

@app.route('/stop_service', methods=['POST'])
def stop_service():
    service_name = request.form.get('service_name')
    # Add your logic to stop the service here
    return jsonify({'status': 'success', 'message': f'Service {service_name} stopped successfully'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)