 def consolidate_cart(cart)
  # code here
  #first figure out how to convert an array into a hash 
  #next figure out how to consolidate the items
  #add count key and value into the hash
    #Use the count enumerable
  new_hash = {}
  cart.each do |item|
    if new_hash[item.keys[0]]
      new_hash[item.keys[0]][:count] += 1
    else
      new_hash[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end 
  end 
  new_hash
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
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]*0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidate_cart = consolidate_cart(cart)
  enabled_coupons_to_cart = apply_coupons(consolidate_cart, coupons)
  enabled_discounts_to_cart = apply_clearance(enabled_coupons_to_cart)

  price = 0.0
  enabled_discounts_to_cart.keys.each do |product|
    price += enabled_discounts_to_cart[product][:price]*enabled_discounts_to_cart[product][:count]
  end
  price > 100.00 ? (price * 0.90).round : price
end