import Mapbox

@objc(SimpleMapViewExample_Swift)

class SimpleMapViewExample_Swift: UIViewController, MGLMapViewDelegate {
    
    private var originalBounds = MGLCoordinateBounds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 37, longitude: -169)
        mapView.zoomLevel = 2
        view.addSubview(mapView)
        
        let southwest = CLLocationCoordinate2D(latitude: 16, longitude: -197)
        let northeast = CLLocationCoordinate2D(latitude: 48, longitude: -142)
        
        originalBounds = MGLCoordinateBounds(sw: southwest, ne: northeast)
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        let linePoints = [
            CLLocationCoordinate2D(latitude: 90, longitude: 180),
            CLLocationCoordinate2D(latitude: -90, longitude: 180)
        ]
        let lineShape = MGLPolyline(coordinates: linePoints, count: 2)
        
        let lineSource = MGLShapeSource(identifier: "line-source", shape: lineShape, options: nil)
        let lineStyle = MGLLineStyleLayer(identifier: "line-style", source: lineSource)
        
        mapView.style?.addSource(lineSource)
        mapView.style?.addLayer(lineStyle)
        
        let leftBounds = MGLCoordinateBounds(
            sw: CLLocationCoordinate2DMake(originalBounds.sw.latitude, originalBounds.sw.longitude),
            ne: CLLocationCoordinate2DMake(originalBounds.ne.latitude, 180)
        )
        
        let leftBoundsView = UIView(frame: mapView.convert(leftBounds, toRectTo: mapView))
        leftBoundsView.layer.opacity = 0.5
        leftBoundsView.backgroundColor = UIColor.red
        mapView.addSubview(leftBoundsView)
        
        let rightBounds = MGLCoordinateBounds(
            sw: CLLocationCoordinate2DMake(originalBounds.sw.latitude, 180),
            ne: CLLocationCoordinate2DMake(originalBounds.ne.latitude, originalBounds.ne.longitude)
        )
        
        let rightBoundsView = UIView(frame: mapView.convert(rightBounds, toRectTo: mapView))
        rightBoundsView.layer.opacity = 0.5
        rightBoundsView.backgroundColor = UIColor.purple
        mapView.addSubview(rightBoundsView)
    }
}
