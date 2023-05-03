import 'package:flutter/material.dart';

class EnvironmentMaintenancePage extends StatefulWidget {
  const EnvironmentMaintenancePage({Key? key}) : super(key: key);

  @override
  State<EnvironmentMaintenancePage> createState() =>
      _EnvironmentMaintenancePageState();
}

class _EnvironmentMaintenancePageState
    extends State<EnvironmentMaintenancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: ClipRRect(
                    child: Image.asset('assets/images/maintenanceImage.png'))),
            const Spacer(),
            Expanded(
              flex: 1,
              child: Text(
                'UNDER\nMAINTENANCE',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 40),
              ),
            )
          ],
        ),
      ),
    );
  }
}
