//
//  MyCollectionViewCell.swift
//  CustomCollectionViewCell
//
//  Created by Duncan Champney on 12/7/20.
//  Released into the public domain.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    var contentCornerRadius: CGFloat = 0 {
        didSet {
            contentView.layer.cornerRadius = contentCornerRadius
            sizeLayerFrames()
        }

    }

    var fraction: CGFloat = 0.075 { // What percent to shrink & shift the faded layers down (0.075 = 7.5%)
        didSet {
            sizeLayerFrames()
        }
    }
    var color: UIColor! = nil
    var layerMask =   CAShapeLayer()
    var layer1 = CALayer()
    var layer2 = CALayer()

    // Use this function to set the cell's background color.
    // (You can't set the view's background color, since we
    // Don't clip the view to it's bounds.
    func setBackgroundColor(_ color: UIColor)  {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        contentView.layer.backgroundColor = color.cgColor
        layer1.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 0.25).cgColor
        layer2.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 0.125).cgColor
    }

    @IBOutlet weak var customLabel: UILabel!

    //Do The initial setup once the cell is loaded.
    //Note that t
    override func awakeFromNib() {
        contentView.layer.masksToBounds = false

        // Color each cell's layer some random hue (change to whatever color you desire.)
        // If you don't use HSB, save the R/G/B values of your color and use those,
        // with lower alpha values, for the extra layers.
        let hue = CGFloat.random(in: 0...360)
        let brightness = CGFloat.random(in: 0.8...1.0)
        layer.masksToBounds = false
        setBackgroundColor(UIColor(hue: hue, saturation: 1, brightness: brightness, alpha: 1))
        //Uncomment the borderWidth values for layer1 and layer2 to see the parts of those layers that are visible.
//        layer1.borderWidth = 1
//        layer2.borderWidth = 1

        //Make the first extra layer have the same color as the cell's layer, but with alpha 0.25
        layer1.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: brightness, alpha: 0.25).cgColor

        //Make the second extra layer have the same color as the cell's layer, but with alpha 0.125
        layer2.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: brightness, alpha: 0.125).cgColor

        //Make the inside of the shape layer white, and the outside clear
        layerMask.fillColor = UIColor.white.cgColor
        layerMask.backgroundColor = UIColor.clear.cgColor

        //With the even/odd rule, the inner shape will not be filled (we'll only fill the part NOT in the inner shape)
        layerMask.fillRule = .evenOdd
        contentCornerRadius = 30


        sizeLayerFrames()

        contentView.layer.addSublayer(layer1)
        layer1.addSublayer(layer2)
        layer1.mask = layerMask
    }

    func sizeLayerFrames() {
        layer1.cornerRadius = contentCornerRadius
        layer2.cornerRadius = contentCornerRadius


        let viewBounds = bounds //Use the layer's bounds as the starting point for the extra layers.
        var frame1 = viewBounds
        frame1.origin.y += viewBounds.size.height * fraction
        frame1.origin.x += viewBounds.size.width * fraction

        frame1.size.width *= CGFloat(1 - 2 * fraction)
        layer1.frame = frame1
        var frame2 = viewBounds
        frame2.origin.y += viewBounds.size.height * 0.75 * fraction
        frame2.origin.x += viewBounds.size.width  * fraction

        frame2.size.width *= CGFloat(1 - 4 * fraction)
        layer2.frame = frame2

        //Create a mask layer to clip the extra layers.
        var maskFrame = viewBounds

        //We are going to install the mask on layer1, so offeset the frame to cover the whole view contents
        maskFrame.origin.y -= viewBounds.size.height * fraction
        maskFrame.origin.x -= viewBounds.size.width * fraction
        maskFrame.size.height += viewBounds.size.height * fraction * 1.75
        layerMask.frame = maskFrame
        maskFrame = viewBounds
        let innerPath = UIBezierPath(roundedRect: maskFrame, cornerRadius: 30)
        maskFrame.size.height += viewBounds.size.height * fraction * 1.75
        let combinedPath = UIBezierPath(rect: maskFrame)
        combinedPath.append(innerPath)
        layerMask.path = combinedPath.cgPath
    }

    override var bounds: CGRect {
        didSet {
            sizeLayerFrames()
        }
    }
}
