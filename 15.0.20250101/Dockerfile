FROM python:3.13-alpine AS builder

WORKDIR /

RUN apk add gcc build-base python3-dev libffi-dev libxml2-dev libxslt-dev libpq-dev openldap-dev

RUN pip install --upgrade pip setuptools wheel

#COPY . .              
COPY requirements.txt . 
RUN pip wheel --wheel-dir=/wheels -r requirements.txt
RUN pip install --root-user-action=ignore --no-index --find-links=/wheels  -r requirements.txt --prefix=/install


FROM python:3.13-alpine
COPY --from=builder /install /usr

#COPY stage0/fs/ /
COPY app.py .

CMD ["python", "app.py"]    
