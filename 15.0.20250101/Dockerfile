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

COPY stage0/underscorejs.tgz .
RUN tar xvzf underscorejs.tgz

FROM python:3.12-alpine

ENV PYTHONPATH=/usr/local/lib/python312.zip:/usr/local/lib/python3.12:/usr/local/lib/python3.12/lib-dynload:/usr/local/lib/python3.12/site-packages:/usr/local/lib/python3/dist-packages

RUN ln -s /usr/local/bin/python3 /usr/bin/python3
RUN apk add libffi libxml2 libxslt libpq openldap libsass font-roboto font-awesome
RUN pip install setuptools
COPY --from=builder /install /usr/local

COPY stage0/fs/usr/ /usr/local/

COPY --from=builder /usr/lib/python3/dist-packages/odoo/addons/ /usr/local/lib/python3/dist-packages/odoo/addons/
COPY --from=builder /usr/local/share/javascript/underscore  /usr/local/share/javascript/underscore

RUN cd /usr/local/lib/python3/dist-packages/odoo/addons/web/static/fonts/google/Roboto && for n in *.ttf ; do echo $n ; t=$(find / -name $n ! -type l); rm -f $n ; ln -s $t $n ; done

CMD ["/usr/local/bin/odoo"]
