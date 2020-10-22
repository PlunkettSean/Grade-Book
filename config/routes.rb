Rails.application.routes.draw do
 	get "courses" => "courses#index"
	get "courses/new" => "courses#new"
 	post "courses" => "courses#create"
	get "students" => "students#index"
end
