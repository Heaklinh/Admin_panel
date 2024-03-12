import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatefulWidget {
  final String image;
  final String productName;
  final String price;
  final String status;
  final int orderNumber;
  final String username;
  const ItemTile({
    super.key,
    required this.image,
    required this.username,
    required this.price,
    required this.status,
    required this.orderNumber,
    required this.productName,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: isHovered ? Colors.grey[500] : AppColor.white,
          border: const Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 0.3,
            ),
          )
          // boxShadow: [
          //   BoxShadow(
          //     offset: const Offset(0, 6),
          //     color: AppColor.disable.withOpacity(.1),
          //     blurRadius: 12,
          //   ),
          // ],
          ),
      child: InkWell(
        onHover: (value) {
          setState(() {
            isHovered = value;
            if (value == true) {
              print('hover');
            } else {
              print('not ');
            }
          });
        },
        borderRadius: BorderRadius.circular(8),
        // onTap: () {},
        child: Row(
          children: [
            Expanded(
              flex: ResponsiveWidget.isCustomScreen(context) ? 2 : 3,
              child: Row(
                children: [
                  Image.network(
                    widget.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Number: ${widget.orderNumber}",
                        style: TextStyle(
                          fontFamily: "Niradei",
                          fontWeight: FontWeight.bold,
                          fontSize:
                              ResponsiveWidget.isLargeScreen(context) ? 16 : 14,
                        ),
                      ),
                      Text(
                        widget.productName,
                        style: const TextStyle(
                            fontFamily: "Niradei", fontSize: 11),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ResponsiveWidget.isSmallScreen(context)
                  ? Align(
                      alignment: Alignment.center,
                      child: Text(
                        '\$${widget.price}',
                        style: TextStyle(
                          fontSize:
                              ResponsiveWidget.isLargeScreen(context) ? 16 : 14,
                        ),
                      ),
                    )
                  : Text(
                      '\$${widget.price}',
                      style: TextStyle(
                        fontSize:
                            ResponsiveWidget.isLargeScreen(context) ? 16 : 14,
                      ),
                    ),
            ),
            Expanded(
              child: Text(
                widget.username,
                style: TextStyle(
                    fontSize:
                        ResponsiveWidget.isSmallScreen(context) ? 12 : 14),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const ShapeDecoration(
                  color: AppColor.primary,
                  shape: BeveledRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(4)),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Text(
                    widget.status,
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize:
                          ResponsiveWidget.isSmallScreen(context) ? 12 : 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
