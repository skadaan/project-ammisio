class Space < ActiveRecord::Base
  belongs_to :tenant
  validates_uniqueness_of :title
  has_many :artifacts, dependent: :destroy
  has_many :user_spaces
  has_many :users, through: :user_spaces
  validate :free_plan_can_only_have_one_space
  
  def free_plan_can_only_have_one_space
    if self.new_record? && (tenant.spaces.count > 0) && (tenant.plan == 'free')
      errors.add(:base, "Free plans cannot have more than one space")
    end
  end
  
  def self.by_user_plan_and_tenant(tenant_id, user)
    tenant = Tenant.find(tenant_id)
    if tenant.plan == 'premium'
      if user.is_admin?
        tenant.spaces
      else
        user.spaces.where(tenant_id: tenant.id)
      end
    else
      if user.is_admin?
        tenant.spaces.order(:id).limit(1)
      else
        user.spaces.where(tenant_id: tenant.id).order(:id).limit(1)
      end
    end
  end
end
