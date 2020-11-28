Rails.application.routes.draw do
 	get "students" => "students#index"
 	get "students/new" => "students#new"
 	post "students" => "students#create"

  get "home" => "courses#home"

  get "courses" => "courses#index"
  get "courses/new" => "courses#new"
  post "courses" => "courses#create"

  get "students/:id" => "students#show"
  get "courses/:id/students" => "courses#students"
  get "courses/:id/assignments" => "courses#assignments"
  get "courses/:id/assignments/new" => "assignments#new"
  post "courses/:id/assignments" => "assignments#create"

	get
	patch  
  delete "courses/:id/assignments/:assignmentId" => "assignments#destroy"

  get "courses/:id/edit" => "courses#edit"
  patch "courses/:id" => "courses#update"
  delete "courses/:id" => "courses#destroy"

	get "students/:id/edit" => "students#edit"
	patch "students/:id" => "students#update"
	delete "students/:id" => "students#destroy"	
end 
