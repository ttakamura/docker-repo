#! /bin/bash
sudo aptitude update
sudo aptitude install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev libgflags-dev libgoogle-glog-dev liblmdb-dev protobuf-compiler git libatlas-dev libatlas3-base libatlas-base-dev libdc1394-22 libdc1394-22-dev
sudo chown -R ubuntu:ubuntu /mnt
cd /mnt
git clone https://github.com/BVLC/caffe.git
cd caffe
cp Makefile.config.example Makefile.config
mv $HOME/anaconda/lib/libm.so $HOME/anaconda/lib/libm.so.tmp
sed -i -e "s/#-gencode arch=compute_50,code=sm_50/-gencode arch=compute_50,code=sm_50/g" Makefile.config
sed -i -e "s/#-gencode arch=compute_50,code=compute_50/-gencode arch=compute_50,code=compute_50/g" Makefile.config
sed -i -e "s/PYTHON_INCLUDE := \/usr\/include\/python2.7/#PYTHON_INCLUDE := \/usr\/include\/python2.7/g" Makefile.config
sed -i -e "s/\/usr\/lib\/python2.7\/dist-packages\/numpy\/core\/include/#\/usr\/lib\/python2.7\/dist-packages\/numpy\/core\/include/g" Makefile.config
sed -i -e "s/# PYTHON_INCLUDE := \$(HOME)\/anaconda\/include/PYTHON_INCLUDE := \$(HOME)\/anaconda\/include/g" Makefile.config
sed -i -e "s/# \$(HOME)\/anaconda\/include\/python2.7/\$(HOME)\/anaconda\/include\/python2.7/g" Makefile.config
sed -i -e "s/# \$(HOME)\/anaconda\/lib\/python2.7\/site-packages\/numpy\/core\/include/\$(HOME)\/anaconda\/lib\/python2.7\/site-packages\/numpy\/core\/include/g" Makefile.config
sed -i -e "s/PYTHON_LIB := \/usr\/lib/# PYTHON_LIB := \/usr\/lib/g" Makefile.config
sed -i -e "s/# PYTHON_LIB := \$(HOME)\/anaconda\/lib/PYTHON_LIB := \$(HOME)\/anaconda\/lib/g" Makefile.config
make all -j8
make test -j8
make runtest