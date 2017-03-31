class TaoDialog extends TaoComponent

  @tag 'tao-dialog'

  @attribute 'mask', type: 'boolean', default: true

  @attribute 'maskCloseable', type: 'boolean', default: true

  @attribute 'destroyOnClose', type: 'boolean', default: false

  @attribute 'active', type: 'boolean', default: true, observe: true

  @attribute 'closeActionSelector', type: 'string', default: '.close-dialog'

  _connected: ->
    @wrapper = @jq.find '.tao-dialog-wrapper'
    @jq.addClass 'mask' if @mask

    @_bind()
    @_show() if @active

  _bind: ->
    @on 'click.tao-dialog', (e) =>
      @close() if $(e.target).is('tao-dialog.mask') && @maskCloseable

    @on 'click.tao-dialog', @closeActionSelector, => @close()

    $(document).on "keydown.tao-dialog-#{@taoId}", (e) =>
      @close() if e.which == 27 && @maskCloseable

    $(window).on "resize.tao-dialog-#{@taoId}", => @_setMaxHeight()

  _activeChanged: ->
    if @active then @_show() else @_close()

  show: ->
    @active = true unless @active

  close: ->
    @active = false if @active

  _show: ->
    @_setMaxHeight()

    @jq.show()
    Tao.helpers.reflow @jq

    $('body').addClass 'tao-dialog-open'
    @jq.addClass 'open'

  _close: ->
    @jq.trigger 'before-close.tao-dialog'
    @jq.removeClass 'open'
    @wrapper.one 'transitionend', => @_afterClosed()

  _afterClosed: ->
    $('body').removeClass 'tao-dialog-open'
    @jq.hide().trigger 'closed.tao-dialog'
    @jq.remove() if @destroyOnClose

  _setMaxHeight: ->
    @wrapper.css 'maxHeight', document.documentElement.clientHeight - 40

  _disconnected: ->
    @off '.tao-dialog'
    $(document).off "keydown.tao-dialog-#{@taoId}"
    $(window).off "resize.tao-dialog-#{@taoId}"

TaoComponent.register TaoDialog
