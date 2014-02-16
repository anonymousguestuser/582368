class StylesController < ApplicationController
  before_action :set_style, only: [:show]

  def index
    @styles = Style.all
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_style
    @style = Style.find(params[:id])
  end

end