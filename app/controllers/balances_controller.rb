class BalancesController < ApplicationController
  def index
    @balances = Balance.all
  end

  def show
    @balance = Balance.find(params[:id])
  end

  def new
    @balance = Balance.new
    @balance_file = BalanceFile.new
  end

  def edit
    @balance = Balance.find(params[:id])
  end

  def create
    @balance = Balance.new(params[:balance])
    @balance_file = BalanceFile.new(params[:balance_file])

    if @balance_file.valid?
      redirect_to @balance, notice: 'Arquivo enviado com sucesso.'
    else
      render action: "new"
    end
  end

  def update
    @balance = Balance.find(params[:id])

    if @balance.update_attributes(params[:balance])
      redirect_to @balance, notice: 'Balance was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @balance = Balance.find(params[:id])
    @balance.destroy
    redirect_to balances_url
  end
end
