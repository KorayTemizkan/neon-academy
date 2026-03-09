/*
Barrel File (Varil Dosyası):
Bir klasörün içindeki birçok dosyayı tek bir dosya üzerinden dışarıya sunan bir dağıtım merkezidir.

Örneğin,

app.dart dosyasında

import 'package:flutter_counter/view/counter_page.dart';
import 'package:flutter_counter/view/counter_view.dart';

yazmak yerine

import 'package:flutter_counter/counter/counter.dart';

yazarak kod karmaşasını önlemiş olduk. Encapsulationmuş muş muş.
*/

export 'counter_page.dart';
export 'counter_view.dart';