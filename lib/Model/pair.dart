class Pair<T1, T2> {
  T1? first;
  T2? second;

  Pair(this.first, this.second);

  Pair.empty();

  static Pair<T1, T2> create<T1, T2>(T1 first, T2 second) {
    return Pair(first, second);
  }

  @override
  bool operator ==(Object other) {
    return (other as Pair).first == this.first &&
        (other as Pair).second == this.second;
  }

  @override
  int get hashCode {
    return first.hashCode;
  }
}
