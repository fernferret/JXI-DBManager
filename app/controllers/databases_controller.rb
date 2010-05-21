class DatabasesController < ApplicationController
  # Make sure the user is authenticated once we have an auth controller
  # before_filter :auth, :except => :index
  def index
    @databases = Database.all
    current_user = UserSession.find
    user_id = current_user && current_user.record.id
		@user = User.find(:first, :conditions => {:id => user_id})
    @mydatabases = Database.find(:all, :conditions => {:user_id => user_id})
		@sdatabases = []
	  Database.all.each do |db|
			if db.users.include?(@user)
				@sdatabases << db
			end
		end	
    respond_to do |format|
      format.html
    end
  end

  def show
    @database = Database.find(params[:id])
    @sharedwith = User.find(:all, :conditions)
    if @database.view_database(current_user);
      respond_to do |format|
        format.html
      end
    else
      respond_to do |format|
        flash[:notice] = I18n.t(:permdenied)
        format.html { redirect_to(:controller => "databases", :action => "index") }
      end
    end
  end

  def edit
    @database = Database.find(params[:id])
    @users = User.find(:all)
    respond_to do |format|
      format.html
    end
  end

  def update
    @database = Database.find(params[:id])
		#We can't rename a database in mysql
    respond_to do |format|
      if @database.update_attributes(params[:database])
        flash[:notice] = I18n.t(:updatedbsucc)
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
		@database.users = [current_user]
    respond_to do |format|
      if @database.save
				db = Mysql.connect('localhost', 'root', 'root', 'test_db')
				@database.issue_query(current_user, @database.create_dbsql, db)
        flash[:notice] = I18n.t(:createdbsucc)
        format.html {redirect_to(@database)}
      else
        format.html {render :action => "new"}
      end
    end
  end

  def destroy
    @database = Database.find(params[:id])
		db = Mysql.connect('localhost', 'root', 'root', @database.name)
		@database.issue_query(@database.user, @database.drop_dbsql, db)
    @database.destroy
    respond_to do |format|
      format.html { redirect_to(databases_url) }
    end
  end

  def destroy_database(user)
    @database = Database.find(params[:id])
    if @database.user == user || user.permissions == "admin"
      @database.destroy
      flash[:notice] = I18n.t(:removesuccess)
      format.html { redirect_to(@database) }	
    else
      format.html { I18n.t(:permdenieddestroy) }
    end
  end
end
