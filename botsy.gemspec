require File.dirname(__FILE__) + '/lib/botsy/version'

spec = Gem::Specification.new do |s|
  
  s.name = 'botsy'
  s.author = 'John Crepezzi'
  s.add_development_dependency('rspec')
  s.add_dependency('yajl-ruby', '~> 0.8.1')
  s.description = 'Smart-ass robot'
  s.email = 'john.crepezzi@patch.com'
  s.files = Dir['lib/**/*.rb']
  s.has_rdoc = true
  s.homepage = 'http://seejohnrun.github.com/botsy/'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.summary = 'Robot that does what he wants'
  s.test_files = Dir.glob('spec/*.rb')
  s.version = Botsy::VERSION
  s.rubyforge_project = 'botsy'

end
