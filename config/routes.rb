Rails.application.routes.draw do
  resources :posts, only: [:index, :show, :new, :create,
                           :edit, :update, :destroy]
  resources :archives, only: [:index]
  resources :tags, only: [:index, :show]

  resources :top_posts, only: [:index]

  scope "/api" do
    post "/parse_markdown", to: "api/markdown_parser#parse"
    resources :tags, only: [:create]
  end

  get "/search", to: "searches#index", as: :search
  get "/admin", to: "admin#index", as: :admin

  root to: "posts#index"
end
