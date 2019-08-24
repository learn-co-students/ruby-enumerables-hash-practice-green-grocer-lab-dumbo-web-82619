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
    if cart[item_name] && cart[item_name][:count] >= coupon[:num]
      binding.pry 
      if !cart["#{item_name} W/COUPON"]
       # binding.pry
        cart["#{item_name} W/COUPON"] = 
          {
          :price => coupon[:cost] / coupon[:num],
          :clearance => cart[item_name][:clearance],
          :count => 1 
          } 
        else
          cart["#{item_name} W/COUPON"][:count] += 1
        en
      end
      cart[item_name][:count] -= coupon[:num]
      # binding.pry
    end
  end 
  cart 
end  
