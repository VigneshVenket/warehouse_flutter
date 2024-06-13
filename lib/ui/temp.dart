import 'package:flutter/material.dart';

import '../tweaks/app_localization.dart';

class TEmp extends StatelessWidget {
  const TEmp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                        Text(
                          AppLocalizations.of(context)!.translate('Account')!,
                        ),
                        IconButton(
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset('assets/102.png',
                                fit: BoxFit.fill, height: 50, width: 50),
                          ),
                          const SizedBox(width: 15),
                          Text(
                              AppLocalizations.of(context)!.translate('George Floyd')!,
                              style:
                                  const TextStyle(fontSize: 15, color: Colors.white)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                AppLocalizations.of(context)!.translate("Rewards")!,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Rs0.00",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                AppLocalizations.of(context)!.translate("Wallet")!,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                AppLocalizations.of(context)!.translate("Points")!,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black,
                      ),
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.translate('Membership benefits')!,
                                      style: const TextStyle(
                                          color: Colors.yellow, fontSize: 8),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.yellow,
                                      size: 10,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.translate('New Member Gift')!,
                                        style: const TextStyle(
                                            color: Colors.yellow, fontSize: 12),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.translate('Birthday Gift Item')!,
                                        style: const TextStyle(
                                            color: Colors.yellow, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.translate('5% OFF')!,
                                        style: const TextStyle(
                                            color: Colors.yellow, fontSize: 12),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.translate('5% OFF')!,
                                        style: const TextStyle(
                                            color: Colors.yellow, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.yellow.shade200),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.translate('Check In')!,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        AppLocalizations.of(context)!.translate('Claim your 20 points')!,
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  ClipOval(
                                    child: Image.asset('assets/102.png',
                                        fit: BoxFit.fill,
                                        height: 50,
                                        width: 50),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue.shade200),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.translate('Share')!,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        AppLocalizations.of(context)!.translate('Up to 1000 Wallet')!,
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 5),
                                  ClipOval(
                                    child: Image.asset('assets/102.png',
                                        fit: BoxFit.fill,
                                        height: 50,
                                        width: 50),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.translate("My Orders")!,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.translate("View All")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      size: 8,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 1),
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.pages_rounded,
                                    size: 30,
                                    color: Colors.grey.shade800,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate('In Progress')!,
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    size: 30,
                                    color: Colors.grey.shade800,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate('Delivered')!,
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.message,
                                    size: 30,
                                    color: Colors.grey.shade800,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate('Reviews')!,
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: Text(
                                      AppLocalizations.of(context)!.translate('Help and info')!
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Icon(Icons.map),
                                          Text(
                                              AppLocalizations.of(context)!.translate('Address')!
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Icon(Icons.account_circle_outlined),
                                          Text(
                                              AppLocalizations.of(context)!.translate('Profile')!
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Icon(Icons.message),
                                          Text(AppLocalizations.of(context)!.translate('Profile')!),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Icon(Icons.help_outline),
                                          Text(AppLocalizations.of(context)!.translate('Help Center')!),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Icon(Icons.delivery_dining),
                                      Text(AppLocalizations.of(context)!.translate('Feedback')!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
