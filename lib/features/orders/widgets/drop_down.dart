// import 'package:flutter/material.dart';

// class CustomDropDown<T> extends StatefulWidget {
//   final List<CustDropdownMenuItem> items;
//   final Function onChanged;
//   final String hintText;
//   final double maxListHeight;
//   final double borderRadius;
//   final double borderWidth;
//   final int defaultSelectedIndex;
//   final bool enabled;
//   const CustomDropDown({
//     super.key,
//     required this.items,
//     required this.onChanged,
//     this.hintText = '',
//     this.maxListHeight = 100,
//     this.borderRadius = 12,
//     this.borderWidth = 10,
//     this.defaultSelectedIndex = -1,
//     this.enabled = true,
//   });

//   @override
//   State<CustomDropDown> createState() => _CustomDropDownState();
// }

// class _CustomDropDownState extends State<CustomDropDown>
//     with WidgetsBindingObserver {
//   bool _isOpen = false, _isAnyItemSelected = false, _isReverse = false;
//   late OverlayEntry _overlayEntry;
//   late RenderBox? _renderBox;
//   Widget? _itemSelected;
//   late Offset dropDownOffset;
//   final LayerLink _layerLink = LayerLink();

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         setState(() {
//           dropDownOffset = getOffset();
//         });
//       }
//       if (widget.defaultSelectedIndex > -1) {
//         if (widget.defaultSelectedIndex < widget.items.length) {
//           if (mounted) {
//             setState(() {
//               _isAnyItemSelected = true;
//               _itemSelected = widget.items[widget.defaultSelectedIndex];
//               widget.onChanged(widget.items[widget.defaultSelectedIndex].value);
//             });
//           }
//         }
//       }
//     });
//     WidgetsBinding.instance.addObserver(this);
//     super.initState();
//   }

//   void _addOverlay() {
//     if (mounted) {
//       setState(() {
//         _isOpen = true;
//       });
//     }

//     _overlayEntry = _createOverlayEntry();
//     Overlay.of(context).insert(_overlayEntry);
//   }

//   void _removeOverlay() {
//     if (mounted) {
//       setState(() {
//         _isOpen = false;
//       });
//       _overlayEntry.remove();
//     }
//   }

//   @override
//   dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   OverlayEntry _createOverlayEntry() {
//     _renderBox = context.findRenderObject() as RenderBox?;

//     var size = _renderBox!.size;

//     dropDownOffset = getOffset();

//     return OverlayEntry(
//         maintainState: false,
//         builder: (context) => Align(
//               alignment: Alignment.center,
//               child: CompositedTransformFollower(
//                 link: _layerLink,
//                 showWhenUnlinked: false,
//                 offset: dropDownOffset,
//                 child: SizedBox(
//                   height: widget.maxListHeight,
//                   width: size.width,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: _isReverse
//                         ? MainAxisAlignment.end
//                         : MainAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Container(
//                           constraints: BoxConstraints(
//                               maxHeight: widget.maxListHeight,
//                               maxWidth: size.width),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12)),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(widget.borderRadius),
//                             ),
//                             child: Material(
//                               elevation: 0,
//                               shadowColor: Colors.grey,
//                               child: ListView(
//                                 padding: EdgeInsets.zero,
//                                 shrinkWrap: true,
//                                 children: widget.items
//                                     .map((item) => GestureDetector(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: item.child,
//                                           ),
//                                           onTap: () {
//                                             if (mounted) {
//                                               setState(() {
//                                                 _isAnyItemSelected = true;
//                                                 _itemSelected = item.child;
//                                                 _removeOverlay();
//                                                 if (widget.onChanged != null)
//                                                   widget.onChanged(item.value);
//                                               });
//                                             }
//                                           },
//                                         ))
//                                     .toList(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//   }

//   Offset getOffset() {
//     RenderBox? renderBox = context.findRenderObject() as RenderBox?;
//     double y = renderBox!.localToGlobal(Offset.zero).dy;
//     double spaceAvailable = _getAvailableSpace(y + renderBox.size.height);
//     if (spaceAvailable > widget.maxListHeight) {
//       _isReverse = false;
//       return Offset(0, renderBox.size.height);
//     } else {
//       _isReverse = true;
//       return Offset(
//           0,
//           renderBox.size.height -
//               (widget.maxListHeight + renderBox.size.height));
//     }
//   }

//   double _getAvailableSpace(double offsetY) {
//     double safePaddingTop = MediaQuery.of(context).padding.top;
//     double safePaddingBottom = MediaQuery.of(context).padding.bottom;

//     double screenHeight =
//         MediaQuery.of(context).size.height - safePaddingBottom - safePaddingTop;

//     return screenHeight - offsetY;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: widget.enabled
//             ? () {
//                 _isOpen ? _removeOverlay() : _addOverlay();
//               }
//             : null,
//         child: Container(
//           decoration: _getDecoration(),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Flexible(
//                 flex: 3,
//                 child: _isAnyItemSelected
//                     ? Padding(
//                         padding: const EdgeInsets.only(left: 4.0),
//                         child: _itemSelected!,
//                       )
//                     : Padding(
//                         padding:
//                             const EdgeInsets.only(left: 4.0), // change it here
//                         child: Text(
//                           widget.hintText,
//                           maxLines: 1,
//                           overflow: TextOverflow.clip,
//                         ),
//                       ),
//               ),
//               const Flexible(
//                 flex: 1,
//                 child: Icon(
//                   Icons.arrow_drop_down,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Decoration? _getDecoration() {
//     if (_isOpen && !_isReverse) {
//       return BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(widget.borderRadius),
//               topRight: Radius.circular(
//                 widget.borderRadius,
//               )));
//     } else if (_isOpen && _isReverse) {
//       return BoxDecoration(
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(widget.borderRadius),
//               bottomRight: Radius.circular(
//                 widget.borderRadius,
//               )));
//     } else if (!_isOpen) {
//       return BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)));
//     }
//   }
// }

// class CustDropdownMenuItem<T> extends StatelessWidget {
//   final T value;
//   final Widget child;

//   const CustDropdownMenuItem({required this.value, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return child;
//   }
// }

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton2 extends StatefulWidget {
  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  @override
  State<CustomDropdownButton2> createState() => _CustomDropdownButton2State();
}

class _CustomDropdownButton2State extends State<CustomDropdownButton2> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        //To avoid long text overflowing.
        isExpanded: true,
        hint: Container(
          alignment: widget.hintAlignment,
          child: Text(
            widget.hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        value: widget.value,
        items: widget.dropdownItems
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                    alignment: widget.valueAlignment,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ))
            .toList(),
        onChanged: widget.onChanged,
        selectedItemBuilder: widget.selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: widget.buttonHeight ?? 40,
          width: widget.buttonWidth ?? 140,
          padding: widget.buttonPadding ??
              const EdgeInsets.only(left: 14, right: 14),
          decoration: widget.buttonDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.black45,
                ),
              ),
          elevation: widget.buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: widget.icon ?? const Icon(Icons.arrow_forward_ios_outlined),
          iconSize: widget.iconSize ?? 12,
          iconEnabledColor: widget.iconEnabledColor,
          iconDisabledColor: widget.iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: widget.dropdownHeight ?? 200,
          width: widget.dropdownWidth ?? 140,
          padding: widget.dropdownPadding,
          decoration: widget.dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
          elevation: widget.dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: widget.offset,
          scrollbarTheme: ScrollbarThemeData(
            radius: widget.scrollbarRadius ?? const Radius.circular(40),
            thickness: widget.scrollbarThickness != null
                ? MaterialStateProperty.all<double>(widget.scrollbarThickness!)
                : null,
            thumbVisibility: widget.scrollbarAlwaysShow != null
                ? MaterialStateProperty.all<bool>(widget.scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: widget.itemHeight ?? 40,
          padding:
              widget.itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
