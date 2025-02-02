import 'package:adjemin_gateway_sdk/src/models/customer.dart';
import 'package:flutter/material.dart';

import 'custom_progress_widget.dart';

class CustomerFormWidget extends StatefulWidget {
  final Customer? customer;
  const CustomerFormWidget({super.key, this.customer});

  @override
  _CustomerFormWidgetState createState() => _CustomerFormWidgetState();
}

class _CustomerFormWidgetState extends State<CustomerFormWidget> {
  bool _isLoading = false;
  bool _isNewNumberOpen = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  final String _currentDialCode = "225";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Choisissez le numéro à utiliser",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: _isLoading ? const CustomProgressWidget() : _buildBody(),
    );
  }

  showProgress() {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  hideProgress() {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          widget.customer != null && widget.customer!.phoneNumber != null
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(widget.customer);
                  },
                  child: _buildCustomerItemUi(widget.customer!),
                )
              : Container(),
          GestureDetector(
            onTap: () {
              if (mounted) {
                setState(() {
                  _isNewNumberOpen = !_isNewNumberOpen;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 14, bottom: 14, right: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 40,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                "Utiliser un autre numéro de téléphone",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(_isNewNumberOpen
                              ? Icons.arrow_drop_down_circle_outlined
                              : Icons.arrow_forward_ios_outlined),
                        ],
                      ),
                      Offstage(
                        offstage: !_isNewNumberOpen,
                        child: _buildForm(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerItemUi(Customer customer) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    customer.photoUrl != null && customer.photoUrl!.isNotEmpty
                        ? customer.photoUrl!
                        : "https://i.imgur.com/vQBp4EF.png"),
                radius: 30.0,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Utiliser mon numéro",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${customer.phoneNumber}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey[500]),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  child: Text("+$_currentDialCode"),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: _phoneNumberController,
                    decoration:
                        const InputDecoration(hintText: "Numéro de téléphone"),
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_phoneNumberController.text.isNotEmpty) {
                  if (widget.customer != null) {
                    Navigator.of(context).pop(Customer(
                        photoUrl: widget.customer!.photoUrl,
                        firstName: widget.customer!.firstName,
                        lastName: widget.customer!.lastName,
                        dialCode: _currentDialCode,
                        phoneNumber: _phoneNumberController.text.trim(),
                        email: widget.customer!.email));
                  }
                }
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                  textStyle: WidgetStateProperty.all(Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white, fontSize: 19))),
              child: const Text(
                "Suivant",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
