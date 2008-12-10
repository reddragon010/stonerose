require 'fileutils'
class AttachmentController < ApplicationController
  UPLOADED = "/uploaded"
  UPLOADED_ROOT = RAILS_ROOT + "/public" + UPLOADED
  MIME_TYPES = [
    "image/jpeg",
    "image/gif",
    "image/png",
    "application/x-shockwave-flash"
  ]
   def command
    self.send params[:Command]
  end

  def GetFolders
    self.GetFoldersAndFiles(false)
  end

  def GetFoldersAndFiles(include_files = true)
    @url = UPLOADED + params[:CurrentFolder]
    @folders = Array.new
    @files = {}
    @current_folder = UPLOADED_ROOT + params[:CurrentFolder]
    Dir.entries(@current_folder).each do |entry|
      next if entry =~ /^\./
      path = @current_folder + entry
      @folders.push entry if FileTest.directory?(path)
      @files[entry] = (File.size(path) / 1024) if (include_files and FileTest.file?(path))
    end

  def CreateFolder
    @url = UPLOADED_ROOT + params[:CurrentFolder]
    path = @url + params[:NewFolderName]
    if !(File.stat(@url).writable?)
      @errorNumber = 103
    elsif params[:CurrentFolder] !~ /[\w\d\s]+/
      @errorNumber = 102
    elsif FileTest.exists?(path)
      @errorNumber = 101
    else
      Dir.mkdir(path,0775)
      @errorNumber = 0
    end
  rescue => e
    @errorNumber = 110 if @errorNumber.nil?
  end
&  end

  def FileUpload
  begin
    ftype = params[:NewFile].content_type.strip
    if ! MIME_TYPES.include?(ftype)
      @errorNumber = 202
      raise "#{ftype} is invalid MIME type"
    else
      dir = UPLOADED_ROOT + (params[:CurrentFolder] ? params[:CurrentFolder] : "/")
      path = dir + params[:NewFile].original_filename
      File.open(path,"wb",0664) do |fp|
        FileUtils.copy_stream(params[:NewFile], fp)
      end
      @errorNumber = 0
    end
  rescue => e
    @errorNumber = 110 if @errorNumber.nil?
  end
    render :text => <<-EOL
    <script type="text/javascript">
    window.parent.frames['frmUpload'].OnUploadCompleted(#{@errorNumber});
    </script>
    EOL
  end
  
  def upload
    self.FileUpload
  end
end
