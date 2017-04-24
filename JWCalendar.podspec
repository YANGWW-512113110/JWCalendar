Pod::Spec.new do |s|

s.name         = "JWCalendar"
s.version      = "0.0.7"
s.summary      = "日历控件."
s.homepage     = "https://github.com/YANGWW-512113110/JWCalendar"
s.license      = "MIT"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.authors             = { "YANGWW" => "512113110@qq.com" }
s.platform     = :ios,"8.0"
s.source       = { :git => "https://github.com/YANGWW-512113110/JWCalendar.git", :tag => "#{s.version}" }
s.source_files = "Classes", "JWCalendar/*"

# 资源文件
# s.resource  = "resource.bundle"

s.requires_arc = true

#s.public_header_files = '/macro-jw.pch'
#s.prefix_header_contents
#s.prefix_header_contents = '#import "macro-jw.pch"'

# 项目依赖其它的第三方库
# s.dependency "JSONKit", "~> 1.4"

s.dependency "JWCategory_"

end
