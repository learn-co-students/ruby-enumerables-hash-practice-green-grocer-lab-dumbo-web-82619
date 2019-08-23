def consolidate_cart(cart)
  # code here
 consolidated_cart = {}
  cart.map {|cart_item_hash|
    if consolidated_cart.key?(cart_item_hash.keys.first) == true 
      consolidated_cart[cart_item_hash.keys.first][:count] += 1 
    else
      consolidated_cart[cart_item_hash.keys.first] = cart_item_hash[cart_item_hash.keys.first]
      consolidated_cart[cart_item_hash.keys.first][:count] = 1 
    end
  }
  return consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
  discounted_hash = cart
  coupons.map {|coupon| 
    if cart.key?(coupon[:item]) == true && coupon[:num] <= cart[coupon[:item]][:count]
    discounted_hash[coupon[:item] + " W/COUPON"]= {:price => coupon[:cost] / coupon[:num], :clearance => cart[coupon[:item]][:clearance], :count => cart[coupon[:item]][:count] - cart[coupon[:item]][:count] % coupon[:num]} #newcount = count - count%num
      discounted_hash[coupon[:item]][:count] = discounted_hash[coupon[:item]][:count] - discounted_hash[coupon[:item] + " W/COUPON"][:count]
    end 
  } 
  return discounted_hash  
end

def apply_clearance(cart)
  # code here
  clearanced_hash = cart
  clearanced_hash.map {|cart_item_key, cart_item_value|
    if cart_item_value[:clearance] == true
      cart_item_value[:price] = (cart_item_value[:price] * 0.80).round(2)
    end
  }
  return clearanced_hash
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  applied_clearance= apply_clearance(applied_coupons)
  final_value = applied_clearance.values.reduce(0) {|sum, cart_item_value|
    sum + (cart_item_value[:price] * cart_item_value[:count])
    
  }
  if final_value > 100
    final_value = final_value * 0.90
  end
  final_value
end
