class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    if user_signed_in?
      redirect_to loggedin_path
      return
    end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if not @user.id.equal?(current_user.id)
      redirect_to :back, alert: "You don't have the permission to edit the user."
    end
  end

  # POST /users
  # POST /users.json
  # shouldn't be able to access this method if not logged in
  # shouldn't create a new user while logged in
  def create
    if user_signed_in?
      redirect_to loggedin_path
      return
    end
#    @user = User.new(user_params)

#    respond_to do |format|
#      if @user.save
#        format.html { redirect_to @user, notice: 'User was successfully created.' }
 #       format.json { render :show, status: :created, location: @user }
  #    else
    #    format.html { render :new }
      #  format.json { render json: @user.errors, status: :unprocessable_entity }
   #   end
 #   end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if not @user.id.equal?(current_user.id)
      redirect_to :back, alert: "You don't have the permission to edit the user."
      return
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if not @user.id.equal?(current_user.id)
      redirect_to :back, alert: "You don't have the permission to delete the user."
      return
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end
end
