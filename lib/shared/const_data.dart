import 'package:vair_app/models/Banner.dart';
import 'package:vair_app/models/Product.dart';

List<Product> exampleProducts = [
  Product(
      id: 1,
      logo: Banner(
          id: 1,
          url:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Facebook_Logo_2023.png/600px-Facebook_Logo_2023.png'),
      banners: [
        Banner(
            id: 1,
            url: 'https://pfps.gg/assets/banners/2441-aesthetic-waves.gif')
      ],
      name: 'Facebook',
      description:
          "Facebook is a website which allows users, who sign-up for free profiles, to connect with friends, work colleagues or people they don't know, online.",
      price: 0),
  Product(
      id: 2,
      logo: Banner(
          id: 2,
          url:
              'https://static-00.iconduck.com/assets.00/discord-icon-2048x2048-nnt62s2u.png'),
      banners: [
        Banner(
            id: 2,
            url:
                'https://static-prod.adweek.com/wp-content/uploads/2022/12/Discord-Snowsgiving-2022-Hero-1280x680.png')
      ],
      name: 'Discord',
      description:
          "Discord is a voice, video, and text chat app that's used by tens of millions of people ages 13+ to talk and hang out with their communities and friends.",
      price: 0),
  Product(
      id: 3,
      logo: Banner(
          id: 3,
          url:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Signal-Logo.svg/600px-Signal-Logo.svg.png'),
      banners: [
        Banner(
            id: 3,
            url:
                'https://cdn.pixabay.com/photo/2020/03/06/21/08/illustration-4908159_1280.jpg')
      ],
      name: 'Signal',
      description:
          'Signal is an encrypted messaging service for instant messaging, voice, and video calls.',
      price: 1.99),
  Product(
      id: 4,
      logo: Banner(
          id: 4,
          url:
              'https://cdn.discordapp.com/attachments/854996766154817559/1169208694576259082/thorium-the-great-browser-v0-nh81ug88ns0a1.png'),
      banners: [
        Banner(
            id: 4,
            url:
                'https://img.freepik.com/premium-vector/flower-mountain-landscape-background_147887-336.jpg')
      ],
      name: 'Thorium Browser',
      description:
          'The fastest browser on Earth. Chromium fork for Linux, Windows, MacOS, Android, and Raspberry Pi named after radioactive element No. 90.',
      price: 1.99),
  Product(
      id: 5,
      logo: Banner(
          id: 5,
          url:
              'https://cdn.haitrieu.com/wp-content/uploads/2022/01/Logo-Zalo-Arc.png'),
      banners: [
        Banner(
            id: 5,
            url:
                'https://images.squarespace-cdn.com/content/v1/5d0b957a67bac40001fe4b33/1583297963085-ALODNP6B3ZXQVPBKH8GT/Discord+Banner.jpg')
      ],
      name: 'Zalo',
      description:
          'Zalo is a messaging application that provides fast, stable, convenient, and private connection for users anytime, anywhere.',
      price: 0),
];
