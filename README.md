
# 🧩 LoadKit
A package that contains loading indicators built with flutter. Package is inspired by [@jogbom](https://github.com/jogboms)'s [Flutter_SpinKit](https://github.com/jogboms/flutter_spinkit).

# 💻  Getting started

Add the load_kit dependency to your pubspec.yaml file like this:
```yaml
dependencies:
  flutter_load_kit: 0.0.1
```

# Import
Import the flutter load_kit package like so:
```dart
import 'package:flutter_load_kit/flutter_load_kit.dart';
```

## Usage
```dart
import 'package:flutter/material.dart';
import 'package:flutter_load_kit/flutter_load_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loadkit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: LoadKitLineChase(
              itemCount: 7,
            ),
          ),
        ),
      ),
    );
  }
}
```

#🪄 What to Expect in the package
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_360.gif" width="120px" height="120px">
      <br />
      360
    </td>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_filled_circle.gif" width="120px" height="120px">
      <br />
      FilledCircle
    </td>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_folding_squares.gif" width="120px" height="120px">
      <br />
      FoldingSquares
    </td>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_line_chase.gif" width="120px" height="120px">
      <br />
      LineChase
    </td>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_pulse_lines.gif" width="120px" height="120px">
      <br />
      PulseLines
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_rotating_lines.gif" width="120px" height="120px">
      <br />
      RotatingLines
    </td>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_rotation_arcs.gif" width="120px" height="120px">
      <br />
      RotationArcs
    </td>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_scaling_wave.gif" width="120px" height="120px">
      <br />
      ScalingWave
    </td>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_spinning_arcs.gif" width="120px" height="120px">
      <br />
      SpinningArcs
    </td>
    <td align="center">
      <img src="https://github.com/Xclusivecyborg/flutter_loadkit/blob/main/images/loadkit_water_droplet.gif" width="120px" height="120px">
      <br />
      WaterDroplet
    </td>
  </tr>
</table> 


## Additional information
TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
 
