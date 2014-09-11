#! /bin/bash
cd /usr/local
git reset --hard
brew untap homebrew/science
rm -rf /usr/local/Library/Formula/opencv.rb
brew tap homebrew/science
brew update
brew install gnu-sed hdf5

function add_line() {
    gsed -i -e '/def install/a\    ENV["CXX"] = "/usr/bin/clang++ -stdlib=libstdc++"' $1
    gsed -i -e '/def install/a\    # The following is necessary because libtool likes to strip LDFLAGS:' $1
    gsed -i -e '/def install/a\    ENV.append "LDFLAGS", "-stdlib=libstdc++ -lstdc++"' $1
    gsed -i -e '/def install/a\    ENV.append "CFLAGS", "-stdlib=libstdc++"' $1
    gsed -i -e '/def install/a\    ENV.append "CXXFLAGS", "-stdlib=libstdc++"' $1
    gsed -i -e '/def install/a\    # ADD THE FOLLOWING:' $1
}

libs+=("boost")
libs+=("snappy")
libs+=("leveldb")
libs+=("protobuf")
libs+=("gflags")
libs+=("glog")
libs+=("szip")
libs+=("lmdb")
libs+=("opencv")

for lib in "${libs[@]}"
do
    add_line "/usr/local/Library/Formula/$lib.rb"
done

for x in snappy leveldb gflags glog szip lmdb
do
    brew uninstall $x
    brew install --build-from-source --fresh -vd $x
done

brew uninstall opencv
gsed -i -e '/py_version = /a\    py_dir = %x(python -c "import site; print site.getsitepackages()[0]").chomp' /usr/local/Library/Formula/opencv.rb
gsed -i -e '/args = std_cmake_args + %W(/a\      -DPYTHON_PACKAGES_PATH=#{py_dir}' /usr/local/Library/Formula/opencv.rb
brew install --build-from-source --fresh -vd opencv --with-eigen --with-jasper --with-tbb

brew uninstall protobuf
gsed -n -e "/if build.with? 'python'/a\      prefix = %x(python -c \"import site; print site.getsitepackages()[0]\").chomp" /usr/local/Library/Formula/protobuf.rb
brew install --build-from-source --with-python --fresh -vd protobuf

brew uninstall boost
brew install --build-from-source --with-python --fresh -vd boost

if [ test -d ~/anaconda ]; then
	py_root=`python -c "import site; print site.getsitepackages()[0]"`
	orig_cv=$py_root/cv2.so
	chown :staff $orig_cv
	chmod +w $orig_cv
	install_name_tool -change libpython2.7.dylib ~/anaconda/lib/libpython2.7.dylib $orig_cv
	install_name_tool -change libpython2.7.dylib ~/anaconda/lib/libpython2.7.dylib $orig_cv

	orig_boost=/usr/local/lib/`readlink /usr/local/lib/libboost_python.dylib`
	chown :staff $orig_boost
	chmod +w $orig_boost
	install_name_tool -change libpython2.7.dylib ~/anaconda/lib/libpython2.7.dylib $orig_boost
	orig_boost=/usr/local/lib/`readlink /usr/local/lib/libboost_python-mt.dylib`
	chown :staff $orig_boost
	chmod +w $orig_boost
	install_name_tool -change libpython2.7.dylib ~/anaconda/lib/libpython2.7.dylib $orig_boost
fi