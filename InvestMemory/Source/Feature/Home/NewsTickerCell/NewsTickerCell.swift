import UIKit
import SnapKit

class NewsTickerCell: UICollectionViewCell {
    
    static let identifier = "NewsTickerCell"

    private let countryImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "flag")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .darkGray
        lb.font = .systemFont(ofSize: 14)
        lb.textAlignment = .left
        return lb
    }()
    
    private let statusImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.up.circle")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(countryImageView)
        contentView.addSubview(infoLabel)
        contentView.addSubview(statusImageView)
    }
    
    private func setupConstraints() {
        countryImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        statusImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        infoLabel.snp.makeConstraints {
            $0.leading.equalTo(countryImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(statusImageView.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }
    }

    func configure(with countryImage: UIImage?, text: String, isPositive: Bool) {
        countryImageView.image = countryImage
        infoLabel.text = text
        statusImageView.image = UIImage(systemName: isPositive ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
        statusImageView.tintColor = isPositive ? .red : .blue
    }
}
