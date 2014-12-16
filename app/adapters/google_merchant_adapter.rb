require "nokogiri"

class GoogleMerchantAdapter
  def initialize
    self
  end

  def create_xml products, brand, reference
    @builder = Nokogiri::XML::Builder.new do |xml|
      xml.rss "version" => "2.0", "xmlns:g" => "http://base.google.com/ns/1.0" do
        xml.channel do
          xml.title "#{brand} products"
          xml.link "http://#{reference}/google_merchant/products.rss"
          xml.description "#{brand} products listing"

          products.each do |product|
            xml.item do
              xml.id product['id']
              xml.title product['name']
              xml.description product['description'].encode("UTF-8") if product['description']
              xml.link product['url']
              xml["g"].id product['id']
              xml["g"].price "#{product['price']} BRL"
              xml["g"].condition "new"
              xml["g"].image_link "http://#{product['image_url']}"
              xml["g"].availability product['available'] ? 'in stock' : 'out of stock'
              xml["g"].brand category_tag(product, 'brand')
              xml["g"].category category_tag(product, 'gm_category')
              xml["g"].identifier_exists "FALSE"
              xml["g"].installment do
                xml["g"].months product['installments'].length
                xml["g"].amount product['installments'].first
              end
            end
          end
        end
      end
    end
    @builder.to_xml
  end

  def category_tag(product, category)
    category_tags = product['category_tags'] if product && product['category_tags'] != []
    if category_tags
      category_tag = category_tags.select {|c| c["tag_type"] == category }
        return category_tag.first['name'] if category_tag.any?
    end
  end

end
