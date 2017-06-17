//
//  IndefiniteLoadingBar.swift
//  IndefiniteLoadingBar
//
//  Created by Charles Muchene on 17/06/2017.
//  Copyright © 2017 SenseiDevs. All rights reserved.
//

import UIKit

/// A basic implementation of an indefinite loading bar
class IndefiniteLoadingBar: UIView {
    
    private var isAnimating: Bool = false
    private var pieceWidth: CGFloat!
    private var progressPiecesArray = [UIView]()
    
    /// Color of the animated pieces
    var progressColor: UIColor = UIColor.green
    
    /// Color of the track
    var trackColor: UIColor = UIColor.clear {
        didSet { self.backgroundColor = trackColor }
    }
    
    /// The number of pieces to animate
    var pieces: Int = 5 {
        didSet { if pieces < 1 { pieces = 1 } }
    }
    
    /// Duration of the piece animation
    var animationDuration:Double = 0.8 {
        didSet { if animationDuration < 0 { animationDuration = 0.1 } }
    }
    
    /// The delay of the loop
    var loopDelay: Double = 0.2 {
        didSet { if loopDelay < 0 { loopDelay = 0.1 } }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        self.pieceWidth = frame.width * 0.1
        self.backgroundColor = self.trackColor
    }
    
    /// Create and return a formatted loading piece
    ///
    /// - Returns: UIView instance as a loading piece
    private func getLoadingPiece() -> UIView {
        let frame = CGRect(x: -pieceWidth, y: 0, width: pieceWidth, height: self.frame.size.height)
        let view = UIView(frame: frame)
        view.clipsToBounds = true
        view.layer.cornerRadius = 3.0
        view.backgroundColor = progressColor
        return view
    }
    
    /// Starts animating the pieces
    func startAnimating() {
        if (isAnimating) {
            return
        }
        isAnimating = true
        for _ in 1...pieces {
            progressPiecesArray.append(getLoadingPiece())
        }
        let delayDelta = animationDuration / Double(pieces)
        var delay: TimeInterval = 0
        for v in progressPiecesArray {
            self.addSubview(v)
            delay += delayDelta
            self.animateProgress(piece: v, delay: delay)
        }
        
    }
    
    /// Stops animating the pieces
    func stopAnimating() {
        if (!isAnimating) {
            return
        }
        isAnimating = false
        for v in progressPiecesArray {
            v.removeFromSuperview()
        }
        self.progressPiecesArray.removeAll()
    }
    
    /// Animates the pieces for the loading bar
    ///
    /// - Parameters:
    ///   - piece: The UIView piece to animate
    ///   - delay: Delay for displaying the piece
    private func animateProgress(piece: UIView, delay: TimeInterval) {
        UIView.animate(withDuration: animationDuration, delay: delay, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            var frame = piece.frame
            frame.origin.x = self.frame.size.width
            piece.frame = frame
        }, completion: { (finished: Bool) in
            var frame = piece.frame
            frame.origin.x = -self.pieceWidth
            piece.frame = frame
            if (finished) {
                self.animateProgress(piece: piece, delay: self.loopDelay
                )
            }
        })
    }
    
}
