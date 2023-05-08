# Create Python Virtual Environment
python3 -m venv ~/.techchefmm-flask-ml-service
source ~/.techchefmm-flask-ml-service/bin/activate

# Initiate project scaffolding, run make install
make install

# Deploy web app
# az webapp up -n techchefmm-flask-ml-service

# Test application, run locustfile.py file
locust -f locustfile.py --headless -t 2s

# Run prediction
./make_predict_azure_app.sh

# Deactivate Python Virtual Environment
deactivate