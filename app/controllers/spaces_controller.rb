
class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy, :users, :add_user]
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :new, :create, :users, :add_user]
  before_action :verify_tenant

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.by_user_plan_and_tenant(params[:tenant_id], current_user)
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = Space.new(space_params)
    @space.users << current_user
    respond_to do |format|
      if @space.save
        format.html { redirect_to root_url, notice: 'Space was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to root_url, notice: 'Space was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def users
    @space_users = (@space.users + (User.where(tenant_id: @tenant.id, is_admin: true))) - [current_user]
    @other_users = @tenant.users.where(is_admin: false) - (@space_users + [current_user])
  end

  def add_user
    @space_user = UserSpace.new(user_id: params[:user_id], space_id: @space.id)

    respond_to do |format|
      if @space_user.save
        format.html { redirect_to users_tenant_space_url(id: @space.id, tenant_id: @space.tenant_id),
          notice: "User was successfully added to space" }
      else
        format.html { redirect_to users_tenant_space_url(id: @space.id, tenant_id: @space.tenant_id),
          error: "User was not added to space" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = Space.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:title, :details, :expected_completion_date, :tenant_id)
    end

    def set_tenant
      @tenant = Tenant.find(params[:tenant_id])
    end

    def verify_tenant
      unless params[:tenant_id] == Tenant.current_tenant_id.to_s
        redirect_to :root,
              flash: { error: 'You are not authorized to access any organization other than your own'}
      end
    end
end