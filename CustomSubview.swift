// ref: http://stackoverflow.com/questions/24339145/how-do-i-write-a-custom-init-for-a-uiview-subclass-in-swift/37645346?noredirect=1#comment66816342_37645346

import UIKit

class CustomSubview : UIView {
    
    init() {
        super.init(frame: UIScreen.main.bounds);
        
        let windowHeight : CGFloat = 150;
        let windowWidth  : CGFloat = 360;
        
        let borderSize : CGFloat = 2;
        let borderColor : CGColor = UIColor(red:   140/255, green: 140/255, blue:  140/255, alpha: 1.0).cgColor; //Apple Border Color
        

        self.backgroundColor = UIColor.white;
        self.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight);
        self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 375);

 
        //Generate upper border for the View
        let upperBorder : CALayer = CALayer();
        upperBorder.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: borderSize);
        upperBorder.backgroundColor = borderColor;
 
        //Generate bottom border for the View
        let bottomBorder : CALayer = CALayer();
        bottomBorder.frame = CGRect(x: 0, y: windowHeight - borderSize, width: self.frame.width, height: borderSize);
        bottomBorder.backgroundColor = borderColor;
 
        //Generate left border for the View
        let leftBorder : CALayer = CALayer();
        leftBorder.frame = CGRect(x: 0,y: 0, width: borderSize, height: self.frame.height);
        leftBorder.backgroundColor = borderColor;
 
        //Generate left border for the View
        let rightBorder : CALayer = CALayer();
        rightBorder.frame = CGRect(x: self.frame.width-borderSize, y: 0, width: borderSize, height: self.frame.height);
        rightBorder.backgroundColor = borderColor;
 
        //Add border
        self.layer.addSublayer(upperBorder);          /* note - it could be added to self.view.layer instead if desired   */
        self.layer.addSublayer(bottomBorder);
        self.layer.addSublayer(leftBorder);
        self.layer.addSublayer(rightBorder);


        //for debug validation
        self.backgroundColor = UIColor.gray;
        print("My Custom Init");
 
        return;
    }
 
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
