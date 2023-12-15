class BlocklistsController < ApplicationController
  before_action :set_blocklist, only: %i[show edit update refresh destroy]

  # GET /blocklists
  def index
    @blocklists = Blocklist.all
  end

  # GET /blocklists/1
  def show
  end

  # GET /blocklists/new
  def new
    @blocklist = Blocklist.new
  end

  # GET /blocklists/1/edit
  def edit
  end

  # POST /blocklists
  def create
    @blocklist = Blocklist.new(blocklist_params)

    if @blocklist.save
      @blocklist.refresh if params[:blocklist][:refresh] == "1"
      redirect_to @blocklist, notice: "Blocklist was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blocklists/1
  def update
    if @blocklist.update(blocklist_params)
      @blocklist.refresh if params[:blocklist][:refresh] == "1"
      redirect_to @blocklist,
                  notice: "Blocklist was successfully updated.",
                  status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def refresh_all
    Blocklist.find_each(&:refresh)
    # TODO: get Turbo in here
    # TODO: use the job ids to poll the status of the worker
    redirect_to blocklists_path, notice: "Refreshing all lists..."
  end

  def refresh
    @blocklist.refresh
    # TODO: get Turbo in here
    # TODO: use the job id to poll the status of the worker
    redirect_to blocklists_path, notice: "Refreshing list..."
  end

  # DELETE /blocklists/1
  def destroy
    @blocklist.destroy!
    redirect_to blocklists_url,
                notice: "Blocklist was successfully destroyed.",
                status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blocklist
    @blocklist = Blocklist.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def blocklist_params
    params.require(:blocklist).permit(:title, :url)
  end
end
