class Foo {
  Foo(this.id, this.title, this.subtitle);

  final int id;
  final String title;
  final String subtitle;

  static List<Foo> generate() {
    return List.generate(
      20,
      (index) => Foo(index, 'Title ${index + 1}', 'Subtitle ${index + 1}'),
    );
  }
}
