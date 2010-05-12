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
		@database = @table.database
		db = Mysql.connect('137.112.150.54', 'root', 'root', @database.name)
		@database.issue_query(@database.user, @database.use_dbsql, db)
		@database.issue_query(@database.user, @table.rename_table(params[:table]['name']), db)

    respond_to do |format|
      if @table.update_attributes(params[:table])
				flash[:notice] = @table.rename_table(params[:table]['name']) 
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
			db = Mysql.connect('137.112.150.54', 'root', 'root', @database.name)
			@database.issue_query(@database.user, @database.use_dbsql, db)
			@database.issue_query(@database.user, @table.create_dbsql, db)
			redirect_to(@table)
		else
			render :action => "new"
		end
  end

  def destroy
		@table = Table.find(params[:id])
		@database = Database.find(@table.database_id)
		db = Mysql.connect('137.112.150.54', 'root', 'root', @database.name)
		@database.issue_query(@database.user, @database.use_dbsql, db)
		@database.issue_query(@database.user, @table.drop_dbsql, db)
		@table.destroy

		respond_to do |format|
			format.html { (@database) }
		end
  end

end
