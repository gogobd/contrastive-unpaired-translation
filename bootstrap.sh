# apt-get install -y colmap ffmpeg
wget -O Miniconda3-py38_4.10.3-Linux-x86_64.sh -nc https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh
bash Miniconda3-py38_4.10.3-Linux-x86_64.sh -b -p $HOME/miniconda
$HOME/miniconda/bin/conda init bash
source /root/.bashrc
conda env create -f environment.yml
conda activate contrastive-unpaired-translation
