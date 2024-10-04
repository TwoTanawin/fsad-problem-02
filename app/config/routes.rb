Rails.application.routes.draw do
  resources :quotations, only: [ :new, :create, :index, :show ] do
    member do
      post "kill"
    end
    collection do
      delete "erase_personalization"
    end
    collection do
      get "import"
      post "import"
    end
  end

  resources :categories
  resources :pages
  resources :sql_tasks

  root "pages#index"
  # root "quotations#index"
  get "quotations", to: "quotations#index", as: "quotations_index"
  get "sql_tasks", to: "sql_tasks#index", as: "sql_tasks_index"
end
