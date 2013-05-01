module ImportHelper

  def parse_level level_string
   level_match = level_string.match(/.*(\d)/)
   level_match.nil? ? nil : level_match[1].to_i   
  end
end
