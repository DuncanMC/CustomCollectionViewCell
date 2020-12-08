//
//  MyCollectionViewCell.swift
//  CustomCollectionViewCell
//
//  Created by Duncan Champney on 12/7/20.
//  Released into the public domain.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    var color: UIColor! = nil

    var hue: CGFloat = 0
    var layer1 = CALayer()
    var layer2 = CALayer()

    @IBOutlet weak var customLabel: UILabel!
    override func awakeFromNib() {

        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = false

        // Color each cell's layer some random hue (change to whatever color you desire.)
        // If you don't use HSB, save the R/G/B values of your color and use those,
        // with lower alpha values, for the extra layers.
        hue = CGFloat.random(in: 0...360)
        layer.masksToBounds = false
        color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
        contentView.layer.backgroundColor = color.cgColor
        layer1.cornerRadius = 30
        layer2.cornerRadius = 30
        //Make the first extra layer have the same color as the cell's layer, but with alpha 0.25
        layer1.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 0.25).cgColor

        //Make the second extra layer have the same color as the cell's layer, but with alpha 0.125
        layer2.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 0.125).cgColor

        sizeLayerFrames()

        contentView.layer.addSublayer(layer1)
        contentView.layer.addSublayer(layer2)
    }

    func sizeLayerFrames() {
        let step:CGFloat = 0.075 // What percent to shrink & shift the faded layers down

        let viewBounds = bounds //Use the layer's bounds as the starting point for the extra layers.
        var frame1 = viewBounds
        frame1.origin.y += viewBounds.size.height * step
        frame1.origin.x += viewBounds.size.width * step

        frame1.size.width *= CGFloat(1 - 2 * step)
        layer1.frame = frame1
        var frame2 = viewBounds
        frame2.origin.y += viewBounds.size.height * 1.75 * step
        frame2.origin.x += viewBounds.size.width * 2 * step

        frame2.size.width *= CGFloat(1 - 4 * step)
        layer2.frame = frame2
    }

    override var bounds: CGRect {
        didSet {
            sizeLayerFrames()
        }
    }
}
