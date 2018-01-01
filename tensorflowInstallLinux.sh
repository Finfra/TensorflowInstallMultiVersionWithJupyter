###### Clear Old virtualenvs #######################
for i in tf0.11p27 tf0.11p35 tf0.12p27 tf0.12p35 tf1.0p27 tf1.0p36 tf1.1p27 tf1.1p35 tf1.2p27 tf1.2p35 tf1.3p27 tf1.3p35 tf1.4p27 tf1.4p35; do
    echo "rm -rf ~/.virtualenvs/$i"
    rm -rf ~/.virtualenvs/$i
done

###### Check Preinstall #############################

# Check python packages
echo "# Check Preinstall"
for i in ipython ipykernel seaborn virtualenv virtualenvwrapper; do
    x=$(pip2 list  --format=legacy|grep $i|wc -l)
    if [ ${#x} -eq 0 ];then 
        sudo pip2 install $i       
    fi
    x=$(pip3 list  --format=legacy|grep $i|wc -l)
    if [ ${#x} -eq 0 ];then 
        sudo pip3 install $i       
    fi

done

###### Virtualenvs Setting ###########################
# Check Cuda env and setting
x=`echo $CUDA_HOME`
if [ ${#x} -eq 0 ];then
    cat>> $HOME/.bashrc<<EOF
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME=/usr/local/cuda
EOF
    . $HOME/.bashrc
fi

# Check cudnn /usr/local/cuda/lib64/libcudnn.so.5
cudnnLibHome=$CUDA_HOME/lib64/
for i in libcudnn.so.5 libcudnn.so libcudnn.so.6; do
    x=$(ls $cudnnLibHome/$i*|wc -l)
    if [ ${#x} -eq 0 ];then
        echo "#####################################################################"
        echo "### Warn : No $cudnnLibHome/$i file is not exist.        ############"
        echo "#####################################################################"
    fi
done     



# Check Virtualenvs env and setting
x=`echo $WORKON_HOME`
if [ ${#x} -eq 0 ];then
    cat>> $HOME/.bashrc<<EOF
export WORKON_HOME=$HOME/.virtualenvs
. /usr/local/bin/virtualenvwrapper.sh
EOF
    . $HOME/.bashrc
fi


###### Tensorflow Install ##########################
# https://pypi.python.org/pypi/tensorflow-gpu

echo " "
echo "# tf0.11p27"
mkvirtualenv -p python2.7 tf0.11p27
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.11.0rc2-cp27-none-linux_x86_64.whl
pip2 install --upgrade $TF_BINARY_URL
python2 -m ipykernel install --user --name=tf0.11p27

echo " "
echo "# tf0.11p35"
mkvirtualenv -p python3.5 tf0.11p35
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.11.0rc2-cp35-cp35m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL
python3 -m ipykernel install --user --name=tf0.11p35

echo " "
echo "# tf0.12p27"
mkvirtualenv -p python2.7 tf0.12p27
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.1-cp27-none-linux_x86_64.whl
pip2 install --upgrade $TF_BINARY_URL
python2 -m ipykernel install --user --name=tf0.12p27

echo " "
echo "# tf0.12p35"
mkvirtualenv -p python3.5 tf0.12p35
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.1-cp35-cp35m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL
python3 -m ipykernel install --user --name=tf0.12p35

echo " "
echo "# tf1.0p27"
mkvirtualenv -p python2.7 tf1.0p27
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.0.0rc2-cp27-none-linux_x86_64.whl
pip2 install --upgrade $TF_BINARY_URL
python2 -m ipykernel install --user --name=tf1.0p27

echo " "
echo "# tf1.0p35"
mkvirtualenv -p python3.5 tf1.0p35
export TF_BINARY_URL=https://pypi.python.org/packages/5d/7c/ecd5e3009cc85b41a5313eb09693ddc976cf4afe694b6e151709810c944c/tensorflow_gpu-1.0.1-cp35-cp35m-manylinux1_x86_64.whl
#https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.0.0rc2-cp36-cp36m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL
python3 -m ipykernel install --user --name=tf1.0p35

echo " "
echo "# tf1.1p27"
mkvirtualenv -p python2.7 tf1.1p27
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.1.0rc2-cp27-none-linux_x86_64.whl
pip2 install --upgrade $TF_BINARY_URL
python2 -m ipykernel install --user --name=tf1.1p27

echo " "
echo "# tf1.1p35"
mkvirtualenv -p python3.5 tf1.1p35
export TF_BINARY_URL=https://pypi.python.org/packages/7e/1c/bead42bf336a4e3200aaeaa30cceab6081457df913d8be65f5044f1fe0eb/tensorflow_gpu-1.1.0-cp35-cp35m-manylinux1_x86_64.whl
#https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.1.0rc2-cp36-cp36m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL
python3 -m ipykernel install --user --name=tf1.1p35

echo " "
echo "# tf1.2p27"
mkvirtualenv -p python2.7 tf1.2p27
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.2.1-cp27-none-linux_x86_64.whl
pip2 install --upgrade $TF_BINARY_URL
python2 -m ipykernel install --user --name=tf1.2p27

echo " "
echo "# tf1.2p35"
mkvirtualenv -p python3.5 tf1.2p35
export TF_BINARY_URL=https://pypi.python.org/packages/fc/06/93f9b5e9fe751dfcd4cbb516608636e036a0a03b935df7d7bb7102b09496/tensorflow_gpu-1.2.1-cp35-cp35m-manylinux1_x86_64.whl
#https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.2.1-cp36-cp36m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL
python3 -m ipykernel install --user --name=tf1.2p35

echo " "
echo "# tf1.3p27"
mkvirtualenv -p python2.7 tf1.3p27
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0rc2-cp27-none-linux_x86_64.whl
pip2 install --upgrade $TF_BINARY_URL
python2 -m ipykernel install --user --name=tf1.3p27

echo " "
echo "# tf1.3p35"
mkvirtualenv -p python3.5 tf1.3p35
export TF_BINARY_URL=https://pypi.python.org/packages/ad/bd/bb96a3203296fa4400e51068d48824efeb72922a5608300bdcceafb38eaa/tensorflow_gpu-1.3.0-cp35-cp35m-manylinux1_x86_64.whl 
#https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0rc2-cp36-cp36m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL
python3 -m ipykernel install --user --name=tf1.3p35

echo " "
echo "# tf1.4p27"
mkvirtualenv -p python2.7 tf1.4p27
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.4.0rc1-cp27-none-linux_x86_64.whl
pip2 install --upgrade $TF_BINARY_URL
python2 -m ipykernel install --user --name=tf1.4p27

echo " "
echo "# tf1.4p35"
mkvirtualenv -p python3.5 tf1.4p35
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.4.1-cp35-cp35m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL
python3 -m ipykernel install --user --name=tf1.4p35



###### Check #######################################
echo "
from __future__ import print_function
import tensorflow as tf
import sys
print(tf.__version__, sys.version_info)
">~/.nowage_test.py
echo ""> ~/.nowage_test.txt

workon tf0.11p27
python2 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf0.11p35
python3 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf0.12p27
python2 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf0.12p35
python3 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.0p27
python2 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.0p35
python3 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.1p27
python2 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.1p35
python3 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.2p27
python2 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.2p35
python3 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.3p27
python2 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.3p35
python3 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.4p27
python2 ~/.nowage_test.py >> ~/.nowage_test.txt
workon tf1.4p35
python3 ~/.nowage_test.py >> ~/.nowage_test.txt

cat ~/.nowage_test.txt
rm ~/.nowage_test.txt
