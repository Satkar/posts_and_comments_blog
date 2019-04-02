App.room = App.cable.subscriptions.create "CommentNotificationsChannel",
  received: (data) ->
    $('#' + data['id']).append data['message']
