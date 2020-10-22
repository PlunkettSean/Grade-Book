Rails.application.routes.draw do
 	get "courses" => "courses#index"
	get "courses/new" => "courses#new"
 	
 	post "courses" => "courses#create"
	get "students" => "students#index"

	get "students/:id/edit" => "students#edit"
	patch "students/:id" => "students#update"
	delete "students/:id" => "students#destroy"
end
