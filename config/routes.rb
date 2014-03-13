Lester::Application.routes.draw do
  root "galleries#index"

  # Public routes
  get "login" => "users#login"
  post "signup" => "users#signup"
  post "signin" => "users#signin"
  delete "logout" => "users#logout"

  # Private routes
  get "galleries/new" => "galleries#new", as:"new_gallery"
  put "galleries/create" => "galleries#create", as:"create_gallery"
  get "galleries/change" => "galleries#change", as:"change_galleries"
  get "galleries/:id/edit" => "galleries#edit", as:"edit_gallery"
  post "galleries/:id/update" => "galleries#update", as:"update_gallery"
  delete "galleries/:id/destroy" => "galleries#destroy", as:"destroy_gallery"
  patch "galleries/:id/publish" => "galleries#publish", as: "publish_gallery"
  patch "galleries/:id/unpublish" => "galleries#unpublish", as: "unpublish_gallery"

  get "galleries/:gallery_id/paintings/new" => "paintings#new", as:"new_painting"
  put "galleries/:gallery_id/paintings/create" => "paintings#create", as:"create_painting"
  get "galleries/:gallery_id/paintings/change" => "paintings#change", as:"change_paintings"
  get "galleries/:gallery_id/paintings/:id/edit" => "paintings#edit", as:"edit_painting"
  post "galleries/:gallery_id/paintings/:id/update" => "paintings#update", as:"update_painting"
  delete "galleries/:gallery_id/paintings/:id/destroy" => "paintings#destroy", as:"destroy_painting"

  # Public routes
  root "galleries#index", as: "galleries"
  get "galleries/:search" => "galleries#show", as: "gallery"
  get "galleries/:search/paintings" => "paintings#index", as:"paintings"
  get "galleries/:search/paintings/:painting" => "paintings#show", as:"painting"
end
