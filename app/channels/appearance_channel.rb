class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance_channel"
    #current_user.appear
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def appear(data)
    current_user.appear(on: data['appearing_on'])
    puts current_user.id
    puts data['appearing_on']
  end

  def away(data)
    current_user.away(on: data['appearing_on'])
  end
end
