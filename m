Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCC5C7EE31
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b6gM4rj+xKTuWYkR/Cd+6nzsEyKLYlCWTzQDK4xSqmA=; b=DrhoYZXVTKIO5ujYxgywgps5wR
	Wq6wh5USibvsFcdJYj/UINIVxlRP89xMW2l8BcYiPsew5dP3r6N/TFRSBnvRxV8lOr6zb0g+Bn+vh
	ei8bDmiJyslQhRwK8IXWH1F2UISWhfGFQw4ocG3qk7N0VVLSkLeCkPuc2Dx1k9J3ex/IvasVdIWID
	22S/jNbhIVx2aT5VELzDnTbrV3MCarImJTlnfkWxlL5eVPOSXbdhWE4UsaZQwy6Ndfdy0K0mlmQCt
	Byw5fItD0C5tw4804qfGvq5NUOqzxO3D9J20/9jod/8ul3axPF8aGMO5jNETi51K4Ht7smvF18+RE
	h/oqF2AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV2rl-0000000DjTz-2tMv;
	Fri, 27 Jun 2025 06:47:17 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV2rj-0000000DjTZ-0Gjs
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 06:47:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751006836; x=1782542836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=b6gM4rj+xKTuWYkR/Cd+6nzsEyKLYlCWTzQDK4xSqmA=;
  b=gy4lD+InUvWum+rIRMcYHm/b1+5mnwslfuBRzQG1C2BhHx0K0wJnx3w4
   5YD0QaK3gXnqWvOulb7uIb2aXKI5KbfKzAa3MSED0b1OTWCU/BHAVhIep
   XJbNcRJoGA/OkqpH5ERgLQk9lQ/rOXF9R5+X9Shzs/pOeTsRyQdgi9P9K
   S+nUGBU8+rWz1K0xJx4DA9AJ9MbRJOyoU/BL5GfPGXiVsg0FGvNbZ7YM7
   oZilc+W2yGwtz7lor30e6RX2ScKJ2unJaDhoLCzxmSj3yDIXfcPa3a8Gl
   kaRDDuwUTIPMDjGpD3MydDdZRKSnHDwi9qwbVGZwjcPbri2bAx5uSnk2C
   A==;
X-CSE-ConnectionGUID: s79W8PxsQzS2044MrojGOg==
X-CSE-MsgGUID: /ySbN0zuRnaOU/MupOtmXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="75861498"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="75861498"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 23:47:15 -0700
X-CSE-ConnectionGUID: S6o5DfdBRMePGiDGcF1aGg==
X-CSE-MsgGUID: m+LrWGy2TqCLJWqQwkL7WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="156760628"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 23:47:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 23:47:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 23:47:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 23:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWenNIekxrPJdYLKePSR0zrG3iAjqhGmKl9yiEzl8+Gk6zGbSFzkw/yZL5wVD63d+Y7w4NxwrDadclhklWmDSyANUhR0dz3hfEotul4eoeESfdfk9LP0BtOAKSe2kWsw06OdIDENzhEvX/0nmVd52tTLcsSRdsl76B6D+rKuzS1YYAzYzSPMx/y7074DsQyLhchDZXmayCMOnPKlpmpUpQf6PV9dDR6UKKNF444tpkBP3LdBcFlJpu3YE0ShwAp/7gQLFB7TS1CUOqEeszul6IKdiZLdYhREIpNcW/PtcUWx/VqYyFThSHRicMQPRTW/aPqozUCSDBizZnB6RiBfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WpB74bffdIkYWvG9w8pZl++TzNX+LCLyXED9HEx32M=;
 b=BoetU5NMqWkXHsR8/jQen21IXAjjMiM29xik2W8F5vkPRQrAOkcrDXVJ3sB4CCvWKDTJO+VM21+3kB72FK+TEazPVWTbZqdRjlyifRMbHENiv4CEq8au9S3YFm6VOQHJjFfqUY6kz/K8wSnwzlvF7CeWFd/R+HsTaDNl52rBnOVB0ZF9iI7emXvI+TLX++3N3eCkkR5cNkhAuPY6d2PFTqtEBfsCHlk+AOdaCirxIygqkX3wjgtrkB8Ya5JZGce9tirxzF4lR24UWdM2Pm/BEtzEBifDSmrQpDYyI+WR1HdLEc4cEJDdWVIKPU92fzJheLnkUIPMiDWm1IuTzWDOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by CYXPR11MB8712.namprd11.prod.outlook.com (2603:10b6:930:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 06:46:57 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 06:46:57 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>
CC: "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Subject: Re: [RFC 1/2] tools/nolibc: add sigaction()
Thread-Topic: [RFC 1/2] tools/nolibc: add sigaction()
Thread-Index: AQHb5tTV4jFvFR2ezkyHlME5X0fZmrQWb+aAgAAg+oA=
Date: Fri, 27 Jun 2025 06:46:56 +0000
Message-ID: <f0c27ce58466d790551689b752a33fa0de6235b9.camel@intel.com>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
	 <20250626195714.2123694-2-benjamin@sipsolutions.net>
	 <20250627063347-cc3c0ad0-7b3b-4bcd-963f-729db103760f@linutronix.de>
In-Reply-To: <20250627063347-cc3c0ad0-7b3b-4bcd-963f-729db103760f@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|CYXPR11MB8712:EE_
x-ms-office365-filtering-correlation-id: 90d4fe3e-f937-4bc0-d9d1-08ddb5466920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDlLeUxuYUhmU1huSE1TU2FFU2ZmWDlTb3prOVZFRTRweVFPSWl4TTJtUm5a?=
 =?utf-8?B?YkdnYVRvUzE5dEZLQmRJVWZsMGxIcTdxMEZTMFJ3dlBib3dRUkdYSFFNenpN?=
 =?utf-8?B?ajFzcytJWGpobGM5U2dmaEVQTnRxc1lLZVFwZzFwZkRmOVlQMG0ybVo2amVw?=
 =?utf-8?B?S3lYckZlWTF6UC9DVnpvRExYUzg0Zm1tMlFuR2lxdzJ5a29TY005T2oyWUQv?=
 =?utf-8?B?elFtMmVKSk5EcjNQdERRbUo4V3lJUlBvNmU1MGJBbzZ0bzlEUi9nWVFjWlpi?=
 =?utf-8?B?bzB2dGpreVVtKzR4dGh4QmZQTjdNVStXSUJhaEhuV3AyUFc5TFp5N0tJdmNn?=
 =?utf-8?B?dGxEbVRMVzNlRHRuaGJVZ01sMy9mcHZqeStjSzJRTDRIK3l6MW9ZVkZxeVVy?=
 =?utf-8?B?cUkvQVBicnlhdFlReXJZNklkZjBTVi9jbDhrUzltakZGdVJUL0I2MDF5eUV3?=
 =?utf-8?B?cWZEVHpiZ1VaaFg0RzZ2L29LcFN0MVlBbUdrdGxxTDFodnd4MUx2ZEtQQmdM?=
 =?utf-8?B?Z1BibWRSaUw5NGoxRnlQTlhVMzh3QzZUZW1lUkFyc05UaGcvdVBMK3dDTGhR?=
 =?utf-8?B?ZW5oaWIvNXJzVnJrbmVZSENIVzBZU29LU1BJb1ppWnJzNGtLUGI4SlRDS0N1?=
 =?utf-8?B?cEZTUFpSSUY2UVJPbjNZT000ejhPL05NdWZxcmVMR293VVZ2RXVSNUU5d3M3?=
 =?utf-8?B?RlpFUzR5TUhobnAzYnVPRWNSY3M3Y1B6b2ZnZWE1cTlXbEFXN0NUdlgrWHlI?=
 =?utf-8?B?MGlTNFNuMjVhY3dNbzJaSEh2aEROU3RvWmZ6TFJheWhBaFYrSS94TElLRFRr?=
 =?utf-8?B?ZkpHRmZBd0VVUHFucFhRb05zbkVSQzdVK0o3eXNxMVFzemsxYkpROEpla0hF?=
 =?utf-8?B?Zkd0YWdrOWNmVnRpOWR4UVJsWlJKUmcydE0vNE82MEJNTmZTdW5JcFFSR0VC?=
 =?utf-8?B?MHdnY1dub1VpYmxqR29EQkcvbFAzdXFYRHg0V2pia1prTkFjcWQ0Ymc4ekpp?=
 =?utf-8?B?Kzd1SmlSZFFpM3RVU0NPMVdrcU1oL2ZHb2FnSlFUa1BJR2xWMmdIR0MyN3hq?=
 =?utf-8?B?SG5xcm5nZmJCbjcwazJaSnBKZlRYa3VzTlRzN0g0ZUl3REp5d29kZ1A3ZlNi?=
 =?utf-8?B?Y2ZWOHc4LzJQclViZ2FKYVFYSkgyT2FPT0pXdHZ5RlVkQkxncmM5U1RNbXh3?=
 =?utf-8?B?U1kwVTlUVjJ5eG9sNTh3ODFMV0hEYzdvZkw3TWRhcllqT0psT1g4ZjZQT1lp?=
 =?utf-8?B?SWxxNFpsYVZzQU9RRkJyUjV6MVZ0RWFJa0RyL1lRWTRnczdyWVVkaEtuK3Q2?=
 =?utf-8?B?Q1JBSE4wU2p5SG4zTkFLYWg0a3lTak5OQzVnZWd5Z3EwMVFLM1dzTFAxS1U4?=
 =?utf-8?B?ZHhMQXF6dlZIZkgxVEU1aEVXMnFUVVh2bHhUNDd0bVRYMmtFTDJldlVTaVF3?=
 =?utf-8?B?R2NCT2xmTDN0V081c2RsNHhxZ2habzhrM0QrZ0FGZk1ncmJaRlN2VkJuSTI2?=
 =?utf-8?B?ck5KdVp6QUs3RWdBalJML2RoZFlwWGcxakhWd1FoakUxZmhtMDlkWnRaR1Mr?=
 =?utf-8?B?eFBxVnEzc0l0TnFDZEZja1FOK1JITGpxUlR5eUpNamRVQjVnYVhGNVl2QjV0?=
 =?utf-8?B?a0UrZ3BrTldiQjE4b1RUZEpIZDUyQkJxb3Vlam11M2hEWmxtaGFiMEh3TW85?=
 =?utf-8?B?aThxditoY2FzQ254OUJRTC9ZRmp6VHNhb29vdW9pRDFOOGVDVzBCejJnMUhT?=
 =?utf-8?B?ODV4SjBKOFRIOTUrZDY4UHRaeTJ2U01yMTYyMUNqTEpBcHlod1gzaSswTWtM?=
 =?utf-8?B?MFB2NXNOVUZSek54RXQzaVdkdmZqeG5DUEEzVkVxQVJ0TDZ1ays5MWttODFl?=
 =?utf-8?B?YXdQU2p0Q0FTNEVneGNoeU1ob0xLaG80dEMxVkx2d01iQTRuRDJyUEtuckFO?=
 =?utf-8?B?NVBKNVUyWjJyQjhNdC9ROHhUZE1pWnZjcHlDVUp2ZkpVaHM3OWJ1cFp5SUlP?=
 =?utf-8?Q?GlqMAO6nFxcboqqOk3kwQmtm4Mjynw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTMvUDIyZW96a1lLVDh6RjlwMDVKdjhFcEZZTWpmNGg4SlhFOGYzdXNJbzRJ?=
 =?utf-8?B?UWJrTXRDSFVWRzdyaXhXeGp4emgwaXRUWElIUTVlSm8xQWRXNGZ0djBpODdL?=
 =?utf-8?B?cTdQSk1MMzVxWUNpd1hWUTlxQkVTY3MyRWtHa0N1SG9sV1c2elJGSUgyWFBB?=
 =?utf-8?B?UkRvYkpiM280ODBibG4waVFuNmdiRWdaYVE0cEhsaE1zQk04cUNtekhjWVFI?=
 =?utf-8?B?Z3N0WkFHYlovbzVhZmhVWHVxamtFeVRGM2E3Si9qZUVCamt0ZnRyWTg3ZnBQ?=
 =?utf-8?B?c0c5eE0wNC8zZ3JZZ0FaeTZtZjNtT1oxMWQ3UlZMQkFNKzVvOElnWDVjODdN?=
 =?utf-8?B?TDczQmtwdlhZU1QxaTJQWlVMR0MxeGdTdC93TGlvTWN5RmVHYWFIWnFjcXBS?=
 =?utf-8?B?bG5kblNIUzAyMFZ5M1U2Nktob3k4RXkvdzBLdXJnYmE2ak9YMENRZjZKb04y?=
 =?utf-8?B?SnhqcWRLOVIwM01rL0Z6aGd6L0YvK1FWYXJTSlhJeVZLQ1FNVE80cTNROXJP?=
 =?utf-8?B?U1JlVkhqLzRrd0hWZWVGd2QzR3UzS0RMQm45d2drek1HT0pEeG9VZTdHamls?=
 =?utf-8?B?UkxjK3JZcnBhNXl4NTA2djFCd0RsbVVUZkpWRXBTekFaQ1QzNnJjU2J6bGZF?=
 =?utf-8?B?dDhsUlZvMTBGcTNtSnZiSnBPQTFwRWpNK2RrL01QUmNPVGtnU0JrQ3ZmQlNi?=
 =?utf-8?B?ZXpmNlNnRDI3MWRjNUR2N0ZTMXpUMmxBMkdndkN5ckduem5FM2RxQ0hUN2tF?=
 =?utf-8?B?c29uMkhXOHUvdUFPZ00vemdBMmlQWlpORW1NREpuRWVaUFp4MnpETGlQWG9k?=
 =?utf-8?B?cnQ2V1hTM0VKYmJ4cDRRazJqUVp4Vi9vb2FqbVdwUXNMRXZObmVlU1ZKbXpn?=
 =?utf-8?B?SnhnTHlFUTRibXAxeTZaMzVtc1o2dGlBTFJSM0xsZGZBYXZCMElwcm5lZDB0?=
 =?utf-8?B?YStlWmEyemlnUUZ4bzdPR3FzTHMvbGxlZ0Q4cVM0ZWNadnMraThIYWdsSXox?=
 =?utf-8?B?aFgzYWdIUGd0Y2d0OGRqS05PU0lXaFhKN3dqUXlMeDBqSjBMcm9HZlAwNlVm?=
 =?utf-8?B?TEJKREgxM0RFWUZHNnZRTVdOaVIvQzg4RnJTeHVpcXhCVEZMUFRqVElsWXIr?=
 =?utf-8?B?djBTN2RDRGkyTGNiSS9iNHFDWk1ZWDhERHpHQVlkVGJMUXlLS2FrZm1obkZL?=
 =?utf-8?B?MU5sWTNrUFhtcnpXRmF4TWYxdnlkK3BXNG9jb3pJNWo5RVl4cjQ3SG5mOFkw?=
 =?utf-8?B?dGpmUG42NE5OV3lYNlJhT05CNE1NZ0RrZzF3R0craTBTdXZNWU1malhGemVk?=
 =?utf-8?B?V0NKTXFJWjA3Ynd1bS81SnFCUUNqbVpYWitOaVA3dVA0LzlRNSsvNnliUFhu?=
 =?utf-8?B?cGlRZlpuWU8vb3FFNVBtNTI2eStNZGJQYlBCOGQ3Qlc4MEd2TmZVWUhJMWxU?=
 =?utf-8?B?OVZzSmZLR1dBK0ppSlZPcWh4Zkl6QW1CRXluQ09QTGlOZ3AvOE84Nk5hVllj?=
 =?utf-8?B?RnRkcXZyMTNCZjc3ZWRXeW9yOW5SMmhRVXk5YlFocmYyWmZnMDUxeXptM21H?=
 =?utf-8?B?MjBJS3cxSzRDVlBkWm9UUXptQ0NZQ3VJR1puWHhEUENlWWJhRm9WQ0JrNFVa?=
 =?utf-8?B?M0NKdUtxcEhwK1BsSXY3K0FlWjFUV1BJNmtDdFRBbzZCMzN1R3h2d3N3WnpE?=
 =?utf-8?B?L0FmamNraHB4RmYvNWNFRm1RQkkwQm1SRStZVGtEalFNNzAySEJnRmtDRmVB?=
 =?utf-8?B?anRicnRDRVgxNzNXUWdSVTFFTnZIb3RubFNkbVJGTFpKcFlpNjlqcm0ybjhj?=
 =?utf-8?B?S0FEU3lWQmtJTjQ3d2ZVa0NPOXJkbUVhK01iVjlXVEpxNG1aMGsrSVY4TVpH?=
 =?utf-8?B?eUY0bi9zZkdXNDVoQXQyalBsTVJiRktid1dMVlFZanBKSzAxSFR6SFMzMFov?=
 =?utf-8?B?RGNLSzBLSi80THl0akJjV2VEK0NYSUJ4YWxRTjBxZDlvb1pVeDhRVXlyTW5W?=
 =?utf-8?B?ME1MZUM4UzdVUlZYTlZvWWF2MytFWTZOUmhyR01qUGMraTVyTGNoY2loWGRM?=
 =?utf-8?B?bFpUMVNtUXhmcDFRTkRNTGs1bzdjNVZFN3duSGpDL1kvVjgrVVpjVEpvbTda?=
 =?utf-8?B?cjh1UmVpTUdQZUNDMk1NOEVkUG1HNUZOYXhwcGtxRmdrRGNoNEVxTmZtWmNQ?=
 =?utf-8?B?TnowMFlWMGZoQWhYYW9ZV0czTE1heGxLWUFKclZ4enBTLzY5d1ByYUQ0Vmht?=
 =?utf-8?B?dlRiNnE0bW41VDB0SVVxUVNkdjJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7B0472494E9D34FB50D6D680F40F9AE@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d4fe3e-f937-4bc0-d9d1-08ddb5466920
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 06:46:57.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbVybR7Yi+JaxBaJK2I1J6oeKbF6H3yr3vkDyCxlhZh4an2kM9dh6yiB8pigxpv2+BNsQx9/5PI6payb8Vdbww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8712
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_234715_178127_2E72CEB8 
X-CRM114-Status: GOOD (  27.65  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMDI1LTA2LTI3IGF0IDA2OjQ4ICswMjAwLCBUaG9tYXMgV2Vpw59zY2h1aCB3cm90
ZToNCj4gT24gVGh1LCBKdW4gMjYsIDIwMjUgYXQgMDk6NTc6MTNQTSArMDIwMCwgQmVuamFtaW4g
QmVyZyB3cm90ZToNCj4gPiBGcm9tOiBCZW5qYW1pbiBCZXJnIDxiZW5qYW1pbi5iZXJnQGludGVs
LmNvbT4NCj4gPiANCj4gPiBJbiBwcmVwYXJhdGlvbiB0byBhZGQgdGVzdHMgdGhhdCB1c2UgaXQu
DQo+IA0KPiBJIHRyaWVkIHRvIGltcGxlbWVudCBzaWduYWwgc3VwcG9ydCBpbiBub2xpYmMgYmVm
b3JlIGJ1dCByYW4gaW50byBzb21lIGlzc3Vlcy4NCj4gVW5mb3J0dW5hdGVseSBJIGRvbid0IHJl
bWVtYmVyIHRoZSBkZXRhaWxzLg0KPiBCdXQgSSBndWVzcyB5b3Uga25vdyBtb3JlIGFib3V0IHNp
Z25hbHMgdGhhbiBtZSwgc28gbGV0J3MgdHJ5IGl0IGFnYWluLg0KPiBJbiBhbnkgY2FzZSB0aGlz
IHNob3VsZCBhZGQgc29tZSB0ZXN0cyB0bw0KPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ub2xp
YmMvbm9saWJjLXRlc3QuYy4NCj4gDQo+IElmIHlvdSB0ZXN0IGl0IHdpdGggcWVtdS11c2VyIHBs
ZWFzZSBiZSBhd2FyZSB0aGF0IHRoZXJlIHdlcmUgaXNzdWVzIGFyb3VuZA0KPiBTQV9SRVNUT1JF
UiB1cCB1bnRpbCByZWNlbnRseSBbMF0gWzFdLg0KDQpPaCwgaXMgdGhlcmUgYSBjb252ZW5pZW50
IHdheSB0byBjcm9zcy1jb21waWxlIGZvciB2YXJpb3VzDQphcmNoaXRlY3R1cmVzIGFuZCBydW4g
dGhlbSB1c2luZyBxZW11Pw0KDQpTbyBmYXIgSSBvbmx5IHRyaWVkIHg4Ni94ODZfNjQuDQoNCj4g
DQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwMjAyLXJpc2N2
LXNhLXJlc3RvcmVyLXYxLTEtNmY0YmY4MTRhMWRkQHQtOGNoLmRlLw0KPiBbMF0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9tdm1lZDA2MHhjOS5mc2ZAc3VzZS5kZS8NCj4gDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQmVyZyA8YmVuamFtaW4uYmVyZ0BpbnRl
bC5jb20+DQo+ID4gLS0tDQo+ID4gwqB0b29scy9pbmNsdWRlL25vbGliYy9ub2xpYmMuaCB8wqAg
MyArKysNCj4gPiDCoHRvb2xzL2luY2x1ZGUvbm9saWJjL3NpZ25hbC5oIHwgMzQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNl
cnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2luY2x1ZGUvbm9saWJjL25v
bGliYy5oIGIvdG9vbHMvaW5jbHVkZS9ub2xpYmMvbm9saWJjLmgNCj4gPiBpbmRleCBjMTk5YWRl
MjAwYzIuLjI5ZTM3YTc1NWFiYSAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9pbmNsdWRlL25vbGli
Yy9ub2xpYmMuaA0KPiA+ICsrKyBiL3Rvb2xzL2luY2x1ZGUvbm9saWJjL25vbGliYy5oDQo+ID4g
QEAgLTkyLDYgKzkyLDkgQEANCj4gPiDCoCNpZm5kZWYgX05PTElCQ19IDQo+ID4gwqAjZGVmaW5l
IF9OT0xJQkNfSA0KPiA+IMKgDQo+ID4gKy8qIFNvIHRoYXQgd2UgZG8gbm90IGdldCBjb21wYXRp
YmlsaXR5IHR5cGVzL2RlZmluZXMgKi8NCj4gPiArI2RlZmluZSBfX0tFUk5FTF9fDQo+IA0KPiBD
b3VsZCB5b3UgZXhwbGFpbiB0aGlzIG1vcmU/DQo+IA0KPiBUaGUgdXNlciBtYXkgaGF2ZSBpbmNs
dWRlZCBrZXJuZWwgVUFQSSBoZWFkZXJzIGFscmVhZHkgYmVmb3JlIGluY2x1ZGluZyBub2xpYmMs
DQo+IHNvIGl0IGRvZXNuJ3QgcmVhbGx5IHdvcmsuDQoNCk1heWJlIHdlIHNob3VsZCBqdXN0IHNl
dCBpdCBpbiB0aGUgQ0ZMQUdTIGRpcmVjdGx5IHRoZW4/DQoNCkhvbmVzdGx5LCBJIGFtIG5vdCBl
bnRpcmVseSBzdXJlIGhvdyB5b3UgYXJlIHN1cHBvc2VkIHRvIGRvIGl0DQpjb3JyZWN0bHkuIFRo
ZSB0aGluZyBpcywgaWYgSSBkbyBub3Qgc2V0IF9fS0VSTkVMX18sIHRoZW4gSSBnZXQgdGhlIG9s
ZA0KY29tcGF0aWJpbGl0eSBkZWZpbmVzIGFuZCB0eXBlcyBmcm9tIGFzbS9zaWduYWwuaC4NCg0K
QW5kLCBJIGRvIG5vdCBzZWUgYW4gYWx0ZXJuYXRpdmUgd2F5LiBJdCB3b3VsZCBub3QgYmUgc2Fm
ZSB0byBhdm9pZCB0aGUNCmluY2x1ZGUgZW50aXJlbHkgYW5kIGlmIHlvdSB0cnkgdGhhdCB5b3Ug
YXJlIGFsc28gbWlzc2luZyB0aGUNClNBX1JFU1RPUkVSIGRlZmluZSBmb3IgdGhlIHByb3BlciAi
c3RydWN0IHNpZ2FjdGlvbiIgZGVmaW5pdGlvbiB0byBiZQ0KY29ycmVjdC4NCg0KVGhlIGJlc3Qg
YWx0ZXJuYXRpdmUgSSBzZWUgd291bGQgYmUgY29weWluZyB0aGUgcHJvcGVyIGRlZmluaXRpb25z
IGludG8NCnRoZSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgaGVhZGVyLiBUaGF0IHdvdWxkIGFsc28g
YmUgdWdseSwgYXMgb25lIHdvdWxkDQpuZWVkIHRvIGRvIGEgInN0cnVjdCBzaWdhY3Rpb24iIC0+
ICJzdHJ1Y3Qgbm9saWJjX3J0X3NpZ2FjdGlvbiINCmNvbnZlcnNpb24gaW50ZXJuYWxseS4gQnV0
LCB0aGF0IHdvdWxkIGhhdmUgdGhlIGFkdmFudGFnZSB0aGF0IG5vbGliYw0Kd29ya3Mgb3V0c2lk
ZSBvZiB0aGUga2VybmVsIHRyZWUuDQoNCkV2ZW4gaWYgYWxsIHRoaXMgaXMgdWdseSwgSSB3b3Vs
ZCBwcmVmZXIgdGhhdCBvdmVyIHVzaW5nIHRoZQ0KY29tcGF0aWJpbGl0eSBzaWdhY3Rpb24gc3lz
Y2FsbCBpbnN0ZWFkIG9mIHJ0X3NpZ2FjdGlvbi4NCg0KPiA+ICsNCj4gPiDCoCNpbmNsdWRlICJz
dGQuaCINCj4gPiDCoCNpbmNsdWRlICJhcmNoLmgiDQo+ID4gwqAjaW5jbHVkZSAidHlwZXMuaCIN
Cj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvaW5jbHVkZS9ub2xpYmMvc2lnbmFsLmggYi90b29scy9p
bmNsdWRlL25vbGliYy9zaWduYWwuaA0KPiA+IGluZGV4IGFjMTNlNTNhYzMxZC4uZmE1MjExOWU1
NzdmIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL2luY2x1ZGUvbm9saWJjL3NpZ25hbC5oDQo+ID4g
KysrIGIvdG9vbHMvaW5jbHVkZS9ub2xpYmMvc2lnbmFsLmgNCj4gPiBAQCAtMTQsNiArMTQsNyBA
QA0KPiA+IMKgI2luY2x1ZGUgImFyY2guaCINCj4gPiDCoCNpbmNsdWRlICJ0eXBlcy5oIg0KPiA+
IMKgI2luY2x1ZGUgInN5cy5oIg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc2lnbmFsLmg+DQo+ID4g
wqANCj4gPiDCoC8qIFRoaXMgb25lIGlzIG5vdCBtYXJrZWQgc3RhdGljIGFzIGl0J3MgbmVlZGVk
IGJ5IGxpYmdjYyBmb3IgZGl2aWRlIGJ5IHplcm8gKi8NCj4gPiDCoGludCByYWlzZShpbnQgc2ln
bmFsKTsNCj4gPiBAQCAtMjMsNCArMjQsMzcgQEAgaW50IHJhaXNlKGludCBzaWduYWwpDQo+ID4g
wqAJcmV0dXJuIHN5c19raWxsKHN5c19nZXRwaWQoKSwgc2lnbmFsKTsNCj4gPiDCoH0NCj4gPiDC
oA0KPiA+ICsvKg0KPiA+ICsgKiBzaWdhY3Rpb24oaW50IHNpZ251bSwgY29uc3Qgc3RydWN0IHNp
Z2FjdGlvbiAqYWN0LCBzdHJ1Y3Qgc2lnYWN0aW9uICpvbGRhY3QpDQo+ID4gKyAqLw0KPiA+ICsN
Cj4gPiArI2lmZGVmIFNBX1JFU1RPUkVSDQo+ID4gK19fYXR0cmlidXRlX18oKG5ha2VkKSkNCj4g
DQo+IF9fYXR0cmlidXRlX18oKG5ha2VkKSkgaXMgbm90IHN1cHBvcnRlZCBldmVyeXdoZXJlLg0K
DQpPbmUgY2FuIGp1c3QgZHJvcCBpdC4gSXQganVzdCBmZWx0IGl0IHdhcyBjbGVhbmVyIGFzIHdl
IHJlYWxseSBqdXN0DQp3YW50IHRvIHNldCB0aGUgcmVnaXN0ZXIgYW5kIGRvIHRoZSBzeXNjYWxs
IHdpdGhvdXQgbW9kaWZ5aW5nIHRoZQ0Kc3RhY2suDQoNCj4gPiArc3RhdGljIHZvaWQgbXlfc2Ff
cmVzdG9yZXIodm9pZCkNCj4gDQo+IFRoaXMgc2hvdWxkIHVzZSBhIG5hbWUgd2l0aCBsZXNzIHBv
dGVudGlhbCB0byBjb25mbGljdCB3aXRoIHVzZXIgY29kZS4NCj4gTGlrZSBfX25vbGliY19zYV9y
ZXN0b3JlcigpLg0KDQpTdXJlIQ0KDQpCZW5qYW1pbg0KDQo+IA0KPiA+ICt7DQo+ID4gKwlteV9z
eXNjYWxsMChfX05SX3J0X3NpZ3JldHVybik7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gKw0K
PiA+ICtzdGF0aWMgX19hdHRyaWJ1dGVfXygodW51c2VkKSkNCj4gPiAraW50IHN5c19zaWdhY3Rp
b24oaW50IHNpZ251bSwgY29uc3Qgc3RydWN0IHNpZ2FjdGlvbiAqYWN0LCBzdHJ1Y3Qgc2lnYWN0
aW9uICpvbGRhY3QpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBzaWdhY3Rpb24gcmVhbF9hY3QgPSAq
YWN0Ow0KPiA+ICsjaWZkZWYgU0FfUkVTVE9SRVINCj4gPiArCWlmICghKHJlYWxfYWN0LnNhX2Zs
YWdzICYgU0FfUkVTVE9SRVIpKSB7DQo+ID4gKwkJcmVhbF9hY3Quc2FfZmxhZ3MgfD0gU0FfUkVT
VE9SRVI7DQo+ID4gKwkJcmVhbF9hY3Quc2FfcmVzdG9yZXIgPSBteV9zYV9yZXN0b3JlcjsNCj4g
PiArCX0NCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+ICsJcmV0dXJuIG15X3N5c2NhbGw0KF9fTlJf
cnRfc2lnYWN0aW9uLCBzaWdudW0sICZyZWFsX2FjdCwgb2xkYWN0LA0KPiA+ICsJCQnCoMKgIHNp
emVvZihhY3QtPnNhX21hc2spKTsNCj4gDQo+IE5vIG5lZWQgZm9yIHRoZSBsaW5lYnJlYWsuDQo+
IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgX19hdHRyaWJ1dGVfXygodW51c2VkKSkNCj4g
PiAraW50IHNpZ2FjdGlvbihpbnQgc2lnbnVtLCBjb25zdCBzdHJ1Y3Qgc2lnYWN0aW9uICphY3Qs
IHN0cnVjdCBzaWdhY3Rpb24gKm9sZGFjdCkNCj4gPiArew0KPiA+ICsJcmV0dXJuIF9fc3lzcmV0
KHN5c19zaWdhY3Rpb24oc2lnbnVtLCBhY3QsIG9sZGFjdCkpOw0KPiA+ICt9DQo+ID4gKw0KPiA+
IMKgI2VuZGlmIC8qIF9OT0xJQkNfU0lHTkFMX0ggKi8NCj4gPiAtLSANCj4gPiAyLjUwLjANCj4g
PiANCg0KSW50ZWwgRGV1dHNjaGxhbmQgR21iSA0KUmVnaXN0ZXJlZCBBZGRyZXNzOiBBbSBDYW1w
ZW9uIDEwLCA4NTU3OSBOZXViaWJlcmcsIEdlcm1hbnkNClRlbDogKzQ5IDg5IDk5IDg4NTMtMCwg
d3d3LmludGVsLmRlDQpNYW5hZ2luZyBEaXJlY3RvcnM6IFNlYW4gRmVubmVsbHksIEplZmZyZXkg
U2NobmVpZGVybWFuLCBUaWZmYW55IERvb24gU2lsdmENCkNoYWlycGVyc29uIG9mIHRoZSBTdXBl
cnZpc29yeSBCb2FyZDogTmljb2xlIExhdQ0KUmVnaXN0ZXJlZCBPZmZpY2U6IE11bmljaA0KQ29t
bWVyY2lhbCBSZWdpc3RlcjogQW10c2dlcmljaHQgTXVlbmNoZW4gSFJCIDE4NjkyOAo=


