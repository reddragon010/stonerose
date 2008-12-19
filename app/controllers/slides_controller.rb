class SlidesController < ApplicationController  
  def index
    @slides = Article.find(:all, :conditions => "start <= datetime('now','localtime') AND stop >= datetime('now','localtime')", :order => "weight")
  end
  
  def show
    @slide = Article.find(params[:id])
    render :action => "show", :layout => "preview"
  end
  
end
