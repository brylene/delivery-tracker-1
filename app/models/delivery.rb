# == Schema Information
#
# Table name: deliveries
#
#  id          :integer          not null, primary key
#  date        :date
#  description :string
#  details     :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Delivery < ApplicationRecord
  belongs_to :user, :required => true
end
