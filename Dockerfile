ARG BASEIMAGE=ort
FROM $BASEIMAGE

RUN apt install software-properties-common build-essential;\
    add-apt-repository ppa:deadsnakes/ppa ;\
    apt-get update ;\
    apt install -y \
        python3.7 python3.7-dev python3.7-venv \
        python3.8 python3.8-dev python3.8-venv \
        python3.9 python3.9-dev python3.9-venv

RUN pip3 install --upgrade setuptools ;\
    pip3 install --upgrade pip ;\
    pip3 install --upgrade distlib 
RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py 

RUN python3.7 /tmp/get-pip.py --upgrade setuptools
RUN python3.8 /tmp/get-pip.py --upgrade setuptools
RUN python3.9 /tmp/get-pip.py --upgrade setuptools
RUN pip3 install pip==18.0 pipdeptree==0.13.2 virtualenv==20.2.2  pipenv poetry
RUN pip3.7 install pip==18.0 pipdeptree==0.13.2 virtualenv==20.2.2 pipenv poetry
RUN pip3.8 install pip==18.0 pipdeptree==0.13.2 virtualenv==20.2.2 pipenv poetry
RUN pip3.9 install --user pipx; python3.9 -m pipx install pipenv

COPY entrypoint.sh /entrypoint.sh

COPY custom root/.ort
WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]
