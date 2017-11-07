// ref: http://stackoverflow.com/questions/24339145/how-do-i-write-a-custom-init-for-a-uiview-subclass-in-swift/37645346?noredirect=1#comment66816342_37645346

import UIKit

class CustomView : UIView {
    
    init() {
        super.init(frame: UIScreen.main.bounds);
        
        //for debug validation
        self.backgroundColor = UIColor.blue;
        print("My Custom Init");
        
        return;
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
