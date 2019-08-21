def consolidate_cart(cart)
   new_hash = {}

  cart.each do|item|
  food_name = item.keys.first
  # over here, 
    if new_hash[food_name] != nil
      new_hash[food_name][:count] += 1
    else
      new_hash[food_name] = item[food_name]
      new_hash[food_name][:count] = 1
    end
  
  end

  return new_hash
end





def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  item = coupon[:item] 

  if cart[item] && cart[item][:count] >= coupon[:num]
    if cart["#{item} W/COUPON"]
      cart["#{item} W/COUPON"][:count] += coupon[:num]

    else
      cart["#{item} W/COUPON"] = {
        :price => (coupon[:cost] / coupon[:num].to_f),
        :clearance => cart[item][:clearance],
        :count => coupon[:num]
      }

    end
    cart[item][:count] -= coupon[:num]

  end
end
cart
end



  
# new_hash = {}

# for i in coupons 
#     (cart.keys).each do |food| 
     
#       if  i[:item] == food 

#         new_hash[food] = cart[food]
#         new_hash[food][:count] = cart[food][:count] - i[:num]

#       else
#         new_hash[food] = cart[food]
      
#       end
#       if  i[:item] == food
              
#     end
#   end
#   # coupons.each do |x|
#   # if  true #(cart.keys).include?(x)
#   #     new_hash["#{x[:item]} W/COUPON"] = cart[:item]
#   #     new_hash["#{x[:item]} W/COUPON"][:price] = i[:cost] / i[:num].to_f
#   #     new_hash["#{x[:item]} W/COUPON"][:count] = i[:num]
#   #   end
#   # end  
# end    

#   for i in coupons
#     if cart.keys.include?(i[:item])
#       food = cart.keys.first
#       new_hash["#{food} W/COUPON"] = cart[food]
#       new_hash["#{food} W/COUPON"][:price] = i[:cost] / i[:num].to_f
#       new_hash["#{food} W/COUPON"][:count] = i[:num]

#     end
#   end
#   new_hash


def apply_clearance(cart)
new_hash = {}
array_keys = cart.keys

for key in array_keys

    if cart[key][:clearance] == true
      new_hash[key] = cart[key]
      new_hash[key][:price] = (cart[key][:price] * 0.8).round(2)
      
   else 
     new_hash[key] = cart[key]
   end
end
  new_hash
end

def checkout(cart, coupons)
 hash_cart = consolidate_cart(cart)
 hash_w_discount = apply_coupons(hash_cart, coupons)
 hash_w_clearance = apply_clearance(hash_w_discount)
 
 total_price = 0.0 
 
 array_keys = hash_cart.keys
 
 for key in array_keys
 
  total_price += hash_cart[key][:price] * (hash_cart[key][:count]).to_f

end

  if total_price > 100.100
    total_price *= 0.9
    return total_price
  end
  total_price
end


 #   if cart[key][:clearance] == true
  #     new_hash[key] = cart[key]
  #     new_hash[key][:price] = (cart[key][:price] * 0.8).round(2)
      
  # else 
  #   new_hash[key] = cart[key]
  # end