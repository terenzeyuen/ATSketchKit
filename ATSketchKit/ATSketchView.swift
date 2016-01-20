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

	public var delegate: ATSketchViewDelegate?
	
	public enum Tools {
		case Finger
		case Pencil
		case SmartPencil
		case Eraser
	}
	public var currentTool: Tools = .Pencil
	public var currentLineWidth: CGFloat = 1.0
	public var currentColor: UIColor = UIColor.greenColor()
	
	var eraserColor: UIColor {
		get {
			return self.backgroundColor != nil ? self.backgroundColor! : UIColor.whiteColor()
		}
	}
	var touchDownPoint: CGPoint!
	var lastKnownTouchPoint: CGPoint!
	
	var topLayer: ATSketchTopLayer!
	
	var pointsBuffer = [CGPoint]()
	
	// Undo/Redo
	var history = [CALayer]()
	public var allowUndoRedo = true
	public var maxUndoRedoSteps = 30
	// TODO: Implement a max count for these for memory-purpose.
	
	public var canUndo: Bool {
		get {
			return allowUndoRedo
			// TODO: add here conditions based on the history stack
		}
	}
	
	public var canRedo: Bool {
		get {
			return allowUndoRedo && self.history.count > 0
		}
	}
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureView()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configureView()
	}
	
	func configureView() {
		// Insert customization & init here
		self.topLayer = ATSketchTopLayer()
		self.topLayer.fillColor = nil
		self.layer.addSublayer(self.topLayer)
	}
	
	public override func drawRect(rect: CGRect) {
		super.drawRect(rect)
		
	}
	
	public func produceImage() -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
		self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image
	}
	
	public override var description: String {
		get {
			return self.debugDescription
		}
	}
	
	public override var debugDescription: String{
		get {
			return "ATSmartBezierPath \n" +
				"Current Tool: \(self.currentTool)\n" +
				"Current Line Width: \(self.currentLineWidth)\n" +
				"Current Color: \(self.currentColor)\n"
		}
	}
}
