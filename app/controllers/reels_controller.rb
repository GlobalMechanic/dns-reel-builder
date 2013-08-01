class ReelsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  load_and_authorize_resource :except => [:show]

  # GET /reels
  # GET /reels.json
  def index
    @reels = Reel.includes(:clips).where("title <> ''").where("user_id = ?", current_user.id).order('created_at DESC').page(params[:page]).per(params[:number])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reels }
    end
  end

  # GET /reels/1
  # GET /reels/1.json
  def show
    @reel = Reel.includes(:clips).find(params[:id])
    @clips = @reel.clips.order('"order"')
    
    respond_to do |format|
      format.html { render layout: 'public_reel' }
      format.json { render json: @reel }
    end
  end

  # POST /reels/1/sort.json
  def sort
    params[:order].each_with_index do |id, index|
      @reel_clip = ReelClip.find_by_reel_id_and_clip_id(params[:id], id.to_i)
      @reel_clip.order = index
      @reel_clip.save
    end

    respond_to do |format|
      format.json { render json: true }
    end
    
  end

  def close
    current_user.current_reel_slug = nil
    respond_to do |format|
      if current_user.save
        format.html { redirect_to clips_url }
        format.json { head :no_content }
      else
        format.html { redirect_to clips_url, notice: 'For some reason the reel wouldn\'t close. <a href="/reels">Open a new one?</a>'.html_safe }
        format.json { render json: "Couldn't close reel.", status: :unprocessable_entity }
      end
    end
  end

  def open
    # @reel = Reel.find(params[:id])
    set_current_reel_slug params[:id]
    respond_to do |format|
      format.html { redirect_to edit_reel_path params[:id] }
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
    @search = Clip.search(params[:search])
    @reel = Reel.find(params[:id])
    @clips = @reel.clips.order('"order"')
    set_current_reel_slug @reel.id
  end

  # POST /reels
  # POST /reels.json
  def create
    @reel = current_user.reels.new(params[:reel])
    @reel.save
    set_current_reel_slug @reel.id
   # @reel.user = current_user
    respond_to do |format|
      if current_user.save
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
    title = @reel.title?
    if title
      notice = 'Reel was successfully updated.'
    else
      @reel.created_at = Time.now
      notice = 'Reel was successfully created.'
    end
    respond_to do |format|
      if @reel.update_attributes(params[:reel])
        format.html { redirect_to edit_reel_path(@reel), notice: notice }
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

    @blank_reel = current_user.reels.new(params[:reel])
    @blank_reel.save
    set_current_reel_slug @blank_reel.id

    respond_to do |format|
      format.html { redirect_to reels_url }
      format.json { head :no_content }
    end
  end

  private
  def set_current_reel_slug(reel_slug)
    current_user.current_reel_slug = reel_slug
    current_user.save
  end

end
