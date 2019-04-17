CASE
  WHEN `ftd_v1` LIKE '%cpc%' AND `ftd_v2` LIKE '%a3%' THEN 'Search-Branded'
  WHEN `ftd_v1` LIKE '%cpc%' AND `ftd_v2` LIKE '%a1%' AND `ftd_v2` LIKE '%dynamic%' THEN 'Search-Dynamic'
  WHEN `ftd_v1` LIKE '%cpc%' AND `ftd_v2` LIKE '%a1%' AND `ftd_v2` LIKE '%remarketing%' THEN 'Remarketing'
  WHEN `ftd_v1` LIKE '%display%'
      OR `ftd_v1` LIKE '%cpc%' AND `ftd_v2` LIKE '%a1%' AND `ftd_v2` LIKE '%display%' THEN 'Search-Display'
  WHEN `ftd_v1` LIKE '%cpc%' AND `ftd_v2` LIKE '%a1%'
      OR `ftd_v1` LIKE '%cpc%' THEN 'Search-Non Branded'
  WHEN `ftd_v1` LIKE '%affiliate%' THEN 'Affiliate'
  WHEN `ftd_v1` LIKE '%user-site%' THEN 'User Site'
  WHEN `ftd_v1` LIKE '%referral%' THEN 'Referral'
  WHEN `ftd_v1` LIKE '%partner%'
      OR `ftd_v1` LIKE '%announcement%' THEN 'Partner'
  WHEN `ftd_v1` LIKE '%email%' THEN 'Email'
  WHEN `ftd_v1` LIKE '%social%' THEN 'Social'
  WHEN `ftd_v1` LIKE '%social%' AND `ftd_v2` LIKE 'paid%'
      OR `ftd_v1` LIKE '%feed%' THEN 'Social-Paid'
  WHEN `referrer_domain` IS NULL  AND `ftd_v1` IS NULL  AND `ftd_v2` IS NULL  THEN 'Direct'
  WHEN `referrer_domain` IN('bing.com',
  'duckduckgo.com',
  'google.co.th',
  'google.co.ve',
  'google.co.za',
  'google.com',
  'google.com.sg',
  'google.com.sv',
  'google.com.tr',
  'google.com.tw',
  'google.com.ua',
  'google.lu',
  'google.co.uk',
  'google.lt',
  'google.se',
  'google.tt',
  'google.lk',
  'google.sk',
  'google.com.vn',
  'google.si',
  'google.tn',
  'google.lv',
  'google.bj',
  'google.ch',
  'google.com.br',
  'google.cz',
  'google.de',
  'google.dk',
  'google.fi',
  'google.fr',
  'google.com.do',
  'google.be',
  'google.cm',
  'google.bg',
  'google.com.co',
  'google.bs',
  'google.cl',
  'google.ge',
  'google.ae',
  'google.as',
  'google.by',
  'google.ca',
  'google.co',
  'google.com.au',
  'google.com.kh',
  'google.es',
  'google.com.ar',
  'com.google.android.googlequicksearchbox',
  'com.google.android.googlequicksearchbox/https/www.google.com',
  'google.at',
  'google.com.bz',
  'google.mr',
  'google.com.eg',
  'google.az',
  'google.com.af',
  'google.ba',
  'google.com.ec',
  'google.ee',
  'google.co.id',
  'google.co.il',
  'google.co.jp',
  'google.co.nz',
  'google.com.gh',
  'google.com.hk',
  'google.com.mx',
  'google.com.my',
  'google.com.na',
  'google.com.ng',
  'google.com.ph',
  'google.com.pr',
  'google.com.sa',
  'google.ie',
  'google.nl',
  'google.pl',
  'google.pt',
  'google.ro',
  'google.ru',
  'google.hu',
  'google.com.pe',
  'google.com.jm',
  'google.it',
  'google.co.in',
  'google.rs',
  'google.no',
  'google.co.kr',
  'google.com.pk',
  'google.is',
  'google.hr',
  'google.com.mt',
  'google.gr',
  'google.com.lb',
  'google.iq',
  'google.gp',
  'google.mn',
  'google.ac',
  'google.ad',
  'google.com.ag',
  'google.com.ai',
  'google.al',
  'google.am',
  'google.co.ao',
  'google.com.bd',
  'google.bf',
  'google.com.bh',
  'google.bi',
  'google.com.bn',
  'google.com.bo',
  'google.bt',
  'google.co.bw',
  'google.cc',
  'google.cd',
  'google.cf',
  'google.cat',
  'google.cg',
  'google.ci',
  'google.co.ck',
  'google.cn',
  'google.co.cr',
  'google.com.cu',
  'google.cv',
  'google.com.cy',
  'google.dj',
  'google.dm',
  'google.dz',
  'google.com.et',
  'google.com.fj',
  'google.fm',
  'google.ga',
  'google.gf',
  'google.gg',
  'google.com.gi',
  'google.gl',
  'google.gm',
  'google.com.gt',
  'google.gy',
  'google.hn',
  'google.ht',
  'google.im',
  'google.io',
  'google.je',
  'google.jo',
  'google.co.ke',
  'google.ki',
  'google.kg',
  'google.com.kw',
  'google.kz',
  'google.la',
  'google.com.lc',
  'google.li',
  'google.co.ls',
  'google.com.ly',
  'google.co.ma',
  'google.md',
  'google.me',
  'google.mg',
  'google.mk',
  'google.ml',
  'google.com.mm',
  'google.ms',
  'google.mu',
  'google.mv',
  'google.mw',
  'google.co.mz',
  'google.ne',
  'google.com.nf',
  'google.com.ni',
  'google.com.np',
  'google.nr',
  'google.nu',
  'google.com.om',
  'google.com.pa',
  'google.com.pg',
  'google.pn',
  'google.ps',
  'google.com.py',
  'google.com.qa',
  'google.rw',
  'google.com.sb',
  'google.sc',
  'google.sh',
  'google.com.sl',
  'google.sn',
  'google.sm',
  'google.so',
  'google.st',
  'google.sr',
  'google.td',
  'google.tg',
  'google.com.tj',
  'google.tk',
  'google.tl',
  'google.tm',
  'google.to',
  'google.co.tz',
  'google.co.ug',
  'google.com.uy',
  'google.co.uz',
  'google.com.vc',
  'google.vg',
  'google.co.vi',
  'google.vu',
  'google.ws',
  'google.co.zm',
  'google.co.zw',
  'uk.search.yahoo.com',
  'search.yahoo.co.jp',
  'us.search.yahoo.com',
  'r.search.yahoo.com',
  'search.yahoo.com',
  'yandex.ru',
  'yandex.com') THEN 'Organic Search'
	WHEN `referrer_domain` IN('facebook.com','m.facebook.com',
'lm.facebook.com',
'l.facebook.com',
'instagram.com',
'l.instagram.com',
'linkedin.com',
'linkedin.android',
'pinterest.com',
'pinterest.ca',
'pinterest.com.au',
'pinterest.com.mx',
'pinterest.de',
'pinterest.es',
'pinterest.fr',
'pinterest.jp',
'pinterest.nz',
'pinterest.co.kr',
'pinterest.co.uk',
'reddit.com',
't.co',
'youtube.com') THEN 'Organic Social'
	ELSE 'Undefined' END