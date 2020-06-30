

import 'dart:isolate';

main() {

  print('start');
  Isolate.spawn(demo1,{
    'name': 'Mashood',
    'email': 'mashood@gmail.com'
  });
  Isolate.spawn(demo1,{
    'name': 'Saad',
    'email': 'Saad@gmail.com'
  });
  Isolate.spawn(demo1,{
    'name': 'Saad',
    'email': 'Saad@gmail.com'
  });
  Isolate.spawn(demo1,{
    'name': 'Mashood',
    'email': 'mashood@gmail.com'
  });

  print('end');
}

demo1(Map<String,String> map){
  print('Hello ${map['name']}');
}

