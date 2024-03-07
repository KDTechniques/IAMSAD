//
//  CustomUIScrollView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

public protocol CustomUIScrollViewViewRepresentable {
    var contentOffset: CGPoint { get set }
    var contentOffsetToScrollAnimated: CGPoint? { get set }
    var isPagingEnabled: Bool { get set }
    var bounces: Bool { get set }
    var alwaysBounceVertical: Bool { get set }
    var alwaysBounceHorizontal: Bool { get set }
    var showsVerticalScrollIndicator: Bool { get set }
    var showsHorizontalScrollIndicator: Bool { get set }
    
    func updateScrollView(_ scrollView: UIScrollView)
}

public extension CGPoint {
    static let invalidContentOffset = CGPoint(
        x: CGFloat.greatestFiniteMagnitude,
        y: CGFloat.greatestFiniteMagnitude
    )
}

public extension CustomUIScrollViewViewRepresentable {
    func isPagingEnabled(_ isPagingEnabled: Bool) -> Self {
        var view = self
        view.isPagingEnabled = isPagingEnabled
        return view
    }
    
    func bounces(_ bounces: Bool) -> Self {
        var view = self
        view.bounces = bounces
        return view
    }
    
    func alwaysBounceVertical(_ alwaysBounceVertical: Bool) -> Self {
        var view = self
        view.alwaysBounceVertical = alwaysBounceVertical
        return view
    }
    
    func alwaysBounceHorizontal(_ alwaysBounceHorizontal: Bool) -> Self {
        var view = self
        view.alwaysBounceHorizontal = alwaysBounceHorizontal
        return view
    }
    
    func showsVerticalScrollIndicator(_ showsVerticalScrollIndicator: Bool) -> Self {
        var view = self
        view.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        return view
    }
    
    func showsHorizontalScrollIndicator(_ showsHorizontalScrollIndicator: Bool) -> Self {
        var view = self
        view.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        return view
    }
    
    func updateScrollView(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = isPagingEnabled
        scrollView.bounces = bounces
        scrollView.alwaysBounceVertical = alwaysBounceVertical
        scrollView.alwaysBounceHorizontal = alwaysBounceHorizontal
        scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    }
}

public extension CustomUIScrollView {
    func contentOffset(_ contentOffset: Binding<CGPoint>) -> Self {
        var view = self
        view._contentOffset = contentOffset
        return view
    }
    
    func contentOffsetToScrollAnimated(_ contentOffsetToScrollAnimated: Binding<CGPoint?>) -> Self {
        var view = self
        view._contentOffsetToScrollAnimated = contentOffsetToScrollAnimated
        return view
    }
}

public struct CustomUIScrollView<Content: View>: UIViewRepresentable, CustomUIScrollViewViewRepresentable {
    public let axis: Axis.Set
    @Binding public var contentOffset: CGPoint
    @Binding public var contentOffsetToScrollAnimated: CGPoint?
    public var isPagingEnabled: Bool = false
    public var bounces: Bool = true
    public var alwaysBounceVertical: Bool = false
    public var alwaysBounceHorizontal: Bool = false
    public var showsVerticalScrollIndicator: Bool = true
    public var showsHorizontalScrollIndicator: Bool = true
    public let content: () -> Content
    
    public init(
        _ axis: Axis.Set,
        contentOffset: Binding<CGPoint> = .constant(.invalidContentOffset),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self._contentOffset = contentOffset
        self._contentOffsetToScrollAnimated = .constant(nil)
        self.content = content
    }
    
    public func makeUIView(context: Context) -> UIScrollView {
        let scrollView = ScrollView(axis)
        scrollView.delegate = context.coordinator
        
        let host = UIHostingController(rootView: content())
        host.view.backgroundColor = .clear
        host.view.translatesAutoresizingMaskIntoConstraints = false
        context.coordinator.host = host
        
        scrollView.addSubview(host.view)
        
        if axis.contains(.horizontal) && axis.contains(.vertical) {
            NSLayoutConstraint.activate([
                scrollView.leftAnchor.constraint(equalTo: host.view.leftAnchor),
                scrollView.rightAnchor.constraint(equalTo: host.view.rightAnchor),
                scrollView.topAnchor.constraint(equalTo: host.view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: host.view.bottomAnchor),
            ])
        } else if axis.contains(.horizontal) {
            NSLayoutConstraint.activate([ scrollView.centerYAnchor.constraint(equalTo: host.view.centerYAnchor) ])
            scrollView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        } else if axis.contains(.vertical) {
            NSLayoutConstraint.activate([ scrollView.centerXAnchor.constraint(equalTo: host.view.centerXAnchor) ])
            scrollView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        } else {
            assertionFailure("No axis for CustomUIScrollView")
        }
        return scrollView
    }
    
    public func updateUIView(_ scrollView: UIScrollView, context: Context) {
        if let contentOffset = contentOffsetToScrollAnimated {
            scrollView.setContentOffset(contentOffset, animated: true)
            DispatchQueue.main.async {
                self.contentOffsetToScrollAnimated = nil
            }
        } else if contentOffset != .invalidContentOffset {
            scrollView.contentOffset = contentOffset
        }
        
        updateScrollView(scrollView)
        
        let host = context.coordinator.host!
        host.rootView = content()
        host.view.setNeedsUpdateConstraints()
        scrollView.layoutIfNeeded()
        scrollView.contentSize = host.view.frame.size
    }
    
    public func makeCoordinator() -> CustomUIScrollView<Content>.Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: CustomUIScrollView
        var host: UIHostingController<Content>!
        
        init(_ view: CustomUIScrollView) { parent = view }
        
        // MARK: UIScrollViewDelegate
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.parent.contentOffset = scrollView.contentOffset
            }
        }
    }
}

private class ScrollView: UIScrollView {
    let axis: Axis.Set
    
    init(_ axis: Axis.Set) {
        self.axis = axis
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        if axis.contains(.horizontal) && !axis.contains(.vertical) {
            return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
        }
        if axis.contains(.vertical) && !axis.contains(.horizontal) {
            return CGSize(width: contentSize.width, height: UIView.noIntrinsicMetric)
        }
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}
