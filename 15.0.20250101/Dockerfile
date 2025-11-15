FROM python:3.13-alpine

WORKDIR /

RUN apk add gcc build-base python3-dev libffi-dev libxml2-dev libxslt-dev libpq-dev openldap-dev

RUN pip install --upgrade pip setuptools wheel

#COPY . .              
COPY requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

CMD ["python", "app.py"]    
