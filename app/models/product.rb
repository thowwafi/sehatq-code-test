class Product < ApplicationRecord
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }

  def update_quantity(qty)
    self.quantity = self.quantity - qty
    self.save
  end

  def return_quantity(qty)
    self.quantity = self.quantity + qty
    self.save
  end
end
