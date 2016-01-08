class Shipping < ActiveRecord::Base
  has_many :links

  def self.track_shipping(response)
    shipping_info = response[:create_shipping]
    transmit_shipping = response[:transmit_shipping]
    shipment_info = shipping_info[:shipment_info]
    shipping = self.new(xmlns: shipment_info[:xmlns], shipment_id: shipment_info[:shipment_id],
                        shipment_status: shipment_info[:shipment_status], tracking_pin: shipment_info[:tracking_pin])
    if shipping.save
      links = shipment_info[:links][:link]
      links.each do |link|
        store_link(shipping, link)
      end
      if transmit_shipping[:manifests].present?
        link = transmit_shipping[:manifests][:link]
        store_link(shipping, link)
      end
    end
  end

  def self.store_link(shipping, link)
    shipping_link = shipping.links.build(rel: link[:rel], href: link[:href], media_type: link[:media_type])
    shipping_link.save
  end

  def get_url(type)
    label = links.where(rel: type).first
    if label.present?
      label.href
    end
  end

end
