enum BodyType { drawerBody, bottomBody }
enum FilterEntry { free, paid }
enum FilterOnline { online, onSite }



enum FilterSortBy {
  nearToFar('near_to_far','Near to Far'),
  farToNear('far_to_near','Far to Near'),
  aToZ('a_to_z','A - Z'),
  zToA('z_to_a','Z - A');

  final String name;
  final String text;
  const FilterSortBy(this.name,this.text);
}

enum DeviceType { android, iphone }

enum NotifierState{loading,loaded,none}

enum Authentication { authenticated, unAuthenticated }
