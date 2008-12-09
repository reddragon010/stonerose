class ContentController < ApplicationController
  def show
    render :action => params[:path].join('/')
  end
  
  def home
    render :action => 'content/home'
  end
end
