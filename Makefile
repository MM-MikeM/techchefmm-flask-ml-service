setup:
	python3 -m venv ~/.techchefmm-flask-ml-service

install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb
	python -m pytest -vv test_hello.py

lint:
	#hadolint Dockerfile #uncomment to explore linting Dockerfiles
	pylint --disable=R,C,W1203,app.py, hello.py

all: install lint test
