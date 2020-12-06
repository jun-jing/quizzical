class User < ApplicationRecord
    has_secure_password

    # VALIDATIONS
    validates :first_name, presence: true
    validates :last_name, presence: true
    # email is present and unique and an email (can be simple format check)
    validates :email, presence: true, uniqueness: true
    
    # password for presence, length and presence of special characters

    # Teacher Relationships
    has_many :group_admins
    has_many :taught_classes, through: :group_admins, source: :group
    has_many :students, through: :taught_classes, source: :students
    has_many :quizzes, through: :taught_classes, source: :quizzes
    
    # Student Relationships
    has_and_belongs_to_many :enrolled_classes, 
        :class_name => 'Group', 
        :join_table => 'groups_users', 
        :foreign_key => 'group_id', 
        :association_foreign_key => 'user_id'

    has_many :assigned_quizzes, through: :enrolled_classes, source: :quizzes
    has_many :teachers, through: :enrolled_classes, source: :teacher
    has_many :results

    def full_name
        "#{first_name} #{last_name}"
    end

end
