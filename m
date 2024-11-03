Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04199D11100
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxtWc2TQUJRkrePhoR6HGbEKCr453+USNTuh3FP6Ipg=; b=4YZ6UTg1JykjN82UZXX6rN+feo
	semgGsGskVEHtfjutCLtLZFtTuR9vxRMPyxsKlo1lndnzHG6jBcmRCf3mo7PXXYNWtzwem2BJ/Fjv
	9EA0IfIerc4WShmXSPbflzCL+PyiTv/3nHL9Dymzzm1Tdv9kQk7Ja/VEPeE56n7pXF4dEXociXhRt
	LUZ3w/gN+Bi9EhlULMucOHW2Y2IOtgVTYKXRrqpZ3d1sjG6wFdzEUagrr3nY6WiwmAEpwFJMm/Cjr
	P6mYpC4quNx25jLorDlWDU9h4tlG7YxKe1wFeHTjSoPbNF1jDpN/ugcC/pjhjnyMzvo5bRLb1NWPA
	9wvf5aIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7bsJ-0000000BYjM-429W;
	Sun, 03 Nov 2024 14:46:43 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7bsH-0000000BYim-0Zlo
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 14:46:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730645201; x=1762181201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=oxtWc2TQUJRkrePhoR6HGbEKCr453+USNTuh3FP6Ipg=;
  b=arWQMImQT+WgbOS97a1b7doDxuPzrWSkNzfjC6kAniZYLQ5XGDRrlL0p
   wPdQoXrZGxP/jOT7AQFxDcDjg4r/M9KXLri2wJPaCTW5M8gTZ7HvgKUIc
   SJnvlgTCrD2lNEF7re+LPTNQfShsPYJACXVVkDQWLc6mtmBJIAdp+Czkd
   UV1Du7LCOHJnQTO8wz0fWsJOSUYwqElYKH4IltdYAvA0kCc/GGu86icIe
   0/iPlOeLEllmg/sP+dNOqwERzkc4JVC2zAHAoovHSg3GSCoJkmETlMRh8
   9vD3lam+5R16Bwoa+InYXGnLimZj7aJxHvAeWbYnB8rPuylsp6TRaZIq/
   A==;
X-CSE-ConnectionGUID: 08a3ic7ERviJPqyCH8Seew==
X-CSE-MsgGUID: Om4UqOySSFuj+VNWAx6AmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="47847130"
X-IronPort-AV: E=Sophos;i="6.11,255,1725346800"; 
   d="scan'208";a="47847130"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 06:46:34 -0800
X-CSE-ConnectionGUID: N0uimPn9TMSCen/6QnuTQw==
X-CSE-MsgGUID: JMJDOjnZQ6KVOAOJszywaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,255,1725346800"; 
   d="scan'208";a="114208417"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2024 06:46:33 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 06:46:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 06:46:32 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 06:46:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcqDNfaz3/y8hLCcMKxMNmEfH+z6rHYgPaa2Lanbde4ZGVSyLBBMbPrb9UKk7Uv5hcNltB2/pwiIhsLQ2bEd1i0QskyzK3NRvHLObhXYW94d0sYpLixMU2utgRhkxf2ev4VJT7e/ce7I71gWEJ9nTW9Pv6Y/Uh3dJpYbwOdTirVGo69UdG3xVBkxh4FH4W+P6/+iJPtIsLfiAFPXS6jf+4hK9G645K14KQJLKXx0+uPcyhiJiC3Vz8TYQfNnxWTgS7Hx0+N2KpoocnDSAfDDVqD6s5/D0dzAyKx2KPou3PKkyaRsClLAf1ypNucj8Ptblc/FSF39sZ2DRJYfeZy1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIjgbAehcovMs+invYPnrWvGFo9M1EaD2fOB9i7deA8=;
 b=nfKR583qldwfME2R2tKZ3twwyOaJrZyR5tHxX5xjN8sFbTJc4thwERT7U6Uu1lufVZWz2BEn2Dl0lJIa0+8c2K6aLz2y9UcV1qTA6uy6ijc+mGLd2lqHoVlIPqHaBw7Hng8XuLg7EMINovx8RI0ENN5JAGIFWXj6BilW7PNSjkH4dAbq4PKNqsBQqXCj4Nf3ngqoafJyys+C1rqlRRkjIc1digyEQu8VjRM8ZTM1fcXXYV0egzsDiLIza43V51mbPR2b8By920UcDv80aOcG39K66n24UNU2/zBCJwlTtSBr4aUXIomXgrJCYTdHLfh1gxqyP0rFDwIwTq1eAz062A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sun, 3 Nov
 2024 14:46:29 +0000
Received: from DS0PR11MB7969.namprd11.prod.outlook.com
 ([fe80::682e:6be3:5d05:3d3d]) by DS0PR11MB7969.namprd11.prod.outlook.com
 ([fe80::682e:6be3:5d05:3d3d%6]) with mapi id 15.20.8114.023; Sun, 3 Nov 2024
 14:46:28 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
CC: "Berg, Johannes" <johannes.berg@intel.com>
Subject: Re: [RFC PATCH] um: mark rodata read-only and implement _nofault
 accesses
Thread-Topic: [RFC PATCH] um: mark rodata read-only and implement _nofault
 accesses
Thread-Index: AQHbG1k4wb28Dh4C4kSLFsrvTXaH2bKlx5uA
Date: Sun, 3 Nov 2024 14:46:28 +0000
Message-ID: <b3ed7fe86ecb18fbee12eb6e5a633f46e4a79941.camel@intel.com>
References: <20241010231219.1ee439d79cce.I138657a313a93c2c0484eaed79fb985b96c586d7@changeid>
In-Reply-To: <20241010231219.1ee439d79cce.I138657a313a93c2c0484eaed79fb985b96c586d7@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7969:EE_|SA0PR11MB4735:EE_
x-ms-office365-filtering-correlation-id: 7d1648ab-bb20-402f-2dcd-08dcfc164ca3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dFhRdmVPZlgycnVzMkpFMVpPWTE4UURtREZqd04wQlY2OWpoREJhbWN5b2pO?=
 =?utf-8?B?d2VNZmd2Y1Q4S2ZPNEV6eVV2U0FVaUt1bUdFRlExZFhqNE1jeG92S0pCWEtK?=
 =?utf-8?B?UEppaGQyU250QmFlVytZRFpVcEx5TGl0Q3Jta2tJdjRvakpxT1VZMCtoOXNh?=
 =?utf-8?B?blBGSkVqU2psbUtrbE15b2s0eXd6Nm1NOHYrQVM0Y2J4VDVwa2xaYWdnZWRt?=
 =?utf-8?B?V0dyYWZSalBEU2pZamtlOVpPNWY1Wkp5LzhhVXY2REdmSDgyQVlvMSsrU2pn?=
 =?utf-8?B?RmJHV2VRZnduQjRqQXZseHArR290LzFjcW5lYzc5c0V3ZzlFZEQ1MFFwS3Jz?=
 =?utf-8?B?QktsczB4cnZFR3lkZnpJaGI2MmEvMENRRTRxbFNTc1lZb2c1TExPTEdSZmVE?=
 =?utf-8?B?dGpiQ1lJeFpmalh2bWM1VXIzZnBMZUxpUEtWc0hNZWhnVTV2UXY4bjN5Z1pn?=
 =?utf-8?B?OFhOTTJJN0dLUFNiMmx2N3AzVE96N0EyZXZpdWQ2eWxKTzFOWUl3ZlNjcmhZ?=
 =?utf-8?B?Z1MxeXlZbzB3MlJsS2IyUWVROG5ldGNiZXNUWDJRMU9VT0I5SXpDTUFCVGVr?=
 =?utf-8?B?bDJRL05DSHdKak9sbmlrK3EvSEx3Y2NXYjlvT3hyTVkzd1pEQUtlaStMQndp?=
 =?utf-8?B?aDBudXlkMjJheXFHQ0V4QVBNNlhDZmJ0YmxjcTRVVGpmdUp6bDl0eEI2cHpj?=
 =?utf-8?B?QW1NUXJNbGg0ekFYaFoxQzdRVjdvVjRJQzI5NjFrMm5FdlMzVGsvSUxHdDFn?=
 =?utf-8?B?c0dWcnlxUUt6Smk5QkJqWU9TWUduSm9xS3REUHdKL0pzZWszOUI0RUI0ZEsr?=
 =?utf-8?B?bnUra3FGc3k4TlV3QmNSbWJBMERkb3pEMndxTDA3aStrdnBXajJUbmVYWmp3?=
 =?utf-8?B?L0NmZ0dCaWxCQ2pkak5OekpadVh2N1haL2hSM0xaN0dHaGxhVEt2Y25ETENB?=
 =?utf-8?B?VGQ1bWZpOHdvR3FqN25YVWhPM2pZWFFScG9iQ0s4OVovRThObDlHWHd6WmUx?=
 =?utf-8?B?ZWhuOVprMnBZRzFLNWd2WDdCdDNONjh0bUpEMHB5WWRhN2RQdnZTcW9GZ3FY?=
 =?utf-8?B?OGlYS3JnRzdtL0R6elVNd2U5UE1MOHZUREFadVlMbUhKMEo3NlBxRjFuR1BU?=
 =?utf-8?B?T2pzS3AzdmEyUnRPT3RnWjBSVjJoNXcya002cDVrL0xhcGd1RmFVK1pDTzE2?=
 =?utf-8?B?UU1xVkp3dGRaUlZObG5TZGRQclpGdGprODhlUm1HUkcyRG1NcUlLSlNZNGVx?=
 =?utf-8?B?M2E0MzZsLzNrT29MUXhmUVEweEpsaElqd2VjalJhdzFPM3hMYXRFczlVRDZh?=
 =?utf-8?B?TW95SmdUOU1SZUhNZGN4OElSQ2QxNllZM0pmMHR1M2RxQlRucW96dkNLbjhx?=
 =?utf-8?B?QjVjOGU4VXJzb29MRzZYdldjMjkxVG4xVVZMRDdFUGFPQ1l1RU95ellqWUd2?=
 =?utf-8?B?UElBRUZVUER0VVpSaFBnL3lZR0RVcCszNlUydDkzVE9EaXc0OHlPUlVXRkNU?=
 =?utf-8?B?ejVYeDhVU1dKa29PajQ4TFRqQzYwMXJXd0FSb2FHdG5lQ2ZKNkdRMm5YSlNq?=
 =?utf-8?B?SWdtYTN0cVZFTm5WVmRJWlZKNFdXd2FocEd4enJ6bFQzSVd2d0NSVzJrWFhi?=
 =?utf-8?B?UGxVejZicFRzVkp6U0dSdFQ1bWZiMU0vcnRKZHVTNGpXbXlvazRZNVRkeFVa?=
 =?utf-8?B?eGNhcjF0OHNZTHdBNjc5aitXem1XSUhOZ0h5YnNVZFhISTM1SXAyZWs2N1pX?=
 =?utf-8?B?WlFuMnRzZDdrNTVuMUZQOG9lbUU3Q08yb1JIYnNBRWN2SVBwWFE3YWREOWgz?=
 =?utf-8?Q?2Uitm7Tgf2f7AyvEsgbdWDJ5Vp6GLX+I2BSrU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7969.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGFsSVVGU3JGL1I5bVI2NGUxSnM1Q2VXY1dQTGRJZXNFRXlUQlpuZVVIZmIv?=
 =?utf-8?B?SlJ2cjlxYjY2d1NNSTFzdmRoQnluOGM2Rk5wdFRJTld3VHNKaUhPS3VBM3VO?=
 =?utf-8?B?Y0IxcllLQU9MNkJna1QwTEJVNGR6YVJIUjhBTit0aldHeHJ1ejlXS2VkZzMv?=
 =?utf-8?B?N3h1ZC9wSk9maXFFcGpOMW1MM3VGK3ROV3RiYVdnTUxxcjU2MWI1MWF5blJU?=
 =?utf-8?B?MXhVaDFGYTNnTUpNVFNaUmxtSzVQT1FDamU1TDF6VTJqaGlKZy91cWViWWdF?=
 =?utf-8?B?aitUZmxmZzVTL3J2NDgrYm1NcWcrZE8xZVZDVjRxZTVOTTN0NSt6V1Q3aThL?=
 =?utf-8?B?S0VRNGl1cXpoZ3hyUzhGTFZGY2tIZTlkM3k3VGxwTThMVXl5TmdZMCsvV0VL?=
 =?utf-8?B?VTFmYmpCR1JKSS9aaVNsUTl6d3A0aXRYNVlOZkx6SEhkRkdkbC9aMTIzNDVm?=
 =?utf-8?B?d0dabjY0MGV1MDU2bm5xYm92eE53K1Vka2dtVHhBU3Znc0E0bHlIRlhMOEQz?=
 =?utf-8?B?V1orYkJDNkZwanJtQm15Zjg5WER2QUlRdzBCTXFDdDI3a0NnYk84bmkvTkMw?=
 =?utf-8?B?OXB4cG1NTmt3M1VJalNyM1NNalJBY2RTemhWeDZLWXdYWUNSRFhGQzFJekQ4?=
 =?utf-8?B?ZjEraVNJQllCVmtCVkRSNTJjY2FlTU9VWEVRMmxFS0lwYkdVWXFZalJNL3pV?=
 =?utf-8?B?bm9LK0psQXV5UDVNcWpJUFFxS2NSOEdRUzMvOWxmeVBDSjFxbEs0V0ZSaFp5?=
 =?utf-8?B?S2ZkUTNlQ3E5NmpoTjJSWWhBbmpBV1RxMW1MNFIxWUgzcjZ6T05tVmEvZ1Ev?=
 =?utf-8?B?ejk3SnRxR1BhZlBlemxDS0Vsdnl6THJjZTQwOUVTQ2hVeUlJNzNzTFY4VUJE?=
 =?utf-8?B?SE5EM1FLc1djR1dnWHFWNVQ2d2FnOGZaYTFBMUZQYTJBWlBoQWJuK1R3T0hs?=
 =?utf-8?B?cXptOTNzNFZRMllGVnduWFc5L2s5NDFEY2ZHcGU2SHNVTmd5c2YrSUUwR3BX?=
 =?utf-8?B?OC9aSGxXUFFGNW9sTUZ6WEEvL09NazNNRmxQbXdvN3o0ZytDd1A5RFNaTWtY?=
 =?utf-8?B?TW1NVXpSNzFwRjFJc0VyaUhUUENwQ1VoNmluQkpIVkFGTFVkdzdqSUVyR1ZY?=
 =?utf-8?B?ZGhDbjlab0d0clFkTGpCaGlmcldyUzUzdjJiWGg5OVVadElCOFdNNEN2cC9h?=
 =?utf-8?B?ZEdBNnBVRzlDZEJMWmpDcDZnRDMwRG1XUTAzTGFhMkpsWE90ZDRaaFliK0du?=
 =?utf-8?B?bUdyenF6RlBnajB4aXp6eW9jWHZhdUNnNlcwWlhYRjZtdytzcHdmY2IwaUJN?=
 =?utf-8?B?RjdhMFBUdWwxMUVDalE5Q0ErZ1hZOXEwSUVscTlTVGkxSGwvTEtMZllmcFl1?=
 =?utf-8?B?VWdRVjlYV2FQbnRmbFo0eEEzQVNtTmRvL2t3UHloY29pejBKTUpTQzVhNmN1?=
 =?utf-8?B?L1p5bEJQQXp5bWEzcGxDTk1Xdk84T2MyVjlMcGFnYnUveVkzVWtFWTdKRElh?=
 =?utf-8?B?eVBERXAyUC92cmpmTExkcHFEbElZN1FVaXg3ajZxaUM5RUJYbG5FMU9Vamgx?=
 =?utf-8?B?V3V2Q0JvRTIyM3FWNjVsbHQyc1pZWEM0UDhqZDYyRjhLVHFPdFh5c2RxWnJW?=
 =?utf-8?B?Ym1RYXlGcDBicFpBa1h4bDhmZWhvNS9kNEh1Sm1WeXZlamJ6bXN2aDViNHZK?=
 =?utf-8?B?c0JzWXZuMklYRmtuLzdQVFBhZXlmbGdNbHBvQTVLbWs3REpmSWgySlNkdDRu?=
 =?utf-8?B?RFluemJnQ29TTk13cm1HTWVIWk5reFdSVkRvaHF1anU3WjU5eW5FTzY3YjdT?=
 =?utf-8?B?QTRFR3JuQ3h0MDd3ZjFBRHFYVVNnN3kwVnVOZzVvZkxpcHVjN3dkVG9TVUJI?=
 =?utf-8?B?Y1BmclJqWlo3dW5YSStsNzU0d1YvOHAvTzZLVE1GVUhMM2pQOFRLRlhhN1Bj?=
 =?utf-8?B?dU15RGJPeVNSM2NRYXEyY2pRZWhzc2Q3ZnlGK1VVeU5zb2NKWS9WenZ1NVFR?=
 =?utf-8?B?dXVzZXh4R3VtU1VYNGRIYzJLOXJPaEgzS0IzaHZsaXF0MUlXdDJ1bUt5Kyt6?=
 =?utf-8?B?d0JhS2VkVUM3QTZjVVIveUpzdlZmbnhiUmRJSXRyOWFtYTZUd1hSRGdjNDRJ?=
 =?utf-8?B?bEE0ZFE5a0pRME1iYzErbk1qYzZnWER4eWhOTnNQU3BHWVJKKzBpa1JzQUZK?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91098377CDC3B54F83E666566B98F93B@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7969.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1648ab-bb20-402f-2dcd-08dcfc164ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2024 14:46:28.4590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qeDheibgcaOOEDEXgl/hF4e1CMr/K1ZHlosGaTdZH7fl7UYsD1tSis6Zs3Z4uww2wG906/M6961H2PQBAouVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_064641_362420_B922892F 
X-CRM114-Status: GOOD (  16.84  )
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

SGksDQoNCnRoZXJlIGlzIGEgc21hbGwgYnVnIHRoYXQgY2F1c2VzIGlzc3VlcyB3aXRoIHRoaXMg
cGF0Y2gsIHNlZSBiZWxvdy4NCg0KT24gVGh1LCAyMDI0LTEwLTEwIGF0IDIzOjEyICswMjAwLCBK
b2hhbm5lcyBCZXJnIHdyb3RlOg0KPiBbU05JUF0NCj4gZGlmZiAtLWdpdCBhL2FyY2gvdW0va2Vy
bmVsL3RyYXAuYyBiL2FyY2gvdW0va2VybmVsL3RyYXAuYw0KPiBpbmRleCBjZGFlZTNlOTQyNzMu
LjM3OGU2ZTE4MTViOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC91bS9rZXJuZWwvdHJhcC5jDQo+ICsr
KyBiL2FyY2gvdW0va2VybmVsL3RyYXAuYw0KPiBAQCAtMTYsNiArMTYsNyBAQA0KPiDCoCNpbmNs
dWRlIDxrZXJuX3V0aWwuaD4NCj4gwqAjaW5jbHVkZSA8b3MuaD4NCj4gwqAjaW5jbHVkZSA8c2th
cy5oPg0KPiArI2luY2x1ZGUgPGFyY2guaD4NCj4gwqANCj4gwqAvKg0KPiDCoCAqIE5vdGUgdGhp
cyBpcyBjb25zdHJhaW5lZCB0byByZXR1cm4gMCwgLUVGQVVMVCwgLUVBQ0NFUywgLUVOT01FTSBi
eQ0KPiBAQCAtMTgwLDcgKzE4MSw4IEBAIHZvaWQgZmF0YWxfc2lnc2Vndih2b2lkKQ0KPiDCoCAq
IElmIHRoZSB1c2VyZmF1bHQgZGlkIG5vdCBoYXBwZW4gaW4gYW4gVU1MIHVzZXJzcGFjZSBwcm9j
ZXNzLCBiYWRfc2VndiBpcyBjYWxsZWQuDQo+IMKgICogT3RoZXJ3aXNlIHRoZSBzaWduYWwgZGlk
IGhhcHBlbiBpbiBhIGNsb25lZCB1c2Vyc3BhY2UgcHJvY2VzcywgaGFuZGxlIGl0Lg0KPiDCoCAq
Lw0KPiAtdm9pZCBzZWd2X2hhbmRsZXIoaW50IHNpZywgc3RydWN0IHNpZ2luZm8gKnVudXNlZF9z
aSwgc3RydWN0IHVtbF9wdF9yZWdzICpyZWdzKQ0KPiArdm9pZCBzZWd2X2hhbmRsZXIoaW50IHNp
Zywgc3RydWN0IHNpZ2luZm8gKnVudXNlZF9zaSwgc3RydWN0IHVtbF9wdF9yZWdzICpyZWdzLA0K
PiArCQnCoCB2b2lkICptYykNCj4gwqB7DQo+IMKgCXN0cnVjdCBmYXVsdGluZm8gKiBmaSA9IFVQ
VF9GQVVMVElORk8ocmVncyk7DQo+IMKgDQo+IEBAIC0xODksNyArMTkxLDcgQEAgdm9pZCBzZWd2
X2hhbmRsZXIoaW50IHNpZywgc3RydWN0IHNpZ2luZm8gKnVudXNlZF9zaSwgc3RydWN0IHVtbF9w
dF9yZWdzICpyZWdzKQ0KPiDCoAkJYmFkX3NlZ3YoKmZpLCBVUFRfSVAocmVncykpOw0KPiDCoAkJ
cmV0dXJuOw0KPiDCoAl9DQo+IC0Jc2VndigqZmksIFVQVF9JUChyZWdzKSwgVVBUX0lTX1VTRVIo
cmVncyksIHJlZ3MpOw0KPiArCXNlZ3YoKmZpLCBVUFRfSVAocmVncyksIFVQVF9JU19VU0VSKHJl
Z3MpLCByZWdzLCBtYyk7DQo+IMKgfQ0KPiDCoA0KPiDCoC8qDQo+IEBAIC0xOTksNyArMjAxLDcg
QEAgdm9pZCBzZWd2X2hhbmRsZXIoaW50IHNpZywgc3RydWN0IHNpZ2luZm8gKnVudXNlZF9zaSwg
c3RydWN0IHVtbF9wdF9yZWdzICpyZWdzKQ0KPiDCoCAqIGdpdmUgdXMgYmFkIGRhdGEhDQo+IMKg
ICovDQo+IMKgdW5zaWduZWQgbG9uZyBzZWd2KHN0cnVjdCBmYXVsdGluZm8gZmksIHVuc2lnbmVk
IGxvbmcgaXAsIGludCBpc191c2VyLA0KPiAtCQnCoMKgIHN0cnVjdCB1bWxfcHRfcmVncyAqcmVn
cykNCj4gKwkJwqDCoCBzdHJ1Y3QgdW1sX3B0X3JlZ3MgKnJlZ3MsIHZvaWQgKm1jKQ0KPiDCoHsN
Cj4gwqAJaW50IHNpX2NvZGU7DQo+IMKgCWludCBlcnI7DQo+IEBAIC0yMjMsNiArMjI1LDE5IEBA
IHVuc2lnbmVkIGxvbmcgc2VndihzdHJ1Y3QgZmF1bHRpbmZvIGZpLCB1bnNpZ25lZCBsb25nIGlw
LCBpbnQgaXNfdXNlciwNCj4gwqAJCWdvdG8gb3V0Ow0KPiDCoAl9DQo+IMKgCWVsc2UgaWYgKGN1
cnJlbnQtPm1tID09IE5VTEwpIHsNCj4gKwkJaWYgKGN1cnJlbnQtPnBhZ2VmYXVsdF9kaXNhYmxl
ZCkgew0KPiArCQkJaWYgKCFtYykgew0KPiArCQkJCXNob3dfcmVncyhjb250YWluZXJfb2YocmVn
cywgc3RydWN0IHB0X3JlZ3MsIHJlZ3MpKTsNCj4gKwkJCQlwYW5pYygiU2VnZmF1bHQgd2l0aCBw
YWdlZmF1bHRzIGRpc2FibGVkIGJ1dCBubyBtY29udGV4dCIpOw0KPiArCQkJfQ0KPiArCQkJaWYg
KCFjdXJyZW50LT50aHJlYWQuc2Vndl9jb250aW51ZSkgew0KPiArCQkJCXNob3dfcmVncyhjb250
YWluZXJfb2YocmVncywgc3RydWN0IHB0X3JlZ3MsIHJlZ3MpKTsNCj4gKwkJCQlwYW5pYygiU2Vn
ZmF1bHQgd2l0aG91dCByZWNvdmVyeSB0YXJnZXQiKTsNCj4gKwkJCX0NCj4gKwkJCW1jX3NldF9y
aXAobWMsIGN1cnJlbnQtPnRocmVhZC5zZWd2X2NvbnRpbnVlKTsNCj4gKwkJCWN1cnJlbnQtPnRo
cmVhZC5zZWd2X2NvbnRpbnVlID0gTlVMTDsNCj4gKwkJCXJldHVybiAwOw0KDQpUaGlzIG5lZWRz
IHRvIGJlICJnb3RvIG91dCIuIE90aGVyd2lzZSBzZWd2X3JlZ3MgaXMgc3RpbGwgc2V0LCB3aGlj
aA0Kd2lsbCByZXN1bHQgaW4gYSBjcmFzaCBsYXRlciBvbiBpZiB0aGUgc3RhY2t0cmFjZSBjb2Rl
IHJlYWRzIGFuDQppbmNvcnJlY3Qgc3RhY2sgcG9pbnRlciBmcm9tIHRoZXJlLg0KDQpCZW5qYW1p
bg0KDQo+ICsJCX0NCj4gwqAJCXNob3dfcmVncyhjb250YWluZXJfb2YocmVncywgc3RydWN0IHB0
X3JlZ3MsIHJlZ3MpKTsNCj4gwqAJCXBhbmljKCJTZWdmYXVsdCB3aXRoIG5vIG1tIik7DQo+IMKg
CX0NCj4gQEAgLTI3NCw3ICsyODksOCBAQCB1bnNpZ25lZCBsb25nIHNlZ3Yoc3RydWN0IGZhdWx0
aW5mbyBmaSwgdW5zaWduZWQgbG9uZyBpcCwgaW50IGlzX3VzZXIsDQo+IMKgCXJldHVybiAwOw0K
PiDCoH0NCj4gwqANCj4gLXZvaWQgcmVsYXlfc2lnbmFsKGludCBzaWcsIHN0cnVjdCBzaWdpbmZv
ICpzaSwgc3RydWN0IHVtbF9wdF9yZWdzICpyZWdzKQ0KPiArdm9pZCByZWxheV9zaWduYWwoaW50
IHNpZywgc3RydWN0IHNpZ2luZm8gKnNpLCBzdHJ1Y3QgdW1sX3B0X3JlZ3MgKnJlZ3MsDQo+ICsJ
CcKgIHZvaWQgKm1jKQ0KPiDCoHsNCj4gwqAJaW50IGNvZGUsIGVycjsNCj4gwqAJaWYgKCFVUFRf
SVNfVVNFUihyZWdzKSkgew0KPiBAQCAtMzAyLDcgKzMxOCw4IEBAIHZvaWQgcmVsYXlfc2lnbmFs
KGludCBzaWcsIHN0cnVjdCBzaWdpbmZvICpzaSwgc3RydWN0IHVtbF9wdF9yZWdzICpyZWdzKQ0K
PiDCoAl9DQo+IMKgfQ0KPiDCoA0KPiAtdm9pZCB3aW5jaChpbnQgc2lnLCBzdHJ1Y3Qgc2lnaW5m
byAqdW51c2VkX3NpLCBzdHJ1Y3QgdW1sX3B0X3JlZ3MgKnJlZ3MpDQo+ICt2b2lkIHdpbmNoKGlu
dCBzaWcsIHN0cnVjdCBzaWdpbmZvICp1bnVzZWRfc2ksIHN0cnVjdCB1bWxfcHRfcmVncyAqcmVn
cywNCj4gKwnCoMKgIHZvaWQgKm1jKQ0KPiDCoHsNCj4gwqAJZG9fSVJRKFdJTkNIX0lSUSwgcmVn
cyk7DQo+IMKgfQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC91bS9vcy1MaW51eC9zaWduYWwuYyBiL2Fy
Y2gvdW0vb3MtTGludXgvc2lnbmFsLmMNCj4gaW5kZXggMTk3OGVhYTU1N2U5Li4yYWEwMjY1N2Vl
NzggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvdW0vb3MtTGludXgvc2lnbmFsLmMNCj4gKysrIGIvYXJj
aC91bS9vcy1MaW51eC9zaWduYWwuYw0KPiBAQCAtMjEsNyArMjEsNyBAQA0KPiDCoCNpbmNsdWRl
IDxzeXMvdWNvbnRleHQuaD4NCj4gwqAjaW5jbHVkZSA8dGltZXRyYXZlbC5oPg0KPiDCoA0KPiAt
dm9pZCAoKnNpZ19pbmZvW05TSUddKShpbnQsIHN0cnVjdCBzaWdpbmZvICosIHN0cnVjdCB1bWxf
cHRfcmVncyAqKSA9IHsNCj4gK3ZvaWQgKCpzaWdfaW5mb1tOU0lHXSkoaW50LCBzdHJ1Y3Qgc2ln
aW5mbyAqLCBzdHJ1Y3QgdW1sX3B0X3JlZ3MgKiwgdm9pZCAqbWMpID0gew0KPiDCoAlbU0lHVFJB
UF0JPSByZWxheV9zaWduYWwsDQo+IMKgCVtTSUdGUEVdCT0gcmVsYXlfc2lnbmFsLA0KPiDCoAlb
U0lHSUxMXQk9IHJlbGF5X3NpZ25hbCwNCj4gQEAgLTQ3LDcgKzQ3LDcgQEAgc3RhdGljIHZvaWQg
c2lnX2hhbmRsZXJfY29tbW9uKGludCBzaWcsIHN0cnVjdCBzaWdpbmZvICpzaSwgbWNvbnRleHRf
dCAqbWMpDQo+IMKgCWlmICgoc2lnICE9IFNJR0lPKSAmJiAoc2lnICE9IFNJR1dJTkNIKSkNCj4g
wqAJCXVuYmxvY2tfc2lnbmFsc190cmFjZSgpOw0KPiDCoA0KPiAtCSgqc2lnX2luZm9bc2lnXSko
c2lnLCBzaSwgJnIpOw0KPiArCSgqc2lnX2luZm9bc2lnXSkoc2lnLCBzaSwgJnIsIG1jKTsNCj4g
wqANCj4gwqAJZXJybm8gPSBzYXZlX2Vycm5vOw0KPiDCoH0NCj4gZGlmZiAtLWdpdCBhL2FyY2gv
dW0vb3MtTGludXgvc2thcy9wcm9jZXNzLmMgYi9hcmNoL3VtL29zLUxpbnV4L3NrYXMvcHJvY2Vz
cy5jDQo+IGluZGV4IDIyODY0ODZiYjBmMy4uMTQ0N2JlN2E0YmYyIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3VtL29zLUxpbnV4L3NrYXMvcHJvY2Vzcy5jDQo+ICsrKyBiL2FyY2gvdW0vb3MtTGludXgv
c2thcy9wcm9jZXNzLmMNCj4gQEAgLTE2Niw3ICsxNjYsNyBAQCBzdGF0aWMgdm9pZCBnZXRfc2th
c19mYXVsdGluZm8oaW50IHBpZCwgc3RydWN0IGZhdWx0aW5mbyAqZmkpDQo+IMKgc3RhdGljIHZv
aWQgaGFuZGxlX3NlZ3YoaW50IHBpZCwgc3RydWN0IHVtbF9wdF9yZWdzICpyZWdzKQ0KPiDCoHsN
Cj4gwqAJZ2V0X3NrYXNfZmF1bHRpbmZvKHBpZCwgJnJlZ3MtPmZhdWx0aW5mbyk7DQo+IC0Jc2Vn
dihyZWdzLT5mYXVsdGluZm8sIDAsIDEsIE5VTEwpOw0KPiArCXNlZ3YocmVncy0+ZmF1bHRpbmZv
LCAwLCAxLCBOVUxMLCBOVUxMKTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIHZvaWQgaGFuZGxl
X3RyYXAoaW50IHBpZCwgc3RydWN0IHVtbF9wdF9yZWdzICpyZWdzKQ0KPiBAQCAtNDg5LDcgKzQ4
OSw3IEBAIHZvaWQgdXNlcnNwYWNlKHN0cnVjdCB1bWxfcHRfcmVncyAqcmVncykNCj4gwqAJCQkJ
CWdldF9za2FzX2ZhdWx0aW5mbyhwaWQsDQo+IMKgCQkJCQkJCcKgwqAgJnJlZ3MtPmZhdWx0aW5m
byk7DQo+IMKgCQkJCQkoKnNpZ19pbmZvW1NJR1NFR1ZdKShTSUdTRUdWLCAoc3RydWN0IHNpZ2lu
Zm8gKikmc2ksDQo+IC0JCQkJCQkJwqDCoMKgwqAgcmVncyk7DQo+ICsJCQkJCQkJwqDCoMKgwqAg
cmVncywgTlVMTCk7DQo+IMKgCQkJCX0NCj4gwqAJCQkJZWxzZSBoYW5kbGVfc2VndihwaWQsIHJl
Z3MpOw0KPiDCoAkJCQlicmVhazsNCj4gQEAgLTQ5Nyw3ICs0OTcsNyBAQCB2b2lkIHVzZXJzcGFj
ZShzdHJ1Y3QgdW1sX3B0X3JlZ3MgKnJlZ3MpDQo+IMKgCQkJCWhhbmRsZV90cmFwKHBpZCwgcmVn
cyk7DQo+IMKgCQkJCWJyZWFrOw0KPiDCoAkJCWNhc2UgU0lHVFJBUDoNCj4gLQkJCQlyZWxheV9z
aWduYWwoU0lHVFJBUCwgKHN0cnVjdCBzaWdpbmZvICopJnNpLCByZWdzKTsNCj4gKwkJCQlyZWxh
eV9zaWduYWwoU0lHVFJBUCwgKHN0cnVjdCBzaWdpbmZvICopJnNpLCByZWdzLCBOVUxMKTsNCj4g
wqAJCQkJYnJlYWs7DQo+IMKgCQkJY2FzZSBTSUdBTFJNOg0KPiDCoAkJCQlicmVhazsNCj4gQEAg
LTUwNyw3ICs1MDcsNyBAQCB2b2lkIHVzZXJzcGFjZShzdHJ1Y3QgdW1sX3B0X3JlZ3MgKnJlZ3Mp
DQo+IMKgCQkJY2FzZSBTSUdGUEU6DQo+IMKgCQkJY2FzZSBTSUdXSU5DSDoNCj4gwqAJCQkJYmxv
Y2tfc2lnbmFsc190cmFjZSgpOw0KPiAtCQkJCSgqc2lnX2luZm9bc2lnXSkoc2lnLCAoc3RydWN0
IHNpZ2luZm8gKikmc2ksIHJlZ3MpOw0KPiArCQkJCSgqc2lnX2luZm9bc2lnXSkoc2lnLCAoc3Ry
dWN0IHNpZ2luZm8gKikmc2ksIHJlZ3MsIE5VTEwpOw0KPiDCoAkJCQl1bmJsb2NrX3NpZ25hbHNf
dHJhY2UoKTsNCj4gwqAJCQkJYnJlYWs7DQo+IMKgCQkJZGVmYXVsdDoNCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L3VtL29zLUxpbnV4L21jb250ZXh0LmMgYi9hcmNoL3g4Ni91bS9vcy1MaW51eC9t
Y29udGV4dC5jDQo+IGluZGV4IGU4MGFiN2QyODExNy4uZDJmM2E1OTViNGVmIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3g4Ni91bS9vcy1MaW51eC9tY29udGV4dC5jDQo+ICsrKyBiL2FyY2gveDg2L3Vt
L29zLUxpbnV4L21jb250ZXh0LmMNCj4gQEAgLTQsNiArNCw3IEBADQo+IMKgI2luY2x1ZGUgPGFz
bS9wdHJhY2UuaD4NCj4gwqAjaW5jbHVkZSA8c3lzZGVwL3B0cmFjZS5oPg0KPiDCoCNpbmNsdWRl
IDxzeXNkZXAvbWNvbnRleHQuaD4NCj4gKyNpbmNsdWRlIDxhcmNoLmg+DQo+IMKgDQo+IMKgdm9p
ZCBnZXRfcmVnc19mcm9tX21jKHN0cnVjdCB1bWxfcHRfcmVncyAqcmVncywgbWNvbnRleHRfdCAq
bWMpDQo+IMKgew0KPiBAQCAtMzEsMyArMzIsMTQgQEAgdm9pZCBnZXRfcmVnc19mcm9tX21jKHN0
cnVjdCB1bWxfcHRfcmVncyAqcmVncywgbWNvbnRleHRfdCAqbWMpDQo+IMKgCXJlZ3MtPmdwW0NT
IC8gc2l6ZW9mKHVuc2lnbmVkIGxvbmcpXSB8PSAzOw0KPiDCoCNlbmRpZg0KPiDCoH0NCj4gKw0K
PiArdm9pZCBtY19zZXRfcmlwKHZvaWQgKl9tYywgdm9pZCAqdGFyZ2V0KQ0KPiArew0KPiArCW1j
b250ZXh0X3QgKm1jID0gX21jOw0KPiArDQo+ICsjaWZkZWYgX19pMzg2X18NCj4gKwltYy0+Z3Jl
Z3NbUkVHX0VJUF0gPSAodW5zaWduZWQgbG9uZyl0YXJnZXQ7DQo+ICsjZWxzZQ0KPiArCW1jLT5n
cmVnc1tSRUdfUklQXSA9ICh1bnNpZ25lZCBsb25nKXRhcmdldDsNCj4gKyNlbmRpZg0KPiArfQ0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdW0vc2hhcmVkL3N5c2RlcC9mYXVsdGluZm9fMzIuaCBi
L2FyY2gveDg2L3VtL3NoYXJlZC9zeXNkZXAvZmF1bHRpbmZvXzMyLmgNCj4gaW5kZXggYjZmMjQz
N2VjMjljLi5hYjVjOGU0NzA0OWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3VtL3NoYXJlZC9z
eXNkZXAvZmF1bHRpbmZvXzMyLmgNCj4gKysrIGIvYXJjaC94ODYvdW0vc2hhcmVkL3N5c2RlcC9m
YXVsdGluZm9fMzIuaA0KPiBAQCAtMjksNCArMjksMTYgQEAgc3RydWN0IGZhdWx0aW5mbyB7DQo+
IMKgDQo+IMKgI2RlZmluZSBQVFJBQ0VfRlVMTF9GQVVMVElORk8gMA0KPiDCoA0KPiArI2RlZmlu
ZSBfX19iYWNrdHJhY2tfZmF1bHRlZChfZmF1bHRlZCkJCQkJCVwNCj4gKwlhc20gdm9sYXRpbGUg
KAkJCQkJCQlcDQo+ICsJCSJtb3YgJDAsICUwXG4iCQkJCQkJXA0KPiArCQkibW92bCAkX19nZXRf
a2VybmVsX25vZmF1bHRfZmF1bHRlZF8lPSwlMVxuIgkJXA0KPiArCQkiam1wIF9lbmRfJT1cbiIJ
CQkJCQlcDQo+ICsJCSJfX2dldF9rZXJuZWxfbm9mYXVsdF9mYXVsdGVkXyU9OlxuIgkJCVwNCj4g
KwkJIm1vdiAkMSwgJTA7IgkJCQkJCVwNCj4gKwkJIl9lbmRfJT06IgkJCQkJCVwNCj4gKwkJOiAi
PXIiIChfZmF1bHRlZCksCQkJCQlcDQo+ICsJCcKgICI9bSIgKGN1cnJlbnQtPnRocmVhZC5zZWd2
X2NvbnRpbnVlKSA6OgkJXA0KPiArCSkNCj4gKw0KPiDCoCNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvdW0vc2hhcmVkL3N5c2RlcC9mYXVsdGluZm9fNjQuaCBiL2FyY2gveDg2L3VtL3No
YXJlZC9zeXNkZXAvZmF1bHRpbmZvXzY0LmgNCj4gaW5kZXggZWU4OGY4ODk3NGVhLi4yNmZiNDgz
NWQzZTkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3VtL3NoYXJlZC9zeXNkZXAvZmF1bHRpbmZv
XzY0LmgNCj4gKysrIGIvYXJjaC94ODYvdW0vc2hhcmVkL3N5c2RlcC9mYXVsdGluZm9fNjQuaA0K
PiBAQCAtMjksNCArMjksMTYgQEAgc3RydWN0IGZhdWx0aW5mbyB7DQo+IMKgDQo+IMKgI2RlZmlu
ZSBQVFJBQ0VfRlVMTF9GQVVMVElORk8gMQ0KPiDCoA0KPiArI2RlZmluZSBfX19iYWNrdHJhY2tf
ZmF1bHRlZChfZmF1bHRlZCkJCQkJCVwNCj4gKwlhc20gdm9sYXRpbGUgKAkJCQkJCQlcDQo+ICsJ
CSJtb3YgJDAsICUwXG4iCQkJCQkJXA0KPiArCQkibW92cSAkX19nZXRfa2VybmVsX25vZmF1bHRf
ZmF1bHRlZF8lPSwlMVxuIgkJXA0KPiArCQkiam1wIF9lbmRfJT1cbiIJCQkJCQlcDQo+ICsJCSJf
X2dldF9rZXJuZWxfbm9mYXVsdF9mYXVsdGVkXyU9OlxuIgkJCVwNCj4gKwkJIm1vdiAkMSwgJTA7
IgkJCQkJCVwNCj4gKwkJIl9lbmRfJT06IgkJCQkJCVwNCj4gKwkJOiAiPXIiIChfZmF1bHRlZCks
CQkJCQlcDQo+ICsJCcKgICI9bSIgKGN1cnJlbnQtPnRocmVhZC5zZWd2X2NvbnRpbnVlKSA6OgkJ
XA0KPiArCSkNCj4gKw0KPiDCoCNlbmRpZg0KDQpJbnRlbCBEZXV0c2NobGFuZCBHbWJIDQpSZWdp
c3RlcmVkIEFkZHJlc3M6IEFtIENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQ0K
VGVsOiArNDkgODkgOTkgODg1My0wLCB3d3cuaW50ZWwuZGUNCk1hbmFnaW5nIERpcmVjdG9yczog
U2VhbiBGZW5uZWxseSwgSmVmZnJleSBTY2huZWlkZXJtYW4sIFRpZmZhbnkgRG9vbiBTaWx2YQ0K
Q2hhaXJwZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOiBOaWNvbGUgTGF1DQpSZWdpc3Rl
cmVkIE9mZmljZTogTXVuaWNoDQpDb21tZXJjaWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVu
Y2hlbiBIUkIgMTg2OTI4Cg==


