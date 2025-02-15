# If running in mac, check to see if you have /usr/include directory 
# If they are not found, headers can be installed using 
# /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_XX.XX.pkg
# that should have been located in your mac (where XX.XX is your mac OS verision number)
# when you installed the Xcode comandline tools 

#CXX=clang++
CXX=g++-8


LIB_FLAGS = -larmadillo -llapack -framework Accelerate -I/usr/local/Cellar/armadillo/9.300.2/include -L/usr/local/Cellar/armadillo/9.300.2/lib


OPT = -O2 -mcmodel=medium  -fopenmp -w 

all: VeST demo   

VeST: src/VeST.cpp  
	$(CXX) $(OPT)  -o bin/$@  $< $(LIB_FLAGS)

demo: 
	bin/./VeST sample/sample_train.txt sample/sample_test.txt sample/result/ 3 10 10 10 L1 
	bin/./VeST sample/sample_train.txt sample/sample_test.txt sample/result/ 3 10 10 10 L1 -m 0.8 
	bin/./VeST sample/sample_train.txt sample/sample_test.txt sample/result/ 3 10 10 10 LF 
	bin/./VeST sample/sample_train.txt sample/sample_test.txt sample/result/ 3 10 10 10 LF -m 0.8 
	bin/./VeST sample/ML_small.tensor NA sample/result 4 6 6 2 2 L1


.PHONY: clean

clean:
	rm -f VeST

