class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  mount_uploader :file, FileUploader

  def file_name
    file.try(:file).try(:filename)
  end
end
