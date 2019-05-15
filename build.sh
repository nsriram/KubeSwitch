#!/bin/bash

clean() {
xcodebuild clean -workspace KubeSwitch.xcworkspace \
  -scheme KubeSwitch \
  -destination 'platform=OS X,arch=x86_64' | xcpretty
}

build() {
xcodebuild build -workspace KubeSwitch.xcworkspace \
  -scheme KubeSwitch \
  -destination 'platform=OS X,arch=x86_64'  | xcpretty
}

test() {
xcodebuild test -workspace KubeSwitch.xcworkspace \
  -scheme KubeSwitch \
  -destination 'platform=OS X,arch=x86_64' | xcpretty	
}

clean_and_build() {
  clean
  build
}

if [ $# -eq 0 ]; then
	echo "[Info] Default clean and build"
	clean_and_build
    exit
fi

if [ "$1" == "build" ]; then
	echo "[Info] Executing clean and build"
	clean_and_build
elif [ "$1" == "test" ]; then
	echo "[Info] Executing clean, build, test"
	clean_and_build
	test
elif [ "$1" == "clean" ]; then
	echo "[Info] Executing clean"
	clean
else
	echo "[Warn] Invalid option"
	echo "[Warn] Usage: build.sh clean (or) build.sh build (or) build.sh test"
fi

exit
