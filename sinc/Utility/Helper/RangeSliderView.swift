 //
//  RangeSliderView.swift
//  sinc
//
//  Created by mac on 13/04/21.
//

import UIKit

protocol RangeSliderViewDelegate {
    func getRagneBetweenThumb(startRange : Int , endRange : Int,slider : RangeSliderView)
}

class RangeSliderView: UIView {
    
    
    @IBOutlet weak var sliderBackgroundView: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var leftThumbImageView: UIImageView!
    @IBOutlet weak var rightThumbImageView: UIImageView!
    
    @IBOutlet weak var lblLastIndex: UILabel!
    @IBOutlet weak var lblStartIndex: UILabel!
    var delegate : RangeSliderViewDelegate?
    
    
    var sliderMainImageView = UIImageView()
    
    var counterFirstLabel = UILabel()
    var counterSecondLabel = UILabel()
    
    var firstSliderPercentage = CGFloat(0)
    var secondSliderPercentage = CGFloat(0)
    var totalPercentage = CGFloat(0)
    var totalBGWidth = CGFloat(0)
    
    var startIndex = 0
    var lastIndex = 0
    var initIndex = 0
    
    var distaceBetweenThumbs = 4
    
    var leftDistance = 0
    var rightDistance = 60
    var distanceOfSlider = Int()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        
    }
    
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "RangeSliderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setUpUI()
    }
    func setUpUI(){
        
        lblTitle.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        lblLastIndex.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        lblStartIndex.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        
        lblLastIndex.text = "\(lastIndex)"
        lblStartIndex.text = "\(startIndex)"
        
        initIndex = startIndex
        distanceOfSlider = lastIndex - startIndex
        
        sliderBackgroundView.backgroundColor = .sepraterViewColor
        sliderBackgroundView.setRoundedView()
        
        totalBGWidth = self.sliderBackgroundView.frame.width
        sliderMainImageView.frame = CGRect(x: 0, y: 0, width: sliderBackgroundView.frame.width, height: sliderBackgroundView.frame.height)
        sliderMainImageView.image = UIImage(named: "slider_range")
        self.sliderBackgroundView.addSubview(sliderMainImageView)
        
        counterFirstLabel.removeFromSuperview()
        counterFirstLabel  = UILabel(frame:CGRect(x: 0, y: -17, width: 32, height: 30))
        self.addSubview(counterFirstLabel)
        counterFirstLabel.text = "\(Int(startIndex))"
        counterFirstLabel.center.x = leftThumbImageView.center.x
        counterFirstLabel.center.y = leftThumbImageView.center.y - 20
        counterFirstLabel.textColor = .black
        counterFirstLabel.textAlignment = .center
        
        counterSecondLabel.removeFromSuperview()
        counterSecondLabel  = UILabel(frame:CGRect(x: 0, y: -17, width: 32, height: 30))
        self.addSubview(counterSecondLabel)
        counterSecondLabel.text = "\(Int(lastIndex))"
        counterSecondLabel.center.x = rightThumbImageView.center.x
        counterSecondLabel.center.y = rightThumbImageView.center.y - 20
        counterSecondLabel.textColor = .black
        counterSecondLabel.textAlignment = .center
        
        counterFirstLabel.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        counterSecondLabel.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        
    }
    
    func resetRangeSlider(){
        leftThumbImageView.frame.origin.x = sliderBackgroundView.frame.origin.x
        rightThumbImageView.frame.origin.x = sliderBackgroundView.frame.width
        counterSecondLabel.frame.origin.x = rightThumbImageView.frame.origin.x
        counterFirstLabel.frame.origin.x = leftThumbImageView.frame.origin.x
        sliderMainImageView.frame.size.width = sliderBackgroundView.frame.width
    }
    
    func applyGestures(){
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(leftThumbPan(_:)))
        self.leftThumbImageView.addGestureRecognizer(panGestureRecognizer)
        let panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(rightThumbPan(_:)))
        self.rightThumbImageView.addGestureRecognizer(panGestureRecognizer2)
    }
    
    func setFirstPoint(){
        counterFirstLabel.text = "\(startIndex)"
        leftThumbImageView.frame.origin.x = CGFloat(Int(totalBGWidth) * startIndex / lastIndex)
        sliderMainImageView.frame.origin.x = CGFloat(Int(totalBGWidth) * startIndex / lastIndex)
        counterFirstLabel.center.y = leftThumbImageView.center.y - 20
        delegate?.getRagneBetweenThumb(startRange: leftDistance,endRange: rightDistance,slider: self)
    }
    
    func setLastPoint(){
        counterSecondLabel.text = "\(lastIndex)"
        counterSecondLabel.center.x = rightThumbImageView.center.x
        counterSecondLabel.center.y = rightThumbImageView.center.y - 20
        delegate?.getRagneBetweenThumb(startRange: leftDistance, endRange: rightDistance,slider: self)
    }
    
    
    @objc func leftThumbPan(_ sender : UIPanGestureRecognizer){
        leftDistance = 0
        startIndex = 0
        let distance = sender.location(in: sliderBackgroundView).x
        let percentage = initIndex + Int(((distance) / totalBGWidth) * CGFloat(distanceOfSlider))
        leftDistance = percentage
        print("print(leftDistance) :", leftDistance)
        if percentage < startIndex {
            return
        }
        else if rightDistance - leftDistance <= distaceBetweenThumbs{
            return
        }
        else{
            counterFirstLabel.text = "\(percentage)"
            leftThumbImageView.frame.origin.x = sender.location(in: sliderBackgroundView).x
            sliderMainImageView.frame.origin.x = sender.location(in: sliderBackgroundView).x
            sliderMainImageView.frame.size.width = rightThumbImageView.frame.origin.x - sender.location(in: sliderBackgroundView).x
            counterFirstLabel.center.x = leftThumbImageView.center.x
            counterFirstLabel.center.y = leftThumbImageView.center.y - 20
            delegate?.getRagneBetweenThumb(startRange: leftDistance,endRange: rightDistance,slider: self)
        }
    }
    
    @objc func rightThumbPan(_ sender : UIPanGestureRecognizer){
        rightDistance = 0
        let percentage = Int(((sender.location(in: sliderBackgroundView).x / CGFloat(totalPercentage)) * totalPercentage))
        rightDistance = percentage
        print("print(rightDistance) :", distaceBetweenThumbs)
        if percentage > lastIndex {
            return
        }
        else if rightDistance - leftDistance <= distaceBetweenThumbs{
            return
        }
        else{
            counterSecondLabel.text = "\(percentage)"
            rightThumbImageView.frame.origin.x = sender.location(in: sliderBackgroundView).x
            sliderMainImageView.frame.origin.x = sender.location(in: sliderBackgroundView).x
            sliderMainImageView.frame.size.width = leftThumbImageView.frame.origin.x - sender.location(in: sliderBackgroundView).x
            counterSecondLabel.center.x = rightThumbImageView.center.x
            counterSecondLabel.center.y = rightThumbImageView.center.y - 20
            delegate?.getRagneBetweenThumb(startRange: leftDistance, endRange: rightDistance,slider: self)
        }
    }
}
