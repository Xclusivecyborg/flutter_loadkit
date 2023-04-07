
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
## 🪄 What to Expect in the package
<table>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_360.gif" width="250px" height="250px">
      <br />
      360
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_filled_circle.gif" width="250px" height="250px">
      <br />
      FilledCircle
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_folding_squares.gif" width="250px" height="250px">
      <br />
      FoldingSquares
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_line_chase.gif" width="250px" height="250px">
      <br />
      LineChase
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_pulse_lines.gif" width="250px" height="250px">
      <br />
      PulseLines
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_rotating_lines.gif" width="250px" height="250px">
      <br />
      RotatingLines
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_rotation_arcs.gif" width="250px" height="250px">
      <br />
      RotationArcs
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_scaling_wave.gif" width="250px" height="250px">
      <br />
      ScalingWave
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_spinning_arcs.gif" width="250px" height="250px">
      <br />
      SpinningArcs
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Xclusivecyborg/flutter_loadkit/main/images/loadkit_water_droplet.gif" width="250px" height="250px">
      <br />
      WaterDroplet
    </td>
  </tr>
</table> 


## BUGS/CONTRIBUTIONS/REQUESTS
If you encounter any problems using this package, please feel free to open an [issue](https://github.com/Xclusivecyborg/flutter_loadkit/issues/new?template=bug_report.md).
If you'd like to contribute to this package, kindly open a pull request [here](https://github.com/Xclusivecyborg/flutter_loadkit)
 
## 👷🏽 Contributors
<table>
  <tr>
    <td align="center">
      <a href = "https://github.com/xclusivecyborg"><img src="https://avatars.githubusercontent.com/u/80969540?s=400&u=cedc45223f44384711b53d38f9427e0e9a911ba2&v=4" width="72" alt="Ayodeji Ogundairo" /></a>
      <p align="center">
        <a href = "https://github.com/xclusivecyborg"><img src = "https://www.iconninja.com/files/241/825/211/round-collaboration-social-github-code-circle-network-icon.svg" width="18" height = "18"/></a>
        <a href = "https://twitter.com/xclusivecyborg"><img src = "https://www.shareicon.net/download/2016/07/06/107115_media.svg" width="18" height="18"/></a>
        <a href = "https://www.linkedin.com/in/ayodeji-ogundairo-a5b4a6201/"><img src = "https://www.iconninja.com/files/863/607/751/network-linkedin-social-connection-circular-circle-media-icon.svg" width="18" height="18"/></a>
      </p>
    </td>
  </tr> 
</table>