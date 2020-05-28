Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    get "/all_products" => "products#all_products"
    get "/single_product" => "products#single_product"
    get "/any_product" => "products#any_product"
    get "/any_product/:id" => "products#any_product"
  end
end
