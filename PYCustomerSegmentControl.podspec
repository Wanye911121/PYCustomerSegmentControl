

Pod::Spec.new do |s|



  s.name         = "PYCustomerSegmentControl"
  s.version      = "0.0.1"
  s.summary      = "A SegmentControl"
  s.homepage     = "https://github.com/MikeZhangpy/PYCustomerSegmentControl"

  s.license      = {
        :type => 'MIT',
        :file => 'LICENSE'
  }

  s.author       = { 
	"MikeZhangpy" => "zhangpy1991@126.com" 
  }

  s.source       = {
        :git => 'https://github.com/MikeZhangpy/PYCustomerSegmentControl.git',
        :tag => s.version.to_s
    }

  s.requires_arc      = true

  s.source_files      = 'PYSegmentControl/*.{m,h}'
end
