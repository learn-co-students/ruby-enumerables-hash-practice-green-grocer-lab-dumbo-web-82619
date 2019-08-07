def consolidate_cart(cart)
  # code here  
  output_hash = {}
  
  cart.each do |item|
    item.each do |item_name, item_info|
      if !output_hash[item_name]
        output_hash[item_name] = item_info.merge({count: 1})
      else 
        output_hash[item_name][:count] += 1 
      end 
    end 
  end 
  output_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_key = "#{coupon[:item]} W/COUPON"
        if !!cart[new_key]
          cart[new_key][:count] += coupon[:num]
        else 
          cart[new_key] = {
            price: coupon[:cost] / coupon[:num],
            clearance: cart[coupon[:item]][:clearance],
            count: coupon[:num]
          }
        end 
        cart[coupon[:item]][:count] -= coupon[:num]
      end 
    end 
  end
  cart 
end

def apply_clearance(cart)
  # code here
   
end

def checkout(cart, coupons)
  # code here 
 
end

