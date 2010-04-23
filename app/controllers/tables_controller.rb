class TablesController < ApplicationController
  def index
		@database = Database.find(params[:database_id])
		@tables = @database.tables

		respond_to do |format|
			format.html
		end
  end

  def show
		# @database = Database.find(params[:database_id])
		@table = Table.find(params[:id])
  end

  def edit
    @table = Table.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @table = Table.find(params[:id])
    respond_to do |format|
      if @table.update_attributes(params[:table])
        flash[:notice] = 'Updated Table successfully'
        format.html {redirect_to(@table)}
      else
        format.html {render :action => "edit"}
      end
    end
  end

  def new
    @database = Database.find(params[:database_id])
    @table = @database.tables.build
    respond_to do |format|
      format.html
    end
  end

  def create
		@database = Database.find(params[:table][:database_id])
		@table = @database.tables.build(params[:table])
		if @table.save
			redirect_to(@table)
		else
			render :action => "new"
		end
  end

  def destroy
		@table = Table.find(params[:id])
		database = Database.find(@table.database_id)
		@table.destroy

		respond_to do |format|
			format.html { (database) }
		end
  end

end
