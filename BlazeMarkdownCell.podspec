Pod::Spec.new do |s|
  s.name           = 'BlazeMarkdownCell'
  s.version        = '0.0.6'
  s.summary        = 'Markdown-cell addition to Blaze'
  s.license 	   = 'MIT'
  s.description    = 'Useful Markdown-cell addition to Blaze, using TSMarkdownParser and TTTAttributedLabel for performance and link checking'
  s.homepage       = 'https://github.com/BobDG/Blaze-MarkdownCell'
  s.authors        = {'Bob de Graaf' => 'graafict@gmail.com'}
  s.source         = { :git => 'https://github.com/BobDG/Blaze-MarkdownCell.git', :tag => s.version.to_s }
  s.source_files   = 'BlazeMarkdownCell/**/*.{h,m}'
  s.platform       = :ios
  s.requires_arc   = true
  s.dependency     'Blaze'
  s.dependency     'TTTAttributedLabel'
end
