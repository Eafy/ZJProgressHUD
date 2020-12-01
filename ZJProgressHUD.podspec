Pod::Spec.new do |s|
  s.name         = "ZJProgressHUD"
  s.version      = "1.0.7"
  s.summary      = "Provide tips hud for iOS Platform."

  s.description  = <<-DESC
    Provide tips hud for iOS Platform.
                   DESC

  s.homepage     = "https://github.com/Eafy/ZJProgressHUD"
  s.license      = { :type => "MIT"}
  s.author       = 'Eafy'
  s.requires_arc = true
  s.ios.deployment_target   = '9.0'
  s.frameworks = 'UIKit','CoreGraphics'

  s.source       = { :git => "https://github.com/Eafy/ZJProgressHUD.git", :tag => "v#{s.version}"}
  s.source_files  = "ZJProgressHUD/*.{h,m,mm,c,hpp,cpp}", "ZJProgressHUD/**/*.{h,m,mm,c,hpp,cpp}"
  s.public_header_files = "ZJBaseUtils/ZJProgressHUD.h"
  
  s.resource_bundles = {
    'ZJProgressHUD' => ['ZJProgressHUD/Resources/*.png']
  }

end

#校验指令
#pod lib lint ZJProgressHUD.podspec --verbose --allow-warnings --use-libraries
#打包指令
#pod package ZJProgressHUD.podspec --force --no-mangle --exclude-deps --verbose
#推送命令
#pod trunk push ZJProgressHUD.podspec --verbose --allow-warnings --use-libraries
