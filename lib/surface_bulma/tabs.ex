defmodule SurfaceBulma.Tabs do
  @moduledoc """
  A simple horizontal navigation **tabs** component
  """

  use Surface.LiveComponent

  @doc "Make tab full width"
  prop expanded, :boolean, default: false

  @doc "Classic style with borders"
  prop boxed, :boolean, default: false

  @doc "The tabs to display"
  slot tabs, required: true

  data active_tab, :integer, default: 0

  data animation, :string, default: ""

  def update(assigns, socket) do
    first_visible_tab = Enum.find_index(assigns.tabs, & &1.visible)

    socket =
      socket
      |> assign(assigns)
      |> assign(:active_tab, first_visible_tab)

    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <div class={"is-fullwidth": @expanded}>
      <nav class={"tabs",  "is-boxed": @boxed, "is-fullwidth": @expanded}>
        <ul>
          <li
            :for={{tab, index} <- Enum.with_index(@tabs), tab.visible}
            class={"is-active": @active_tab == index, isDisabled: tab.disabled}
          >
            <a :on-click="tab_click" phx-value-index={index}>
              <span :if={tab.icon} class="icon is-small">
                <i class={tab.icon} aria-hidden="true"></i>
              </span>
              <span>{tab.label}</span>
            </a>
          </li>
        </ul>
      </nav>
      <section class="tab-content" style="overflow: hidden;">
        <div
          :for={{tab, index} <- Enum.with_index(@tabs)}
          :show={tab.visible && @active_tab == index}
          class={"tab-item animated #{@animation} faster"}
        >
          <#slot name="tabs" index={index}/>
        </div>
      </section>
    </div>
    """
  end

  def handle_event("tab_click", %{"index" => index_str}, socket) do
    index = String.to_integer(index_str)
    animation = next_animation(socket.assigns, index)
    {:noreply, assign(socket, active_tab: index, animation: animation)}
  end

  defp next_animation(assigns, clicked_index) do
    %{animation: animation, active_tab: active_tab} = assigns

    cond do
      clicked_index > active_tab ->
        "slideInRight"

      clicked_index < active_tab ->
        "slideInLeft"

      true ->
        animation
    end
  end
end
