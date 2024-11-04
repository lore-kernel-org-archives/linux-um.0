Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C103D111BB
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wr+8MN61stYjHtgdG5FHrocVpyjA3BSJXm66gV0vLjY=; b=ihR+mtRoNTFCKjlGqEnUEx68zT
	o3pSdVdR0u4gb/TWCaDlbL0ufmUSYLhhCqD3KJvoZjzIyNnKkSMOV91fG23Glh0OnAXq0WFwigOKB
	dmpOWzmyMXMKnBv+xQQDPdimBoBQSSDc0m6KWLyTVACvGlzR+Asquyb+RYGELelSgVUUJY8QnXs7I
	AlSNg95LaO9chCPkRvmsQxEdw3a1MGzzvNDxJbhGcOXhVkXx1Y4/x3LzvZniEKQwFcteB7SmEcTJD
	2Id6bCTOOU9YrdUr4NgvazAnr4vbwpA37COiTIDgeeLxk1UjNP3vhX3L+yfmJ9aDSogUroFIuWjWB
	EGkWqKvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7sH2-0000000Cwdk-1xu0;
	Mon, 04 Nov 2024 08:17:20 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7sH0-0000000CwdJ-1Gjl
	for linux-um@lists.infradead.org;
	Mon, 04 Nov 2024 08:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730708238; x=1762244238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=Wr+8MN61stYjHtgdG5FHrocVpyjA3BSJXm66gV0vLjY=;
  b=kDwt2NfzjDBZQ7GkG285bZkr4m1ggLzCI723PhFkzj70nWgaVT037dzp
   6ANvq8MCpmO7vWCo7Lq1/PGouns8x35nH6ksbjtFsbijR68rvQ48JkBXb
   1yHsrgq0EYs5YyhUke3k7NJesmAwgbbWwe4Z7AWketO9t7fDDi5RXKaPx
   qAEZg0evMvUCRNQJ+cQKx9Brt9uv5cQkH7KgcbDYMYkDbp7cFbtWMYpJL
   x+y6qtLJa7eS65IFn1FNt5QjmybsBz2imbtJKmAMqafPJ+0HHE1qBneWw
   ar0lh8VOfZI3trS1a1ywRWCC9mjD3Hkcyeqhhj5qLxUqAxBIyRiCcFtuA
   g==;
X-CSE-ConnectionGUID: pN6BADIYSEicxKZtpxuYqw==
X-CSE-MsgGUID: +0YEP4FLRs+K3127YCMG2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29808451"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="29808451"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:17:16 -0800
X-CSE-ConnectionGUID: JK1AJElbRgmOXX0EHdNx5A==
X-CSE-MsgGUID: ISJqJfk+QtauuYkUCMVXAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88340422"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 00:17:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 00:17:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 00:17:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 00:17:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLCP9kFW7vllH74O87eOVhvEUmvUfPsLChJh74zndDT3KW5qJoLid3lYHbBeyO3iNAlL7y+hyA2wyeUHEr+HU8yiWJiFvb7xvch/qLKDkgdLDOP/kAJSbzvZaEPgljQKIqvhBCHtavUk5h/x+p0Wa0XRmsoEQv11Y4waiZv1Dr4RX4/QcGTxQBPtPvFSfW/OT3LqfIX/p14+mS7/vS6e03qiQYUlNIZ28/Nm/pTJs8n19u7pMbFS5Vu1PrR4thscG6x2F5YX6vM1jv9jcRjRJPdpVRduaTmsJAOxvF0x0Ib/m2hg32N9tIDz5mhbEnt7rb6UFF/SzvNUheBeGnYLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtDzRuXGussYD+YlwaLhtnkZ/jaVzFV0atIVb+uWKa0=;
 b=W1Bc5lXCqXKMKwcB0MULik8QU2oepelV+HOHIkDpyzrkDgT+Cw5N+D9e6lY/kv3Pkjy/9Vc3uE5xXG00xlSZOwKoDTSfUyZc3WRzh7LO9kGkDojCTSW/OAk8iEhR6TTkaZZAzmwI+ZUWZMM4/RzTLmSA0VYQMHzuDfvgzPbR/ZgkMgzwY2A310/G2WmAaHnAAsl6iFZt1CMn0GETCmXwHT1bxNjvgcTkONyuS0HKp+vtZ0Jrl5mmrmzFCKlD3fSNELR9yax3/lJPhbNd2Fhpxojs+YyETCwbJj5rgD4pLZfaKvVqZTuZHjexQQXG18ylZp96JH2XEQvApDGLQljyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by MW5PR11MB5906.namprd11.prod.outlook.com (2603:10b6:303:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:17:07 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:17:06 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "thehajime@gmail.com" <thehajime@gmail.com>
CC: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Subject: Re: [PATCH] um: move thread info into task
Thread-Topic: [PATCH] um: move thread info into task
Thread-Index: AQHbLgHi1FG7cJy2vkOG3N8PAZw6o7KmxYWAgAACUQA=
Date: Mon, 4 Nov 2024 08:17:05 +0000
Message-ID: <083d8c0460d4774698a972102f893f92770a4b0d.camel@intel.com>
References: <20241103150534.1368018-1-benjamin@sipsolutions.net>
	 <m2ldxzh14i.wl-thehajime@gmail.com>
In-Reply-To: <m2ldxzh14i.wl-thehajime@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|MW5PR11MB5906:EE_
x-ms-office365-filtering-correlation-id: ef8e5517-7907-41e2-6e56-08dcfca911ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bG5DUCtKTlZ6TWRXLzE4dE5wUlpWd1NZWGZWSk1uNy9xVFFrTERtU1B0QzNo?=
 =?utf-8?B?UEVIVng0QnZoblppbk1QVmlCcWRUNmF3K2gzbDNDU2tUYWJ6N0l1Yk41Y0xv?=
 =?utf-8?B?Tm8ySU5QR1N0WDZnQksvSnlVSVUvZWZGeU5jbDBBMUlmaXE4YktUWFdlZkw4?=
 =?utf-8?B?cXN5OTVJak5lVi9nNndGU2UvUUMrMlFhVmR5c1EvVG00NkhoWXNZZytYaktE?=
 =?utf-8?B?VGJKTHhReWFwTjF3a1RsL0tUVGtwSS9za3B5ajQ5MFlvNnVRaEVsNE5RUXMw?=
 =?utf-8?B?WHp0cmRGUnlpV2V1TEw2cEZPWjFDNHd1VkZiREVlWHpBTkFmV2k2VDc0Z0px?=
 =?utf-8?B?QjZOVVlJeTJPSFVQT2ZEOU0yWDErajlYY1VWY1NrM1RTamJtQVNyYTRhY054?=
 =?utf-8?B?b253bUJOQjRaRkVJK290SitEb0RKb0E4SytYT21PYzlVeGNpMTd2MWdaYS95?=
 =?utf-8?B?MWVxaytteGszV2Njd3F0cHJxQmdpYW1nU3p3RUN4TnljWmFPLzZTYnlTZU91?=
 =?utf-8?B?UDlQNTlHOUl1L0tLSDBuaXFuZXVCcFE5RS9EbFI5ajBuQzIxMDNuSmhlSnNP?=
 =?utf-8?B?dnN4S3lCdnp1anVIdWd3UGNackt2cUNOQ1hENEpKMmFRYTZUQm5ka3IvTnJF?=
 =?utf-8?B?MkdhS20xbWVIbFplaThCY1U2REVBdGNnbjdjVWdkMTNtWEFFWWZNalRvaU5H?=
 =?utf-8?B?NmR3Vk1TM2JMcmxweEVxWXRXNmZUcDkwRlhPVlV3dFhNS01UTk85blBYY3B4?=
 =?utf-8?B?YnRFamZUWE03NlZiWXl2NzZYL1FoODFXWmRzZzE0NElzWmNyaHJ2RG9CeW1E?=
 =?utf-8?B?UC9TMlhScFJMenlTMWJ1RGwrYnIwT1NoU1V2UkZxUUFjRm9hSEFJSVUyZmk5?=
 =?utf-8?B?UU5Wbis5aFV6ZGpyU0NqOGl5T3N0VnRuSlNZbzlwSFRkam5LZ3ZXSFNlaWdp?=
 =?utf-8?B?SkZzM0FpcGora2JkV014K2N0WGtsYktkVWlyYmcwSVpwMVo5a0F5czNhMHp6?=
 =?utf-8?B?N1YyMkJ0eHgwNXUwMFlWQzJwc0h5dnFXa0tremM3cWxlTEdHZFNJVFVuQWxE?=
 =?utf-8?B?cDBQRFRwMUVtU3JnMUJzVmpta0pYTzBpOWV0a2cwNlZVNE14T1BwRkE5K3hT?=
 =?utf-8?B?SmU1ejZySUVqcXdaWUZIMGxaQVEvWENvc09wNDJoQVlmNW5YV016NmdFeUk1?=
 =?utf-8?B?WVZlaDVIRmQvUTFURnlOMDVGTkcwaWE1NlVCODc4SC8zZ2IyMWhHYlluQjEy?=
 =?utf-8?B?UzdTNjhJTlE1NmYyL1lMMWM5b3BGalF5aWZ1R0ltaHQ0dWZRb2dvdkRnSjFr?=
 =?utf-8?B?YTVBRUdtWm5YSGxHVmNYYktOR3o4aFBJMmF6RmRocm9RZFAzQm9sOHgzZVRD?=
 =?utf-8?B?TlVGaXJpZnRTcm5NVityZWVGTXhjbW53emMwb1M1UlRRNURPZ1Y3RmVISFYx?=
 =?utf-8?B?V1pJK09rQ2xGODMwYW4zQTlVUjhRbnhFaE5iSFhiMk16ZTNzeVloUjJKZE5l?=
 =?utf-8?B?RHRNdS9OTUZtRWZ3OWU0eHkvRHEwMS82TUFnQWJLYVlwSVpCbkRwc1B6eW5i?=
 =?utf-8?B?ci9BNnBsRUpLazhseG5tOU1OOUZIU3d1THZNeG5uUE5PSlZnNGd2VXJsY2Jx?=
 =?utf-8?B?NU82LzQ4TzUwR015VEZhWnVJUjE0NWJ6UGpZQU5LK1orbmxoVGdvZEtTSXVM?=
 =?utf-8?B?bkhza0YyTVJVbmJMR2IyNExOZnQ5UmxZZi9FcVBlY09DdklheDhPNDZBRDA4?=
 =?utf-8?B?OEl5ZUZnUDdYbG1XT290enBKUmNqTWJaVk1VY1pLVUZ0bHB0K3JFT2t1L0Fi?=
 =?utf-8?Q?AtPQ10MpyaVZdvw8UPosmmlxLHHvSdBslOj68=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU93WE5Ybi9kb1g4VGVaM1VaU3R6cFB5Ni9saVErbHVXSGpRR1Z2SHNPQnhU?=
 =?utf-8?B?MG9wRVBDVDlzQXV5aUxpbks4ZkpLd2ZKS3lyNHhJMEY4NldlUmZvUkVDOVFX?=
 =?utf-8?B?TDBtS3NtVmwyUWVwM2dJbVFwOHZXU3EybXdqY0pFcXpaYmRDc0p0NGczUjd2?=
 =?utf-8?B?VUlQN3BHL1BxMElGRVlYMjRDRDRveDBvdUhTS1V5VWhqKzZReXROQ0QzaE1L?=
 =?utf-8?B?c3VweDEzQmVENEhjQ0RyK2dPVUNMcTk1eTlBQjI3bXN3RVphRGFXRktpNDJ1?=
 =?utf-8?B?eEVPWUdtRXVqQytxRVM3VkMwQzZmd3A1OTdkRk5ackxZSkNwcVI0NFFZTlMz?=
 =?utf-8?B?MW0vZXpJOHhZYUg2UkZ3U29Wa2RNUnM4RlNmKzVSVWE0WGd0Wkhrb0tKN002?=
 =?utf-8?B?S0psVlkwTGZEemo0eTZLa3puamhlbGgvaHhHcDZ3ZVVpK29GQ1ZxdnR2YlRK?=
 =?utf-8?B?SkhQcWQyNFIxNWVnTVMxMG95TDE5dzlqQzhZaU9qUm4yTjNpbGwzTE1ZWnhv?=
 =?utf-8?B?M1crZmR3TzJtMVoxbFpIRERienhQNGNrT2RKZ1Myd25ySGNsNUE4SHBWWUY2?=
 =?utf-8?B?OFVvWHVQK0FQdGdwYTBoczdXZXp5OU9tdm9Lem5yNzFEVzRNY0pUWW1BK0J5?=
 =?utf-8?B?RUlXNTRJZzRnTmI5c3lBNmllSk5Pem0yc2JTcFpicHRDSWQzUnoyc0xzOGhr?=
 =?utf-8?B?d1R5U3NhdGVWaitHNkJUSFZjNlF4TkpRYkRZQ0RPQ3FuWmNRWkVKSFFjV1Zq?=
 =?utf-8?B?UmRSK295bStZZUs3ZEhnN0xhdWpPaVIxUlZCYy9BWllaanhyb204aEpDWnJ1?=
 =?utf-8?B?Nmw3SVZlcWE0cm0zV2lUSDlzWTlPU2pyMll4UWZUZC83azVyd2VBQzFlNHZZ?=
 =?utf-8?B?RFg4bnU4RDZ1WS9FR29uVlNVZ2hmNlRrTVR3L1pDekFLL3g4NXBONGloTkp0?=
 =?utf-8?B?STRVSmsybTZ1RXVpUmw3ZlhRNUdTVGx4VmZBbEQrY2k2N0tjbXUvQjJnM21I?=
 =?utf-8?B?RkFrdzZxMjBhcjUzbEV6SlNaY0hDUk5xWnFCdXliaTFQa1VPRkVFSjNjbEhH?=
 =?utf-8?B?RVNwRU9qMjVEU2lPcHMwL2lDRytwcVVINWlPT28vODcyZlI0dCtMWmUvaFNJ?=
 =?utf-8?B?a1pEcEhXZHJZMzBHcmVkbEJJZW1hV2Z6SFMvc0hpRmZOdUQ4Y1JRb0JWQW5z?=
 =?utf-8?B?bDJndFAzNWVaZnNmNjJndm9UTER6TTZrMWZQdkNkUTdTS1YyQWlmSFJXN1hS?=
 =?utf-8?B?SlRLS1piRTNpVE5wc2dkamQ4MkN6a3V5dGQ4OHo5ei8raXlBNW9BMEtvN3NC?=
 =?utf-8?B?Zzd3b0NZU2JmdnYwaFVLM0t3QmNpN0YzUUYrckVvRHZPZStaZFEySkJvN0ZS?=
 =?utf-8?B?YUZpZE5RUHpHYnQ1YllGK2ptb3VrbVpDR2t5ZkVoNTRyOWVzN0tIbDVzM05J?=
 =?utf-8?B?MnFVTjROWUtEMXpJZTJWbnFZVHFHMTgyTHhXMmFBcjEzeGd6dFpMTlRCSHU2?=
 =?utf-8?B?MXJsYWZ2MjVMekhRS1pBQ3orKzB0S1VQZjAwZ1dkcmFMbXVRT3E0ZUZ2Q0kz?=
 =?utf-8?B?R2s2NFBDTEtxVmkzVmRsdlY0TlE3YmFnZDlCKzJMUERzL1ZHSjh1QTZOcXFP?=
 =?utf-8?B?bkNobi8rdWJ3TTFicWtBQ0pJRHdKd00zanNPNmxheEw5Q0U0aVdRQ2dCSFp4?=
 =?utf-8?B?NGlTVldYMHFjeDdlU3N4bWF3VGl5czlKaUxXVkkzNEhudUkzY042RTdpZk5T?=
 =?utf-8?B?S2RwWWQrenpTdWxqNGZpUmZRS205UWNKNXp4dXRPTU1pbDJiS0NyMGtpRkh4?=
 =?utf-8?B?My9LOStzVzBQdk1wN1phM2pwQy9qRU5UNFNpMkJNM05OenZIQjVSaEVUMGNt?=
 =?utf-8?B?bkhuaUc3WWI2S2Uvbzc4UU96NGRmUENSb0t6MEZMN1NHbUZIRmJmckNxQ2pl?=
 =?utf-8?B?bGJxMEFvTFBjSzJsSUdIQkpsdThSaFJBazRRd2dHSWU1M3ZNMkRzVzE4QkNk?=
 =?utf-8?B?eDIzZ1ViNmwyNHlLVGk0bmdkWGNISFVzWHVpM1g2NjNpL2tqUlB1Y1NTK0Nv?=
 =?utf-8?B?ekZyMlMyd0ZlZXIreWYyQ0xOakJwbkxRby9DVkZFVllRUGxqenBmaVZ0amVU?=
 =?utf-8?B?SllnUFhZeGZ4R3VyMjR2Yk9kb0o1dk0zenhBOElLSTV3cnJwZXpWVG05N01Y?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66C7BE8CEB3F654DB1D73DEA1080210E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8e5517-7907-41e2-6e56-08dcfca911ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 08:17:05.9808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOEr0quupBbUeCUV8VR45ZO1cKCTQ8Vv7pduk1rVBvJGrzM0hhKgWNUL4mTGL77z2GScoscJnxtXHA3Xe4Pc7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5906
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_001718_427093_FE63F101 
X-CRM114-Status: GOOD (  20.63  )
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

SGksDQoNCk9uIE1vbiwgMjAyNC0xMS0wNCBhdCAxNzowOCArMDkwMCwgSGFqaW1lIFRhemFraSB3
cm90ZToNCj4gdGhpcyBpcyBhIGdyZWF0IGNsZWFuIHVwIEkgdGhpbmsuDQo+IEkndmUgYWxzbyBh
cHBsaWVkIG15IHRlbnRhdGl2ZSBub21tdSBwYXRjaCBhbmQgd29ya3MgZmluZSB3aXRoIG1pbm9y
DQo+IG1vZGlmaWNhdGlvbnMuDQo+IA0KPiBPbiBNb24sIDA0IE5vdiAyMDI0IDAwOjA1OjM0ICsw
OTAwLA0KPiBCZW5qYW1pbiBCZXJnIHdyb3RlOg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC91
bS9pbmNsdWRlL2FzbS9jdXJyZW50LmgNCj4gPiBiL2FyY2gvdW0vaW5jbHVkZS9hc20vY3VycmVu
dC5oDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjkz
ZWU4OWU1NjM3Mg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNoL3VtL2luY2x1ZGUv
YXNtL2N1cnJlbnQuaA0KPiA+IEBAIC0wLDAgKzEsMjQgQEANCj4gPiArLyogU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gPiArI2lmbmRlZiBfX0FTTV9DVVJSRU5UX0gNCj4g
PiArI2RlZmluZSBfX0FTTV9DVVJSRU5UX0gNCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9j
b21waWxlci5oPg0KPiA+ICsNCj4gPiArI2lmbmRlZiBfX0FTU0VNQkxZX18NCj4gPiArDQo+ID4g
KyNpbmNsdWRlIDxhcy1sYXlvdXQuaD4NCj4gDQo+IHdpdGggdGhpcyBpbmNsdWRlLCBJIGd1ZXNz
IDxnZW5lcmF0ZWQvYXNtLW9mZnNldHMuaD4gaXMgbm93IGluIGENCj4gY2lyY3VsYXIgZGVwZW5k
ZW5jeS4NCj4gDQo+IGFmdGVyIG9ubHkgYXBwbHlpbmcgdGhpcyBwYXRjaCBvbnRvIHVtbC9uZXh0
LCBhbmQgbWFrZSBtcnByb3Blcg0KPiBBUkNIPXVtLCBJIGNhbm5vdCBidWlsZCBVTUwga2VybmVs
IHdpdGggZGVmY29uZmlnLg0KDQpPaC4gUHJvYmFibHkgdGhlIGVhc2llc3QgaXMgdG8ganVzdCBn
ZXQgcmlkIG9mICJzdHJ1Y3QgY3B1X3Rhc2siIGFuZA0KdGhlbiBjb3B5IHRoZSBkZWZpbml0aW9u
IG9mIGNwdV90YXNrcyBvdmVyLiBpLmUuDQoNCiAgZXh0ZXJuIHZvaWQgKiBjcHVfdGFza3NbXTsN
Cg0KYXQgdGhhdCBwb2ludC4NCg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3VtL29zLUxpbnV4L3Np
Z25hbC5jIGIvYXJjaC91bS9vcy1MaW51eC9zaWduYWwuYw0KPiA+IGluZGV4IDE5NzhlYWE1NTdl
OS4uODdkMzFhMDY3MmMwIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvdW0vb3MtTGludXgvc2lnbmFs
LmMNCj4gPiArKysgYi9hcmNoL3VtL29zLUxpbnV4L3NpZ25hbC5jDQo+ID4gQEAgLTE4Niw0NyAr
MTg2LDE0IEBAIHN0YXRpYyB2b2lkICgqaGFuZGxlcnNbX05TSUddKShpbnQgc2lnLA0KPiA+IHN0
cnVjdCBzaWdpbmZvICpzaSwgbWNvbnRleHRfdCAqbWMpID0gew0KPiA+IMKgCVtTSUdVU1IxXSA9
IHNpZ3VzcjFfaGFuZGxlciwNCj4gPiDCoH07DQo+ID4gwqANCj4gPiArZXh0ZXJuIGNoYXIgY3B1
MF9pcnFzdGFja1tdOw0KPiA+ICsNCj4gDQo+IG1heWJlIHRoaXMgbGluZSBpc24ndCBuZWVkZWQg
Pw0KDQpPb3BzLCB5ZXMuIEluaXRpYWxseSBJIHRob3VnaHQgSSBzdGlsbCBuZWVkZWQgdG8gZGV0
ZWN0IG5lc3RlZCBzaWduYWxzLg0KVGhhdCBpcyBhIGxlZnRvdmVyIG9mIGRvaW5nIHRoYXQgYnkg
aW5zcGVjdGluZyB0aGUgc3RhY2sgcG9pbnRlciBpbiB0aGUNCm1jb250ZXh0IHJlZ2lzdGVyIHNl
dC4NCg0KQmVuamFtaW4NCkludGVsIERldXRzY2hsYW5kIEdtYkgNClJlZ2lzdGVyZWQgQWRkcmVz
czogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55DQpUZWw6ICs0OSA4OSA5
OSA4ODUzLTAsIHd3dy5pbnRlbC5kZQ0KTWFuYWdpbmcgRGlyZWN0b3JzOiBTZWFuIEZlbm5lbGx5
LCBKZWZmcmV5IFNjaG5laWRlcm1hbiwgVGlmZmFueSBEb29uIFNpbHZhDQpDaGFpcnBlcnNvbiBv
ZiB0aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUNClJlZ2lzdGVyZWQgT2ZmaWNlOiBN
dW5pY2gNCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11ZW5jaGVuIEhSQiAxODY5
MjgK


