module Support
  module Travis
    def self.travis?
      ENV['CI'] && ENV['TRAVIS']
    end
  end
end
