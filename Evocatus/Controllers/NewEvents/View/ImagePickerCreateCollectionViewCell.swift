import UIKit
import SnapKit

class ImagePickerCreateCollectionViewCell: UICollectionViewCell {
    // MARK:- Properties
    var isCellSelected: Bool = false {
        didSet {
//            imageViewBorderView.alpha = 0
        }
    }
    
    // MARK:- Views
//    lazy var imageViewBorderView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "main")
//        view.layer.cornerRadius = 15
////        view.isHidden =
//        return view
//    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
//        imageView.layer.backgroundColor = UIColor(named: "purple")?.cgColor
//        imageView.layer.borderWidth = 3
        return imageView
    }()
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupImageView()
    }
    
    // MARK:- Views' setup
//    private func setupBorderView() {
//        contentView.addSubview(imageViewBorderView)
//        imageViewBorderView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(3)
            make.trailing.equalToSuperview().inset(3)
            make.top.equalToSuperview().inset(3)
            make.bottom.equalToSuperview().inset(3)
        }
    }
}
