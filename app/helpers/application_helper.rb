require 'action_view'
require 'action_view/helpers'
require 'action_view/helpers/text_helper'
require 'action_view/helpers/url_helper'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/output_safety_helper'

module ApplicationHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::OutputSafetyHelper
  

end
