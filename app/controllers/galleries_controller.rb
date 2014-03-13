class GalleriesController < ApplicationController
  before_filter :artist?, except: [:index, :show]

  def index
    @galleries = Gallery.public
  end

  def show
    search = params[:search].gsub("-", " ")
    begin
      Integer(search)
      @gallery = Gallery.find(search)
    rescue ArgumentError
      search = params[:search].gsub("-", " ")
      @gallery = Gallery.find_by(title: search)
    end
  end

  # Private actions
  def new
    @gallery = Gallery.new
    @paintings = @gallery.paintings
  end

  def create
    if @current_user.galleries.create(gallery_params).valid?
      redirect_to :back, notice: "Gallery created, but is still private!"
    else
      redirect_to :back, alert: "Validation errors"
    end
  end

  def change
    @galleries = @current_user.galleries
    @private = @galleries.private
    @public = @galleries.public
  end

  def update
    @gallery = @current_user.galleries.find(params[:id])
    if @gallery.update_attributes(gallery_params)
      redirect_to :back, notice: "Gallery updated"
    else
      redirect_to :back, alert: "Validation errors"
    end
  end

  def edit
    @gallery = @current_user.galleries.find(params[:id])
    @paintings = @gallery.paintings
  end

  def publish
    @gallery = @current_user.galleries.find(params[:id])

    redirect_to root_path, alert: "Invalid action" if @gallery.public?
    @gallery.update_attributes(private: false, published_at: DateTime.now)
    redirect_to :back, notice: "Gallery published"
  end

  def unpublish
    @gallery = @current_user.galleries.find(params[:id])

    redirect_to root_path, alert: "Invalid action" if @gallery.private?
    @gallery.update_attributes(private: true, published_at: nil)
    redirect_to :back, notice: "Gallery unpublished"
  end

  def destroy
    @gallery = @current_user.galleries.find(params[:id])
    @gallery.destroy
    redirect_to :back, notice: "Gallery destroyed"
  end

  private
  def artist?
    redirect_to root_path, alert: "Invalid url" unless @current_user.try(:artist?)
  end

  def gallery_params
    params.require(:gallery).permit(:cover_id, :title, :description)
  end
end
