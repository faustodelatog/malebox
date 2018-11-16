class Empaque < ActiveRecord::Base
	has_many :tapas

	def tapa_ids
		tapas.map{|t| t.id}.join(',')
	end
end
