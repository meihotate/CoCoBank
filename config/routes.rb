Rails.application.routes.draw do
  devise_for :admins, :controllers => {
		:sessions => 'admins/sessions' ,
		:passwords => 'admins/passwords'
	}
  devise_for :users, :controllers => {
		:sessions => 'users/sessions' ,
		:passwords => 'users/passwords',
    :registrations => 'users/registrations'
	}

  root 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Admin側
  namespace :admins do
  	patch "users/:user_id/approve" => "admins#appro", as: "admin_approve"

  	resources :admins, only:[:show, :edit, :update]

  end

  #User側
  namespace :users do
    get "quit" => "users#quit", as: "user_quit"
    patch "quit" => "users#clear", as: "user_clear"
    get "show" => "users#show", as: "user_show"
    get "editing" => "users#edit", as: "user_editing"
    patch "updating" => "users#update", as: "update"
    get "index" => "users#index", as: "users"
    get "counselor_index" => "users#counselor_index", as: "users_counselor"
    get "detail" => "users#detail", as: "users_detail"
    post "profile_image" => "profile_images#create", as: "user_profile_images"
    patch "profile_image" => "profile_images#update", as: "user_profile_image"
    get "chatroom" => "chatrooms#show", as: "user_chatroom"
    post "chatroom" => "chatrooms#create", as: "user_chatrooms"
    post "chatmembers" => "chatmembers#create", as: "user_chatmembers"
    post "chatmessages" => "chatmessages#create", as: "user_chatmessages"
    post "relationship" => "relationships#create", as:"user_following"
    patch "relationship" => "relationships#update", as:"user_followed"
  end

end
