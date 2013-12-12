module DragonRentalRequestsHelper
  @dragon_names = Dragon.all.map(&:name)
end
