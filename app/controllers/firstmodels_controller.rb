class FirstmodelsController < ApplicationController
  def index
    @firstmodels = Firstmodel.all
  end
  def show
    @firstmodel = Firstmodel.find(params[:id])
  end
  def edit
    @firstmodel = Firstmodel.find(params[:id])
  end
  def new
    @firstmodel = Firstmodel.new
  end
  def create
    @firstmodel = Firstmodel.create(firstmodel_params)
    if @firstmodel
      flash[:notice] = "Firstmodel saved successfully"
      redirect_to firstmodels_path
    else
      flash[:alert] = "Firstmodel failed to save"
      render :new
    end
  end
  def update
    @firstmodel = Firstmodel.find(params[:id])
    @firstmodel = @firstmodel.update(firstmodel_params)
    redirect_to firstmodels_path
  end
  def destroy
    @firstmodel = Firstmodel.find(params[:id])
    if @firstmodel.delete
      flash[:notice] = "Firstmodel deleted"
      redirect_to firstmodels_path
    else
      flash[:alert] = "Firstmodel failed to delete"
    end
  end
  private
  def firstmodel_params
    params.require(:firstmodel).permit(:name)
  end
end
