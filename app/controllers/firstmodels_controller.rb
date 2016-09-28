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
      results = @firstmodel.search_yelp(@firstmodel.name)
      @yelp_results = []
      results.businesses.each do |result|
        @yelp_results.push(result)
      end
      @hash = Gmaps4rails.build_markers(@yelp_results) do |result, marker|
        marker.lat result.location.coordinate.latitude
        marker.lng result.location.coordinate.longitude
        marker.infowindow "#{result.name} phone: #{result.phone}"
        # marker.picture({
        #   "url" => result.snippet_image_url,
        #   "width" => 100,
        #   "height" => 100
        #   })
        marker.json({ title: result.name })
      end
      @firstmodels = Firstmodel.all
      flash[:notice] = "Firstmodel saved successfully"
      render :index
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
