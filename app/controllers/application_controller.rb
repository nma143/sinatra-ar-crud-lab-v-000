
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  post '/posts' do
    Post.create(name: params[:post][:name], content: params[:post][:content])
    @posts = Post.all
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @oldpost = Post.find_by(id: params[:id])

    erb :edit
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  patch '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    @post.name = params[:post][:name]
    @post.content =  params[:post][:content]
    @post.save
    @posts = Post.all
    erb :index
  end

  delete '/posts/:id/delete' do
    @post = Post.find_by(id: params[:id])
    @post.destroy
    erb :delete
  end
end
