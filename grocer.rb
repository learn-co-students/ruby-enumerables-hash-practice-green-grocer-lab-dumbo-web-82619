require 'pry'

def consolidate_cart(cart)
  ordered_cart = {}
  i = 0 
  while i < cart.length do 
    ordered_cart[cart[i].keys[0]] = cart[i].values[0]
    ordered_cart[cart[i].keys[0]][:count] = cart.count(cart[i])
    i += 1 
  end 
  ordered_cart
end

def apply_coupons(cart, coupons)
  i = 0 
  while i < coupons.length do 
    if cart.has_key?("#{coupons[i][:item]} W/COUPON") and coupons[i][:num] <= cart[coupons[i][:item]][:count]
      cart["#{coupons[i][:item]} W/COUPON"][:count] += coupons[i][:num]
      cart[coupons[i][:item]][:count] -= coupons[i][:num]
    elsif cart.has_key?(coupons[i][:item]) and coupons[i][:num] <= cart[coupons[i][:item]][:count]
      cart[coupons[i][:item]][:count] -= coupons[i][:num]
      cart["#{coupons[i][:item]} W/COUPON"] = 
      {
        :price => (coupons[i][:cost] / coupons[i][:num]), 
        :clearance => cart[coupons[i][:item]][:clearance], 
        :count => coupons[i][:num]
      }
    end
    i += 1 
  end
  cart
end

def apply_clearance(cart)
  cart.each do |key, value|
    if cart[key][:clearance]
     cart[key][:price] = (cart[key][:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  ordered = consolidate_cart(cart)
  order_discounted = apply_coupons(ordered, coupons)
  clearanced = apply_clearance(order_discounted)
  total = clearanced.reduce(0) do
    |total, item| 
    total = total + (item[1][:price] * item[1][:count])
    total
   end
  if total > 100
    discounted_total = (total * 0.9).round(2)
    discounted_total
  else
    total
  end
end



