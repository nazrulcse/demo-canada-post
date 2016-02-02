module ApplicationHelper
  def image_without_asw_params(url)
    parsed = URI::parse(url)
    parsed.fragment = parsed.query = nil
    parsed.to_s
  end
end
