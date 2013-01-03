class ReelClipsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /reels/1/2
  # GET /reels/1/2.json
  def add
    @reel = Reel.find(params[:reel_id])
    next_order = @reel.reel_clips.length > 0 ? @reel.reel_clips.last.order.to_i + 1 : 0
    
    @clip = Clip.find(params[:clip_id])
    @reel_clip = @reel.reel_clips.new
    @reel_clip.clip_id = @clip.id
    @reel_clip.order = next_order

    puts @reel_clip.inspect

    respond_to do |format|
      if @reel_clip.save
        format.html { redirect_to reel_path(@reel, :anchor => 'clip-' + @clip.id.to_s), notice: 'Reel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reels/1/2
  # PUT /reels/1/2.json
  def remove
    @reel = Reel.find(params[:reel_id])
    @clip = Clip.find(params[:clip_id])

    respond_to do |format|
      if @reel.clips.delete(@clip)
        format.html { redirect_to reel_path(@reel, :anchor => 'clip-' + @clip.id.to_s), notice: 'Reel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reel.errors, status: :unprocessable_entity }
      end
    end
  end

end
