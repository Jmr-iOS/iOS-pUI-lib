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
 * 		headers
 *      deprecate bold etc.
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
    
    //Font Options (add as needed)
    enum FontUtilOptions {
        case bold;
        case italic;
        case light;
        case ultralight;
        case regular;
        case medium;
        case thin;
        case heavy;
    }

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
    
    
    /********************************************************************************************************************************/
    /** @fcn        updateFont(_ font : UIFont, _ feats : [FontUtilOptions]) -> UIFont
     *  @brief      get customized font version
     *  @details    e.g. bold or italics, etc.
     *
     *  @assum    font features valid for selected family and in combination together
     *  @warn     throws fatal error if font requested not present
     *  @todo     support correct selection of feats (e.g. ABC vs. CAB, etc.)
     *  @note     italic always follows bold (e.g. 'Verdana-BoldItalic')
     *  @open     .MT support
     */
    /********************************************************************************************************************************/
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
        
        if(verbose) { print("FontUtils.updateFont():             returning \(newFontName)"); }
        
        return newFont!;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        updateSize(_ font : UIFont, _ size : CGFloat) -> UIFont
     *  @brief      set font size
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func updateFontSize(_ font : UIFont, _ size : CGFloat) -> UIFont {
        
        //Return updated
        return font.withSize(size);
    }
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        incrementFontSize(_ font : UIFont, _ size : CGFloat) -> UIFont
     *  @brief      increment font size
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func incrementFontSize(_ font : UIFont, _ size : CGFloat) -> UIFont {
        
        //Calc size
        let size : CGFloat = (font.pointSize + size);
        
        //Return updated
        return font.withSize(size);
    }
    
        
    /********************************************************************************************************************************/
    /** @fcn        applyTrait()
     *  @brief      apply conventional iOS traits, for reference
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
    
    
    /********************************************************************************************************************************/
    /** @fcn        withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = fontDescriptor().withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits));
        return UIFont(descriptor: descriptor!, size: 0);
    }

    
    /********************************************************************************************************************************/
    /** @fcn        fontDescriptor()
     *  @brief      get font descriptor of a standard UITextView
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func fontDescriptor() -> UIFontDescriptor {
        let text : UITextView = UITextView();
        return text.font!.fontDescriptor;
    }
}

