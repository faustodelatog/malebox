class ProductoCosa < ActiveRecord::Base
  belongs_to :cosa
  belongs_to :producto
end
