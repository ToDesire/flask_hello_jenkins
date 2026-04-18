FROM python:3.12-slim

RUN useradd -m flask
WORKDIR /home/flask


COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


COPY . .


RUN chmod a+x app.py test.py && \
    chown -R flask:flask /home/flask


ENV FLASK_APP=app.py
EXPOSE 5000

USER flask


CMD ["python", "app.py"]