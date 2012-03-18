class HeadlineResponse
  class HeadlineItem
    class Images
      include Enumerable
      attr_reader :images

      def initialize(images)
        @images = images.map {|img| Image.new img }
      end

      def each &block
        @images.each &block
      end

      def [](int)
        @images[int]
      end
    end

    class Image
      attr_reader :image

      def initialize(image)
        @image = image
      end

      # returns true if the image is landscape oriented.
      def landscape?
        @image["width"] > @image["height"]
      end

      # returns true if the image is portrait oriented.
      def portrait?
        !landscape?
      end

      # returns caption of image
      def caption
        @image["caption"]
      end

      # returns name of image
      def name
        @image["name"]
      end

      # returns url of image
      def url
        @image["url"]
      end

      # returns credit (attribution) of image
      def credit
        @image["credit"]
      end

      # returns width of image
      def width
        @image["width"]
      end

      # returns height of image
      def height
        @image["height"]
      end
    end
  end
end