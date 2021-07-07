require 'pry'

def consolidate_cart(cart)
  ordered_cart = {}
  # i = 0 
  # while i < cart.length do 
  #   ordered_cart[cart[i].keys[0]] = cart[i].values[0]
  #   ordered_cart[cart[i].keys[0]][:count] = cart.count(cart[i])
  #   i += 1 
  # end 
  cart.each do |item|
    if ordered_cart[item.keys[0]]
      ordered_cart[item.keys[0]][:count] += 1 
    else
      ordered_cart[item.keys[0]] = {
        count: 1, 
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
  ordered_cart
end

def apply_coupons(cart, coupons)
  # i = 0 
  # while i < coupons.length do 
  #   if cart.has_key?("#{coupons[i][:item]} W/COUPON") and coupons[i][:num] <= cart[coupons[i][:item]][:count]
  #     cart["#{coupons[i][:item]} W/COUPON"][:count] += coupons[i][:num]
  #     cart[coupons[i][:item]][:count] -= coupons[i][:num]
  #   elsif cart.has_key?(coupons[i][:item]) and coupons[i][:num] <= cart[coupons[i][:item]][:count]
  #     cart[coupons[i][:item]][:count] -= coupons[i][:num]
  #     cart["#{coupons[i][:item]} W/COUPON"] = 
  #     {
  #       :price => (coupons[i][:cost] / coupons[i][:num]), 
  #       :clearance => cart[coupons[i][:item]][:clearance], 
  #       :count => coupons[i][:num]
  #     }
  #   end
  #   i += 1 
  # end
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else
          cart[new_name] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
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
  # ordered = consolidate_cart(cart)
  # order_discounted = apply_coupons(ordered, coupons)
  # clearanced = apply_clearance(order_discounted)
  # total = clearanced.reduce(0) do
  #   |total, item| 
  #   total = total + (item[1][:price] * item[1][:count])
  #   total
  # end
  # if total > 100
  #   discounted_total = (total * 0.9).round(2)
  #   discounted_total
  # else
  #   total
  # end
  consol_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(consol_cart, coupons)
  cart_with_discounts_applied = apply_clearance(cart_with_coupons_applied)

  total = 0.0
  cart_with_discounts_applied.keys.each do |item|
    total += cart_with_discounts_applied[item][:price]*cart_with_discounts_applied[item][:count]
  end
  total > 100.00 ? (total * 0.90).round : total
end



