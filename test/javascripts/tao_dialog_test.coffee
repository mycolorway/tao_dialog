{module, test} = QUnit

module 'TaoDialog',

  beforeEach: (assert) ->
    done = assert.async()

    @taoDialog = $('''
      <tao-dialog/>
    ''').appendTo('body').get(0)

    setTimeout -> done()

  afterEach: ->
    @taoDialog.jq.remove()
    @taoDialog = null

, ->

  test 'inherits from TaoComponent', (assert) ->
    assert.ok @taoDialog instanceof TaoComponent
