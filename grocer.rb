def consolidate_cart(array)
  hsh = {}
  array.each do |item|
    if hsh[item.keys[0]]
      hsh[item.keys[0]][:count] += 1

    else
      hsh[item.keys[0]] = {count: 1, price: item.values[0][:price], clearance: item.values[0][:clearance]}
    end
  end
  hsh
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else
          cart[new_name] = {count: coupon[:num], price: coupon[:cost]/coupon[:num], clearance: cart[coupon[:item]][:clearance]}
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
      cart[item][:price] = (cart[item][:price] * 0.80).round(2)
    end
  end
  cart
end




def checkout(array, coupons)
  cart = consolidate_cart(array)
  cc = apply_coupons(cart, coupons)
  cd = apply_clearance(cc)

  total = 0
  cd.keys.each do |item|
    total += cd[item][:price] * cd[item][:count]
  end
  
  if total > 100.00 
    total = (total * 0.90).round(2)
  end
  total
end

