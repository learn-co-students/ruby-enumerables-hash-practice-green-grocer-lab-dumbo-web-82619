def consolidate_cart(cart)
  # code here
  #first figure out how to convert an array into a hash 
  #next figure out how to consolidate the items
  #add count key and value into the hash
    #Use the count enumerable
  hash = {}
  cart.each do |product|
    if hash[product.keys[0]]
      hash[product.keys[0]][:count] += 1
    else
      hash[product.keys[0]] = {
        count: 1,
        price: product.values[0][:price],
        clearance: product.values[0][:clearance]
      }
    end 
  end 
  hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |ind_coup|
    if cart.keys.include? ind_coup[:item]
      if cart[ind_coup[:item]][:count] >= ind_coup[:num]
        added_name = "#{ind_coup[:item]} W/COUPON"
        if cart[added_name]
          cart[added_name][:count] += ind_coup[:num]
        else
          cart[added_name] = {
            count: ind_coup[:num],
            price: ind_coup[:cost]/ind_coup[:num],
            clearance: cart[ind_coup[:item]][:clearance]
          }
        end
        cart[ind_coup[:item]][:count] -= ind_coup[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item_key, item_hash|
    if !!item_hash[:clearance]
      item_hash[:price] = (item_hash[:price] * 0.8).round(2)
    end 
  end
  cart 
end

def checkout(cart, coupons)
  # code here 
  consolidated_cart = consolidate_cart(cart)
  applied_coupons_cart = apply_coupons(consolidated_cart, coupons)
  applied_clearance_cart = apply_clearance(applied_coupons_cart)
  
  total_cost = 0 
  
  applied_clearance_cart.each do |item_key, item_hash|
    total_cost += item_hash[:price] * item_hash[:count]
  end 
  if total_cost > 100 
    total_cost * 0.9
  else 
    total_cost
  end 
end

