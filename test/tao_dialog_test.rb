require 'test_helper'

class TaoDialogTest < ActiveSupport::TestCase

  test 'version number' do
    assert TaoDialog::VERSION.is_a? String
  end

  test 'TaoDialog::Engine inherits from Rails::Engine' do
    assert TaoDialog::Engine < Rails::Engine
  end

end
