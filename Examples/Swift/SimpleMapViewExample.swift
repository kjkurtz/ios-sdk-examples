import Mapbox

@objc(SimpleMapViewExample_Swift)

class SimpleMapViewExample_Swift: UIViewController, MGLMapViewDelegate {
    
    var shapeCollection: MGLShapeCollectionFeature!
    var shapeSource: MGLShapeSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.lightStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), zoomLevel: 5, animated: false)
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        let point1 = MGLPointFeature()
        point1.coordinate = CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06)
        
        let point2 = MGLPointFeature()
        point2.coordinate = CLLocationCoordinate2D(latitude: 60.31, longitude: 20.06)

        shapeCollection = MGLShapeCollectionFeature(shapes: [point1, point2])
        shapeSource = MGLShapeSource(identifier: "shape-source", shape: shapeCollection, options: nil)
        
        let layer = MGLCircleStyleLayer(identifier: "shape-style", source: shapeSource)
        layer.circleColor = NSExpression(forConstantValue: UIColor.red)
        layer.circleRadius = NSExpression(forConstantValue: 10)
        
        style.addSource(shapeSource)
        style.addLayer(layer)
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        let point3 = MGLPointFeature()
        point3.coordinate = CLLocationCoordinate2D(latitude: 59.31, longitude: 19.06)
        
        if shapeSource != nil {
            shapeSource.shape = MGLShapeCollectionFeature(shapes: [])
        }
        
        print("⚠️ camera changing - \(reason)")
    }
}
