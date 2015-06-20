class RegistrosController < ApplicationController
  before_action :set_registro, only: [:show, :edit, :update, :destroy]

  # GET /registros
  # GET /registros.json
  def index
    @registros = current_user.registros.all
  end

  def export
    @data = Registro.order(:created_at)
    respond_to do |format|
     format.html { redirect_to root_url }
     format.csv { send_data @data.to_csv }
    end
  end

  # GET /registros/1
  # GET /registros/1.json
  def show
  end

  # GET /registros/new
  def new
    @registro = Registro.new
    @cur_user = current_user.id;
  end

  # GET /registros/1/edit
  def edit
  end

  # POST /registros
  # POST /registros.json
  def create
    @registro = Registro.new(registro_params)
    @registro.user_id = current_user.id
    respond_to do |format|
      if @registro.save
        format.html { redirect_to @registro, notice: 'Registro was successfully created.' }
        format.json { render :show, status: :created, location: @registro }
      else
        format.html { render :new }
        format.json { render json: @registro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registros/1
  # PATCH/PUT /registros/1.json
  def update
    respond_to do |format|
      if @registro.update(registro_params)
        format.html { redirect_to @registro, notice: 'Registro was successfully updated.' }
        format.json { render :show, status: :ok, location: @registro }
      else
        format.html { render :edit }
        format.json { render json: @registro.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # DELETE /registros/1
  # DELETE /registros/1.json
  def destroy
    @registro.destroy
    respond_to do |format|
      format.html { redirect_to registros_url, notice: 'Registro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registro
      @registro = Registro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registro_params
      params.require(:registro).permit(:media, :channel, :h_inicio, :h_final, :location, :user_id)
    end
end
