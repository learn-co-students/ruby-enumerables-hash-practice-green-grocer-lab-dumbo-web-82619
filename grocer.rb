require "pry"

def consolidate_cart(cart)
  # code here
  new = {}
  cart.each do |items|
    binding.pry 
    items.each do |item, price|
      new[item] ||= price
      new[item] [:count] ? new [item][:count] += 1 : 
      new[item][:count] = 1
    end 
  end
    new 
end

def apply_coupons(cart, coupons) 
  
  coupons.each do |coupon| 
    coupon.each do |key, value| 
      name = coupon[:item] 
    
      if cart[name] && cart[name][:count] >= coupon[:num] 
        if cart["#{name} W/COUPON"] 
          cart["#{name} W/COUPON"][:count] += 1 
        else 
          cart["#{name} W/COUPON"] = {:price => coupon[:cost], 
          :clearance => cart[name][:clearance], :count => 1} 
        end 
  
      cart[name][:count] -= coupon[:num] 
    end 
  end 
end 
  cart 
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
