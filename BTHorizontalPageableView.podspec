Pod::Spec.new do |s|

    s.name                  = "BTHorizontalPageableView"
    s.version               = "0.1.1"
    s.summary               = "Horizontal pageable scroll view with tabs."
    s.platform              = :ios
    s.ios.deployment_target = '8.0'
    s.description           =  "Add custom views and titles to generate a view linking views and titles."
    s.requires_arc          = true
    s.license               = { :type => "MIT", :file => "LICENSE" }
    s.author                = "Rodrigo Gonzalez"
    s.homepage              = "https://github.com/rdgonzalez85/BTHorizontalPageableView"
    s.source                = { :git => "https://github.com/rdgonzalez85/BTHorizontalPageableView.git", :tag => "#{s.version}"}
    s.source_files          = "BTHorizontalPageableView/BTHorizontalPageableView/*.{swift}"

end
