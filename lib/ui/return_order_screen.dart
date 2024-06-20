import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/order_shipment_return/order_shipment_return_bloc.dart';
import 'package:flutter_kundol/blocs/order_shipment_return/order_shipment_return_event.dart';
import 'package:flutter_kundol/blocs/order_shipment_return/order_shipment_return_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';

import '../blocs/order_shipment_cancel/order_shipment_cancel_bloc.dart';
import '../blocs/orders/orders_bloc.dart';
import '../blocs/shipment_track/shipment_track_bloc.dart';
import '../constants/app_styles.dart';
import '../models/orders_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

import '../repos/order_shipment_cancel_repo.dart';
import '../repos/orders_repo.dart';
import '../repos/shipment_track_repo.dart';
import 'my_orders.dart';



class ReturnOrderScreen extends StatefulWidget {
  final Function(Widget widget)? navigateToNext;
  final OrdersData? ordersData;

  const ReturnOrderScreen({required this.ordersData,required this.navigateToNext,Key? key}) : super(key: key);

  @override
  _ReturnOrderScreenState createState() => _ReturnOrderScreenState();
}

class _ReturnOrderScreenState extends State<ReturnOrderScreen> {

  List<String>  returnReasons=[
    "I have multiple issues with product",
    "Product is missing in the package",
    "Received a broken/damaged item",
    "Received wrong item",
    "Don't like the size/fit of the product",
    "Quality of the product not as expected",
    "Don't want the product anymore"
  ];

  String ?_selectedReason;
  TextEditingController commentController=TextEditingController();
  TextEditingController upiIdController=TextEditingController();

  List<File>? _selectedImages;

  List<String>  returnType=[
    "exchange",
    "refund"
  ];

  int onReturnTypeSelected=-1;
  String ?selectedReturnType;
  String ?submitSelectedReturnType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(0, 0, 0, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      appBar:  AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).brightness ==
              Brightness.dark?Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(255, 255, 255,1),
          title: Text(
            "Order Return",style: GoogleFonts.gothicA1(
              color:Theme.of(context).brightness ==
                  Brightness.dark?Color.fromRGBO(255,255,255,1):Color.fromRGBO(18, 18, 18,1) ,
              fontSize: 18,
              fontWeight: FontWeight.w800
          ),
          )),
      body:BlocListener<OrderShipmentReturnBloc,OrderShipmentReturnState>(
        listener:(context,state){
          if(state is OrderShipmentReturnSuccess){
            // Navigator.of(context).pop();
            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute
            //   (builder: (c){
            //     return  MultiBlocProvider(
            //       providers: [
            //         BlocProvider(create: (BuildContext context) {
            //           return OrdersBloc(RealOrdersRepo())
            //             ..add(const GetOrders());
            //         }),
            //         BlocProvider(create: (BuildContext context) {
            //           return OrderShipmentCancelBloc(orderShipmentCancelRepo: RealOrderShipmentCancelRepo());
            //         })
            //       ],
            //       child:  MyOrders(navigateToNext: widget.navigateToNext!),
            //     );
            // }), (route) => false);
            // widget.navigateToNext!(
            //     MultiBlocProvider(
            //       providers: [
            //         BlocProvider(create: (BuildContext context) {
            //           return OrdersBloc(RealOrdersRepo())
            //             ..add(const GetOrders());
            //         }),
            //         BlocProvider(create: (BuildContext context) {
            //           return OrderShipmentCancelBloc(orderShipmentCancelRepo: RealOrderShipmentCancelRepo());
            //         })
            //       ],
            //       child:  MyOrders(navigateToNext: widget.navigateToNext!),
            //     ));
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c){
              return BlocProvider(
                  create: (context) =>
                      ShipmentTrackBloc(RealShipmentTrackRepo()),
                  child: ViewOrderPage(
                    ordersData: widget.ordersData,
                    navigateToNext: widget.navigateToNext,
                  )
              );
            }));

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c){
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (BuildContext context) {
                    return OrdersBloc(RealOrdersRepo())
                      ..add(const GetOrders());
                  }),
                  BlocProvider(create: (BuildContext context) {
                    return OrderShipmentCancelBloc(orderShipmentCancelRepo: RealOrderShipmentCancelRepo());
                  })
                ],
                child:  MyOrders(navigateToNext: widget.navigateToNext!),
              );
            }));
            AppConstants.showMessage(context,state.response.message!, Colors.green);
          }else if(state is OrderShipmentReturnFailure){
            AppConstants.showMessage(context, state.error, Colors.red);
          }
        } ,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text("Reason for Return",style: GoogleFonts.gothicA1(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),),
                SizedBox(height: 5,),
                DropdownButtonHideUnderline(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.06,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(240, 240, 240, 1),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        hint: Text('Select a reason', style: GoogleFonts.gothicA1(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),),
                        value: _selectedReason,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedReason = newValue;
                          });
                        },
                        items: returnReasons.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: GoogleFonts.gothicA1(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Text("Comment",style: GoogleFonts.gothicA1(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),),
                SizedBox(height: 5),
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    autofocus: false,
                    style: GoogleFonts.gothicA1(),
                    maxLines: null,
                    cursorColor: Color.fromRGBO(255, 76, 59, 1),
                    controller: commentController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Color.fromRGBO(29, 29, 29, 1)
                          : Color.fromRGBO(240, 240, 240, 1),
                      filled: true,
                      // border: InputBorder.none,
                      hintText: "Add comment here",
                      hintStyle: GoogleFonts.gothicA1(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),

                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Text("Upload Image",style: GoogleFonts.gothicA1(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),),
                SizedBox(height: 5),
                UploadImageWidget(),
                SizedBox(height: 15,),
                Text("Return Type",style: GoogleFonts.gothicA1(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),),
                SizedBox(height: 5),
                ReturnType(),
                Visibility(
                    visible: onReturnTypeSelected==1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("UPI Id",style: GoogleFonts.gothicA1(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),),
                        SizedBox(height: 5),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(240, 240, 240, 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            autofocus: false,
                            style: GoogleFonts.gothicA1(),
                            cursorColor: Color.fromRGBO(255, 76, 59, 1),
                            controller: upiIdController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(29, 29, 29, 1)
                                  : Color.fromRGBO(240, 240, 240, 1),
                              filled: true,
                              // border: InputBorder.none,
                              hintText: "Enter Id here",
                              hintStyle: GoogleFonts.gothicA1(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),

                            ),
                          ),
                        ),

                      ],
                    )),
                SizedBox(height: 15,),
                Container(
                    width: double.maxFinite,
                    height: 45.0,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).brightness==Brightness.dark?Color.fromRGBO(0, 0, 0, 1):Color.fromRGBO(255, 255, 255, 1) ,
                            ),
                            side: const MaterialStatePropertyAll(
                                BorderSide(color: Color.fromRGBO(255, 76, 59, 1))
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                        onPressed: () {
                            BlocProvider.of<OrderShipmentReturnBloc>(context).add(OrderShipmentReturnRequested(
                                orderStatus: "Return",
                                orderReturnReason: _selectedReason!,
                                orderReturnComment: commentController.text,
                                returnAmount:selectedReturnType!,
                                returnImages: _selectedImages!,
                                upiId: upiIdController.text, orderId: widget.ordersData!.orderId!, waybillNumber: widget.ordersData!.waybill!));

                          // Navigator.of(context).push(MaterialPageRoute(builder:(c)=>ThankYouScreen()));
                        },
                        child:  Text("Confirm Return",style: GoogleFonts.gothicA1(
                            color: Color.fromRGBO(255, 76, 59, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                        ),))
                ),

              ],
            ),
          ),
        ),
      )

    );



  }


  Widget UploadImageWidget() {


    Future<void> _pickImages() async {

      List<Asset> resultList = [];

        Future<File> assetToFile(Asset asset) async {
          final ByteData byteData = await asset.getByteData();
          final List<int> imageData = byteData.buffer.asUint8List();
          final String tempFileName = '${DateTime.now().millisecondsSinceEpoch}.png';
          final tempFilePath = '${(await getTemporaryDirectory()).path}/$tempFileName';
          await File(tempFilePath).writeAsBytes(imageData);
          return File(tempFilePath);
        }

      try {
        resultList = await MultiImagePicker.pickImages(
            androidOptions: AndroidOptions(
                hasCameraInPickerPage: true,
                maxImages: 4
            )
          // maxImages: 4,
          // enableCamera: true,
        );
      } on Exception catch (e) {
        print('Error picking images: $e');
        return;
      }

      if (!mounted) return;

      // Convert Asset to XFile asynchronously
      List<File> files = [];

      for (Asset asset in resultList) {
        File file = await assetToFile(asset);
        files.add(file);
      }

      setState(() {
        _selectedImages = files;
        print(_selectedImages);
      });
    }

    return Column(
      children: [
        _selectedImages != null && _selectedImages!.isNotEmpty
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                color: Color.fromRGBO(240, 240, 240, 1),
                borderRadius: BorderRadius.circular(10)
              ),
              child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: _selectedImages!.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.file(
                  File(_selectedImages![index].path),
                  fit: BoxFit.fill,
                ),
              );
            },
          ),
        )
            : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
                color: Color.fromRGBO(240, 240, 240, 1),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: InkWell(
                onTap: (){
                  _pickImages();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.28,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(255, 76, 59,1),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color.fromRGBO(255, 76, 59,1), )
                  ),
                  child: Center(
                    child: Text("Add images",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gothicA1(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color:Color.fromRGBO(255, 76, 59,1),
                      ),),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget ReturnType(){
    return  Container(
      width: MediaQuery.of(context).size.width*0.95,
      height: MediaQuery.of(context).size.height*0.15,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:returnType.length,
          itemBuilder: (context,index){
              return Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        onReturnTypeSelected=index;
                        selectedReturnType=getSelectedReturnTypeName();

                        print(selectedReturnType);
                      });
                    },
                    child:
                    Row(
                      children: [
                        Container(
                            width:40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:Theme.of(context).brightness==Brightness.dark?
                              Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                            ),
                            child: Image.asset("assets/images/Icon  payment checkout.png",width: 24,height: 24,)),
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(top:15.0),
                            child: Text(returnType[index].toUpperCase(),
                              textAlign:TextAlign.left,
                              style: GoogleFonts.gothicA1(
                                  color: Theme.of(context).brightness==Brightness.dark?
                                  Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                              ),),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                        onReturnTypeSelected==index?
                        Icon(Icons.radio_button_on,color:Theme.of(context).brightness==Brightness.dark?
                        Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1) ,size: 24,):
                        Icon(Icons.radio_button_off,color: Theme.of(context).brightness==Brightness.dark?
                        Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(0, 0, 0, 1),size: 24,),
                      ],
                    ),
                  ),
                ],
              );

          }),
    );
  }

  String getSelectedReturnTypeName() {
    if (onReturnTypeSelected >= 0 && onReturnTypeSelected < returnType.length) {
      return returnType[onReturnTypeSelected];
    }
    return "No selection";
  }

}
