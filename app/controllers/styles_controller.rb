class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit]

  def index
    @styles = Style.all
  end

  def show
  end

  def new
    @style = Style.new
  end

  def create
    @style = Style.new(style_params)

    respond_to do |format|
      if @style.save
        format.html { redirect_to @style, notice: 'Style was successfully created.' }
        format.json { render action: 'show', status: :created, location: @style }
      else
        format.html { render action: 'new' }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_style
    @style = Style.find(params[:id])
  end

  def style_params
    params.require(:style).permit(:name, :description)
  end

end