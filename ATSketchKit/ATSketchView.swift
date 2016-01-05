//
//  ATSketchView.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

@IBDesignable
public class ATSketchView: UIView {

	public enum Tools {
		case Finger
		case Pencil
	}
	
	public enum Actions {
		case Select
		case Move
		case Draw
	}
	
	var touchDownPoint: CGPoint!
	var lastKnownTouchPoint: CGPoint!
	
	var topLayer: ATSketchTopLayer!
	
	public var currentTool: Tools = .Pencil
	public var currentAction: Actions = .Draw
	
	var pointsBuffer = [CGPoint]()
	
	var pointsLayers = [[CGPoint]]()
	
	public override func drawRect(rect: CGRect) {
		var smartPath = ATSmartBezierPath(withPoints: pointsBuffer)
		var smoothPath = smartPath.smoothPath(20)

		UIColor.redColor().setStroke()
		smoothPath.lineWidth = 1
		smoothPath.stroke()
		
		for points in pointsLayers {
			smartPath = ATSmartBezierPath(withPoints: points)
			smoothPath = smartPath.smoothPath(20)

			UIColor.blackColor().setStroke()
			smoothPath.lineWidth = 1
			smoothPath.lineCapStyle = .Round
			smoothPath.stroke()
		}
	}

}
