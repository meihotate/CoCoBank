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
    patch "users/:user_id/reject" => "admins#reject", as: "admin_reject"
    get "counselor_index" => "admins#counselor_index", as: "admin_counselor"
    get "users/:user_id/detail" => "admins#detail", as: "admin_user_detail"
    get "chatroom/:id/:user_id/:other_user_id" => "chatrooms#show", as: "adminschatroom"
    delete "/:user_id/destroy" => "admins#destroy", as: "destroy"

  	resources :admins, only:[:index, :show, :edit, :update]

  end

  #User側
  namespace :users do
    get "/:user_id/quit" => "users#quit", as: "quit"
    delete "/:user_id/destroy" => "users#destroy", as: "destroy"
    get "/:id/show" => "users#show", as: "show"
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
    delete "relationship" => "relationships#destroy", as:"followed"
    post "friendship" => "friendships#create", as:"from_user"
    patch "friendship" => "friendships#update", as:"to_user"
    patch "friendship_reject" => "friendships#update_reject", as:"to_user_reject"

    resources :watson_reqs, only:[:show, :edit, :update, :new, :create, :index]

  end
  # Refileが生成するRoutingはautomountではなく手動で設定する
  # https://github.com/refile/refile#mounting
  # https://qiita.com/yaqi/items/115e08e1c83243a87db7
  # config/initializers/refile.rbを作ってautomountを無効にする（Refile.automount = false）
  mount Refile::App.new, at: Refile.mount_point, as: :refile_app
  # 未定義のroutingにいったらtopに飛ばす
  get '*pages' => 'home#top'

end
