require_dependency "uplodar/application_controller"

module Uplodar
  class BrowserController < ApplicationController
    before_filter :authenticate_user!

    def index
      setup(params[:share], params[:path])
      authorize! :read, @share
    end

    def create
      setup(params[:browser][:share], params[:browser][:path])
      authorize! :write, @share

      if !params[:browser][:new_file].blank?
        FsManager.save_file(@fsm.current_path, params[:browser][:new_file])
        write_event("Upload", "#{File.join(@fsm.current_path, params[:browser][:new_file].original_filename)}")

      elsif !params[:browser][:new_dir].blank?
        FsManager.make_dir(@fsm.current_path, params[:browser][:new_dir])
        write_event("Create", "#{File.join(@fsm.current_path, params[:browser][:new_dir])}")

      else
        redirect_to root_url && return
      end
    end

    def edit
      setup(params[:share], params[:path])
      authorize! :write, @share
      @entry  = params[:entry]
    end

    def update
      setup(params[:browser][:share], params[:browser][:path])
      authorize! :write, @share

      @path      = @fsm.current_path
      @new_path  = params[:browser][:new_path].blank? ? @path : File.join(@fsm.current_path, params[:browser][:new_path])

      #TODO: this has to be reviewd
      @entry     = params[:browser][:entry]
      @new_entry = params[:browser][:new_entry].blank? ? @entry : params[:browser][:new_entry]

      FsManager.move(File.join(@path, @entry), File.join(@new_path, @new_entry))
      write_event("Move", "#{File.join(@path, @entry)} --> #{File.join(@new_path, @new_entry)}")
    end


    def delete
      setup(params[:share], params[:path])
      authorize! :write, @share

      FsManager.delete(@fsm.current_path, params[:entry])
      write_event("Delete", "#{File.join(@fsm.current_path, params[:entry])}")
    end

    private

    def setup(share, path)
      @share  = (current_user.is_uplodar_admin? ? Share : current_user.shares).where(:name => share).first
      @fsm    = FsManager.new(@share, path)
      rel_url = relative_url_root
      mnt_url = Rails.application.routes.named_routes[:uplodar].path
      mnt_url =  mnt_url.spec.to_s if mnt_url.respond_to?(:spec)
      @suburi = rel_url.blank? ? mnt_url.to_s : File.join(rel_url, mnt_url).to_s
    end

    def write_event(action, msg)
      Event.create(:share_id => @share.id, :user_id => current_user.id, :action => action, :msg => msg)
    end

  end
end
