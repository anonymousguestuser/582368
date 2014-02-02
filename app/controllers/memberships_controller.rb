class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @beer_clubs = BeerClub.all
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)
    @membership.attributes = {user: current_user}
    respond_to do |format|
      unless current_user.beer_clubs.include?@membership.beer_club
        @membership.save
        format.html { redirect_to current_user, notice: 'Club successfully joined.' }
        format.json { render action: 'show', status: :created, location: @membership }
      else
        @beer_clubs = BeerClub.all
        format.html { render action: 'new' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  #def update
  #  respond_to do |format|
  #    if @membership.update(membership_params)
  #      format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @membership.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy if current_user == @membership.user
    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:user_id, :beer_club_id)
    end
end
