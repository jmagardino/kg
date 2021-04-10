defmodule KgWeb.EggOrderView do
  use KgWeb, :view

  def completed_egg_orders(egg_orders), do: Enum.reject(egg_orders, fn egg_order -> egg_order.completed_at == nil end)

  def pending_egg_orders(egg_orders), do: Enum.filter(egg_orders, fn egg_order -> egg_order.completed_at == nil end)
end
