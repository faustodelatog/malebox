class Tapa < ActiveRecord::Base

  belongs_to :empaque, required: false
  
end
