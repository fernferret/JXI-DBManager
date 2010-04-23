class TableControllerController < ApplicationController
  def index
		@database = Database.find(params[:database_id])
		@tables = @database.tables

		respond_to do |format|
			format.html
		end
  end

  def show
		@database = Database.find(params[:database_id])
		@table = @database.tables.find(params[:id])
  end

  def edit
		@database = Database.find(params[:database_id])
		@table = @database.table.find(params[:id])
  end

  def create
		@database = Database.find(params[:database_id])
		@table = @database.tables.build

		if @table.save
			redirect_to_table_url(@table)
		else
			render :action => "new"
		end
  end

  def destroy
		@database = Database.find(params[:database_id])
		@table = @database.table.find(params[:id])
		@table.destroy

		respond_to do |format|
			format.html { redirect_to_database_tables_path(@database) }
		end
  end

end
