FROM python:3.9-slim-buster

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt 

EXPOSE 8000

CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000"]
