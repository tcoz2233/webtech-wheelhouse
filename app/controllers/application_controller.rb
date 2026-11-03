class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # No action is left unchecked: an action that forgets to ask a policy fails,
  # and so does an index that is not built from a policy scope.
  # (A public controller opts out with skip_after_action and is listed in docs/decisions.md.)
  after_action :verify_authorized
  after_action :verify_policy_scoped, if: -> { action_name == "index" }

  rescue_from Pundit::NotAuthorizedError, with: :render_forbidden

  private

  # The policies receive the account of the current session (nil for a visitor).
  def pundit_user
    resume_session&.user
  end

  # A refused request answers 403 with a page in the layout of the application.
  # A visitor with no session is sent to sign in instead and never sees the 403 page.
  def render_forbidden
    return request_authentication unless pundit_user

    render "errors/forbidden", status: :forbidden, formats: :html
  end
end