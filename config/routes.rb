Rails.application.routes.draw do
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :archives, only: [:index]

  scope "/api" do
    post "/parse_markdown", to: "api/markdown_parser#parse"
    resources :tags, only: [:create]
  end

  get "/admin", to: "admin#index", as: :admin

  root to: "posts#index"
end
