class Session < ApplicationRecord
  belongs_to :user

  def set_session(session_id, data, user_id)
  end;nil
end
