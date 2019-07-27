class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  before_validation :generate_number, on: :create
  
  state_machine :state, initial: :pending do
    event :proceed do
      transition to: :complete
    end

    event :cancel do
      transition to: :canceled
    end
  end

  def calculate_total(qty)
    self.total = qty * self.product.price
    self.save
  end

  def generate_number(options = {})
    options[:length]  ||= 5
    options[:letters] ||= false
    options[:prefix]  ||= "SHQ"

    possible = (0..9).to_a
    possible += ('A'..'Z').to_a if options[:letters]
    self.number ||= loop do
      # Make a random number.
      random = "#{options[:prefix]}#{(0...options[:length]).map { possible.sample }.join}"
      # Use the random  number if no other order exists with it.
      if self.class.exists?(number: random)
        # If over half of all possible options are taken add another digit.
        options[:length] += 1 if self.class.count > (10**options[:length] / 2)
      else
        break random
      end
    end
  end
end
