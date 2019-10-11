App.room = App.cable.subscriptions.create "RoomChannel",

  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    current_user_check = $('input:hidden[name="chatuser_id"]').val()
    img = document.getElementById('chatprofileimage')
    imgsrc = img.getAttribute('src')
    if data['chatroom_id'] == $('input:hidden[name="chatroom_id"]').val()
      if current_user_check == data['current_user_id']
        $('#chatmessages').append('<div class="mycomment"><p>' + data['message'] + '</p></div>');
      else
        $('#chatmessages').append('<div class="balloon6"><div class="faceicon">' + '<img src=' + imgsrc + '>' + '</div><div class="chatting"><div class="says"><p>' + data['message'] + '</p></div></div></div>');


  speak: (message, chatroom_id, chatmember_id, current_user_id) ->
    @perform 'speak', "message": message, "chatroom_id": chatroom_id, "chatmember_id":chatmember_id, "current_user_id":current_user_id   # @ = thisなので、 this.perform("speak", "message": message)


  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  	chatroom_id = $('input:hidden[name="chatroom_id"]').val()
  	chatmember_id = $('input:hidden[name="chatmember_id"]').val()
  	current_user_id = $('input:hidden[name="current_user_id"]').val()
  	messagetime = Date.now()

  	if event.keyCode is 13 # return = send
    	App.room.speak(event.target.value, chatroom_id, chatmember_id, current_user_id)
    	event.target.value = ''
    	event.preventDefault()