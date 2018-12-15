import TinyStore
import PlaygroundSupport

let view = TSDashboardView(
    frame: CGRect(
        x: 0.0,
        y: 0.0,
        width: 500.0,
        height: 500.0
    )
)

view.backgroundColor = .white

PlaygroundPage.current.liveView = view
