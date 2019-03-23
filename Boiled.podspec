#
#  Be sure to run `pod spec lint Boiled.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  	s.platform     			= :ios, "10.0"
  	s.name         			= "Boiled"
  	s.version      			= "0.0.1"
  	s.summary      			= "Boiler plate code that I use in all my projects."
  	s.description  			= "Boiler plate provides a flow, a screen coordinator and the mechanism to create a component."
  	s.license      			= "MIT"
  	s.homepage 				= "https://github.com/TerrickMansur/Boiled"
  	s.author             	= { "Terrick Mansur" => "terrickmansur@gmail.com" }
  	s.social_media_url   	= "https://twitter.com/tepsmansur"

  	s.source       			= { :git => "https://github.com/TerrickMansur/Boiled.git", :tag => "#{s.version}" }

	s.source_files			= "Boiled/**/*.{h,m,swift}"
	s.resources 			= ["Boiled/**/*.storyboard"]

	s.dependency 'ReactiveKit'

end
