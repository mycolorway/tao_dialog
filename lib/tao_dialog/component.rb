module TaoDialog
  class Component < TaoOnRails::Components::Base

    def initialize view, options = {}
      super

      if @options[:class].present?
        @options[:class] += ' tao-dialog'
      else
        @options[:class] = 'tao-dialog'
      end
    end

  end
end
