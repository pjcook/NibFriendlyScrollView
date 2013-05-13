Purpose
--------------

NibFriendlyScrollView is a simple library that allows you to configure the contentView of a UIScrollView via a nib file therefore not requiring you to create multiple IBOutlets for the UIScrollView and UIView (for the content view).  This class is also configured with keyboard listeners which are enabled by default.  When the keyboard is displayed the content insets of the scrollview are resized so that the scrollview content aligns with the keyboard and the scrollview content is not hidden by the keyboard.


Installation
--------------

To install iAdPlusAdMob into your app, drag the following files into your project:
 - NibFriendlyScrollView.h and .m

In your nib file, add a UIScrollView and a UIView.  Make the UIScrollView inherit from NibFriendlyScrollView, then bind the "scrollViewContent" IBOutlet from the scrollview to the UIView.  That's it.  I had to name the contentView IBOutlet "scrollViewContent" so as not to interfere with Apple's "contentView".

