
class Post {
  String title;
  String body;
  bool isLiked = false;
  int likes = 0;

  Post(this.body, this.title);

  void likePost() {
    this.isLiked = !this.isLiked;
    if (this.isLiked) {
      this.likes++;
    } else {
      this.likes--;
    }
  }
}
