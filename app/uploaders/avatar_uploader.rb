# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  storage :file
  def default_url(*args)
    "/assets/" + [version_name, "no_avatar.gif"].compact.join('_')
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
