class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new_recipe
  end

  post '/recipes/new' do
    recipe = Recipe.create(params)
    recipe.save

    redirect to "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(params[:id])

    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(params[:id])
    erb :edit
  end

  patch '/recipes/:id/edit' do
    @recipe = Recipe.find_by(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]

    redirect to '/recipes/#{@recipe.id}'
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end
end
