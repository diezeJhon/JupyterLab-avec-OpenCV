# Utilise gocv comme base
FROM gocv/opencv:4.9.0-static

# Met à jour le système et installe Python et pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    libgl1-mesa-glx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Définit le répertoire de travail pour root
WORKDIR /root/work

# Expose le port 8888 pour JupyterLab
EXPOSE 8888

# Copie le fichier requirements.txt pour les librairies nécessaires
COPY ./requirements.txt /root/work/requirements.txt

# Installe JupyterLab, notebook, et les dépendances Python
RUN pip3 install --no-cache-dir jupyterlab notebook && \
    pip3 install -r /root/work/requirements.txt

# Commande pour démarrer JupyterLab en root
CMD ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
