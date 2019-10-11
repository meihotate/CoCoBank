class Users::ChatroomsController < ApplicationController
  def show
    chatroom = Chatroom.find(params[:id])
    if current_user.id.to_s != params[:other_user_id]
      # binding.pry
        if Chatmember.with_deleted.where(chatroom_id: params[:id], user_id: current_user.id) != ([] || nil) && Chatmember.with_deleted.where(chatroom_id: params[:id], user_id: params[:other_user_id]) != ([] || nil)
            # binding.pry
            nowdate = DateTime.now
            chatroom.update(accesstime: nowdate)
            @member = Chatmember.with_deleted.find_by(user_id: current_user.id, chatroom_id: chatroom.id)
            @other_user = User.with_deleted.find(params[:other_user_id])
            @message = Chatmessage.new

            if Chatmessage.with_deleted.where(chatroom_id: chatroom.id)
              @chatmessages = Chatmessage.with_deleted.where(chatroom_id: chatroom.id).order(created_at: :asc)
            end
        else
            flash[:notice] = "不正なアクセスです"
            redirect_to users_show_path(current_user)
        end
    else
      flash[:notice] = "不正なアクセスです"
      redirect_to users_show_path(current_user)
    end
  end

  def create
  end
end
