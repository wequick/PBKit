Pod::Spec.new do |s|
  s.name             = 'PBKit'
  s.version          = '0.1.1'
  s.summary          = 'UIKit with Pbind.'
  s.description      = <<-DESC
A group of UI components that using Pbind which can simply configure layout and data source with Plist.
                       DESC

  s.homepage         = 'https://github.com/wequick/PBKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'galenlin' => 'oolgloo.2012@gmail.com' }
  s.source           = { :git => 'https://github.com/wequick/PBKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://weibo.com/galenlin'

  s.ios.deployment_target = '7.0'

#  s.source_files = 'PBKit/Classes/**/*'

  s.subspec 'PBDropdownMenu' do |sub|
    sub.source_files = 'PBKit/Classes/PBDropdownMenu/**/*'
  end

  s.dependency 'Pbind' 
end
