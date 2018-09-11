Pod::Spec.new do |s|
  s.name             = 'EFKeyboardToolBar'
  s.version          = '0.0.1'
  s.summary          = 'A keyboard toolBar in Swift.'

  s.description      = <<-DESC
A keyboard toolBar in Swift, inspired by KeyboardToolBar.
                       DESC

  s.homepage         = 'https://github.com/EyreFree/EFKeyboardToolBar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EyreFree' => 'eyrefree@eyrefree.org' }
  s.source           = { :git => 'https://github.com/EyreFree/EFKeyboardToolBar.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EyreFree777'

  s.ios.deployment_target = '8.0'

  s.requires_arc = true

  s.source_files = 'EFKeyboardToolBar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'EFKeyboardToolBar' => ['EFKeyboardToolBar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
