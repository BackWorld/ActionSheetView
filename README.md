# ActionSheetView
A action sheet view simple and easy to use.

![Demo](http://upload-images.jianshu.io/upload_images/1334681-bf66e4a0ff406c06.gif?imageMogr2/auto-orient/strip)

- Platform: iOS8.0+ 
- Language: Swift3.0
- Editor: Xcode8

### How to use it?

```
let items = ["item0", "item1", "item2"]

ActionSheetView.show(items: items){[unowned self] (index) in
    print("selected item: \(index)")
}

```
