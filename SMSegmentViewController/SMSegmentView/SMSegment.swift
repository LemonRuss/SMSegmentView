//
//  SMSegment.swift
//
//  Created by Si MA on 03/01/2015.
//  Copyright (c) 2015 Si Ma. All rights reserved.
//

import UIKit

open class SMSegment: SMBasicSegment {
    
    // UI Elements
    override open var frame: CGRect {
        didSet {
            self.resetContentFrame()
        }
    }
    
    open var verticalMargin: CGFloat = 5.0 {
        didSet {
            self.resetContentFrame()
        }
    }
        
    // Segment Colour
    open var onSelectionColour: UIColor = UIColor.darkGray {
        didSet {
            if self.isSelected == true {
                self.backgroundColor = self.onSelectionColour
            }
        }
    }
    open var offSelectionColour: UIColor = UIColor.white {
        didSet {
            if self.isSelected == false {
                self.backgroundColor = self.offSelectionColour
            }
        }
    }
    fileprivate var willOnSelectionColour: UIColor! {
        get {
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var brightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            self.onSelectionColour.getHue(&hue,
              saturation: &saturation,
              brightness: &brightness,
              alpha: &alpha)
            return UIColor(hue: hue, saturation: saturation*0.5,
              brightness: min(brightness*1.5, 1.0), alpha: alpha)
        }
    }
    
    // Segment Title Text & Colour & Font
    open var title: String? {
        didSet {
            self.label.text = self.title
            
            if let titleText = self.label.text as NSString? {
                self.labelWidth =
                  titleText.boundingRect(with: CGSize(width: self.frame.size.width,
                    height: self.frame.size.height),
                    options:NSStringDrawingOptions.usesLineFragmentOrigin,
                    attributes: [NSFontAttributeName: self.label.font],
                    context: nil).size.width
            } else {
                self.labelWidth = 0.0
            }
            
            self.resetContentFrame()
        }
    }
    open var onSelectionTextColour: UIColor = UIColor.white {
        didSet {
            if self.isSelected == true {
                self.label.textColor = self.onSelectionTextColour
            }
        }
    }
    open var offSelectionTextColour: UIColor = UIColor.darkGray {
        didSet {
            if self.isSelected == false {
                self.label.textColor = self.offSelectionTextColour
            }
        }
    }
    open var titleFont: UIFont = UIFont.systemFont(ofSize: 17.0) {
        didSet {
            self.label.font = self.titleFont
            
            if let titleText = self.label.text as NSString? {
                self.labelWidth =
                  titleText.boundingRect(with: CGSize(width: self.frame.size.width + 1.0,
                    height: self.frame.size.height),
                    options:NSStringDrawingOptions.usesLineFragmentOrigin,
                    attributes: [NSFontAttributeName: self.label.font],
                    context: nil).size.width
            } else {
                self.labelWidth = 0.0
            }
            
            self.resetContentFrame()
        }
    }
    
    // Segment Image
    open var onSelectionImage: UIImage? {
        didSet {
            if self.onSelectionImage != nil {
                self.resetContentFrame()
            }
            if self.isSelected == true {
                self.imageView.image = self.onSelectionImage
            }
        }
    }
    open var offSelectionImage: UIImage? {
        didSet {
            if self.offSelectionImage != nil {
                self.resetContentFrame()
            }
            if self.isSelected == false {
                self.imageView.image = self.offSelectionImage
            }
        }
    }
    
   
    fileprivate var imageView: UIImageView = UIImageView()
    fileprivate var label: UILabel = UILabel()
    fileprivate var labelWidth: CGFloat = 0.0
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(verticalMargin: CGFloat, onSelectionColour: UIColor,
      offSelectionColour: UIColor, onSelectionTextColour: UIColor,
      offSelectionTextColour: UIColor, titleFont: UIFont) {
        
        self.verticalMargin = verticalMargin
        self.onSelectionColour = onSelectionColour
        self.offSelectionColour = offSelectionColour
        self.onSelectionTextColour = onSelectionTextColour
        self.offSelectionTextColour = offSelectionTextColour
        self.titleFont = titleFont
        
        super.init(frame: CGRect.zero)
        self.setupUIElements()
    }
    
    
    
    func setupUIElements() {
        
        self.backgroundColor = self.offSelectionColour
        
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(self.imageView)
        
        self.label.textAlignment = NSTextAlignment.center
        self.label.font = self.titleFont
        self.label.textColor = self.offSelectionTextColour
        self.addSubview(self.label)
    }
    
    
    // MARK: Update Frame
    fileprivate func resetContentFrame() {
        
      var imageViewFrame = CGRect(x: 0.0, y: self.verticalMargin,
          width: self.bounds.width, height: self.frame.size.height - self.verticalMargin*2)
            imageViewFrame.origin.x =
              max((self.frame.size.width - imageViewFrame.size.width) / 2.0, 0.0)
        
        self.imageView.frame = imageViewFrame
    }
    
    // MARK: Selections
    override open func setSelected(_ selected: Bool, inView view: SMBasicSegmentView) {
        super.setSelected(selected, inView: view)
        if selected {
            self.backgroundColor = self.onSelectionColour
            self.label.textColor = self.onSelectionTextColour
            self.imageView.image = self.onSelectionImage
        } else {
            self.backgroundColor = self.offSelectionColour
            self.label.textColor = self.offSelectionTextColour
            self.imageView.image = self.offSelectionImage
        }
    }
    
    // MARK: Handle touch
    override open  func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if self.isSelected == false {
            self.backgroundColor = self.willOnSelectionColour
        }
    }
}
