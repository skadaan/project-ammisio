class UserSpacesController < ApplicationController
  before_action :set_user_space, only: [:show, :edit, :update, :destroy]

  # GET /user_spaces
  # GET /user_spaces.json
  def index
    @user_spaces = UserSpace.all
  end

  # GET /user_spaces/1
  # GET /user_spaces/1.json
  def show
  end

  # GET /user_spaces/new
  def new
    @user_space = UserSpace.new
  end

  # GET /user_spaces/1/edit
  def edit
  end

  # POST /user_spaces
  # POST /user_spaces.json
  def create
    @user_space = UserSpace.new(user_space_params)

    respond_to do |format|
      if @user_space.save
        format.html { redirect_to @user_space, notice: 'User space was successfully created.' }
        format.json { render :show, status: :created, location: @user_space }
      else
        format.html { render :new }
        format.json { render json: @user_space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_spaces/1
  # PATCH/PUT /user_spaces/1.json
  def update
    respond_to do |format|
      if @user_space.update(user_space_params)
        format.html { redirect_to @user_space, notice: 'User space was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_space }
      else
        format.html { render :edit }
        format.json { render json: @user_space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_spaces/1
  # DELETE /user_spaces/1.json
  def destroy
    @user_space.destroy
    respond_to do |format|
      format.html { redirect_to users_tenant_space_url(id: @user_space.space_id,
        tenant_id: @user_space.space.tenant_id),
        notice: 'User was successfully removed from the space' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_space
      @user_space = UserSpace.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_space_params
      params.require(:user_space).permit(:space_id, :user_id)
    end
end
