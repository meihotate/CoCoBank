$ ->
  App.appearance = App.cable.subscriptions.create "AppearanceChannel",
    connected: ->
      # Called when the subscription is ready for use on the server
      @install()
      @appear()

    disconnected: (data) ->
      # Called when the subscription has been terminated by the server
      @uninstall(data)

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      a = data['on']
      if data['event'] == 'appear'
        $('#login_' + a ).html('<p class="bgc-yellow bdr-10 texralign-c">ログイン中</p>');
      else
        $('#login_' + a ).html('<p></p>');


    appear: () ->
      @perform("appear", "appearing_on": $("#login").data("name"))

    install: ->
      $(document).on "load.appearance", =>
        @appear()
      $(document).on "click.appearance", buttonSelector, =>
        @away()
        false
      $(buttonSelector).show()

    uninstall: (data) ->
      $(document).off(".appearance")
      $(window).off(".appearance")

    away: ->
      @perform("away", "appearing_on": $("#login").data("name"))
      $('input:hidden[name="deviselogout"]').click();

    buttonSelector = "[data-behavior~=appear_away]"

