Rails.application.routes.draw do
 	get "students" => "students#index"
 	get "students/new" => "students#new"
 	post "students" => "students#create"

  get "courses" => "courses#index"
  get "courses/new" => "courses#new"
  post "courses" => "courses#create"

  get "assignments" => "assignments#index"
  get "assignments/new" => "assignments#new"
  post "assignments" => "assignments#create"

  get "students/:id" => "students#show"
  get "courses/:id" => "courses#show"

	get "students/:id/edit" => "students#edit"
	patch "students/:id" => "students#update"
	delete "students/:id" => "students#destroy"

	get "courses/:id/edit" => "courses#edit"
  patch "courses/:id" => "courses#update"
 	delete "courses/:id" => "courses#destroy"
end 
