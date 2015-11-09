#
# Be sure to run `pod lib lint JZMultiChoicesCircleButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JZMultiChoicesCircleButton"
  s.version          = "0.1.5"
  s.summary          = "Multi-choices button with 3D parallax effect."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  

  s.homepage         = "https://github.com/JustinFincher/JZMultiChoicesCircleButton"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Fincher Justin" => "zhtsu47@me.com" }
  s.source           = { :git => "https://github.com/JustinFincher/JZMultiChoicesCircleButton.git", :tag => s.version.to_s }
  s.social_media_url = 'http://fincher.im/'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'JZMultiChoicesCircleButton' => ['Pod/Assets/*.png']
  }
end
