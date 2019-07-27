module ApplicationHelper
  def number_to_idr(number)
    number_to_currency(number, :unit => "Rp", :negative_format => "(%u%n)",  :separator => ",", :delimiter => ".")
  end
end
