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
end
