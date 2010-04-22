class DatabasesController < ApplicationController
  # Make sure the user is authenticated once we have an auth controller
  # before_filter :auth
  def index
    @databases = Database.all
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

  def new
    @database = Database.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @database = Database.new(params[:database])
    respond_to do |format|
      if @database.save
        flash[:notice] = 'Created new Database successfully'
        format.html {redirect_to(@database)}
      else
        format.html {render :action => "new"}
      end
    end
  end
end
