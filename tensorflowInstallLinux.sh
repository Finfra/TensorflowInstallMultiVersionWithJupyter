###### Clear Old virtualenvs #######################
for i in tf0.11 tf0.11p3 tf0.12 tf0.12p3 tf1.0 tf1.0p3 tf1.1  tf1.1p3 ; do
    echo "rm -rf ~/.virtualenvs/$i"
    rm -rf ~/.virtualenvs/$i
done

###### Virtualenvs Setting###########################

# Check Cuda env and setting
x=`echo $CUDA_HOME`
if [ ${#x} -eq 0 ];then
    cat>>~/.bashrc<<EOF
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME=/usr/local/cuda
EOF
    . ~/.bashrc
fi





# Check Virtualenvs and install
x=`pip list --format=columns|grep virtualenvwrapper|wc -l`
if [ $x = "0" ]; then
    sudo pip install virtualenv virtualenvwrapper
fi

# Check Virtualenvs env and setting
x=`echo $WORKON_HOME`
if [ ${#x} -eq 0 ];then
    cat>>~/.bashrc<<EOF
export WORKON_HOME=~/.virtualenvs
. /usr/local/bin/virtualenvwrapper.sh
EOF
    . ~/.bashrc
fi


###### Tensorflow Install ##########################
mkvirtualenv tf0.11
pip install ipykernel
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.11.0-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf0.11

mkvirtualenv -p python3 tf0.11p3
pip3 install ipykernel
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.11.0-cp35-cp35m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf0.11p3

mkvirtualenv tf0.12
pip install ipykernel
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.1-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf0.12

mkvirtualenv -p python3 tf0.12p3
pip3 install ipykernel
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.1-cp35-cp35m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf0.12p3


mkvirtualenv tf1.0
pip install ipykernel
pip install --upgrade tensorflow-gpu
python -m ipykernel install --user --name=tf1.0


mkvirtualenv -p python3  tf1.0p3
pip3 install ipykernel
pip3 install --upgrade tensorflow-gpu
python -m ipykernel install --user --name=tf1.0p3


mkvirtualenv tf1.1
pip install ipykernel
pip install --upgrade https://pypi.python.org/packages/1a/82/4df568bd75b2356b41fcd11d05e651b0333512bc8e836ebc51be6e2e18fe/tensorflow-1.1.0rc0-cp27-cp27mu-manylinux1_x86_64.whl
python -m ipykernel install --user --name=tf1.1


mkvirtualenv -p python3 tf1.1p3
pip3 install ipykernel
pip3 install --upgrade https://pypi.python.org/packages/2a/1e/6daa6c848a7ecbe7244c05542e33b68034adb03f60b0245f2606f0fa8334/tensorflow-1.1.0rc0-cp35-cp35m-manylinux1_x86_64.whl
python -m ipykernel install --user --name=tf1.1p3

###### Check #######################################
echo "
from __future__ import print_function
import tensorflow as tf
import sys
print(tf.__version__, sys.version_info)
">/tmp/nowage_test.py
echo ""> /tmp/nowage_test.txt
workon tf0.11
python /tmp/nowage_test.py >> /tmp/nowage_test.txt
workon tf0.11p3
python /tmp/nowage_test.py >> /tmp/nowage_test.txt
workon tf0.12
python /tmp/nowage_test.py >> /tmp/nowage_test.txt
workon tf0.12p3
python /tmp/nowage_test.py >> /tmp/nowage_test.txt
workon tf1.0
python /tmp/nowage_test.py >> /tmp/nowage_test.txt
workon tf1.0p3
python /tmp/nowage_test.py >> /tmp/nowage_test.txt
workon tf1.1
python /tmp/nowage_test.py >> /tmp/nowage_test.txt
workon tf1.1p3
python /tmp/nowage_test.py >> /tmp/nowage_test.txt
cat /tmp/nowage_test.txt
rm /tmp/nowage_test.txt
