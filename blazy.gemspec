# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{blazy}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Deepak N"]
  s.date = %q{2010-10-03}
  s.description = %q{Blazy read as be_lazy is a handy extension to active record models meant to be used in script/console}
  s.email = %q{endeep123@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["Rakefile", "README.rdoc", "spec", "lib/blazy.rb", "lib/extensions", "lib/extensions/active_model.rb", "lib/extensions/active_record.rb", "lib/extensions/class.rb"]
  s.homepage = %q{http://github.com/endeepak/blazy}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Provides extension to active record models}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<active_support>, [">= 0"])
      s.add_development_dependency(%q<factory_girl>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<active_support>, [">= 0"])
      s.add_dependency(%q<factory_girl>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<active_support>, [">= 0"])
    s.add_dependency(%q<factory_girl>, [">= 0"])
  end
end
