##ベースになるDocker image
FROM ubuntu:latest

RUN apt-get -y update && apt-get install -y \
sudo \
wget \
vim

##apt-getというのはubuntuのパッケージ管理(brew, conda)
##apt-getを更新して常にインストール時に最新のパッケージをインストールするようにしてる 

# install basic packages
#RUN apt-get install -y sudo wget bzip2
#RUN apt-get install vim -y
 
##sudo:super user do
##wget:`指定したファイルのダウンロード
##bzip2:ファイルを圧縮するコマンド


###install anaconda3
WORKDIR /opt
# download anaconda package
# archive -> https://repo.continuum.io/archive/
RUN wget https://repo.continuum.io/archive/Anaconda3-2019.10-Linux-x86_64.sh
 
RUN /bin/bash /opt/Anaconda3-2019.10-Linux-x86_64.sh -b -p /opt/anaconda3
RUN rm -f Anaconda3-2019.10-Linux-x86_64.sh

##環境変数をset　ちなみに上書き可能
ENV PATH /opt/anaconda3/bin:$PATH
 
# update pip and conda
RUN pip install --upgrade pip

# install OpenCV
RUN apt-get update
RUN apt-get install -y libsm6 libxext6 libxrender-dev libglib2.0-0
RUN pip install opencv-python
 
WORKDIR /
RUN mkdir /work
 
# install jupyterlab
ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root", "--LabApp.token=''"]

##DockerイメージをrunしたときにあらかじめJupyter Labが起動するように
##ENTRYPOINT [‘コマンド’, ‘引数１’, ‘引数２’]といった使い方
##CMDと同様，実行可能コンテナを作る時に使う．変更ができず，「実行必須コマンド」にしたいときに使う．
##ローカルからWebブラウザを使ってアクセス. 今回はローカルなのでIPに 0.0.0.0 (ローカル)を指定
##--allow-root としてrootユーザで実行できるように．
##passwordの設定もめんどいので --LabApp.toke='' でtokenを使わずJupyter Labにログインできるように．
