import 'package:flutter/material.dart';
import 'package:socio_sphere/screens/add_post_screen.dart';
import 'package:socio_sphere/screens/feed_screen.dart';

const webScreenSize=600;

const homeScreenItems = [
          FeedScreen(),
          Text('search'),
          AddPostScreen(),
          Text('notify'),
          Text('profile')
        ];