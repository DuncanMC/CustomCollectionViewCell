//
//  MyCollectionViewCell.swift
//  CustomCollectionViewCell
//
//  Created by Duncan Champney on 12/7/20.
//  Copyright © 2020 Duncan Champney. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    var color: UIColor! = nil

    var hue: CGFloat = 0
    var layer1 = CALayer()
    var layer2 = CALayer()

    @IBOutlet weak var customLabel: UILabel!
    override func awakeFromNib() {

        let step:CGFloat = 0.075 // What percent to shift the faded layers down
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = false

        //Color each cell's layer some random hue (change to whatever color you desire. The
        hue = CGFloat.random(in: 0...360)
        layer.masksToBounds = false
        color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
        contentView.layer.backgroundColor = color.cgColor

        let layerFrame = contentView.layer.bounds
        var frame1 = layerFrame
        frame1.origin.y += layerFrame.size.height * step
        frame1.origin.x += layerFrame.size.width * step

        frame1.size.width *= CGFloat(1 - 2 * step)
        layer1.frame = frame1
        layer1.cornerRadius = 30

        //Make the first extra layer have the same color as the cell's layer, but with alpha 0.25
        layer1.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 0.25).cgColor
        contentView.layer.addSublayer(layer1)

        //Create a mask layer to clip the extra layers.
//        let mask = CAShapeLayer()
//        mask.frame = layerFrame
//        var maskFrame = layerFrame
//        maskFrame.origin.y -= layerFrame.size.height * step + 3
//
//        maskFrame.origin.y += layerFrame.size.height
//        mask.path = UIBezierPath(rect: maskFrame).cgPath
//        mask.fillColor = UIColor.white.cgColor
//        mask.backgroundColor = UIColor.clear.cgColor
//        layer1.mask = mask
        var frame2 = layerFrame
        frame2.origin.y += layerFrame.size.height * 1.75 * step
        frame2.origin.x += layerFrame.size.width * 2 * step

        frame2.size.width *= CGFloat(1 - 4 * step)
        layer2.frame = frame2
        layer2.cornerRadius = 30
        //Make the second extra layer have the same color as the cell's layer, but with alpha 0.1245
        layer2.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 0.125).cgColor
        contentView.layer.addSublayer(layer2)
    }

    override var frame: CGRect {
        didSet {
            print("new frame = \(frame)")
        }
    }
}
