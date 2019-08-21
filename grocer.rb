require "pry"

def consolidate_cart(original_cart)
  new_cart = {}
  original_cart.map do |items_hash| 
    items_hash.map do |item, hash| 
      new_cart[item] = hash 
      new_cart[item][:count] ? new_cart[item][:count] += 1 :   
      new_cart[item][:count] = 1 
    end
  end 
  new_cart
end

def apply_coupons(cart, coupons)
    coupons.each do |coupon_hash|
    item = coupon_hash[:item]
    cost = coupon_hash[:cost]
    amount_coupons = coupon_hash[:num]
    
    if cart.keys.include?(item) && cart[item][:count] >= amount_coupons
      new_hash = {"#{item} W/COUPON" => { 
        :price => coupon_hash[:cost] / coupon_hash[:num],
        :clearance => cart[item][:clearance],
        :count => coupon_hash[:num]
        }
      }
      if cart["#{item} W/COUPON"].nil?
        cart.merge!(new_hash)
      else
        cart["#{item} W/COUPON"][:count] += amount_coupons
      end
      cart[item][:count] -= coupon_hash[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item_array| 
      if item_array[1][:clearance] == true 
       item_array[1][:price] = (item_array[1][:price] * 0.80).round(2)
      end 
    end
  cart
end

def checkout(cart, coupons)
cart = consolidate_cart(cart) 
  cart = apply_coupons(cart, coupons)
cart = apply_clearance(cart) 
total = 0 

cart.each do |item, hash| 
 total += hash[:price] * hash[:count]
 end

if total > 100
  total = (total * 0.90).round(2)
end

total
end
