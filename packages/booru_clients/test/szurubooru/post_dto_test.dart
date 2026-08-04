import 'package:booru_clients/szurubooru.dart';
import 'package:test/test.dart';

void main() {
  group('PostDto.fromJson', () {
    test('joins relative image paths when base URL has no trailing slash', () {
      final post = PostDto.fromJson(
        {
          'contentUrl': 'data/posts/1.jpg',
          'thumbnailUrl': 'data/generated-thumbnails/1.jpg',
        },
        baseUrl: 'https://booru.home.local',
      );

      expect(post.contentUrl, 'https://booru.home.local/data/posts/1.jpg');
      expect(
        post.thumbnailUrl,
        'https://booru.home.local/data/generated-thumbnails/1.jpg',
      );
    });

    test('does not duplicate slashes when joining image paths', () {
      final post = PostDto.fromJson(
        {
          'contentUrl': '/data/posts/1.jpg',
          'thumbnailUrl': '/data/generated-thumbnails/1.jpg',
        },
        baseUrl: 'https://booru.home.local/',
      );

      expect(post.contentUrl, 'https://booru.home.local/data/posts/1.jpg');
      expect(
        post.thumbnailUrl,
        'https://booru.home.local/data/generated-thumbnails/1.jpg',
      );
    });

    test('preserves absolute image URLs', () {
      final post = PostDto.fromJson(
        {
          'contentUrl': 'https://cdn.example.com/posts/1.jpg',
          'thumbnailUrl': '//cdn.example.com/thumbnails/1.jpg',
        },
        baseUrl: 'https://booru.home.local',
      );

      expect(post.contentUrl, 'https://cdn.example.com/posts/1.jpg');
      expect(post.thumbnailUrl, '//cdn.example.com/thumbnails/1.jpg');
    });
  });

  group('MicroPostDto.fromJson', () {
    test(
      'joins relative thumbnail path when base URL has no trailing slash',
      () {
        final post = MicroPostDto.fromJson(
          {'thumbnailUrl': 'data/generated-thumbnails/1.jpg'},
          baseUrl: 'https://booru.home.local',
        );

        expect(
          post.thumbnailUrl,
          'https://booru.home.local/data/generated-thumbnails/1.jpg',
        );
      },
    );
  });
}
