class ListsController < ApplicationController
  def index
    @lists = List.all
    @banner_url = "https://pipewrenchmag.com/wp-content/uploads/2022/01/Darkened-Movie-Theater-scaled.jpg"
    @banner_text = "Save any kind of movie"
    @default_url = "https://live.staticflickr.com/2693/4146363535_bcca17a8b6_b.jpg"
  end

  def show
    @list = List.find(params[:id])
    if @list.photo.key.nil?
      @banner_url = "https://live.staticflickr.com/2693/4146363535_bcca17a8b6_b.jpg"
    else
      @banner_url = @list.photo
    end
    @banner_text = @list.name
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.photo.nil?
      @list.photo.key = "https://live.staticflickr.com/2693/4146363535_bcca17a8b6_b.jpg"
    end
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
