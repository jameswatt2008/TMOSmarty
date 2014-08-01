

Pod::Spec.new do |s|


  s.name         = "TMOSmarty"
  s.version      = "1.0.0"
  s.summary      = "TMOSmarty is a template engine for iOS Apps."

  s.description  = <<-DESC
                   Smarty is a PHP template engine. TMOSmarty all thoughts are inherited from the Smarty, we migrate Smarty to Objective-C, so there TMOSmarty.
                   DESC

  s.homepage     = "https://github.com/duowan/TMOSmarty"
  #

  s.license      = "MIT"
  #

  s.author             = { "PonyCui" => "cuiminghui@yy.com" }

  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/duowan/TMOSmarty.git", :tag => "1.0.0" }

  s.source_files  = "Src", "Src/*.{h,m}", "Depends", "Depends/*.{h,m}"

  s.requires_arc = true

#  s.subspec 'asSubModule' do |sm|
#    sm.platform     = :ios, "6.0"
#    sm.source_files = "Src", "Src/*.{h,m}";
#    sm.dependency "teemov2";
#  end


end
