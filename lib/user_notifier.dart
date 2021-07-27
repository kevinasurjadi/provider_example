Future<String> getUser() {
  return Future.delayed(
    Duration(seconds: 3),
    () => "Mohammad Afdal",
  );
}
