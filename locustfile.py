from locust import HttpUser, constant, task


class techcheffmm_flask_ml(HttpUser):

    wait_time = constant(1)
    host = "https://techchefmm-flask-ml-service.azurewebsites.net"

    @task
    def get_default_site(self):
        response = self.client.get("/")
        print(response.text)
        print(response.status_code)
        print(response.headers)