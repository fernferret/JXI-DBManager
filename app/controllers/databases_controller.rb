class DatabasesController < ApplicationController
  # Make sure the user is authenticated once we have an auth controller
  # before_filter :auth, :except => :index
  def index
    @databases = Database.all
    current_user = UserSession.find
    user_id = current_user && current_user.record.id
    @mydatabases = Database.find(:all, :conditions => {:user_id => user_id})
    respond_to do |format|
      format.html
    end
  end

  def show
    @database = Database.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def edit
    @database = Database.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @database = Database.find(params[:id])
    @database.user = current_user 
    respond_to do |format|
      if @database.update_attributes(params[:database])
        flash[:notice] = 'Updated Database successfully'
        format.html {redirect_to(@database)}
      else
        format.html {render :action => "edit"}
      end
    end
  end

  def new
    @database = Database.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @database = Database.new(params[:database])
    @database.user = current_user 
    respond_to do |format|
      if @database.save
        flash[:notice] = 'Created new Database successfully'
        format.html {redirect_to(@database)}
      else
        format.html {render :action => "new"}
      end
    end
  end

  def destroy
    @database = Database.find(params[:id])
    @database.destroy
    respond_to do |format|
      format.html { redirect_to(databases_url) }
    end
  end

	def destroy_database(user)
		@database = Database.find(params[:id])
		if @database.user == user || user.permissions == "admin"
			@database.destroy
			flash[:notice] = 'Sucessfully removed database'
			format.html { redirect_to(@database) }	
		else
			format.html { "You don't have permissions to destroy this database" }
		end
	end
end
