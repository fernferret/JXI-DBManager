class ColumnsController < ApplicationController
  def index
    @table = Table.find(params[:table_id]) 
    @column = @table.columns
  end

  def show
    @column = Column.find(params[:id])
  end

  def edit
    @table = Table.find(params[:table_id]) 
    @column = @table.columns.find(params[:id])
  end

  def new
    @table = Table.find(params[:table_id])
    @column = @table.columns.build
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @table = Table.find(params[:column][:table_id])
    @column = @table.columns.build(params[:column])

	if @column.save
      redirect_to(@table)
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
