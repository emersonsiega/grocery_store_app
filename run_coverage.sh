flutter test --coverage

lcov --remove coverage/lcov.info 'lib/**.g.dart' 'lib/**.gr.dart' 'lib/main/*' 'lib/infra/logger/**' 'lib/view/settings/**' -o coverage/lcov.info

genhtml coverage/lcov.info -o coverage/html

open coverage/html/index.html