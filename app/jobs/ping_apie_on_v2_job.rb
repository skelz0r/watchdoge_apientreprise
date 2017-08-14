class PingAPIEOnV2Job < AbstractPingJob

  base_uri Rails.application.config_for(:watchdoge_secrets)['apie_base_uri']

  protected

  def request_url(endpoint)
    endpoint.custom_url || "/v2/#{endpoint.name}/#{endpoint.parameter}?token=#{apie_token}&#{endpoint.options.to_param}"
  end

  def endpoints
    Tools::EndpointFactory.new('apie').load_all
  end

  private

  def apie_token
    Rails.application.config_for(:watchdoge_secrets)['apie_token']
  end
end