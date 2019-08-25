require "pry"

def consolidate_cart (cart)
  new_cart = {}
  cart.each do |item|
    item.each do |item_name, value_hash|
      # binding.pry
      new_cart[item_name] ||= value_hash
      new_cart[item_name][:count] ? new_cart[item_name][:count] += 1 : new_cart[item_name][:count] = 1 
    # binding.pry 
    end 
  end
  new_cart
 #binding.pry
end 

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    if cart[item_name]
      if cart[item_name][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
        if !cart["#{item_name} W/COUPON"]
        cart["#{item_name} W/COUPON"] = 
          {:price => coupon[:cost] / coupon[:num], :clearance => cart[item_name][:clearance], :count => coupon[:num]
          } 
          cart[item_name][:count] -= coupon[:num]
        elsif coupon[:item][:count] >= coupon[:num] && cart.has_key?("#{item_name} W/COUPON")[:count]
        cart["#{item} W/COUPON"][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
        end
      end
    end
  end 
  cart 
end  
