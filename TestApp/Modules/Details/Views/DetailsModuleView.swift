import UIKit
import MapKit

private extension DetailsModuleView {
    struct Appearance {
        let mapHeight: CGFloat = 300
        let previewCircleSize = CGSize(width: 270, height: 270)
        let cornerRadius: CGFloat = 100
        let previewTopInset: CGFloat = 200
        let titleFontSize: CGFloat = 28
        let descriptionFontSize: CGFloat = 15
        let titleTopInset: CGFloat = 40
        let titleSideInset: CGFloat = 20
        let substrateWidth: CGFloat = 8
    }
}

public final class DetailsModuleView: UIView {
    private let appearance = Appearance()
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        view.region = .init(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        return view
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = appearance.previewCircleSize.width / 2
        return imageView
    }()
    
    private lazy var circle: UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .white
        circleView.layer.cornerRadius = (appearance.previewCircleSize.width + appearance.substrateWidth) / 2
        
        circleView.layer.shadowColor = UIColor.black.cgColor
        circleView.layer.shadowOpacity = 0.5
        circleView.layer.shadowOffset = .zero
        circleView.layer.shadowRadius = 8
        return circleView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: appearance.titleFontSize)
        return label
    }()
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: appearance.descriptionFontSize)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    
    private lazy var parkLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: appearance.descriptionFontSize)
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var isFavouriteImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubviews()
        self.makeConstraints()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(item: HomeItemModel) {
        titleLabel.text = item.name
        previewImageView.image = UIImage(named: item.imageName)
        mapView.setCenter(.init(latitude: item.coordinates.latitude, longitude: item.coordinates.longitude), animated: false)
        if item.isFavorite {
            isFavouriteImageView.image = UIImage(systemName: "star.fill")
            isFavouriteImageView.tintColor = .systemYellow
        } else {
            isFavouriteImageView.image = UIImage(systemName: "star")
            isFavouriteImageView.tintColor = .systemGray
        }
        parkLabel.text = item.park
        stateLabel.text = item.state
    }
    
    private func addSubviews() {
        addSubview(mapView)
        addSubview(circle)
        addSubview(previewImageView)
        addSubview(titleLabel)
        addSubview(isFavouriteImageView)
        addSubview(parkLabel)
        addSubview(stateLabel)
    }
    
    private func makeConstraints() {
        mapView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(appearance.mapHeight)
        }
        
        previewImageView.snp.makeConstraints { make in
//            make.centerY.equalTo(mapView.snp.bottom)
            make.top.equalTo(safeAreaLayoutGuide).inset(appearance.previewTopInset)
            make.size.equalTo(appearance.previewCircleSize)
            make.centerX.equalToSuperview()
        }
        
        circle.snp.makeConstraints { make in
            make.center.equalTo(previewImageView)
            make.size.width.height.equalTo(appearance.previewCircleSize.width + appearance.substrateWidth)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImageView.snp.bottom).offset(appearance.titleTopInset)
            make.leading.equalToSuperview().inset(appearance.titleSideInset)
        }
        
        isFavouriteImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalTo(titleLabel.snp.trailing).offset(appearance.titleSideInset / 2)
            make.height.width.equalTo(titleLabel.snp.height).multipliedBy(0.7)
        }
        
        parkLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(appearance.titleSideInset)
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(parkLabel)
            make.trailing.equalToSuperview().inset(appearance.titleSideInset)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
    }
}
