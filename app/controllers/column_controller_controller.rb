class ColumnControllerController < ApplicationController
  def index
		@database = Database.find(params[:database_id])
		@table = @database.tables.find(params[:table_id]) 
		@column = @table.columns
  end

  def show
		@database = Database.find(params[:database_id]) 
		@table = @database.tables.find(params[:table_id]) 
		@column = @table.columns.find(params[:id])
	end

  def edit
		@database = Database.find(params[:database_id]) 
		@table = @database.tables.find(params[:table_id]) 
		@column = @table.columns.find(params[:id])
  end

  def create
		@database = Database.find(params[database_id])
		@table = @database.tables.find(params[:table_id])
		@column = @table.columns.build

		if @column.save
			redirect_to_column_url(@column)
		else
			render :action => "new"
		end
  end

  def destroy
		@database = Database.find(params[:database_id])
		@table = @database.tables.find(params[:table_id])
		@column = @table.column.find(params[:id])
		@column.destroy

		respond_to do |format|
			format.html {
				redirect_to_database_tables_columns_path(@database) }
		end
  end

end
