class Shipping < ActiveRecord::Base
  has_many :links

  def self.track_shipping(response)
    shipment_info = response[:shipment_info]
    shipping = self.new(xmlns: shipment_info[:xmlns], shipment_id: shipment_info[:shipment_id],
                        shipment_status: shipment_info[:shipment_status], tracking_pin: shipment_info[:tracking_pin])
    if shipping.save
      links = shipment_info[:links][:link]
      links.each do |link|
        shipping_link = shipping.links.build(rel: link[:rel], href: link[:href], media_type: link[:media_type])
        shipping_link.save
      end
    end
  end

  def label_url
    label = links.where(rel: 'label').first
    if label.present?
      label.href
    end
  end

end
