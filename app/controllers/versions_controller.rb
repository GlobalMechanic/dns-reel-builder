class VersionsController < ApplicationController

  # GET %/version/1
  # GET %/version/1.json
  def show
    @version = Version.find(params[:id])
    @version.object = YAML.load(@version.object).except('created_at', 'updated_at', 'thumbnail_file_name', 'thumbnail_content_type', 'thumbnail_file_size', 'thumbnail_updated_at', 'id');
    @clip = Clip.new(@version.object)
    respond_to do |format|
      format.html { render :template => "clips/show" }
      format.json { render json: @version }
    end
  end

end
