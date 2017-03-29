(function() {
  var TaoDialog,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  TaoDialog = (function(superClass) {
    extend(TaoDialog, superClass);

    function TaoDialog() {
      return TaoDialog.__super__.constructor.apply(this, arguments);
    }

    TaoDialog.tag('tao-dialog');

    TaoDialog.attribute('modal', {
      type: 'boolean',
      "default": true
    });

    TaoDialog.attribute('closeable', {
      type: 'boolean',
      "default": true
    });

    TaoDialog.attribute('active', {
      type: 'boolean',
      "default": true,
      observe: true
    });

    TaoDialog.attribute('closeActionSelector', {
      type: 'string',
      "default": '.close, .close-button'
    });

    TaoDialog.prototype._connected = function() {
      this.wrapper = this.jq.find('.tao-dialog-wrapper');
      if (this.modal) {
        this.jq.addClass('modal');
      }
      this._setMaxHeight();
      this._bind();
      if (this.active) {
        return this._show();
      }
    };

    TaoDialog.prototype._bind = function() {
      this.on('click.tao-dialog', (function(_this) {
        return function(e) {
          if ($(e.target).is('tao-dialog') && _this.closeable) {
            return _this.close();
          }
        };
      })(this));
      this.on('click.tao-dialog', this.closeActionSelector, (function(_this) {
        return function() {
          return _this.close();
        };
      })(this));
      return $(window).on("resize.tao-dialog-" + this.taoId, (function(_this) {
        return function() {
          return _this._setMaxHeight();
        };
      })(this));
    };

    TaoDialog.prototype._activeChanged = function() {
      if (this.active) {
        return this._show();
      } else {
        return this._close();
      }
    };

    TaoDialog.prototype.show = function() {
      if (!this.active) {
        return this.active = true;
      }
    };

    TaoDialog.prototype.close = function() {
      if (this.active) {
        return this.active = false;
      }
    };

    TaoDialog.prototype._show = function() {
      $('body').addClass('tao-dialog-open');
      this.jq.show() && Tao.helpers.reflow(this.jq);
      return this.jq.addClass('open');
    };

    TaoDialog.prototype._close = function() {
      this.jq.trigger('before-close.tao-dialog');
      this.jq.removeClass('open');
      return this.wrapper.one('transitionend', (function(_this) {
        return function() {
          $('body').removeClass('tao-dialog-open');
          return _this.jq.hide().trigger('closed.tao-dialog');
        };
      })(this));
    };

    TaoDialog.prototype._setMaxHeight = function() {
      return this.wrapper.css('maxHeight', document.documentElement.clientHeight - 40);
    };

    TaoDialog.prototype._disconnected = function() {
      this.off('.tao-dialog');
      return $(window).off("resize.tao-dialog-" + this.taoId);
    };

    return TaoDialog;

  })(TaoComponent);

  TaoComponent.register(TaoDialog);

}).call(this);
