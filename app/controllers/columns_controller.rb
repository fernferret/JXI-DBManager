class ColumnsController < ApplicationController
  def index
    @table = Table.find(params[:table_id]) 
    @column = @table.columns
  end

  def show
    @column = Column.find(params[:id])
  end

  def edit
    @column = Column.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def update
    @column = Column.find(params[:id])
    respond_to do |format|
      if @column.update_attributes(params[:column])
        flash[:notice] = 'Updated Database successfully'
        format.html {redirect_to(root_url)}
      else
        format.html {render :action => "edit"}
      end
    end
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
    #@database = Database.find(params[:database_id])
    #@table = @database.tables.find(params[:table_id])
    @column = Column.find(params[:id]) 
    @column.destroy

    respond_to do |format|
      format.html {
        redirect_to(:controller => 'databases', :action => 'index') 
			}
    end
  end
end
