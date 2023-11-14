import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    var mapView: MKMapView!
    let selectSchoolButton = UIButton(type: .system)
    let geocoder = CLGeocoder()
    var currentAddresses: [String] = []

    struct School {
        let name: String
        let coordinate: CLLocationCoordinate2D
        let associatedAddresses: [String]
    }

    // Example schools with associated addresses
    let schools = [
        School(
            name: "Tulane University",
            coordinate: CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1209),
            associatedAddresses: [
                "7700 Burthe St, New Orleans LA 70118",
                "7608 Zimpel St, New Orleans LA 70118",
                "2422 Joseph St, New Orleans LA 70115",
                "7500 Zimpel St, New Orleans LA 70118",
                "1032 Cherokee St, New Orleans LA 70118",
                "7506 Zimpel St, New Orleans LA 70118",
                "1414 Audubon St, New Orleans LA 70118"
            ]
        )
        // Add more schools as needed
    ]

    let zoomInButton = UIButton(type: .system)
    let zoomOutButton = UIButton(type: .system)

   override func viewDidLoad() {
       super.viewDidLoad()
       setupMapView()
       setupSelectSchoolButton()
       setupZoomButtons()
       centerMapOnSchool(schools[0])
   }


    private func setupMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
    }
    
    private func setupSelectSchoolButton() {
        selectSchoolButton.setTitle("Select School", for: .normal)
        selectSchoolButton.addTarget(self, action: #selector(showSchoolSelection), for: .touchUpInside)
        selectSchoolButton.frame = CGRect(x: 20, y: 50, width: 200, height: 40)
        selectSchoolButton.layer.borderWidth = 1
        selectSchoolButton.layer.borderColor = UIColor.blue.cgColor
        selectSchoolButton.layer.cornerRadius = 5
        view.addSubview(selectSchoolButton)
    }
    private func setupZoomButtons() {
            // Zoom In Button
            zoomInButton.setTitle("Zoom In", for: .normal)
            zoomInButton.frame = CGRect(x: 20, y: 100, width: 80, height: 40)
            zoomInButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
            view.addSubview(zoomInButton)

            // Zoom Out Button
            zoomOutButton.setTitle("Zoom Out", for: .normal)
            zoomOutButton.frame = CGRect(x: 110, y: 100, width: 80, height: 40)
            zoomOutButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
            view.addSubview(zoomOutButton)
        }

        @objc private func zoomIn() {
            let region = MKCoordinateRegion(center: mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta / 2, longitudeDelta: mapView.region.span.longitudeDelta / 2))
            mapView.setRegion(region, animated: true)
        }

        @objc private func zoomOut() {
            let region = MKCoordinateRegion(center: mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta * 2, longitudeDelta: mapView.region.span.longitudeDelta * 2))
            mapView.setRegion(region, animated: true)
        }
    

    @objc private func showSchoolSelection() {
        let alertController = UIAlertController(title: "Select School", message: nil, preferredStyle: .actionSheet)

        for school in schools {
            alertController.addAction(UIAlertAction(title: school.name, style: .default, handler: { _ in
                self.selectSchoolButton.setTitle(school.name, for: .normal) // Update button title
                self.centerMapOnSchool(school)
                self.currentAddresses = school.associatedAddresses
                self.processNextAddress()
            }))
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }

    private func centerMapOnSchool(_ school: School) {
        let region = MKCoordinateRegion(center: school.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

    private func processNextAddress() {
        guard !currentAddresses.isEmpty else {
            updateMapRegionToFitAllAnnotations()
            return
        }

        let nextAddress = currentAddresses.removeFirst()
        geocodeAddress(nextAddress)
    }

    private func geocodeAddress(_ address: String) {
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            if let error = error {
                print("Geocoding error for address \(address): \(error.localizedDescription)")
            } else if let coordinate = placemarks?.first?.location?.coordinate {
                self?.addAnnotation(at: coordinate, withTitle: address)
            }
            self?.processNextAddress()
        }
    }

    func addAnnotation(at coordinate: CLLocationCoordinate2D, withTitle title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }

    func updateMapRegionToFitAllAnnotations() {
        var zoomRect = MKMapRect.null
        for annotation in mapView.annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.1, height: 0.1)
            zoomRect = zoomRect.union(pointRect)
        }
        mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
    }
}
