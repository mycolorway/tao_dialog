# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)

require 'tao_dialog/version'

Gem::Specification.new do |spec|
  spec.name          = 'tao_dialog'
  spec.version       = TaoDialog::VERSION
  spec.authors       = ['heroicyang']
  spec.email         = ['yangxiong@mycolorway.com']

  spec.homepage      = 'https://github.com/mycolorway/tao_dialog'
  spec.summary       = 'Dialog component based on tao framework.'
  spec.description   = 'Dialog component based on tao framework.'
  spec.license       = "MIT"

  spec.files = Dir["{lib,vendor}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "tao_on_rails", "~> 0.7.0"

  spec.add_development_dependency "blade", "~> 0.7.0"
  spec.add_development_dependency "blade-sauce_labs_plugin", "~> 0.6.2"
end
