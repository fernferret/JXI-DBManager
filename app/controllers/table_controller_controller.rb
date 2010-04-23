class TableControllerController < ApplicationController
  def index
		@tables = Table.all

		respond_to do |format|
			format.html
		end
  end

  def show
		@table = Table.find(params[:id])

		respond_to do |format|
			format.html
		end
  end

  def edit
		@table = Table.find(params[:id])	
  end

  def create
		@table = Table.new(params[:table])

		respond_to do |format|
			format.html { render :action => "new" }
		end		
  end

  def destroy
		@table = Table.find(params[:id])
		@table.destroy

		respond_to do |format|
			format.html { redirect_to(tables_url) }
		end
  end

end
