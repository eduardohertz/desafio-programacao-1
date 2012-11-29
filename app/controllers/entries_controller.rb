class EntriesController < ApplicationController
  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new
    @entry_file = EntryFile.new
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def create
    @entry = Entry.new(params[:entry])
    @entry_file = EntryFile.new(params[:entry_file])

    if @entry_file.valid?
      @entry_file.parse
      redirect_to @entry, notice: 'Arquivo enviado com sucesso.'
    else
      render action: "new"
    end
  end

  def update
    @entry = Entry.find(params[:id])

    if @entry.update_attributes(params[:entry])
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to entries_url
  end
end