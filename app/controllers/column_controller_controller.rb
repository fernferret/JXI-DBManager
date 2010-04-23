class ColumnControllerController < ApplicationController
  def index
		@columns = Column.all

		respond_to do |format|
			format.html
		end
  end

  def show
		@column = Column.find(params[:id])

		respond_to do |format|
			formatl.html
		end
  end

  def edit
		@column = Column.find(params[:id])
  end

  def create
		@column = Column.new(params[:column])
		
		respond_to do |format|
			format.html { render :action => "new" }
		end
  end

  def destroy
		@column = Column.find(params[:id])
		@column.destroy

		respond_to do |format|
			format.html { redirect_to(columns_url) }
		end
  end

end
