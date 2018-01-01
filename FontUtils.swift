/************************************************************************************************************************************/
/** @file		FontUtils.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 * 	@created	1/1/18
 * 	@last rev	1/1/18
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


class FontUtils : NSObject {
    
    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    override init() {
        super.init();
        print("FontUtils.init():     initialization complete");
        return;
    }
    
    class func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = fontDescriptor().withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits));
        return UIFont(descriptor: descriptor!, size: 0);
    }
    
    
    class func bold() -> UIFont {
        return withTraits(traits: .traitBold);                              /* .SFUIText-Semibold                                   */
    }
    
    
    class func italic() -> UIFont {
        return withTraits(traits: .traitItalic);                            /* .SFUIText-Italic                                     */
    }
    
    
    class func boldItalic() -> UIFont {
        return withTraits(traits: .traitBold, .traitItalic);                /* .SFUIText-SemiboldItalic                             */
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

