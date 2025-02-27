//
//  ReviewsCountCell.swift
//  Test
//
//  Created by Максим Назаров on 27.02.2025.
//

import UIKit

struct ReviewsCountCellConfig {
    static let reuseId = String(describing: ReviewsCountCellConfig.self)
    
    let count: NSAttributedString
    
    fileprivate let layout = ReviewsCountCellLayout()
}

// MARK: - TableCellConfig

extension ReviewsCountCellConfig: TableCellConfig {
    func update(cell: UITableViewCell) {
        guard let cell = cell as? ReviewsCountCell else { return }
        cell.config = self
        cell.reviewsCountLabel.attributedText = count
    }
    
    func height(with size: CGSize) -> CGFloat {
        layout.height(config: self, maxWidth: size.width)
    }
}

// MARK: - Cell

final class ReviewsCountCell: UITableViewCell {
    
    fileprivate var config: Config?
    
    fileprivate let reviewsCountLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = config?.layout else { return }
        reviewsCountLabel.frame = layout.reviewsCountLabelFrame
    }
    
}
// MARK: - Private

private extension ReviewsCountCell {
    func setupCell() {
        setupReviewsCountLabel()
    }
    
    func setupReviewsCountLabel() {
        contentView.addSubview(reviewsCountLabel)
        reviewsCountLabel.layer.opacity = 0.5
    }
}


// MARK: - Layout

private final class ReviewsCountCellLayout {
    
    // MARK: - Фреймы
    
    private(set) var reviewsCountLabelFrame = CGRect.zero
    
    // MARK: - Отступы

    private let insets = UIEdgeInsets(top: 9.0, left: 12.0, bottom: 9.0, right: 12.0)
    
    // MARK: - Расчёт фреймов и высоты ячейки
    
    func height(config: Config, maxWidth: CGFloat) -> CGFloat {
        
        let width = maxWidth - insets.right
        let currentTextHeight = (config.count.font()?.lineHeight ?? .zero)
        let textSize = config.count.boundingRect(width: width, height: currentTextHeight).size
        let center = (maxWidth / 2) - ( textSize.width / 2)
        
        reviewsCountLabelFrame = CGRect(
            origin: CGPoint(x: center, y: insets.top),
            size: textSize
        )
        
        return reviewsCountLabelFrame.maxY + insets.bottom
    }
}

// MARK: - Typealias

fileprivate typealias Config = ReviewsCountCellConfig
fileprivate typealias Layout = ReviewsCountCellLayout
