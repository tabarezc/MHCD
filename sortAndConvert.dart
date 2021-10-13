import 'dart:math';

void main() {
  var random = new Random();

//Generates a list of 100 random integers between 1 and 26
  List<int> list = new List.generate(100, (index) => random.nextInt(26) + 1);

  List<String>? charList = convertArray(list);

  print(charList);
}

//Uses an integer list as a parameter. The list is then sorted and converted
//to their respective ASCII characters.
List<String>? convertArray(List<int> list) {
  //If the list is empty an empty list is returned
  if (list.isEmpty) return [];

  //If the list is null, then null is returned
  if (list == null) return null;

  //If the list is larger than 1, then the list is sorted
  if (list.length > 1) list.sort();

  //If the integer exceeds 27 then null is returned
  if (list[list.length - 1] == 27) {
    return null;
  }

  List<String> stringList = [];

//This loop iterates through every number in the integer list, converts
//it to an ASCII character and stores it in a string list
  for (int item in list) {
    stringList.add(String.fromCharCode(item + 64));
  }

  return stringList;
}
