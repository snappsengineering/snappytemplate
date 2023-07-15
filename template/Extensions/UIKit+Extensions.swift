//
//  UIKit+Extensions.swift
//
//  Created by snapps
//

import UIKit

extension UIView {
    /// Creates a container with a backgroundColor set to Style.Palette.cardBackground
    static func makeContainer(frame: CGRect = .zero) -> UIView {
        let view = UIView(frame: frame)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }

    static func makeDivider(frame _: CGRect = .zero) -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.height(1)
        return view
    }

    func with(backgroundColor: UIColor?) -> UIView {
        self.backgroundColor = backgroundColor
        return self
    }

    func with(clipsToBounds: Bool) -> UIView {
        self.clipsToBounds = clipsToBounds
        return self
    }

    func with(cornerRadius: CGFloat) -> UIView {
        layer.cornerRadius = cornerRadius
        return self
    }

    func withShadow(shadowColor: UIColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) -> UIView {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        return self
    }

    func with(size: CGSize) -> Self {
        self.size(size)
        return self
    }

    func with(height: CGFloat) -> Self {
        self.height(height)
        return self
    }
    
    func with(minHeight: CGFloat) -> Self {
        self.height(min: minHeight)
        return self
    }

    func withLayer(masksToBounds: Bool) -> Self {
        layer.masksToBounds = masksToBounds
        return self
    }
    
    func with(alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    /**
      Rounds the specified corners
      
      
      layerMinXMinYCorner = top Left

      layerMaxXMinYCorner = top Right

      layerMinXMaxYCorner = bottom left

      layerMaxXMaxYCorner = bottom Right
      
      - parameter corners: Array of CACorerMask.
      - parameter radius: The radius to use when drawing rounded corners for the layer’s background. Animatable.
      **/
    func withRoundedCorners(corners: CACornerMask = [.layerMaxXMinYCorner], radius: CGFloat = 48, requiresBlackBackground: Bool = false) -> Self {
        if requiresBlackBackground {
            backgroundColor = .black
            let view = UIView.makeContainer().with(backgroundColor: .white)
            addSubviewWithoutAutoLayout(view)
            view.edgesToSuperview()
            view.clipsToBounds = true
            view.layer.cornerRadius = radius
            view.layer.maskedCorners = corners
        } else {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = corners
        }
        return self
    }
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubviewWithoutAutoLayout($0) }
    }
    
    func addSubviewWithoutAutoLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func edgesToSuperview(_ insets: UIEdgeInsets = UIEdgeInsets.zero, usingSafeArea: Bool = false) {
        guard let superview else { return }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(
                equalTo: usingSafeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor,
                constant: insets.left
            ),
            trailingAnchor.constraint(
                equalTo: usingSafeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor,
                constant: insets.right
            ),
            topAnchor.constraint(
                equalTo: usingSafeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor,
                constant: insets.top
            ),
            bottomAnchor.constraint(
                equalTo: usingSafeArea ? superview.safeAreaLayoutGuide.bottomAnchor :  superview.bottomAnchor,
                constant: insets.bottom
            ),
        ])
    }
    
    func height(_  height: CGFloat) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func height(min: CGFloat) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: min)
        ])
    }
    
    func size(_ size:  CGSize) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width)
        ])
    }
}

extension UIStackView {
    /// Creates a vertical UIStackView with 8pt spacing
    static func make(frame _: CGRect = .zero) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8

        return stack
    }

    func with(axis: NSLayoutConstraint.Axis) -> UIStackView {
        self.axis = axis
        return self
    }

    func with(spacing: CGFloat) -> UIStackView {
        self.spacing = spacing
        return self
    }

    func with(alignment: Alignment) -> UIStackView {
        self.alignment = alignment
        return self
    }

    func with(distribution: Distribution) -> UIStackView {
        self.distribution = distribution
        return self
    }
    
    func withNoSpacing() -> UIStackView {
        self.spacing = 0
        return self
    }
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension UILabel {
    /// Creates a UILabel with numberOfLines = 0 and lineBreakMode .byWordWrapping
    static func make(frame _: CGRect = .zero) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        label.setContentCompressionResistancePriority(.required, for: .vertical)

        return label
    }

    func with(font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    
    func with(textColor: UIColor?) -> Self {
        guard let textColor = textColor else { return self }
        self.textColor = textColor
        return self
    }
    
    func with(textAlignment: NSTextAlignment) -> UILabel {
        self.textAlignment = textAlignment
        return self
    }
}

extension UIButton {
    static func make(type: UIButton.ButtonType = .system, title: String? = nil, target: Any, action: Selector) -> UIButton {
        let button = UIButton(type: type)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        return button
    }

    static func make(type: UIButton.ButtonType = .system, with action: @escaping () -> Void) -> UIButton {
        let button = UIButton(type: type)
        button.commonInit()
        button.on(.primaryActionTriggered) {
            action()
        }
        return button
    }
    
    static func make(with image: UIImage?, action: @escaping () -> Void) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.commonInit()
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .center
        button.on(.primaryActionTriggered) {
            action()
        }
        return button
    }

    private func commonInit() {
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .fill
        titleLabel?.numberOfLines = 0
        setContentCompressionResistancePriority(.required, for: .vertical)
        height(min: 44)
    }
}

extension UIViewController {
    func showAlert(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title,
                                      message: viewModel.message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "Dismiss",
                              style: .default,
                              handler: { _ in viewModel.handler?() }))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    func showGenericErrorAlert() {
        showAlert(viewModel: AlertViewModel())
    }
}

extension UIScrollView {
    static func makePagingScrollView(delegate: UIScrollViewDelegate) -> UIScrollView {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.isPagingEnabled = true
        scrollview.delegate = delegate
        scrollview.clipsToBounds = false
        return scrollview
    }
}
