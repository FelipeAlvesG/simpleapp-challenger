FROM python:alpine3.15

LABEL maintainer="Felipe Alves Gonçalves <felipealves1995@gmail.com>"

WORKDIR /app

COPY . /app/

RUN pip install -r requirements.txt

EXPOSE 8008

CMD [ "python", "app.py"]