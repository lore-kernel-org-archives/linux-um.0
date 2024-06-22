Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92844C2BB85
	for <linux-um@archiver.kernel.org>; Sat, 22 Jun 2024 06:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3S93vVE9s7VvxIMidbK21k6nyVsuLzvWA8A2RJx3ne8=; b=iI3KS3N5OBocF0KKxlxtzytrsf
	Uk+GKjgld4zD31YVsFJwzl5+ATC9m3HrWv9eVWhtFK6plmJ10cJPl1zVZvrQ0NPzb49jpNaBCfvKp
	JTbvMuo2S4Gqb/2p7GInuhVGwo9sV9YPWWxWyNibaJH0uyuQ8pi0Fq25+f9BH8XZYGkqi/XWFMaeA
	ddDgqlQgdcfliuTHBdAinf2Hy5oLLrw2oq5Tfww5D5lCKkbNSnYKMC5y0VNYC2FyWsVcps2bXu2go
	qvZqw/ufFKxlyIsc1m7/AGCx9dAROaCEcK4jCCua+TcT/cxMN2E1hTYaYVg+8/Eq1JFlcls8fVHC2
	s+F4ZZ4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKtuh-0000000BUgN-2JYj;
	Sat, 22 Jun 2024 06:07:51 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKtuf-0000000BUfr-0izR
	for linux-um@lists.infradead.org;
	Sat, 22 Jun 2024 06:07:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719036469; x=1750572469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xvDu0IERs33YFFpOIqsSC03l24wzHA82W7XARUl+RcA=;
  b=RwKdmNHx/te6zi0OU3xPnE6pq0JHxvfSG8OsVGMdbuFwmYaM4FCxxp0e
   rhVFUlvc9Qj+Il46A2tziDSUBZfKF+67sOWHdf3eB3BFj8a4NkfhFgO4O
   uB2yMHZEIAIlnaKYTJ8jLpILUqm/19hKdrq239p2ddPbv42mHZzBufo6n
   nFp7RH0+64WYIOZ2UdTub8XFhd1PrvfMUpaotn+qAYYBJp0FAxwR6/uZN
   6MFGJ0R/5B7/K/W6QKZutO1LpFuFzBeG2XfHfFplatZ5QcTfCh4vLtew1
   evcxs8Lpj0A0Kmgir7TeXqe+3SFPHzi6vNd/KWeNdtYYCPk2M5xqOrp3Q
   A==;
X-CSE-ConnectionGUID: ynLJMZ8ZRLmJfrJNO3qAsA==
X-CSE-MsgGUID: 6fYVOg2MTvK+wEbi+kXw1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="12190099"
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="12190099"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 23:07:44 -0700
X-CSE-ConnectionGUID: DWiZ2G8XRuWXNyVLO+9scg==
X-CSE-MsgGUID: VW4dFkxfTx6axeYnzQNc0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="43230573"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 23:07:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 23:07:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 23:07:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 23:07:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 23:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx4pKDe5nB8R8XduQujUCIO2U3eHRYlWFmzcGYE41iGP2N2gds1iAQSGVNtgo4cpEDaHjIFiMUas58cGp211lrd80AfXJ7HJe/cq7DBBzR/L8q92p8o/wBVlbXtcmNL2r4WqYcRz28JtjCLRVG4WFlpH0kDahhLLwgT8BA/y5HP2p3YN4Ao8DHUkbfvrLKrwnUqOgE6rLuEGo6OtDKTwYMq0Iy73RhltocaozOWc2zLjfpExUElXVsy95sIyb4vv3v19a4KZa0LD+ZSHGBodTDltefSojmIUfTYeZqXKHEDIRGt+vH4ZWf0cRkECZ4ULBcViyAp6+yo/pT9X7ZZzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S93vVE9s7VvxIMidbK21k6nyVsuLzvWA8A2RJx3ne8=;
 b=iw/mRGCU9JUxfiZ0zz4ZsufCN9uo6EeFPWNkbmHgtKg9L9VpZrW5M9ZQRSpy/EFIam/qertbd0H2Zyp+5VOTlr1S8deE0La8CCoYipZn0z5kN5uaFv1+bUXr+71CCvwIKwEMeTfnf6z/7CZ9awq8peZUYy3SZmHS3+Y/2I01dYKS+sBw4P00p16vHKx04V4XH/92qhFcu+L4bCMRtOuhkkNq2lyidC0vP92gFyfgOS3HYJbXeSG+h3A/kJQl6kIaAdthh/2J4Xwf9dkGT/nulYkVGlmqS6fHjgGGQJxPD9YR0RLXkAmqFStYOpACQFMxJ+e3osTH7mI694dGgtwAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 MN6PR11MB8219.namprd11.prod.outlook.com (2603:10b6:208:471::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.22; Sat, 22 Jun 2024 06:07:36 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%4]) with mapi id 15.20.7677.030; Sat, 22 Jun 2024
 06:07:35 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"Richard Weinberger" <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "Bjorn
 Andersson" <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
	<pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "linux-remoteproc@vger.kernel.org"
	<linux-remoteproc@vger.kernel.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH vhost v9 2/6] virtio: remove support for names array
 entries being null.
Thread-Topic: [PATCH vhost v9 2/6] virtio: remove support for names array
 entries being null.
Thread-Index: AQHaligQYdJ7G3/Ep0SOtqEoL6Vt7bHQpCeAgAAKTgCAAAYCAIAC0a8A
Date: Sat, 22 Jun 2024 06:07:35 +0000
Message-ID: <DS0PR11MB6373310FBF95058B8FE8CD95DCCA2@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-3-xuanzhuo@linux.alibaba.com>
 <20240620035749-mutt-send-email-mst@kernel.org>
 <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
 <20240620044839-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620044839-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|MN6PR11MB8219:EE_
x-ms-office365-filtering-correlation-id: d216aa01-a40f-45c0-0616-08dc92819cca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011|38070700015;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fKDwNw+VGHC0SYJZLY7t4E40jBlGIpQGzu17hMb/EsIfbdc6xyQ+QhuaLh?=
 =?iso-8859-1?Q?8nTXGaaSfDVuUVsOillAglm/1z52/YXzWlGwETQSGVGi9872IuYPcQ9/Ia?=
 =?iso-8859-1?Q?TtyWSZ2jTXA2EbdAD550XPJQtr3GMmkC388wTvQbCKeuUICVKj+1iG3fBw?=
 =?iso-8859-1?Q?neRs0dBDh8dCrGWFWnRtHxRoI/P0l0X2xkl0fdMslAQX45nFBC1cBurR/h?=
 =?iso-8859-1?Q?OisBpf5xqWwjYzQmA0+GrnHwBtHibCCCOxQsoQn6Y0XUCgr3YQSN3Gd0q1?=
 =?iso-8859-1?Q?ZS8814tRgRKOphVLb7DopXRtfOYxij7NUzWoz7KYcVAYP+5Czr1ruXNDbh?=
 =?iso-8859-1?Q?J1tyF9gni6bK/NXv/6S/aq2d5ewN/E2I8HpnZONTUjcRnJY/s8jiGgrl2C?=
 =?iso-8859-1?Q?6QnpabYOiHkmkOot6yQmclsGF5zbrBR1B6Xifsg3fG3G5PKh4JFP38TqiJ?=
 =?iso-8859-1?Q?eJ0si6RXR7r0finlyDuJMeOUXgssiRH9eYLwEuBgVpi1bXPRPO+OC2/9nk?=
 =?iso-8859-1?Q?pXCbup7yohNPFWpTns/xhIQJ3A/WAjN4V8cXjwMtrP8NbTxzG5j/SqNnNQ?=
 =?iso-8859-1?Q?qyXT1yhhhSpgVS00Flj1arf/3Ciiv5dS1vAEc4EgVR+ukEV0s3FuxKiN42?=
 =?iso-8859-1?Q?4OtoWPcriirpGJlRDoqTDfAhX6beKq3x7JxmuZrB2XUIm6qjqMlnb4EP9/?=
 =?iso-8859-1?Q?p0GJrHEN0j68qbVgFVHtzGG7dmsVfhRXG1DNb3L/l2PwlKSKdF51DJnyVE?=
 =?iso-8859-1?Q?vMXpE08t2lhvzGoIU6Liev5aMUpN3OfHvJeChqe3JpcVAlDm51UZu0PSES?=
 =?iso-8859-1?Q?eJKbXW1eYyI5Tqjws0tqez+m6BbeClEMQDXeUatQi8yrEyzeL1OsJQ+XSb?=
 =?iso-8859-1?Q?Bh9Q3JCqjhIuN3l7N6Jg+p8FnsMIXR5r3YEdlhC6Uln7pa9DiLlMlG/k0D?=
 =?iso-8859-1?Q?Sa91sj2T90OxsdPOSNYuMcKDZv/C1zenkzlhx3p1Lb6Zl3g2LS5mr6mqbY?=
 =?iso-8859-1?Q?NbuT3RFytAHIbb+dQ8O/COUy0G/4wLI4k73PpmqpiLROcqyyiO/WYXURqe?=
 =?iso-8859-1?Q?IKBmD3nXLxvnRZFeoqGNKvEi+Lv5EnWNnE48EHt47WjKB91fgzBdyWv8Yv?=
 =?iso-8859-1?Q?/RCg5AH0JD2sOOscgtshkP6vS73sT4wD8kofHxnRRM4MhchBHL9VptylsS?=
 =?iso-8859-1?Q?7qyRFpkU8Zj0Kke+HLdFmlgZvb6Kz4GhiSUIje8TLwlp0jN5o8jg1GT2Yv?=
 =?iso-8859-1?Q?pU6XIufy03SIji3yADto0ibzCaXgA5a6NODMaHyZeOjCuLVifmI7xUwjrQ?=
 =?iso-8859-1?Q?X0pARD4/g0kntFx66KUnOfabPOy6AfuBGfFgi/TjDzSUxCE11VUZjddWb3?=
 =?iso-8859-1?Q?C3JDkicE/prvGYWAACtHgrIWFp3AvmpeWL9uQQdJaroy2Q/By/+w0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jq+Z23GM4aUFwhVYxkThuhBTzlP+rpyv51+Gy/D+ozAlZZB6uSehDi/YDm?=
 =?iso-8859-1?Q?qu0oK0LwNNItb8rT64bui5ZNcYHF86XyO0FBIkjFXIGM1mKChwJodk+baU?=
 =?iso-8859-1?Q?7OFiqrR2Vj08NPY0Pbuz4M9NAfa4S9HIS3d2lxqJKIYvbPWl/+x5+UiOEt?=
 =?iso-8859-1?Q?MXCJRAeqLPeQKIdsm50o+I1vdQhSR0nHaB9VXLFByl/JOygePmDSOJrepe?=
 =?iso-8859-1?Q?c2HSEImuFR/uP4+vvZq6mtBisV9prlEOa4xFOplKoMT+G78lbQylvjdaw5?=
 =?iso-8859-1?Q?t49sIB40I1kYkppdzkI7cXQoxiy7zWEA2MqrelmpmavsEwCzXXsHCvOxta?=
 =?iso-8859-1?Q?OFV+EHhKbM8SrDipvaDbuPyBV+3kpGTeERdIopUnFQF9RuyUPiKVZVES45?=
 =?iso-8859-1?Q?Id3vWdvVKDAsKBrYQaJyan1qd3LyVKLh7T9F1yrEmICwwl2oeTpOpP/ezH?=
 =?iso-8859-1?Q?QOm46cNFYDQDtIVax8n1ktzYLIq0L+7RC3zNMQVKB9AsSMD0Tbmt6iGtg7?=
 =?iso-8859-1?Q?oBThv5hJqj511JVyNe9ST2KRs0+1iSB+rSnhdMNE8BSJtr2NEjdGJIMtDF?=
 =?iso-8859-1?Q?Lf7WlOenSYLmJw9TFckTyrWnIDeM/KgB7APt/WO4+IxeeL+/ZisR8hXQp2?=
 =?iso-8859-1?Q?JHH7FwYfhKb2pFCmMeeAq+rqV1cmAYI2WA8Esga6unpVscBi6OAfE6RgJI?=
 =?iso-8859-1?Q?g8GVU0jZNNTOMoB7xj6lwoY3sPS4KZZCIik1C5KekK864dz2mH50PGY2OK?=
 =?iso-8859-1?Q?3VqnWd3/mFpj0TjgwwmFiio5yCZe26Oba5M4YAZ5x0QQOprdAdOTFgAWFF?=
 =?iso-8859-1?Q?+31BkpPWz8tbpz+oWgLC+vF/xH+4axrYpUg6o9sVhZSv0F5Y4uNphtn5aF?=
 =?iso-8859-1?Q?8EP1L5wMX9TzjgrkNJviLUWsqZd83rOpYGc/v+eXML0+8tHqS8y2O6D6O1?=
 =?iso-8859-1?Q?V4mIku1P6wCS1cGCk857vust75g7VaSAC8sRMyhre9LZH9zcLDRU92Qsn8?=
 =?iso-8859-1?Q?O8NsYEpp4KCptMqWmUdE0bm4PmTeQsFqWKgLNUxsJehQugJzgbAfwT+V26?=
 =?iso-8859-1?Q?JWcXA4QdLz7QTkhHa93UbEOTQ+4HfCRSWyj2GJyoNKPIPsY+QtqqrjICfE?=
 =?iso-8859-1?Q?dOZ+FODMoaHo+x4FHW+UlMPdDCgxHsvlsymMItPlaxoaJRaAh3WPQnz2OI?=
 =?iso-8859-1?Q?qXkTUi2ZwfxT3lAomtXalA7x+rglTJI8bhvMd552zHVcxXAWxLANMJ0jKS?=
 =?iso-8859-1?Q?1543kPZ2y2y90oC9RO33da49TIEn3wgLb6dZVE1SeGrGtC8riJC7LrkIru?=
 =?iso-8859-1?Q?ycxFpxYrW+VxN3oKGFWb8Lt08110A/Mng55Q5Nsb3SYRrAGF3Iqf4jCwun?=
 =?iso-8859-1?Q?Te5vgG30gIQEkMWm7kTbG+QkJ6+I4cfqngFllNdry2Q2SP7+v/6lodHSb2?=
 =?iso-8859-1?Q?5Xqc/hw4GwbfVX000nk8YocCr2qUQ1N/tV8cg98rV2BPyIMdeqYzBk8/sh?=
 =?iso-8859-1?Q?NWdl2YPOZUJaZ+eMWJoPW0sblSyxoX90ldqZGwOCPu2DKnti7zsdut/3UQ?=
 =?iso-8859-1?Q?ZXFbvzSSm8fJZ9eQwDLBbU4tIcEMNWnlAlcMG42eKwURiTPpfTq7VRBN0c?=
 =?iso-8859-1?Q?qCjGXF2yNq2KU/+Pv0S1ifeovgZcn8FPgU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d216aa01-a40f-45c0-0616-08dc92819cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2024 06:07:35.8292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2s7IXeti5mwsCGKtdPlgXkZYUZrDQMNvyv3NDpWB4vcWcuhQrJf0JosAoqNgyRbupbptm4JmOe5EFAWYeFKZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8219
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_230749_259058_5E66F007 
X-CRM114-Status: GOOD (  28.18  )
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

On Thursday, June 20, 2024 5:01 PM, Michael S. Tsirkin wrote:
> On Thu, Jun 20, 2024 at 04:39:38PM +0800, Xuan Zhuo wrote:
> > On Thu, 20 Jun 2024 04:02:45 -0400, "Michael S. Tsirkin" <mst@redhat.co=
m>
> wrote:
> > > On Wed, Apr 24, 2024 at 05:15:29PM +0800, Xuan Zhuo wrote:
> > > > commit 6457f126c888 ("virtio: support reserved vqs") introduced
> > > > this support. Multiqueue virtio-net use 2N as ctrl vq finally, so
> > > > the logic doesn't apply. And not one uses this.
> > > >
> > > > On the other side, that makes some trouble for us to refactor the
> > > > find_vqs() params.
> > > >
> > > > So I remove this support.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > Acked-by: Eric Farman <farman@linux.ibm.com> # s390
> > > > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> > >
> > >
> > > I don't mind, but this patchset is too big already.
> > > Why do we need to make this part of this patchset?
> >
> >
> > If some the pointers of the names is NULL, then in the virtio ring, we
> > will have a trouble to index from the arrays(names, callbacks...).
> > Becasue that the idx of the vq is not the index of these arrays.
> >
> > If the names is [NULL, "rx", "tx"], the first vq is the "rx", but
> > index of the vq is zero, but the index of the info of this vq inside th=
e arrays is
> 1.
>=20
>=20
> Ah. So actually, it used to work.
>=20
> What this should refer to is
>=20
> commit ddbeac07a39a81d82331a312d0578fab94fccbf1
> Author: Wei Wang <wei.w.wang@intel.com>
> Date:   Fri Dec 28 10:26:25 2018 +0800
>=20
>     virtio_pci: use queue idx instead of array idx to set up the vq
>=20
>     When find_vqs, there will be no vq[i] allocation if its corresponding
>     names[i] is NULL. For example, the caller may pass in names[i] (i=3D4=
)
>     with names[2] being NULL because the related feature bit is turned of=
f,
>     so technically there are 3 queues on the device, and name[4] should
>     correspond to the 3rd queue on the device.
>=20
>     So we use queue_idx as the queue index, which is increased only when =
the
>     queue exists.
>=20
>     Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20

The approach was taken to prevent the creation (by the device) of unnecessa=
ry
queues that would remain unused when the feature bit is turned off. Otherwi=
se,
the device is required to create all conditional queues regardless of their=
 necessity.

>=20
> Which made it so setting names NULL actually does not reserve a vq.

If there is a need for an explicit queue reservation, it might be feasible =
to assign
a specific name to the queue(e.g. "reserved")?
This will require the device to have the reserved queue added.

>=20
> But I worry about non pci transports - there's a chance they used a diffe=
rent
> index with the balloon. Did you test some of these?
>=20
> --
> MST
>=20


