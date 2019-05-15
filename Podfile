platform :osx, '10.12'

use_frameworks!

target "KubeSwitch" do
  pod 'Yams', '~> 2.0'
end

def test_dependency_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'KubeSwitchTests' do
  test_dependency_pods
end
