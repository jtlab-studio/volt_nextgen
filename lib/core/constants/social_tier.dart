enum SocialTier {
  loneWolf,
  clan,
  tribe,
  chiefdom,
  state,
  nation,
}

extension SocialTierExtension on SocialTier {
  String get displayName {
    switch (this) {
      case SocialTier.loneWolf:
        return 'Lone Wolf';
      case SocialTier.clan:
        return 'Clan';
      case SocialTier.tribe:
        return 'Tribe';
      case SocialTier.chiefdom:
        return 'Chiefdom';
      case SocialTier.state:
        return 'State';
      case SocialTier.nation:
        return 'Nation';
    }
  }

  String get description {
    switch (this) {
      case SocialTier.loneWolf:
        return 'Solo runner with basic features.';
      case SocialTier.clan:
        return 'Small group of 2-5 runners.';
      case SocialTier.tribe:
        return 'Medium group of 6-20 runners.';
      case SocialTier.chiefdom:
        return 'Large group of 21-50 runners.';
      case SocialTier.state:
        return 'Major group of 51-200 runners.';
      case SocialTier.nation:
        return 'Elite group of 201+ runners.';
    }
  }
}
