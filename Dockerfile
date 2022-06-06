# multi-stage builds: stage 1/2
FROM python:3.10 as builder

COPY requirements.txt setup.py ./
COPY package package

# use PyPI mirrior from BFSU. Substitute it by any mirrors nearby instead.
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --user -r requirements.txt


# multi-stage builds: stage 2/2
FROM python:3.10-slim

ARG USERNAME=pdm

# Creates a non-root user with an explicit UID and adds permission to access the work folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers

RUN adduser -u 5678 --disabled-password --gecos "" ${USERNAME}
# copy from last build the required packages
COPY --from=builder /root/.local /home/${USERNAME}/.local
RUN chown -R ${USERNAME} /home/${USERNAME}/.local
USER ${USERNAME}
ENV PATH=/home/${USERNAME}/.local/bin:${PATH}

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# port 8888 is the default port for jupyter
EXPOSE 8888

WORKDIR /home/${USERNAME}/code
COPY path.py path.ipynb ./

# execute once as the container gets run
CMD ["jupyter-lab", "--no-browser", "--ip", "0.0.0.0", "path.ipynb"]