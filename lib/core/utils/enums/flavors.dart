enum Flavor {
  preview('preview'),
  hed('hed'),
  hsvp('hsvp'),
  hmv('hmv'),
  mphu('mphu');

  final String name;
  String get nameUpper => name.toUpperCase();
  const Flavor(this.name);
}