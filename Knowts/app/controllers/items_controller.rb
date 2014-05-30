class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @list = List.find_by_id params[:list_id]
    @workspace = @list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "You have no permission to view the items"
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find_by_id params[:id]
    @workspace = @item.list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "You have no permission to view the item"
    end
  end

  # GET /items/new
  def new
    @list = List.find_by_id params[:list_id]
    @workspace = @list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "You have no permission to create item in this workspace"
    end
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find_by_id params[:id]
    @workspace = @item.list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "You have no permission to edit the items"
    end
  end

  # POST /items
  # POST /items.json
  def create
    @list = List.find_by_id params[:list_id]
    @workspace = @list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "You have no permission to create the items"
      return
    end
    @item = @list.items.create item_params
    @list.save
    respond_to do |format|
      if @item.save
        format.html { redirect_to @workspace, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @item = Item.find_by_id params[:id]
    @workspace = @item.list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "You have no permission to edit the items"
      return
    end
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @workspace, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @workspace }
      else
        format.html { render :edit }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  def addme
    @item = Item.find_by_id params[:id]
    @workspace = @item.list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "You have no permission add yourself to the item."
      return
    end
    if not @item.users.include? current_user
      @item.users << current_user
      @item.save
      redirect_to @workspace, notice: 'User added to item'
    else
      redirect_to @workspace
    end
  end

  def removeme
    @item = Item.find_by_id params[:id]
    @workspace = @item.list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "Denied permission"
      return
    end
    if @item.users.include? current_user
      @item.users.delete(current_user)
      @item.save
      redirect_to @workspace, notice: 'User removed from item'
    else
      redirect_to @workspace
    end
  end

  def toggledone
    @item = Item.find_by_id params[:id]
    @workspace = @item.list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "Denied permission"
      return
    end

    # this is a hack, because ruby complains about item.completed = not item.completed
    @item.completed = !@item.completed
    @item.save
    redirect_to @workspace
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find_by_id params[:id]
    @workspace = @item.list.workspace
    if not @workspace.users.include? current_user
      redirect_to workspaces_path, alert: "Denied permission"
      return
    end
    @item.destroy
    respond_to do |format|
      format.html { redirect_to @workspace, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:content, :due)
    end
end
