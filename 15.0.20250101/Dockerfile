FROM python:3.12-alpine AS builder

WORKDIR /

RUN apk add gcc build-base python3-dev libffi-dev libxml2-dev libxslt-dev libpq-dev openldap-dev

RUN pip install --upgrade pip setuptools wheel

#COPY . .              
COPY requirements.txt . 
RUN pip wheel --wheel-dir=/wheels -r requirements.txt
RUN pip install --root-user-action=ignore --no-index --find-links=/wheels  -r requirements.txt --prefix=/install

COPY stage0/addons.tgz .
RUN tar xvzf addons.tgz --strip-components=1

FROM python:3.12-alpine

ENV PYTHONPATH=/usr/local/lib/python312.zip:/usr/local/lib/python3.12:/usr/local/lib/python3.12/lib-dynload:/usr/local/lib/python3.12/site-packages:/usr/local/lib/python3/dist-packages

RUN ln -s /usr/local/bin/python3 /usr/bin/python3
RUN apk add libffi libxml2 libxslt libpq openldap libsass
RUN pip install setuptools
COPY --from=builder /install /usr/local

COPY stage0/fs/usr/ /usr/local/

COPY --from=builder /usr/lib/python3/dist-packages/odoo/addons/ /usr/local/lib/python3/dist-packages/odoo/addons/

CMD ["/usr/local/bin/odoo"]
