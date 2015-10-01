Gem::Specification.new do |s|
	s.name = 'wst-parser'
	s.version = '0.2.2'
	s.date = '2015-10-01'
	s.summary = 'Web Site Today Parser'
	s.description = 'Parse content of a wst instance'
	s.authors = ['Yves Brissaud']
	s.email = 'yves.brissaud@gmail.com'
	all_files       = `git ls-files -z`.split("\x0")
	s.files         = all_files.grep(%r{^(bin|lib)/})
	s.executables   = all_files.grep(%r{^bin/}) { |f| File.basename(f) }
	s.require_paths = ['lib']
	s.homepage = 'https://github.com/eunomie/wst-parser'
	s.license = 'MIT'
end
