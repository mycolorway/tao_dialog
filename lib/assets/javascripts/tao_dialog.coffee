class TaoDialog extends TaoComponent

  @tag 'tao-dialog'

  @attribute 'modal', type: 'boolean', default: true

  @attribute 'closeable', type: 'boolean', default: true

  @attribute 'active', type: 'boolean', default: true, observe: true

  @attribute 'closeActionSelector', type: 'string', default: '.close, .close-button'

  _connected: ->
    @wrapper = @jq.find '.tao-dialog-wrapper'
    @jq.addClass 'modal' if @modal

    @_setMaxHeight()
    @_bind()
    @_show() if @active

  _bind: ->
    @on 'click.tao-dialog', (e) =>
      @close() if $(e.target).is('tao-dialog') && @closeable

    @on 'click.tao-dialog', @closeActionSelector, => @close()

    $(window).on "resize.tao-dialog-#{@taoId}", => @_setMaxHeight()

  _activeChanged: ->
    if @active then @_show() else @_close()

  show: ->
    @active = true unless @active

  close: ->
    @active = false if @active

  _show: ->
    $('body').addClass 'tao-dialog-open'
    @jq.show() && Tao.helpers.reflow(@jq)
    @jq.addClass 'open'

  _close: ->
    @jq.trigger 'before-close.tao-dialog'
    @jq.removeClass 'open'
    @wrapper.one 'transitionend', =>
      $('body').removeClass 'tao-dialog-open'
      @jq.hide().trigger 'closed.tao-dialog'

  _setMaxHeight: ->
    @wrapper.css 'maxHeight', document.documentElement.clientHeight - 40

  _disconnected: ->
    @off '.tao-dialog'
    $(window).off "resize.tao-dialog-#{@taoId}"

TaoComponent.register TaoDialog
