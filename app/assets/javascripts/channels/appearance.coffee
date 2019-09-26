App.appearance = App.cable.subscriptions.create "AppearanceChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log("test1")
    @install()
    @appear()
    console.log(@install)
    console.log(@appear)

  disconnected: (data) ->
    # Called when the subscription has been terminated by the server
    console.log(data)
    @uninstall(data)

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log data['on']
    a = data['on']
    console.log data['event']
    if data['event'] == 'appear'
      $('#login_' + a ).html('<p>ログイン中</p>');
    else
      console.log("ログアウトした？");
      $('#logout_' + a ).html('<p></p>');

  appear: () ->
    console.log("test4")
    @perform("appear", "appearing_on": $("#login").data("name"))

  install: ->
    console.log("test6")
    $(document).on "load.appearance", =>
      console.log("test6")
      @appear()
    $(document).on "click.appearance", buttonSelector, =>
      console.log("test7")
      @away()
      false
    $(buttonSelector).show()

  uninstall: (data) ->
    console.log("test8")
    $(document).off(".appearance")
    $(window).off(".appearance")
    $(buttonSelector).hide()
    $('#logout_' + data['on'] ).html('<p></p>');

  away: ->
    console.log("test5")
    @perform("away", "appearing_on": $("#login").data("name"))

  buttonSelector = "[data-behavior~=appear_away]"
  console.log(buttonSelector)

