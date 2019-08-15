require "pry"


def consolidate_cart(cart)
  # 1. check for duplicate keys, delete the excess pair and create a new key: value pair, count and update that. 
  #2. Return a hash that is composed of the simplified pairs in the array.
  #binding.pry
  new_cart = {}
  cart.each do |cart_item| 
    item = cart_item.keys[0]
    if new_cart[item]
      new_cart[item][:count] +=1
    else
      new_cart[item] = {
        count: 1,
        price: cart_item.values[0][:price],
        clearance: cart_item.values[0][:clearance]
      }
    end
  end
 new_cart
end

def apply_coupons(cart, coupons)
  #1. Iterate through the coupons array and check if any of the items in the coupons array are in the cart array.
  #2. If there are items in both arrays, lower the count of the item that is coupon-ed and then create a new hash in the array ____w/Coupon that has the coupon price, clearance and an updated count equal to the count indicated by the coupon.
  #3 return the updated cart array
  coupons.each do |coupon|
    if cart[coupon[:item]]
      if cart[coupon[:item]][:count] >= coupon[:num]
        w_coupon= "#{coupon[:item]} W/COUPON"
        if cart[w_coupon]
          cart[coupon[:item]][:count] -= coupon[:num]
          cart[w_coupon][:count] += coupon[:num]
        else
          cart[w_coupon] = {
            count: coupon[:num],
            price: coupon[:cost] / coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
           cart[coupon[:item]][:count] -= coupon[:num]
        end
      end
    end    
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[1][:clearance]
      item[1][:price] = (item[1][:price] * 0.8).round(2)
      #binding.pry
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  cons_cart = consolidate_cart (cart)
  cons_coup_cart =apply_coupons(cons_cart, coupons)
  pen_cart =apply_clearance (cons_coup_cart)
    pen_cart.each do |item|
      total += (pen_cart[item[0]][:price] * pen_cart[item[0]][:count])
    end
  if total > 100
    total = (total * 0.9).round(2)
  end
  total
end
