# JupyterLab avec OpenCV

Ce projet configure un environnement Docker combinant OpenCV et JupyterLab pour exécuter des notebooks Python avec toutes les dépendances nécessaires.

---

## 🛠️ Fonctionnalités

- **OpenCV 4.9.0** préinstallé.
- **JupyterLab** installé et configuré.
- Accès en tant qu'utilisateur `root` par défaut.
- Gestion simplifiée des dépendances Python via `requirements.txt`.

---

## 📄 Dockerfile

### Contenu du Dockerfile
```dockerfile
# Utilise gocv comme base
FROM gocv/opencv:4.9.0-static

# Met à jour le système et installe Python et pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    libgl1-mesa-glx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installe JupyterLab et notebook
RUN pip3 install --no-cache-dir jupyterlab notebook

# Définit le répertoire de travail
WORKDIR /root/work

# Expose le port 8888 pour JupyterLab
EXPOSE 8888

# Ajoute le fichier requirements.txt pour les dépendances Python
COPY ./TP1/requirements.txt /root/work/requirements.txt

# Installe les dépendances Python
RUN pip3 install -r /root/work/requirements.txt

# Commande pour démarrer JupyterLab
CMD ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=UIMM", "--allow-root"]
```
## docker-compose 

``` docker-compose
version: '3.8'

services:
  jupyter-lab:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: jupyter_lab_opencv
    ports:
      - "8888:8888" # Redirection du port pour Jupyter Lab
    volumes:
      - ./TP1:/root/work # Monter le répertoire local pour vos TP
    environment:
      GRANT_SUDO: "yes"
      JUPYTER_ENABLE_LAB: "yes"
    init: true
    tty: true
```
le requirements.txt :
```
keras==2.13.1 
tensorflow==2.13.1  
numpy==1.23.5  
opencv-python==4.8.0.74  
pandas==1.5.3  
```
# 📤 Image Docker Hub
 L'image Docker a été poussée sur Docker Hub sous le nom suivant :

```bash
docker push diezejhon/machinelearning-jupyter-lab:tagname
```
# 🧑‍🏫 Tutoriel pour Utiliser l'Image Docker
Étape 1 : Télécharger l'Image Docker depuis Docker Hub
Téléchargez l'image avec la commande suivante :
```bash
docker pull diezejhon/machinelearning-jupyter-lab:tagname
```
Etape 2 : lancer la commande suivante:
``` bash 
docker run -it --rm `
  -p 8888:8888 `
  -v ${PWD}\TP1:/root/work `
  --name jupyter_lab_opencv `
  diezejhon/machinelearning-jupyter-lab:latest
```
Etape 3 : rendez vous sur 
http://localhost:8888/