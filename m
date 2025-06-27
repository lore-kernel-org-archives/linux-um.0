Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD74EC7EE31
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfHDt2PUQ2d+B2WppJv5z4fKd0KeqF5YG/bA5TNR8Js=; b=DYSAjaJ2/nzW24L/9EBtNBOi1a
	xZg0bWwSt07zs69VksxXuHji8WETSNrNMYHm3NZGe5TnEC2d/TRaOmtI8Ix6PokIjnZBYWNb2CwSZ
	PGYLNWAiNyjyw0VUFOBW9ehWtHRA+2m8GpLMwmIsZUWMMVWvy+nRw5ivspe19FH2ZTVoNH/OjKndH
	TmXRTZY6e5f3Grv5OogIUm8fOMaGYh2Hha7S1v72o+2lPKyoqqjrWkM95t+vO9yxNylzkv7/8ttXy
	EQXS5YHD2F1bVEPTwx/l530N3R5HMYywrbSIfSvTwePir1LHRwokMzdyRYi3LOFslEk6f9W6K0bOT
	cmu3BC2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4GZ-0000000Dvub-0pNd;
	Fri, 27 Jun 2025 08:16:59 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4EM-0000000Dvk3-2w9W
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 08:14:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751012083; x=1782548083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=cfHDt2PUQ2d+B2WppJv5z4fKd0KeqF5YG/bA5TNR8Js=;
  b=h+bIprwjPhSq24cS7ZSg8zxzs7X3qVg4RYyG1Lh4orsxQKGUUrXdTB1Q
   XTdF205gGWMX7T25YzvFFNjHImXRE/r5hl1emZIIUpkFM5iKvfAHDMU5h
   SAzjNW1kpN5deNiaLr3tdlBcvAujirGjWQma0BUBB79FKDa1/4EfHl4uT
   j7efYxyp+Fz4ZmxLtok/toxITKI1SVJALxB5A2cNCOFj0lApwBYyUDJLI
   lQWbRiOhL+ZK23cgTWf5kJtZoc93T8ONtxO6VDeh9OXPbtSr6Q4iCIP1+
   0vZOMgE3ayW7gcNhHk0JH1qHrTLiEVmO0GseXcuHrQmfhs487Jsxs0D3C
   w==;
X-CSE-ConnectionGUID: SSQJNZrKQuiFIf/HYzYzcg==
X-CSE-MsgGUID: KcWQmv/3RPWSXPqFWG3RFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57127448"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="57127448"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 01:14:42 -0700
X-CSE-ConnectionGUID: ta7HaBWFTCqRfOmFoZW/Bg==
X-CSE-MsgGUID: 8DqaZxJjTKeW5Y5SxahXKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="157029521"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 01:14:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 01:14:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 01:14:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 01:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDEy0yPsBL7epcgn+CtK11Yar5mT+XdEACJ6pVaVNzdHPByJiog9azUUC77aA0zPMlrmQP/qUS8igSZYpklMVD2R382HNYxSDXEP8yzxCWBZ9oI9rPCHg3/4kA+JTdbk4CwFTvRpUqx1K2sO3QhT4ljNTWnLLxz4o6AY7uQmSycJK5WgmpbB3fQCgLcRqyKGTPbPQxTt7nkKf8DcPYHyeCE2nr7CZaUYfZBdXNuD18PkjUu2wNANS6/anDGSF1G3PlKqZWsFT0exnaXlIYZWMXDbFv/4cFd/S1EklxcXBc2ZHu+JF4CT/Ywm4K5jsCRDdVrT06CuEbEkhypbo5GRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hig0T76NA0QnmLQtCc/KDRUiu7J7j29N1BI+pu1i4Rs=;
 b=IsmwsQDKCKkjPHO5IBHmUg9U2N/8g8gwDYNAORs9W4FU6Tqa6WAFRlOXlRZmLIRD0PZpQmJr09wmXiS8EvALwPuCVK8jln+DHRPTiO2Iq/JQ52GmWwZSk7NApBmyO6Df+BHnnPaL7x6Y8/BV5W6wmNVlq4zW16NY/iRUv7J+NwbgnOuQgdOx8zLA49Co93D3F0O2aael8HQaMW8sJmgzM5mafmX3AGU524vmVb8sJMB+hPi6gsf3YvdHComvpC+7japtFqCO1ehlSbuRVXGXwmBTBr1AXHJjiPNXRiNVNUMlV/FhPqKpxgaR8hkvEobGVK/HwzdtbaihoT3p8a8Z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by DS0PR11MB7998.namprd11.prod.outlook.com (2603:10b6:8:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 08:14:25 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 08:14:25 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>
CC: "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Subject: Re: [RFC 1/2] tools/nolibc: add sigaction()
Thread-Topic: [RFC 1/2] tools/nolibc: add sigaction()
Thread-Index: AQHb5tTV4jFvFR2ezkyHlME5X0fZmrQWb+aAgAAg+oCAABBSgIAACCAA
Date: Fri, 27 Jun 2025 08:14:25 +0000
Message-ID: <31b32fbb34552e9cfd9e5c427794d6faca3209f7.camel@intel.com>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
	 <20250626195714.2123694-2-benjamin@sipsolutions.net>
	 <20250627063347-cc3c0ad0-7b3b-4bcd-963f-729db103760f@linutronix.de>
	 <f0c27ce58466d790551689b752a33fa0de6235b9.camel@intel.com>
	 <20250627092734-ed8973ef-444f-4996-beee-e0c4f637fc52@linutronix.de>
In-Reply-To: <20250627092734-ed8973ef-444f-4996-beee-e0c4f637fc52@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|DS0PR11MB7998:EE_
x-ms-office365-filtering-correlation-id: 382e5bc9-b30b-4ac0-e890-08ddb552a141
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZnlnREFvUERiWTk2NEgyTy9KeWxkMEVTQnVROEhObHNUN2x0VXBYNllMTEt5?=
 =?utf-8?B?VFY3b2g3Y1A3Z3JkRUIzSFZ1QjZHeHlDYjIvQ0JOODByM2RGNkNlUGR3emNm?=
 =?utf-8?B?NzBEdXRyZ1ZNYUJjZVQwaXlXTk5yL2VYSEZIN1RBTlpYa3F5V1M3ZGNjY2Ir?=
 =?utf-8?B?MnpEOFNPdHZ2SE92Wm9wcW55bnVOUnZudFkyRzgvUit5VDNwdndwYkRBV045?=
 =?utf-8?B?dklLa0tFam0vSHEzWURnMHRrZm1acDdDU2M4S1dkd3ArRlVjcUFaODNhM3FO?=
 =?utf-8?B?YkV4RERaYzM5VytweDRML1REVndGWGNjZzh1ZW1nVklHS0poSzRaNTB4dFNn?=
 =?utf-8?B?M3hHVDlmSXl3NWJRK3REbGxQNGx4SjBOOVNLRG1HdUU2b2prTUJrQVdWUTJ5?=
 =?utf-8?B?bEZWTUNTbUI3THhUcGZObm1sZ2swVTNaWTVZTFpYdTJlWXZkWmlEV0ZlU2xs?=
 =?utf-8?B?bzFjY3FmWXFmcUVvRGMvdHZpTmZTQlRrV1ZyZGhHNG5WUnp3REtEQmRvRUdJ?=
 =?utf-8?B?SGlodzJTSHVMZUtNOFV0bXIyWDR4QnlvNVdGNlV3Z25rUHAyei9FbCsxOWt4?=
 =?utf-8?B?REhueVZqSDlLVFVmemJMck5aSTUzeE1pbG9DeTl1eWswS3VsUTVtRlRHeVNm?=
 =?utf-8?B?UXFPY3BBMVNCOWtwWEtCekRLRUo1NFJSUUFCOVM1MGE3T2ZGOTFhQmwwZXN2?=
 =?utf-8?B?Z1JpU0V4NkcvM1FxeDNqRFllM0NzM0JIbWZqajFhVUpOaFBFajZBT21KMWR3?=
 =?utf-8?B?MnRCVyt4a0VxNTlBcU5zVEFuWCtITDNqOHpaNEJneVpyUlp3eWxFQkQ0Wkdo?=
 =?utf-8?B?aTlhYXpNSnUzNkRmS1NsaWZRTHZlT0V5bHorM0R1dTIrdXQ4cVArTUF0d3JY?=
 =?utf-8?B?V0I5ajl5S0ZudlZ6S2V4aWtGVldJbDM0emFoTTRMMGI4TXVYQmg3djB6WXNj?=
 =?utf-8?B?b2pwSVBGVVNSRGRsTUwxL2lqc3NTc2NrTVZtdUhBZ25VTEs2bXZxVzFNckNU?=
 =?utf-8?B?ZVZTT1dnVzBRVnQrWTMxbGl6TDlNTkNGUXUrOWx0cEViYjhFV1lGdEpEWHhM?=
 =?utf-8?B?azlCcTRuRlVLMTkrV1IrMzRoVFlFZWl6REV2Uzc4UlB3SS9JcS9aZnhscGNx?=
 =?utf-8?B?NGdFRVhBRXBBdHBQREtpZHNFTTlqYUo2dC9CTjJZWkVBREh0d0lwUW4zRHM2?=
 =?utf-8?B?T1VZd1RvVkVrZDhJaExZUGRjeGV3TjQramU5cUhSQ2FkWWNFR3NPTmJNdGc3?=
 =?utf-8?B?Q2J0SDhRS0pidFBLMmx3UFJPbDFVTGdmYnJHQXpibnN6U2wxTmRzVnpnTHZz?=
 =?utf-8?B?anA4Wk5VbzdvY0xkS0hpZmk4YUZQZGY2bjRmSlQwSXlrZ240aUZDeUprQ2s1?=
 =?utf-8?B?Wkx6Vy9yVkkydXBtOHkwa3VpUUIxVDZPblFyd00zbEQ2NzFkVUVkVkk0L3oz?=
 =?utf-8?B?UThjVWhkMHNGMXdhVk1FWWkwcVJheHZhUUtpRGZuZEhOZEN6Z3NqamUyd3lN?=
 =?utf-8?B?bkVEZTB3VWtUQUdGL1pmTEVsTVZrdTVCQmlSVWQ0QU1lYS9IQkdUeXVZblk4?=
 =?utf-8?B?cFNYNEhJcTFuNm1KYTQ5bG4xYUFlbENBbTlYaVQ1RW8vMC9WNVdtVG12U1Vt?=
 =?utf-8?B?MTVmWlN0T2p1YVJQS2ptTENpdXUyK0hweC9yQ295aThKYWQ1MHhGLzA1ZTE4?=
 =?utf-8?B?UGZrcGdBeEh4ai9WKzdOWnhVOGFjdHZKU015dU1ob3N5U3JDUFRCWTBrelBm?=
 =?utf-8?B?bEw0K1BZTURmOVJEN01iTnlHdzBudU1iTytsV2ViZ3NaV1NKT1dlTHo2VU9U?=
 =?utf-8?B?aVdjZ1h4V0dhTytsNVQ2ZytCWkhRSUEra3RlblhjLzRsZW1Odk4wdWNKY1Bv?=
 =?utf-8?B?d3RqdlN5eUQyUmR1b0hkTGNzTzdEeTBHRnpLYmVaclVReWFPMERVZklZRHk0?=
 =?utf-8?B?Ri84R1hPYmsxb2NoWUhTZVIySEg3dEJNaDl0WmhCMzNOVksyb29SRVFNSUxk?=
 =?utf-8?B?Vk5GUllDczZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjFsbzNEUDBDY294RitGL2hTcGpUcXBlYUJjU3ZzVFE0QzYzOHFzOCtiaEgy?=
 =?utf-8?B?QXpVa1FJODNzVVZaaUk4Q2ZUL1k4Y2FWcHRLSC80MVpjUlJkS3JDaU5PQi9N?=
 =?utf-8?B?RTlEeCtTblpXeU5lM1VhNysraHRxV1VaTVhoY0Raclc0VjhSYUpvc2tLUFBq?=
 =?utf-8?B?amZCQUxDSUU2d1lNSFNxZXpRMnpoV1lLUE5JeE90djlEaEpjM3lWV2tVbVBk?=
 =?utf-8?B?bkdGUVVwZzhNVHBHYzVzWkNOTUNsNHpyaHlsM0xpNmRyUFB5anlmUnhUTjIx?=
 =?utf-8?B?NGhPN3FRQlBuUWN5UjI1bmxsazlCdjNYWkJ5ODhPcldiVGpzeEdWTTlHZjlk?=
 =?utf-8?B?UFN1UGgrT20rSVVDaDd3d2Y0K3dCN3c0ajdVS3dNTTBUL0wvQVlPMjI5N1po?=
 =?utf-8?B?OXhrZkh5amNzWWFpb2syOWllZnFtem5UMS8rQy9QNlo4MHYzNS9USm9QRE5j?=
 =?utf-8?B?OEFMcFFoRm5OUHlSRWdRMll4ZHUyTklrRXFhcENzaCszb1pqTERNWmxUZ0Zr?=
 =?utf-8?B?MDRYS0d0YTIwVUdEVGJualZKbStuUjZ6dlpMTmIrNDF2YkVPUVhXZ29lYXRt?=
 =?utf-8?B?ck9oRXJOb2p1MjFVR2djeVJ5WGZtM1ZSRmYwNloxU3pOdjZLYm1VRjhYMGRS?=
 =?utf-8?B?U0sweGl0eXFNY1dBSXlpTkU5WC9pbzhGVWtKZk5IUUVqakxUZEk0SWtUZ2t4?=
 =?utf-8?B?SVV4ekpKRmhPWVRmL0hac2NmVlJ0bHc5ZDB2M1hQWGpKclExVUVWZkVXeW5T?=
 =?utf-8?B?T0xQZXM2aWtsd2FoM3dMaXlkVFZJNkU5dW82WkdQczNuK3FqS3l5dkY2Tm8v?=
 =?utf-8?B?dGprUXBhb1V2eU9NTzArMlp3T29kV0Y4bllEbmVoeXR4Q0FUT1ViY2g4ajUx?=
 =?utf-8?B?SDlMMm1aeXhyeWRlaXl0ekJuU3hCQXozdTZYT2dNdHFHeWhkWDBjNHR0Nk5Y?=
 =?utf-8?B?WFRnQlVVbi9DSGxzWEVGOFBmUzY0WWVkc294NlJNTFRuQ29jUFhUUXF6b1Z1?=
 =?utf-8?B?RFB5cWR6NURGck5Icm5pWnJEU0tBSHdKd3FpNGtLK1VQYnd4NWdXR0lyTXBo?=
 =?utf-8?B?T0lTSkhOQkhjZGVJamV0MmsvNXhwUjlLeEtuQURxL3cvNTJOeUkzMWx4Yk9h?=
 =?utf-8?B?b3BYd1MzaVpMSlVCT2psRk9mQk93SHo3cnRxKzhKM0NGZm91ejQ2OGZKTWx2?=
 =?utf-8?B?VU5BVERPS084MlR4cUxJeVhHK0tkWkZ2T0ViMmN5NGxCKzBWUjEwRXVJb3Fl?=
 =?utf-8?B?MVY1OTZMSm4yNWpQUjc2aG5Mc1FoSG1rUklZWlRPM1YwQkM3SVMvRXN5Q1Bu?=
 =?utf-8?B?L2hjRGIvS0JqbmNlNk9tZDZyS0t5WXUra3NwbHY3bWpYRnU0dWRYME1pVkJF?=
 =?utf-8?B?cmpVTW12bjlYTVdKWXdpbW9aOFMwc2YxSmNyckdlZFA3TW1QaHhUZldoV29X?=
 =?utf-8?B?MWQ1SXpaTlZOYVliUXZPcWFEeVBncXFoc0RiNjkyL1ZiaENTWmhBcnhHWTRB?=
 =?utf-8?B?SW5RdXhIb1V3VlNKeFAybTRLRDJSeDNoKzA4MEhYekpyN0lxb3lvaGdOMDBv?=
 =?utf-8?B?K3Rmc3NEMGdPdktQVmtqUGNrUWVhV0V5UXl5MHU2dG1PR2pyYmp0UVpMY3pG?=
 =?utf-8?B?Zk42TGdCWnZEZGdkZXJKYzBDdEErWURuUXRlbGtnWGFyTjg3eDYrMnQ4a21H?=
 =?utf-8?B?cnFHd0N1TkpQTTlJSnc0NkNTb0phZEVTU1hnN290WjJsNDNHMGNvMDBxb3hF?=
 =?utf-8?B?WG10cExueVJ3U1VrNmpGUW5QVTlkN1BqY3o0U2oxb09ab09hNkNEVkdtYnh5?=
 =?utf-8?B?TW4wUUJzZVNXWklKK1djUTBid053cUIyUTV2WXZOL0FSa2hUTUhpTnNiNlgy?=
 =?utf-8?B?RHlBbE1KUTROZjVBVDVwaUR6amRNdFdmdTc5bWk4Q2swcEsybi9jcS9tNng4?=
 =?utf-8?B?N051YkhyUFQ4djNsU0U3VnJENXJSQzRUUXF0UmtUdkhvZXNDdUdrYjNUdEVG?=
 =?utf-8?B?VGo4TWIxN3NFcDRmNDJkQmwyeUxsTDFwTGhLVDZsUTN4ZDY0L0dqb0R6bEpW?=
 =?utf-8?B?MkZxMm04WG93aG9kaVBKUlRWclM2ZldWQVBHSGNQZ0dmdlE5T0wwRk5IaE1E?=
 =?utf-8?B?dnYwVFdpZUp2TVp6aHVwK0Q4Y0ltMjcwNUdMQ0RXeG1jZlhNSEljMEorckxx?=
 =?utf-8?B?d0JsYmQyZ0p1allkalpUK3JZOGYwYzhMMnJTR3pjcTBLVVFpb2FBUnBPd3hB?=
 =?utf-8?B?b1NXeVNwRzBZbGdPM2QzelBQUk1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4F695EF675C0B4E9A556D37410871DD@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382e5bc9-b30b-4ac0-e890-08ddb552a141
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 08:14:25.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAIxPQupvnmgx3xQzkq0GkxoxKKeaVKglVEwZZLhakY35Qk/hIZXfNWhrl+YzIlk+B4WwIBI+HtN18BdgTyYkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7998
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_011442_757746_E5EEF5F1 
X-CRM114-Status: GOOD (  29.91  )
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

SGksDQoNCk9uIEZyaSwgMjAyNS0wNi0yNyBhdCAwOTo0NSArMDIwMCwgVGhvbWFzIFdlacOfc2No
dWggd3JvdGU6DQo+IE9uIEZyaSwgSnVuIDI3LCAyMDI1IGF0IDA2OjQ2OjU2QU0gKzAwMDAsIEJl
cmcsIEJlbmphbWluIHdyb3RlOg0KPiA+IFtTTklQXQ0KPiA+IA0KPiA+IE9oLCBpcyB0aGVyZSBh
IGNvbnZlbmllbnQgd2F5IHRvIGNyb3NzLWNvbXBpbGUgZm9yIHZhcmlvdXMNCj4gPiBhcmNoaXRl
Y3R1cmVzIGFuZCBydW4gdGhlbSB1c2luZyBxZW11Pw0KPiA+IA0KPiA+IFNvIGZhciBJIG9ubHkg
dHJpZWQgeDg2L3g4Nl82NC4NCj4gDQo+IFdlIGhhdmUgYSBzY3JpcHQgZm9yIHRoYXQgaW4gdGhl
IG5vbGliYyB0ZXN0c3VpdGU6DQo+IA0KPiAkIGNkIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25v
bGliYy8NCj4gJCAuL3J1bi10ZXN0cy5zaCAtcCAtbSB1c2VyDQo+IGkzODY6wqDCoMKgwqDCoMKg
wqDCoMKgIDIyNSB0ZXN0KHMpOiAyMjIgcGFzc2VkLMKgwqAgMyBza2lwcGVkLMKgwqAgMCBmYWls
ZWQgPT4gc3RhdHVzOiB3YXJuaW5nDQo+IHg4Nl82NDrCoMKgwqDCoMKgwqDCoCAyMjUgdGVzdChz
KTogMjIyIHBhc3NlZCzCoMKgIDMgc2tpcHBlZCzCoMKgIDAgZmFpbGVkID0+IHN0YXR1czogd2Fy
bmluZw0KPiBhcm02NDrCoMKgwqDCoMKgwqDCoMKgIDIyNSB0ZXN0KHMpOiAyMjIgcGFzc2VkLMKg
wqAgMyBza2lwcGVkLMKgwqAgMCBmYWlsZWQgPT4gc3RhdHVzOiB3YXJuaW5nDQo+IC4uLg0KPiAN
Cj4gIi1wIiBkb3dubG9hZHMgYSBidW5jaCBvZiB0b29sY2hhaW5zIGZyb20ga2VybmVsLm9yZw0K
PiAiLW0gdXNlciIgdXNlcyBxZW11LXVzZXIuICItbSBzeXN0ZW0iLCBvciBubyAiLW0iIGF0IGFs
bCB3b3VsZCBidWlsZCBhIGtlcm5lbCBhbmQgdXNlIHFlbXUtc3lzdGVtLg0KPiAiLWwiIHdpbGwg
dXNlIGxsdm0vY2xhbmcgaW5zdGVhZCBvZiBnY2MgKG9ubHkgdXNlIHdpdGggIi1tIHVzZXIiKS4N
Cj4gDQo+IEFjdHVhbCB0ZXN0cyBhcmUgaW4gbm9saWJjLXRlc3QuYy4NCg0KTmVhdCEgTmVlZCB0
byB0cnkgdGhhdCBzb21lIHRpbWUsIHRoaXMgaXNuJ3QgaGlnaCBwcmlvcml0eSBmb3IgbWUNCnRo
b3VnaC4NCg0KPiA+ID4gW1NOSVBdDQo+ID4gDQo+ID4gTWF5YmUgd2Ugc2hvdWxkIGp1c3Qgc2V0
IGl0IGluIHRoZSBDRkxBR1MgZGlyZWN0bHkgdGhlbj8NCj4gDQo+IFdlIGFsc28gZG9uJ3QgY29u
dHJvbCB0aGUgQ0ZMQUdTIHRoZSB1c2VyIGlzIHVzaW5nLg0KPiANCj4gPiBIb25lc3RseSwgSSBh
bSBub3QgZW50aXJlbHkgc3VyZSBob3cgeW91IGFyZSBzdXBwb3NlZCB0byBkbyBpdA0KPiA+IGNv
cnJlY3RseS4gVGhlIHRoaW5nIGlzLCBpZiBJIGRvIG5vdCBzZXQgX19LRVJORUxfXywgdGhlbiBJ
IGdldCB0aGUgb2xkDQo+ID4gY29tcGF0aWJpbGl0eSBkZWZpbmVzIGFuZCB0eXBlcyBmcm9tIGFz
bS9zaWduYWwuaC4NCj4gPiANCj4gPiBBbmQsIEkgZG8gbm90IHNlZSBhbiBhbHRlcm5hdGl2ZSB3
YXkuIEl0IHdvdWxkIG5vdCBiZSBzYWZlIHRvIGF2b2lkIHRoZQ0KPiA+IGluY2x1ZGUgZW50aXJl
bHkgYW5kIGlmIHlvdSB0cnkgdGhhdCB5b3UgYXJlIGFsc28gbWlzc2luZyB0aGUNCj4gPiBTQV9S
RVNUT1JFUiBkZWZpbmUgZm9yIHRoZSBwcm9wZXIgInN0cnVjdCBzaWdhY3Rpb24iIGRlZmluaXRp
b24gdG8gYmUNCj4gPiBjb3JyZWN0Lg0KPiA+IA0KPiA+IFRoZSBiZXN0IGFsdGVybmF0aXZlIEkg
c2VlIHdvdWxkIGJlIGNvcHlpbmcgdGhlIHByb3BlciBkZWZpbml0aW9ucyBpbnRvDQo+ID4gdGhl
IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBoZWFkZXIuIFRoYXQgd291bGQgYWxzbyBiZSB1Z2x5LCBh
cyBvbmUgd291bGQNCj4gPiBuZWVkIHRvIGRvIGEgInN0cnVjdCBzaWdhY3Rpb24iIC0+ICJzdHJ1
Y3Qgbm9saWJjX3J0X3NpZ2FjdGlvbiINCj4gPiBjb252ZXJzaW9uIGludGVybmFsbHkuIEJ1dCwg
dGhhdCB3b3VsZCBoYXZlIHRoZSBhZHZhbnRhZ2UgdGhhdCBub2xpYmMNCj4gPiB3b3JrcyBvdXRz
aWRlIG9mIHRoZSBrZXJuZWwgdHJlZS4NCj4gDQo+IEkgdGhpbmsgd2UgbmVlZCB0byBkbyBzb21l
dGhpbmcgbGlrZSB0aGlzLg0KPiBMdWNraWx5IHRoZSByZWFsIG1lc3Mgc2VlbXMgdG8gYmUgb25s
eSBvbiB4ODYuDQoNClJpZ2h0LCBpZiBpdCBpcyBqdXN0IHg4NiwgdGhlbiBpdCBpc24ndCB0b28g
YmFkLiAiSnVzdCIgbmVlZHMgc29tZQ0KaGVhZGVyIG1hZ2ljIHNvIHRoYXQgaXQgZG9lc24ndCBn
ZXQgaW50byB0aGUgd2F5IG9mIHRoZSB1c2VyIHRvbyBtdWNoLg0KDQo+ID4gRXZlbiBpZiBhbGwg
dGhpcyBpcyB1Z2x5LCBJIHdvdWxkIHByZWZlciB0aGF0IG92ZXIgdXNpbmcgdGhlDQo+ID4gY29t
cGF0aWJpbGl0eSBzaWdhY3Rpb24gc3lzY2FsbCBpbnN0ZWFkIG9mIHJ0X3NpZ2FjdGlvbi4NCj4g
DQo+IEFzIGFuIGFsdGVybmF0aXZlLCB5b3UgYXJlIG5vdCBmb3JjZWQgdG8gdXNlIG5vbGliYyBm
b3IgdGhlIEtVbml0IFVBUEkNCj4gZnJhbWV3b3JrLiBZb3UgY2FuIGRlcGVuZCBvbiBDT05GSUdf
Q0NfQ0FOX0xJTktfU1RBVElDPXkgYW5kIHVzZSAiLXN0YXRpYyIgZm9yDQo+IHRoZSB0b29sY2hh
aW5zICJyZWFsIiBsaWJjLg0KPiBOb3QgdGhhdCBJIHdhbnQgdG8gZGlzY291cmFnZSB5b3UgZnJv
bSBjb250cmlidXRpbmcgdG8gbm9saWJjLCB0aG91Z2guDQoNCk9oLCBJIGFic29sdXRlbHkgZG8g
bm90IHdhbnQgdG8gdXNlIGdsaWJjIDotKQ0KDQpUaGUgdGhpbmcgaXMsIEkgKnJlYWxseSogd2Fu
dCB0byB1c2Ugbm9saWJjIGZvciB0aGUgVU0ga2VybmVsIGl0c2VsZg0KYW5kIGRyb3AgZ2xpYmMg
c3VwcG9ydCBlbnRpcmVseSBhcyBnbGliYyBpcyBhIGh1Z2UgbWVzcy4gRm9yIGV4YW1wbGUsDQp0
aGUgdW0ga2VybmVsIHRyaWVzIHRvIG92ZXJyaWRlIHRoZSBtYWxsb2MgZnVuY3Rpb24gdG8gbWFw
IGl0IHRvDQprbWFsbG9jIGFmdGVyIGluaXRpYWxpemF0aW9uLiBCdXQgdGhlbiwgdGhhdCBkb2Vz
IG5vdCBldmVuIHdvcmssIGFuZA0KZ2xpYmMgaXRzZWxmIGNvbnRpbnVlcyB0byB1c2UgaXRzIG93
biBpbXBsZW1lbnRhdGlvbiDigKYgdGhpcyBraW5kIG9mDQpzdHVmZiBzZWVtcyBsaWtlIGEgcmVj
aXBlIGZvciBkaXNhc3Rlci4NCg0KTm93LCBJIGRvbid0IG1pbmQgZG9pbmcgcmF3IHN5c2NhbGxz
IGluIHRoZSB1bSBrZXJuZWwuIEJ1dCBiYXNpYyBzaWduYWwNCmhhbmRsaW5nIHNlZW1zIGxpa2Ug
YSBuaWNlIGFkZGl0aW9uIGZvciBub2xpYmMuDQoNCkJlbmphbWluDQoNCj4gDQo+ID4gPiA+ICsN
Cj4gPiA+ID4gwqAjaW5jbHVkZSAic3RkLmgiDQo+ID4gPiA+IMKgI2luY2x1ZGUgImFyY2guaCIN
Cj4gPiA+ID4gwqAjaW5jbHVkZSAidHlwZXMuaCINCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xz
L2luY2x1ZGUvbm9saWJjL3NpZ25hbC5oIGIvdG9vbHMvaW5jbHVkZS9ub2xpYmMvc2lnbmFsLmgN
Cj4gPiA+ID4gaW5kZXggYWMxM2U1M2FjMzFkLi5mYTUyMTE5ZTU3N2YgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL3Rvb2xzL2luY2x1ZGUvbm9saWJjL3NpZ25hbC5oDQo+ID4gPiA+ICsrKyBiL3Rvb2xz
L2luY2x1ZGUvbm9saWJjL3NpZ25hbC5oDQo+ID4gPiA+IEBAIC0xNCw2ICsxNCw3IEBADQo+ID4g
PiA+IMKgI2luY2x1ZGUgImFyY2guaCINCj4gPiA+ID4gwqAjaW5jbHVkZSAidHlwZXMuaCINCj4g
PiA+ID4gwqAjaW5jbHVkZSAic3lzLmgiDQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvc2lnbmFs
Lmg+DQo+ID4gPiA+IMKgDQo+ID4gPiA+IMKgLyogVGhpcyBvbmUgaXMgbm90IG1hcmtlZCBzdGF0
aWMgYXMgaXQncyBuZWVkZWQgYnkgbGliZ2NjIGZvciBkaXZpZGUgYnkgemVybyAqLw0KPiA+ID4g
PiDCoGludCByYWlzZShpbnQgc2lnbmFsKTsNCj4gPiA+ID4gQEAgLTIzLDQgKzI0LDM3IEBAIGlu
dCByYWlzZShpbnQgc2lnbmFsKQ0KPiA+ID4gPiDCoAlyZXR1cm4gc3lzX2tpbGwoc3lzX2dldHBp
ZCgpLCBzaWduYWwpOw0KPiA+ID4gPiDCoH0NCj4gPiA+ID4gwqANCj4gPiA+ID4gKy8qDQo+ID4g
PiA+ICsgKiBzaWdhY3Rpb24oaW50IHNpZ251bSwgY29uc3Qgc3RydWN0IHNpZ2FjdGlvbiAqYWN0
LCBzdHJ1Y3Qgc2lnYWN0aW9uICpvbGRhY3QpDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gKw0KPiA+
ID4gPiArI2lmZGVmIFNBX1JFU1RPUkVSDQo+ID4gPiA+ICtfX2F0dHJpYnV0ZV9fKChuYWtlZCkp
DQo+ID4gPiANCj4gPiA+IF9fYXR0cmlidXRlX18oKG5ha2VkKSkgaXMgbm90IHN1cHBvcnRlZCBl
dmVyeXdoZXJlLg0KPiA+IA0KPiA+IE9uZSBjYW4ganVzdCBkcm9wIGl0LiBJdCBqdXN0IGZlbHQg
aXQgd2FzIGNsZWFuZXIgYXMgd2UgcmVhbGx5IGp1c3QNCj4gPiB3YW50IHRvIHNldCB0aGUgcmVn
aXN0ZXIgYW5kIGRvIHRoZSBzeXNjYWxsIHdpdGhvdXQgbW9kaWZ5aW5nIHRoZQ0KPiA+IHN0YWNr
Lg0KPiANCj4gSWYgaXQgd29ya3Mgd2l0aG91dCwgYWxzbyBnb29kLg0KPiBJZiB5b3Ugd2FudCB5
b3UgY2FuIGFsc28gdXNlIF9fbm9saWJjX2hhc19hdHRyaWJ1dGUobmFrZWQpIGZyb20gY29tcGls
ZXIuaC4NCj4gDQo+IDxzbmlwPg0KDQpJbnRlbCBEZXV0c2NobGFuZCBHbWJIDQpSZWdpc3RlcmVk
IEFkZHJlc3M6IEFtIENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQ0KVGVsOiAr
NDkgODkgOTkgODg1My0wLCB3d3cuaW50ZWwuZGUNCk1hbmFnaW5nIERpcmVjdG9yczogU2VhbiBG
ZW5uZWxseSwgSmVmZnJleSBTY2huZWlkZXJtYW4sIFRpZmZhbnkgRG9vbiBTaWx2YQ0KQ2hhaXJw
ZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOiBOaWNvbGUgTGF1DQpSZWdpc3RlcmVkIE9m
ZmljZTogTXVuaWNoDQpDb21tZXJjaWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBI
UkIgMTg2OTI4Cg==


