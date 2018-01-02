/************************************************************************************************************************************/
/** @file		FontUtils.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 * 	@created	1/1/18
 * 	@last rev	1/2/18
 *
 * 	@section	Opens
 * 		none current
 *
 *  @section    Reference
 *      https://stackoverflow.com/questions/4713236/how-do-i-set-bold-and-italic-on-uilabel-of-iphone-ipad
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

//@todo     header
//@note     to be added to as needed
enum FontUtilOptions {
    case bold
    case italic
    case light
    case ultralight
    case regular
    case medium
    case thin
    case heavy
}


class FontUtils : NSObject {
    
    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    override init() {
        super.init();
        if(verbose) { print("FontUtils.init():      initialization complete"); }
        return;
    }
    
    //@todo     header
    class func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = fontDescriptor().withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits));
        return UIFont(descriptor: descriptor!, size: 0);
    }
    
    
    //@todo     header
    class func bold() -> UIFont {
        return withTraits(traits: .traitBold);                              /* .SFUIText-Semibold                                   */
    }
    
    
    //@todo     header
    class func italic() -> UIFont {
        return withTraits(traits: .traitItalic);                            /* .SFUIText-Italic                                     */
    }
    
    
    //@todo     header
    class func boldItalic() -> UIFont {
        return withTraits(traits: .traitBold, .traitItalic);                /* .SFUIText-SemiboldItalic                             */
    }
    
    
    //@todo     header
    //@assum    font features valid for selected family and in combination together
    //@warn     throws fatal error if font requested not present
    //@todo     support correct selection of feats (e.g. ABC vs. CAB, etc.)
    //@note     italic always follows bold (e.g. 'Verdana-BoldItalic')
    //@open     .MT support
    class func updateFont(_ font : UIFont, _ feats : [FontUtilOptions]) -> UIFont {
        
        let fontName       : String   = font.fontName;
        let fontNameFields : [String] = fontName.split{$0 == "-"}.map(String.init);
        let fontFamily     : String   = fontNameFields[0];
        
        //Generate customization string
        var custStr : String = "";
        
        for feat in feats {
            switch(feat) {
                case .bold:
                    custStr = custStr + "Bold";
                    break;
                case .italic:
                    custStr = custStr + "Italic";
                    break;
                case .light:
                    custStr = custStr + "Light";
                    break;
                case .ultralight:
                    custStr = custStr + "UltraLight";
                    break;
                case .regular:
                    custStr = custStr + "Regular";
                    break;
                case .medium:
                    custStr = custStr + "Medium";
                    break;
                case .thin:
                    custStr = custStr + "Thin";
                    break;
                default:
                    fatalError("FontUtils.updateFont():    \(feat) requested and not supported yet.");
            }
            
        }
        
        //Generate
        let newFontName = fontFamily + "-" + custStr;
        let newFont : UIFont? = UIFont(name: newFontName, size: font.pointSize);
        
        //@post     safety
        if(newFont == nil) {
            fatalError("font \(newFontName) not supported");
        }
        
        if(verbose) { print("FontUtils.updateFont():  returning \(newFontName)"); }
        
        return newFont!;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        applyTrait()
     *  @brief      x
     *  @details    x
     *
     *  @section Traits
     *      .traitItalic
     *      .traitBold
     *      .traitExpanded
     *      .traitCondensed
     *      .traitMonoSpace
     *      .traitVertical
     *      .traitUIOptimized
     *      .traitTightLeading
     *      .traitLooseLeading
     */
    /********************************************************************************************************************************/
    class func applyTrait(font : UIFont, newTrait : UIFontDescriptorSymbolicTraits) -> UIFont {
        font.fontDescriptor.withSymbolicTraits(newTrait);
        return withTraits(traits: newTrait);
    }
    
    
    class func fontDescriptor() -> UIFontDescriptor {
        let label : UILabel = UILabel();
        return label.font.fontDescriptor;
    }
}

