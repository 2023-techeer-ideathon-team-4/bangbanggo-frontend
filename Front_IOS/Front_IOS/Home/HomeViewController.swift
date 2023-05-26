import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private let centerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Center", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Map setup
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)

        // Button setup
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        view.addSubview(centerButton)
        NSLayoutConstraint.activate([
            centerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            centerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])

        // Request location permission
        locationManager.requestWhenInUseAuthorization()

        // Location manager setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    @objc private func centerButtonTapped() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            mapView.removeAnnotations(mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            mapView.addAnnotation(annotation)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(describing: MKPinAnnotationView.self))
        pinView.pinTintColor = .red
        pinView.animatesDrop = true

        return pinView
    }
}
