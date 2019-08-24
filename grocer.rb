require "pry"
def consolidate_cart(cart)
 newcart = {}
 items_name = cart.map do  |item|
   item.keys.first
   
 end
  cart.each do |item|
           newcart[item.keys.first] = item[item.keys.first]
       newcart[item.keys.first][:count] = items_name.select{|name| name == item.keys.first}.count
      
  #   if newcart.keys.include?(item.keys.first)
  #     newcart[item.keys.first][:count] += 1
  #   else
  #     newcart[item.keys.first][:count] = 1
  # end
  # binding.pry
  #   cart.each do |item|
  #     newcart[i] = newcart[i] +=1 
  #     return i if newcart[i]<1 
  #   end
  #     return nil
  end
  return newcart
end

def apply_coupons(cart, coupons)
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
   cart.keys.each do |item|
   if cart[item][:clearance]
    cart[item][:price] = (cart[item][:price]*0.80).round(2)
   end 
 end 
 cart
end

def checkout(cart, coupons)
    cd_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(cd_cart, coupons)
  cart_with_discounts_applied = apply_clearance(cart_with_coupons_applied)

  total = 0.0
  cart_with_discounts_applied.keys.each do |item|
    total += cart_with_discounts_applied[item][:price]*cart_with_discounts_applied[item][:count]
  end
  total > 100.00 ? (total * 0.90).round : total
end

