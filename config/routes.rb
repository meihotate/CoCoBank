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
    get "counselor_index" => "users#counselor_index", as: "admin_counselor"

  	resources :admins, only:[:index, :show, :edit, :update]

  end

  #User側
  namespace :users do
    get "quit" => "users#quit", as: "quit"
    patch "quit" => "users#clear", as: "clear"
    get "/:user_id/show" => "users#show", as: "show"
    get "editing" => "users#edit", as: "editing"
    patch "updating" => "users#update", as: "update"
    get "index" => "users#index", as: "users"
    get "counselor_index" => "users#counselor_index", as: "counselor"
    get "/:user_id/detail" => "users#detail", as: "detail"
    post "profile_image" => "profile_images#create", as: "profile_images"
    patch "profile_image" => "profile_images#update", as: "profile_image"
    get "chatroom/:id" => "chatrooms#show", as: "chatroom"
    post "chatroom" => "chatrooms#create", as: "chatrooms"
    post "chatmembers" => "chatmembers#create", as: "chatmembers"
    post "chatmessages" => "chatmessages#create", as: "chatmessages"
    post "relationship" => "relationships#create", as:"following"
    patch "relationship" => "relationships#update", as:"followed"
    post "friendship" => "friendships#create", as:"from_user"
    patch "friendship" => "friendships#update", as:"to_user"
    patch "friendship_reject" => "friendships#update_reject", as:"to_user_reject"

    resources :watson_reqs, only:[:show, :edit, :update, :new, :create] do
      resource :watson_results, only:[:show, :create, :update]
    end

  end

end
