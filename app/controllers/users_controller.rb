class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  before_filter :su_login_required, :only => [:edit,:update,:destroy, :toggleAdmin, :toggleSuperAdmin]

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def index
    @users = User.find(:all)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def toggleAdmin
    @user = User.find(params[:id])
    if @user.admin
      @user.admin = false
    else
      @user.admin = true
    end
    @user.save
    redirect_to(:action => "index")
  end
  
  def toggleSuperAdmin
    @user = User.find(params[:id])
    if @user.superadmin
      @user.superadmin = false
    else
      @user.superadmin = true
    end
    @user.save
    redirect_to(:action => "index")    
  end
end
