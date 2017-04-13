###### Clear Old virtualenvs #######################
for i in tf0.11 tf0.11p3 tf0.12 tf0.12p3 tf1.0 tf1.0p3 tf1.1 tf1.1p3 ; do
    echo "rm -rf ~/.virtualenvs/$i"
    rm -rf ~/.virtualenvs/$i
done

###### Virtualenvs Setting###########################

# Check Cuda env and setting
x=`echo $CUDA_HOME`
if [ ${#x} -eq 0 ];then
    cat>>~/.bashrc<<EOF
export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
export PATH="$CUDA_HOME/bin:$PATH"
EOF
    . ~/.bashrc
fi

# Check Virtualenvs and install
x=`port list|grep py-virtualenvwrapper|wc -l`
if [ $x = "0" ]; then
    sudo port install py-virtualenv py-virtualenvwrapper
fi

# Check Virtualenvs env and setting
x=`echo $WORKON_HOME`
if [ ${#x} -eq 0 ];then
    cat>>~/.profile<<EOF
export WORKON_HOME=~/.virtualenvs
. /Library/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh
EOF
    . ~/.profile
fi


###### Tensorflow Install ##########################
mkvirtualenv tf0.11
pip install ipykernel
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/gpu/tensorflow-0.11.0-py2-none-any.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf0.11

mkvirtualenv -p python3 tf0.11p3
pip3 install ipykernel
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/gpu/tensorflow-0.11.0-py3-none-any.whl
pip3 install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf0.11p3

mkvirtualenv tf0.12
pip install ipykernel
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/gpu/tensorflow_gpu-0.12.1-py2-none-any.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf0.12

mkvirtualenv -p python3 tf0.12p3
pip3 install ipykernel
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/gpu/tensorflow_gpu-0.12.1-py3-none-any.whl
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
pip install --upgrade https://pypi.python.org/packages/24/2d/05b4d0731608e7c827f6571b805b671d110b936e95debbfb21bc1fe7c351/tensorflow-1.1.0rc0-cp27-cp27m-macosx_10_11_x86_64.whl
python -m ipykernel install --user --name=tf1.1

mkvirtualenv -p python3 tf1.1p3
pip3 install ipykernel
pip3 install --upgrade https://pypi.python.org/packages/ba/69/8cc9d6005397501c777fc79a549adf975933544e4a175bd31bae543ceb53/tensorflow-1.1.0rc0-cp35-cp35m-macosx_10_11_x86_64.whl
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
