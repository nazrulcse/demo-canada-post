class WelcomeController < ApplicationController
  require 'canada_post'

  def index
    shipper = {postal_code: 'M5X1B8',
               country_code: 'CA'}

    recipient = {postal_code: 'M5R1C6',
                 country_code: 'CA'}

    package = {weight: {value: 1, units: 'KG'},
               dimensions: {length: 25, width: 15, height: 10, units: 'CM'}}

    # @rate = CANADA_POST_SERVICE.rate(shipper: shipper,
    #   recipient: recipient,
    #  package: package)

    @shipment = ''
    if params[:commit].present?
      @sender = params[:sender]
      @destination = params[:destination]
      @package = params[:package]
      @notification = params[:notification]
      @preferences = params[:preferences]
      @settlement_info = params[:settlement_info]
      CANADA_POST_SERVICE.create(
          sender: @sender,
          destination: @destination,
          package: @package,
          notification: @notification,
          preferences: @preferences,
          settlement_info: @settlement_info,
          group_id: '5241556',
          mailing_date: '2016-01-10',
          contract_id: '2514533',
          service_code: 'DOM.EP',
          mobo: params[:mobo]
      )
    end
  end

  def test
    xml = <<XML
<shipment xmlns="http://www.canadapost.ca/ws/shipment-v7">  <group-id>5241556</group-id>  <expected-mailing-date>2016-01-10</expected-mailing-date>  <cpc-pickup-indicator>true</cpc-pickup-indicator>  <delivery-spec>    <service-code>DOM.EP</service-code>    <sender>      <name>fdgfdg</name>      <company>dfgdfg</company>      <contact-phone>54545</contact-phone>      <address-details>        <address-line-1>dfgdf gdf gdf g</address-line-1>        <city>Dhaka</city>        <prov-state>Dhaka</prov-state>        <country-code>CA</country-code>        <postal-zip-code>1234</postal-zip-code>      </address-details>    </sender>    <destination>      <name>gfh d fg</name>      <company>fd hfh</company>      <address-details>        <address-line-1>dfgdf gdf gdf g</address-line-1>        <city>Dhaka</city>        <prov-state>Dhaka</prov-state>        <country-code>CA</country-code>        <postal-zip-code>1234</postal-zip-code>      </address-details>    </destination>    <parcel-characteristics>      <weight/>      <dimensions>        <height>2.0</height>        <width>1.0</width>        <length>1.0</length>      </dimensions>    </parcel-characteristics>    <print-preferences>      <output-format>8.5x11</output-format>    </print-preferences>    <notification>      <email/>      <show-postage-rate>false</show-postage-rate>      <show-insured-value>true</show-insured-value>    </notification>    <settlement-info>      <contract-id>2514533</contract-id>      <intended-method-of-payment>Account</intended-method-of-payment>    </settlement-info>  </delivery-spec></shipment>
XML
  end

end
