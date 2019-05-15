xcodebuild clean build test -workspace KubeSwitch.xcworkspace \
  -scheme KubeSwitch \
  -destination 'platform=OS X,arch=x86_64' | xcpretty
