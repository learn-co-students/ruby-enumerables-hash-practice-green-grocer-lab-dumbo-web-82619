require "pry"
def consolidate_cart(cart)
  new = {}
  cart.each do |item|
    key = item.keys[0]
    value = item.values[0]
    if new[key]
      new[key][:count] += 1
   else
     new[key] = value
     new[key][:count] = 1
   end
  end
  new
end

def apply_coupons(cart, coupons)
  index = 0 
  coupons.each do |coupon|
    item = coupon[:item]
    cost = coupon[:cost]
    coupon_num = coupon[:num]
    if cart.keys.include?(item) && cart[item][:count] >= coupon_num
      cart[item][:count] -= coupon_num
      if cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"][:count]+= coupon_num
      else
      cart["#{item} W/COUPON"] = {:price => cost/coupon_num, :clearance => cart[item][:clearance], :count => coupon_num} 
     end
   end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item|
    item_name = item[0]
    if cart[item_name][:clearance] == true
      cart[item_name][:price] = (cart[item_name][:price]*0.8).round(1)
    end
  end
 cart
end


def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  if coupons 
    cart = apply_coupons(cart, coupons)
  end
  #binding.pry
  cart = apply_clearance(cart)
  #binding.pry
  total = cart.reduce(0) do |total, item|
    total += item[1][:price] * item[1][:count]
    total
  end
  if total > 100
    total = total*0.9.round(1)
  end
  total
  #binding.pry
end
