class CakeStyle < ActiveRecord::Base
	has_many :orders, inverse_of: :cake_style

	before_destroy :check_for_orders

	has_attached_file :style_photo, styles: { medium: "300x300>", thumb: "150x150#" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :style_photo, content_type: /\Aimage\/.*\Z/

  	scope :current_styles, -> { where("current = ?", true) }

  	scope :recent, -> { order(created_at: :desc)}

private

	def check_for_orders
		if orders.any?
			errors[:base] << "cannot delete Cake Style that has orders"
		return false
		end
	end

end
