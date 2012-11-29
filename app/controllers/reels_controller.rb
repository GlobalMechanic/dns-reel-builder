class ReelsController < ApplicationController

  # GET /reels
  # GET /reels.json
  def index
    @reels = Reel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reels }
    end
  end

  # GET /reels/1
  # GET /reels/1.json
  def show
    @reel = Reel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reel }
    end
  end

  # GET /reels/new
  # GET /reels/new.json
  def new
    @reel = current_user.reels.new
    #@reel.user = current_user
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reel }
    end
  end

  # GET /reels/1/edit
  def edit
    @reel = Reel.find(params[:id])
  end

  # POST /reels
  # POST /reels.json
  def create
    @reel = current_user.reels.new(params[:reel])
   # @reel.user = current_user
    respond_to do |format|
      if @reel.save
        format.html { redirect_to @reel, notice: 'Reel was successfully created.' }
        format.json { render json: @reel, status: :created, location: @reel }
      else
        format.html { render action: "new" }
        format.json { render json: @reel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reels/1
  # PUT /reels/1.json
  def update
    @reel = Reel.find(params[:id])

    respond_to do |format|
      if @reel.update_attributes(params[:reel])
        format.html { redirect_to @reel, notice: 'Reel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reels/1
  # DELETE /reels/1.json
  def destroy
    @reel = Reel.find(params[:id])
    @reel.destroy

    respond_to do |format|
      format.html { redirect_to reels_url }
      format.json { head :no_content }
    end
  end

end
