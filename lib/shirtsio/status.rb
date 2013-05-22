# Retrieves the current state of any previously placed order.
class Shirtsio::Status < Shirtsio::Endpoint
  # Retrieve an order's possible status.
  #
  # Possible statuses include:
  #   * Processing - Order was accepted by the API and is being processed
  #                  before production.
  #   * Printing - Order is in the production process.
  #   * Shipped - Order has been shipped.
  #     * If an order is shipped or delivered, you will be given tracking
  #       numbers for each package.
  #     * Generally, larget orders are shipped via UPS and smaller orders
  #       are shipped via USPS.
  #   * Delivered - Order has been delivered.
  #   * Canceled - Order has been canceled.
  #     * If an order is canceled, you will be given a reason for
  #       cencellation.
  #     * Possible reasons include: incorrect color count, intellectual
  #       property infringement, out of stock, invalid printing
  #       specifications.
  #
  # @param [Integer] id Order identification number
  # @return [Shirtsio::Status] the order's status
  # @see https://www.shirts.io/docs/status_reference/
  def self.find(id)
    new(Shirtsio.get("/status/#{id}"))
  end

  # Provides the ability to have status updates pushed to a URL.
  class Webhook < Shirtsio::Endpoint
    # Delete the current webhook.
    #
    # @return [Boolean] true if successful; otherwise false;
    # @see https://www.shirts.io/docs/status_reference/#webhooks_section
    def delete
      Webhook.delete(url)
    end

    # Register a new webhook URL.
    #
    # @param [String] url URL status updates will be pushed to 
    # @return [Boolean] true if successful; otherwise false
    # @see https://www.shirts.io/docs/status_reference/#webhooks_section
    def self.create(url)
      Shirtsio.post('/webhooks/register/', { :url => url })[:success]
    end

    # Retrieve all registered webhook URLs.
    #
    # @return [Shirtsio::Status::Webhook] a list of registered webhook URLs
    # @see https://www.shirts.io/docs/status_reference/#webhooks_section
    def self.list
      webhooks = []
      response = new(Shirtsio.get('/webhooks/list/'))
      if response.respond_to?(:listener_url)
        response.listener_url.each do |webhook|
          webhooks << new({ :url => webhook })
        end
      end
      webhooks
    end

    # Delete a registered webhook URL.
    #
    # @param [String] url URL of webhook to be removed
    # @return [Boolean] true if successful; otherwise false
    # @see https://www.shirts.io/docs/status_reference/#webhooks_section
    def self.delete(url)
      Shirtsio.post('/webhooks/delete/', { :url => url })[:success]
    end
  end
end
