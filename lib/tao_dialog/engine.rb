require 'tao_on_rails'
require 'tao_dialog/component'

module TaoDialog
  class Engine < Rails::Engine
    paths['app/views'] << 'lib/views'
  end
end
