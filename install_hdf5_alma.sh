# ===========================================================================
#   Script from the hdf5-manylinux repo:
#     https://github.com/h5py/hdf5-manylinux/blob/master/install_hdf5.sh
# ===========================================================================

set -euo pipefail

echo "Installing zlib with yum"
dnf -y install zlib-devel wget

pushd /tmp

# This seems to be needed to find libsz.so.2
ldconfig

echo "Downloading & unpacking HDF5 ${HDF5_VERSION}"

wget https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5-$HDF5_VERSION.tar.gz
tar -xzvf hdf5-$HDF5_VERSION.tar.gz
pushd hdf5-hdf5-$HDF5_VERSION
chmod u+x autogen.sh

echo "Configuring, building & installing HDF5 ${HDF5_VERSION} to ${HDF5_DIR}"
./configure --prefix $HDF5_DIR --enable-build-mode=production --with-szlib
make -j $(nproc)
make install
popd

# Clean up to limit the size of the Docker image
echo "Cleaning up unnecessary files"
rm -r hdf5-hdf5-$HDF5_VERSION
rm hdf5-$HDF5_VERSION.tar.gz

dnf -y erase zlib-devel
