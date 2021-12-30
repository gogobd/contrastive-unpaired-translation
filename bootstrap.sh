# apt-get install -y colmap ffmpeg
wget -O Miniconda3-py38_4.10.3-Linux-x86_64.sh -nc https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh
bash Miniconda3-py38_4.10.3-Linux-x86_64.sh -b -p $HOME/miniconda
$HOME/miniconda/bin/conda init bash
source /root/.bashrc
conda update -y -n base -c defaults conda
conda env create -f working-environment.yml
conda activate contrastive-unpaired-translation

# conda uninstall pytorch
# conda uninstall cpuonly
# conda install pytorch torchvision cudatoolkit=11.3.1 -c pytorch

# conda env update --name contrastive-unpaired-translation --file environment.yml --prune
# conda env export -f working-environment.yml
