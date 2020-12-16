#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>

using namespace std;

vector<int> input;
const int LAST = 30000000;

int main() {
  input.push_back(0);
  input.push_back(13);
  input.push_back(1);
  input.push_back(16);
  input.push_back(6);
  input.push_back(17);

  for (int ix = 0; ix < input.size(); ++ix) {
    cout << (ix + 1) << ": " << input[ix] << "\n";
  }

  int next_to_print = 0;
  for (int ix = input.size(); ix < LAST; ++ix) {
    int last = input[input.size() - 1];
    auto found = find(input.rbegin() + 1, input.rend(), last);
    input.push_back(found != input.rend() ? distance(input.rbegin(), found) : 0);
    if (ix > next_to_print) {
      cout << (ix + 1) << ": " << input[ix] << "\n";
      next_to_print = ix * 11 / 10;
    }
  }
  cout << "\n" << LAST << ": " << input[input.size() - 1] << "\n";

  return 0;
}
