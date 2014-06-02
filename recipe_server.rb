require_relative 'recipe_methods'
require 'sinatra'

get '/' do
  redirect '/recipes'
end

get '/recipes' do
  @recipes = get_recipe_names()
  erb :index
end

get '/recipes/:id' do
  @recipe_id = params[:id]
  @recipe, @ingredients = get_recipe(@recipe_id)
  erb :recipe
end
