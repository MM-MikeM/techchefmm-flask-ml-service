python3 -m venv ~/.techchefmm-flask-ml-service
source ~/.techchefmm-flask-ml-service/bin/activate
make install
az webapp up -n techchefmm-flask-ml-service
locust -f locustfile.py --headless -t 2s
./make_predict_azure_app.sh
deactivate