class PaintingsController < ApplicationController
  before_filter :artist?, except: [:index, :show]

  # Public actions
  def index
    search = params[:search].gsub("-", " ")
    begin
      Integer(search)
      @gallery = Gallery.find(search)
    rescue ArgumentError
      @gallery = Gallery.find_by(title: search)
    end

    @paintings = @gallery.paintings
  end

  def show
    search = params[:search].gsub("-", " ")
    begin
      Integer(search)
      @gallery = Gallery.find(search)
    rescue ArgumentError
      @gallery = Gallery.find_by(title: search)
    end

    painting = params[:painting].gsub("-", " ")
    begin
      Integer(painting)
      @painting = @gallery.paintings.find(painting)
    rescue ArgumentError
      @painting = @gallery.paintings.find_by(title: painting)
    end
  end

  # Private actions
  def new
    @painting = Painting.new
  end

  def create
    if @gallery.paintings.create(painting_params).valid?
      redirect_to change_paintings_path(@gallery.id), notice: "Painting created"
    else
      redirect_to :back, alert: "Validation errors"
    end
  end

  def change
    @paintings = @gallery.paintings
  end

  def update
    @painting = @gallery.paintings.find(params[:id])
    if @painting.update_attributes(painting_params)
      redirect_to change_paintings_path(@gallery.id), notice: "Painting updated"
    else
      redirect_to :back, alert: "Validation errors"
    end
  end

  def edit
    @painting = @gallery.paintings.find(params[:id])
  end

  def destroy
    @painting = @gallery.paintings.find(params[:id])
    @painting.destroy
    redirect_to change_paintings_path(@gallery.id), notice: "Painting destroyed"
  end

  private
  def artist?
    @gallery = @current_user.galleries.find(params[:gallery_id]) if @current_user

    if !@current_user.try(:artist?) || !@gallery
      redirect_to root_path, alert: "Invalid url"
    end
  end

  def painting_params
    params.require(:painting).permit(:url, :title, :description)
  end
end
