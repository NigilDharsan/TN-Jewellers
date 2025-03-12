enum Environment { DEV, UAT, PROD }

class Config {
  static Map<dynamic, dynamic> _config = _Config.debugConstants;

  static const double appVersion = 1.0;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.UAT:
        _config = _Config.stagingConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get environment {
    return _config[_Config.environment];
  }

  static get baseUrl {
    return _config[_Config.baseUrl];
  }

  static get scopes {
    return _config[_Config.scopes];
  }
}

class _Config {
  static const String environment = 'dev';
  static const String baseUrl = 'https://pos.ind.in/hello_taxi/v1/';

  static const List<String> scopes = <String>[
    'openid',
    'email',
    'byufuel-api',
    'profile',
    'offline_access'
  ];

  static Map<dynamic, dynamic> debugConstants = {
    environment: "dev",
    baseUrl: 'https://pos.ind.in/hello_taxi/v1/',
    scopes: <String>[
      'openid',
      'email',
      'byufuel-api',
      'profile',
      'offline_access'
    ]
  };

  static Map<dynamic, dynamic> stagingConstants = {
    environment: "uat",
    baseUrl: 'https://pos.ind.in/hello_taxi/v1/',
    scopes: <String>[
      'openid',
      'email',
      'byufuel-api',
      'profile',
      'offline_access'
    ]
  };

  static Map<dynamic, dynamic> prodConstants = {
    environment: "prod",
    baseUrl: 'https://pos.ind.in/hello_taxi/v1/',
    scopes: <String>[
      'openid',
      'email',
      'byufuel-api',
      'profile',
      'offline_access'
    ]
  };
}
