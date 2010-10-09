require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"
require "spec"
require "spec/rake/spectask"

Spec::Rake::SpecTask.new do |t|
  t.spec_opts = %w(--format specdoc --colour)
  t.libs = ["spec"]
end

task :default => ["spec"]

spec = Gem::Specification.new do |s|
  s.name              = "blazy"
  s.version           = "0.1.2"
  s.summary           = "Provides fluent extension to active record models"
  s.description       = "Blazy read as be_lazy is a fluent extension to active record models and meant only to be used in script/console"
  s.author            = "Deepak N"
  s.email             = "endeep123@gmail.com"
  s.homepage          = "http://github.com/endeepak/blazy"
  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(README.rdoc)
  s.rdoc_options      = %w(--main README.rdoc)
  s.files             = %w(Rakefile README.rdoc) + Dir.glob("{spec,lib/**/*}")
  s.require_paths     = ["lib"]
  s.add_development_dependency('rspec', '= 1.3.0')
  s.add_development_dependency('activerecord', '= 2.3.5')
  s.add_development_dependency('active_support', '= 2.3.5')
  s.add_development_dependency('factory_girl', '= 1.2.4')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

desc "Install the gem locally"
task :install => :gem do
  sh %{gem install pkg/#{spec.name}-#{spec.version}}
end

desc "Uninstall the gem"
task :uninstall do
  sh %{gem uninstall #{spec.name}}
end

task :package => :gemspec

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end
