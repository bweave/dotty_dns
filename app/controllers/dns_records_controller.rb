class DnsRecordsController < ApplicationController
  before_action :set_dns_record, only: %i[show edit update destroy]

  # GET /dns_records
  def index
    relation =
      if params[:search].present?
        DnsRecord.where("domain LIKE ?", "#{params[:search]}%")
      else
        DnsRecord.all
      end

    @pagy, @dns_records = pagy(relation)
  end

  # GET /dns_records/1
  def show
  end

  # GET /dns_records/new
  def new
    @dns_record = DnsRecord.new
  end

  # GET /dns_records/1/edit
  def edit
  end

  # POST /dns_records
  def create
    @dns_record = DnsRecord.new(dns_record_params)

    if @dns_record.save
      redirect_to dns_records_path,
                  notice: "Dns record was successfully created.",
                  status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dns_records/1
  def update
    if @dns_record.update(dns_record_params)
      redirect_to dns_records_path,
                  notice: "Dns record was successfully updated.",
                  status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /dns_records/1
  def destroy
    @dns_record.destroy!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = "Dns record was successfully deleted."
      end
      format.html do
        redirect_to dns_records_path,
                    notice: "Dns record was successfully deleted.",
                    status: :see_other
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dns_record
    @dns_record = DnsRecord.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def dns_record_params
    params.require(:dns_record).permit(:domain, :ip_address)
  end
end
