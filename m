Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9E3D1AD2A
	for <linux-um@archiver.kernel.org>; Wed, 16 Oct 2024 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+vvJPXJ23IiKBbzXyyZd+8fZ3WrnK6d2J0E9K+Ilg4=; b=s8lwvbsqWCOxEEm2EFEjY2gmGU
	NvqzE6dHGDqaFFskzH9O122ydvd+/akzTAJpCWY7ZZiomHqrggtNDJDXZnF+n5o4NENEWkoceVwpS
	PNEi/xa8KnZ63y7x4fRbbp9li8ti8/wxZSbgRdBy8wh9DcV4iK0PzsaHzisydjRpaTEgdCd0ybSM7
	ZsIc8dt0JFlZ+GhZAdiLVnY4OAZFDQrG7IcQVQxEg6reAGCHj4l4F7ksQ9TajMe8auY9CpQ6AuH45
	VEhzmZpy0+k5ynu5xKexs4jZFOnr8azleiYZPIyzeuDmqb9Fmijolixf5OOt9dqmUTF7bA7H/9dJo
	drZNJ8JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0zWT-0000000B3ZJ-0bpR;
	Wed, 16 Oct 2024 08:36:49 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0zFP-0000000Azuc-1CqP
	for linux-um@lists.infradead.org;
	Wed, 16 Oct 2024 08:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729066751; x=1760602751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=O+vvJPXJ23IiKBbzXyyZd+8fZ3WrnK6d2J0E9K+Ilg4=;
  b=eskuwDF71A+js7LnTs+E2zcSD82HIta8gAPhsrrEHX+x4cOscprjkhqY
   +yYXbpeVD35wzJ6bYmsAMtk0lKH9pou+3/ENtbdwFlDUhJHWC3Hy3pcAN
   yDs7Kc7larh4tlLoAXTcMT3D6T8BRy28B92nocn9VF/QsWI16fgEkdCU7
   20Mo57RCsoQvVPKezBAOd+xdGadMBmWxKORoGL2wBQyVVBuCeYKkm8A0G
   rbOpZTJPBXZMrpjYcTI2a/LAJVGyx3eTRb6J8qhKZgPSTL70dsVgc4+4T
   gxshQF/rXDzbl5a7Z0qcLa1er+wLdfjIsrMAJBZSn39UOCaT6hOB9QRWX
   A==;
X-CSE-ConnectionGUID: LqgbH8TbS5Sc2Ogzm+SkvA==
X-CSE-MsgGUID: GBZAixrnQwGQzQ8oMVoSJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="45996882"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="45996882"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 01:19:10 -0700
X-CSE-ConnectionGUID: +3NMIGuHTkCrzfQBuj6Jbg==
X-CSE-MsgGUID: GLe1bfWSTSOlQErxInuTAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78609656"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 01:19:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:19:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:19:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 01:19:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 01:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSiuBGQ/aKktBqmnlwvJLIqAKRX2oaVRuziZ4JyG22jNL0X5q3IUnS+dKgPpc8rQIEjvaGytjyzHOaX16q+WD3CfkDN57MkVGiqPyzrb7Kpf0Y814Bw7L2QwIZa5msEI4vRDoPFuc3byBK50EqTDlWdLZYcfaJQ2edzgLKgceFsl9GTEIjvetN/OrZqrpMUuwuaDVwKICwv/vZkIwSIUa68BNM7MZYR5tgL7+Xb5EecgfdLXLVzCVD/fMjj5zbCw78TetvjJILmSwtrJ4qf0RGGXeQphT3HBRejIJmqKGoM3UNwUwcfstsvdUVjIYPtGrgGmBkp8DK6oqRetLtfmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9IAoSF4A0hWirXn6vX+gtrPMstRr426LrT8RpGE4Po=;
 b=GsZNID3Iz1K2CcxEqvJtKtm0cVab6cCs8AdL2Jwkpb1RY2v+Gxvxmm+okCqZl0a4jzNUPJBJuZHxOYa5oRZOUHKMn3Ddlu9pRESA9E9ejmWN7R26bVJoKRlXgSwI3i3S4tRVtRDbeIwe7EmE9/EVjVihfWdBF+KcLeIZldTdXSLSqSp4jMAsOyU56jtKomHd1VMf2NGMoNKGTH/J8Y9pDtuYnpW8E14q6KMtWbbhELpQQHZrxMZGmYAeShwy2V6TFkP16/B2nS82rtXP8lFeLsftsBnvJ43J/ev7zwGCE841uc81zXPLVsafStzqtckn6IvcKeDmLyte/cldXCtUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 08:19:05 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%3]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 08:19:05 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "nathan@kernel.org" <nathan@kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Subject: Re: [PATCH v9 02/10] um: use execveat to create userspace MMs
Thread-Topic: [PATCH v9 02/10] um: use execveat to create userspace MMs
Thread-Index: AQHbCpHmTJLMehXZL0izK/tklaQClLKI0rEAgABgSYA=
Date: Wed, 16 Oct 2024 08:19:05 +0000
Message-ID: <0cfc6640941ce432de34522d8ff7e1c35c6dcce9.camel@intel.com>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
	 <20240919124511.282088-3-benjamin@sipsolutions.net>
	 <20241016023426.GA1115452@thelio-3990X>
In-Reply-To: <20241016023426.GA1115452@thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|SJ0PR11MB4975:EE_
x-ms-office365-filtering-correlation-id: 9f213f13-223f-44d0-8b45-08dcedbb336d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VUIvYmU5K2NKdloxcVMrb21zZGlkNGIxaEtQRWs5QnJQN3ZudFgzd2dYeEVl?=
 =?utf-8?B?MGJxTjNab0dRUFlmdnR0Z2dld3NHaWJ1Tnh4SGg1OUFVUWV1enU3bFhHTlVC?=
 =?utf-8?B?ZmppZVpBeXNrcTZCemFlSzZpcUNtVU1xQUg2NEg2SU1hdlRMYTZjc1VKQXpm?=
 =?utf-8?B?NnVqYXBheWh3aDRTbnBkWHdlUXBEcjM1SklQSnhhOTR4QW8rUklFSTNTWGJv?=
 =?utf-8?B?M0Y4ekJDS09MZHB2UC8xeENMSERkMDYrRzJtNzhva0RXRUt2dmJQbkdlN1JI?=
 =?utf-8?B?SWlqbXA0Wmh6OU5RTElEdEEzTGl0Rk40YWpJQTBhMDNyS3JtZll5amVYRDNE?=
 =?utf-8?B?cThtbmlzaXZBT2FIaVZRcEJ4OUJESFNCelNZdHI5OHFMUkpqRkpOSmM0SDBy?=
 =?utf-8?B?SWhMaHROM3JTck5tcFJRcGhxSkJoemFWWURIekZxN1J1dm1lYnUyeEFiMDFl?=
 =?utf-8?B?UmlkcTNtV3A0eXZkTFRFRmI1ZjBFdzRFL1I5d1RNOStDaE02UVR3Z2J6cXZy?=
 =?utf-8?B?VjdteXdIQy91Yyszc0N5NEd3N0NPMFJuRkljYldZMlF0RnBtMTBHdWhESnd1?=
 =?utf-8?B?d0gwNDNwb1ZYWTAvUkpiQ3NyR2ttMklIaDI0VllLanFoODBTUTB0Y2RGM1Rz?=
 =?utf-8?B?Z1EzU2pZUDR0QytBaU4vSjZRMk9ZaG5PbXk4Y2RaaXBMVTJIM1Rrd0x6WVpu?=
 =?utf-8?B?cXFoNkVISFBKamJBdXlpNkRPajVIQ0k5dU9qcHZwNVhoTjZzR1AxUHR0bHNV?=
 =?utf-8?B?LzZaRXpHUkRTSmxxNFZ0dDZpei9oNmp0R0REWVFwc0FScmJsMmNJa0dzRjlM?=
 =?utf-8?B?RVJSeHNhSGxib0NrVkRiSXhCRGhtelkyaHRZNDhCUUhFelZia3B2ZlBLR2Fq?=
 =?utf-8?B?dnJjWnRYSXhlMGladVVOemZNbDdhcUZYandsbzc0QzBHUWtLQjNORlpWMUpG?=
 =?utf-8?B?Q3pWRlpyaWZYeTR0TjhPUi9rVSs1OFVhYnFDa3JwaW5pWUtkMHQ2cysxcU1Z?=
 =?utf-8?B?eGc2Y1FrdzJGaWZ3dUc3bWZXajJHeGEvQ2FqSE5Fd0N0NVRsZEdUK0tGbmFT?=
 =?utf-8?B?L2YwTEwydmx2MFVOUjNyeGdWbVRtVjFhK2l2NVA4TnJqZzVlMjh0MWdKUTJn?=
 =?utf-8?B?Zno0M0pkK1AxSFJaYkZUbFlHZ2ZPejNCTXFNT0ZkWVBJSEJvamtRbmQxQzk0?=
 =?utf-8?B?a1FUckhWSmVrZ29OeVFnVzhzNWpvWTR5TVNKUFVTaG1hb2VLRDVPYkw4WElE?=
 =?utf-8?B?a0w0VVZjTkpDVkVacEZGSnJoNWpiZ0pCZU9xZ2dvZFVwQUVzUDZpaGlPZG9U?=
 =?utf-8?B?QUVMeitVWEh2VXFQUGh4ZzVlSzFPMnBpWVl5aEJ5S3ZQQjlXSEh2ZDZ0ZUpW?=
 =?utf-8?B?Q05QWUxvbTVxbUh1OEQ4a1QzZVJkVytWRHF3N21FMXJUL1I2TGRLQnRCM0dn?=
 =?utf-8?B?UjBQT3M0NDAwaDg4aENzZllJRGV5ODEyY1dhWXNhM1FNQWJQWEJvaUcxVWNW?=
 =?utf-8?B?elZlZWU2L0pVeXpjVlAzRU5NMEtmWExVSitwMlJXUzRyWmgrTWtSTHJrUmk1?=
 =?utf-8?B?NExia3UrSGtVTndqQ1BlZURKMS83RitZb0wvRUkybDdUZ1NwNnZGVTF3cE5U?=
 =?utf-8?B?RXY0MjRVN0NwaUdUU0x1NC9VVUhYeUszWjJVNCtBRisrRW9vdVZodG1KSnBB?=
 =?utf-8?B?M1hxYTRPKzlJSUNxTG5nRmlDZmFYNGNiRFJHZWFvYjhJVXdQaHBaSnkyYTZS?=
 =?utf-8?B?N1pzeVF3MzgrL05rWW0yTGp1RzJoVHJNbW9yR1A2WEdlUHl3bkFhU0I4eWhq?=
 =?utf-8?B?azAxUmtYZmppekpLOEc2dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXJjN1FIMTE4c1YrWDNOejlQSGRTK2JGTlIvNCtSa1NuT3dSS1A3ZVREeHBu?=
 =?utf-8?B?ZnJLM0M0MDIrVXVic1V4WGpFRS9TTmNMei9VQzJKL08zbzlTMnNSeTZqUXNa?=
 =?utf-8?B?eUtGeC9PZWZ3S2hiZmlZV1k1a1psdzA1WVBDbkk0NWZ6WFM1ODB1WjI2R1pn?=
 =?utf-8?B?MnNWaWJhejVpb3dGVEJNaS9pOVRXeFhWbHA2NlZ3UzQ1bzJxOGZ1ZWIrdTdW?=
 =?utf-8?B?UlVrSkQ3MFJjOHBPK1VVSFJEcFRqTlk0OU05eFdianVvRVk1VitCZXljdnBz?=
 =?utf-8?B?TkdJKzRvYldOY1J3dVdyOTlodTBJbVdnMWRyM0NTSHdINGg1QkNpSnZzdEV4?=
 =?utf-8?B?ZElURXFsNW9Tcm9vQ1BiS3ovL2ZVNGxrNnhqWGI1aTJOUlppMm9ZZkRpMHRY?=
 =?utf-8?B?NEs3SlBTOFIwTXJVYTNheUFLazI2Y0NEMEJmQzRZUlFieDduUG0zUXpQbmVZ?=
 =?utf-8?B?aXhaQnUxV1ZONTBqMU40dyt4ZUF2Zkp5S2RieDJxb0pubDlheEpCbXM5OEdv?=
 =?utf-8?B?NGpoTWQrMFBFWFV3NDVvY2xwR3FkQ05mdlNMSmdEVXpoUWdaY3ZoUUdveVlX?=
 =?utf-8?B?YWJSN2lqbU9rckxjb2ZKNFZDYTNxUmU5MkFjTXIyRHVBM3FtWG5ZVi8wQU5k?=
 =?utf-8?B?ckhPMjVYdnJNZ016Ym9mak1EMWU3TUlzYlNKU1RYL1N6WnMrdkZjTjRkOVZ0?=
 =?utf-8?B?a2g1dmU3T21EYVBERyttaXZieVg3K1psQmtKSTlHOTV4eEltNHNzaXZmQXZt?=
 =?utf-8?B?aXF3QW1TYmdFWWRuTml3YjdXSzRCMWVTZWpOM1gxVXJEdmJQQ21GSjhqaTlj?=
 =?utf-8?B?OU16d1M2WHlsMDhhRm1HdGJnUmV6dTVnWEpQblhsalExL2tsc042cFc1aUV2?=
 =?utf-8?B?QUFDN3o4bGxhNk8vVUU0cUZ3SmgzRm9sVHQ0SDd6M3Z1TmZXdFE5Q042WVZS?=
 =?utf-8?B?b2hBek9KNGxRQ1hkVUpmaFYzdXZtT3N4OUhzTk42aGFaTkw3eUVkR1k2bkJH?=
 =?utf-8?B?bms0UnNhbjIvdUw2ZzdveUluMGdVMW16RDlKSm9LUWFPU2daU2d6NU5XaDcy?=
 =?utf-8?B?QjVxUVdjNDlwQWYyNnNZV245WUVYL2hDS2JPQVJvUmIzeW1zcmxPQmkwVFoz?=
 =?utf-8?B?bGlDWXQ1ZHlvczRWUzc3N0xpeGNJbE1aWVpMNkF3dHd1RFBUdmdoZWxxVGFI?=
 =?utf-8?B?ZFFSTTRmeTV6NWMxalQ5WkpReWRQRkVuRjZCb0xtUlJTQjdITlA0OHh5ZUdW?=
 =?utf-8?B?eG44SmtqZGIyekJ0MnJ1dFdDQnRoOWNKeld1enRkbElYY09KOU0xM2ZyZ3Bx?=
 =?utf-8?B?Z2lyTW41dkg4bGF1bHFKUG00QzlLOGY2Zk9zN2YxQ3pBcHpLZERpcUlONm9M?=
 =?utf-8?B?dWsyUVFOQUJuZEdqQzBrVDVhOHo1QitxcjJGNnAvWS96Lzd6TG16SktoT3ow?=
 =?utf-8?B?U1R6cWQwTU85VFYxUW5hY2pMOGNldHczRzNmTC9xdEhUZVAybkFvRU5RV0dw?=
 =?utf-8?B?bDJ5RGlJTWdCN3JjaTRKRk1YclYwdXhrQUZkQzd6L1lTb3hscllTT25EbXZu?=
 =?utf-8?B?b0pNMlRlR3BLRVNGWjFGUmlIa01zWXdldkhyWmt2Vm9SWGxYV2NhM3B5UXpt?=
 =?utf-8?B?Zzk1Y2NjZlJYdWZqcngyMWdDbkpCblV0alZxbk5aTXRuQVp3TU1TSmhOZktk?=
 =?utf-8?B?dXd4NFhMRmRXMGh0VHFUVU5XR1RMNkthcWx0d3FGeGRGM0ZtTVk4eVVRand1?=
 =?utf-8?B?Z2dRZ3owdVdZbEs0N1ZZMFZZRXE3UmVyWUdSdHNmVHJjTHBsSzJaK01oeVNY?=
 =?utf-8?B?QUU1Z2kxVGJRRk5pNTlkK1FuVlRGMnNOaGxiL0JSK0t6cEsyeWpSeW9FY0Jp?=
 =?utf-8?B?dDZadVNIMEphTWZad1JBNmczRjRIWUpwV3d0VU1yczZreGVwVkVCMFlTRWpa?=
 =?utf-8?B?cGhWY1BzS3hDN2xXaE55Q3QxMVVHd0txU3RzVHV4bUwrUlA5N0JpTnVoZ2RT?=
 =?utf-8?B?SW42aWVTQWJGcDlHaGFKSkN2R1NSaHN1RSs0ZGFUcXczRXhKWnE4TkJML0xs?=
 =?utf-8?B?NVhJempxQ0lFNzRWUUt3MEZHVnY2YUdlcnkxcDQxNWNxM1R6bTErbkZOZStV?=
 =?utf-8?B?TElTYlEzTWt4bUw2d3h6QUtTSGNGaE1mVHlyaWg4alRtRmtEWG1NK3pJK3Vr?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0C952F5C76C864C9B2CF297E47B9D37@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f213f13-223f-44d0-8b45-08dcedbb336d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 08:19:05.7056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uEZTrXHIY8GZ1Dm0EArub9Qmen+YqG6HXkOp+RclLJq8RWpCetQxCtrrhOChGuADPLXF7YWe/bU1DpZKN3kVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_011911_371815_4FE6DA88 
X-CRM114-Status: GOOD (  24.35  )
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

SGkgTmF0aGFuLA0KDQpPbiBUdWUsIDIwMjQtMTAtMTUgYXQgMTk6MzQgLTA3MDAsIE5hdGhhbiBD
aGFuY2VsbG9yIHdyb3RlOg0KPiBPbiBUaHUsIFNlcCAxOSwgMjAyNCBhdCAwMjo0NTowM1BNICsw
MjAwLCBCZW5qYW1pbiBCZXJnIHdyb3RlOg0KPiAuLi4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC91
bS9rZXJuZWwvc2thcy9NYWtlZmlsZQ0KPiA+IGIvYXJjaC91bS9rZXJuZWwvc2thcy9NYWtlZmls
ZQ0KPiA+IGluZGV4IDZmODZkNTNlM2Q2OS4uZmJiNjE5NjgwNTVmIDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvdW0va2VybmVsL3NrYXMvTWFrZWZpbGUNCj4gPiArKysgYi9hcmNoL3VtL2tlcm5lbC9z
a2FzL01ha2VmaWxlDQo+ID4gQEAgLTMsMTQgKzMsNDMgQEANCj4gPiDCoCMgQ29weXJpZ2h0IChD
KSAyMDAyIC0gMjAwNyBKZWZmIERpa2UNCj4gPiAoamRpa2VAe2FkZHRvaXQsbGludXguaW50ZWx9
LmNvbSkNCj4gPiDCoCMNCj4gPiDCoA0KPiA+IC1vYmoteSA6PSBzdHViLm8gbW11Lm8gcHJvY2Vz
cy5vIHN5c2NhbGwubyB1YWNjZXNzLm8NCj4gPiArb2JqLXkgOj0gc3R1Yi5vIG1tdS5vIHByb2Nl
c3MubyBzeXNjYWxsLm8gdWFjY2Vzcy5vIFwNCj4gPiArCSBzdHViX2V4ZV9lbWJlZC5vDQo+ID4g
Kw0KPiA+ICsjIFN0dWIgZXhlY3V0YWJsZQ0KPiA+ICsNCj4gPiArc3R1Yl9leGVfb2Jqcy15IDo9
IHN0dWJfZXhlLm8NCj4gPiArDQo+ID4gK3N0dWJfZXhlX29ianMgOj0gJChmb3JlYWNoIEYsJChz
dHViX2V4ZV9vYmpzLXkpLCQob2JqKS8kRikNCj4gPiArDQo+ID4gKyMgT2JqZWN0IGZpbGUgY29u
dGFpbmluZyB0aGUgRUxGIGV4ZWN1dGFibGUNCj4gPiArJChvYmopL3N0dWJfZXhlX2VtYmVkLm86
ICQoc3JjKS9zdHViX2V4ZV9lbWJlZC5TICQob2JqKS9zdHViX2V4ZQ0KPiA+ICsNCj4gPiArJChv
YmopL3N0dWJfZXhlLmRiZzogJChzdHViX2V4ZV9vYmpzKSBGT1JDRQ0KPiA+ICsJJChjYWxsIGlm
X2NoYW5nZWQsc3R1Yl9leGUpDQo+ID4gKw0KPiA+ICskKG9iaikvc3R1Yl9leGU6IE9CSkNPUFlG
TEFHUyA6PSAtUw0KPiA+ICskKG9iaikvc3R1Yl9leGU6ICQob2JqKS9zdHViX2V4ZS5kYmcgRk9S
Q0UNCj4gPiArCSQoY2FsbCBpZl9jaGFuZ2VkLG9iamNvcHkpDQo+ID4gKw0KPiA+ICtxdWlldF9j
bWRfc3R1Yl9leGUgPSBTVFVCX0VYRSAkQA0KPiA+ICvCoMKgwqDCoMKgIGNtZF9zdHViX2V4ZSA9
ICQoQ0MpIC1ub3N0ZGxpYiAtbyAkQCBcDQo+ID4gKwkJCcKgwqAgJChLQlVJTERfQ0ZMQUdTKSAk
KFNUVUJfRVhFX0xERkxBR1MpIFwNCj4gPiArCQkJwqDCoCAkKGZpbHRlciAlLm8sJF4pDQo+ID4g
Kw0KPiA+ICtTVFVCX0VYRV9MREZMQUdTID0gLW4gLXN0YXRpYw0KPiANCj4gQWZ0ZXIgdGhpcyBj
aGFuZ2UgaW4gLW5leHQgYXMgY29tbWl0IDMyZThlYWYyNjNkOSAoInVtOiB1c2UgZXhlY3ZlYXQN
Cj4gdG8NCj4gY3JlYXRlIHVzZXJzcGFjZSBNTXMiKSwgSSBhbSBzZWVpbmcgYW4gZXJyb3Igd2hl
biBidWlsZGluZyBBUkNIPXVtDQo+IGRlZmNvbmZpZyB3aXRoIGNsYW5nLg0KPiANCj4gwqAgJCBt
YWtlIC1za2oiJChucHJvYykiIEFSQ0g9dW0gTExWTT0xIG1ycHJvcGVyIGRlZmNvbmZpZyBsaW51
eA0KPiDCoCBjbGFuZzogZXJyb3I6IHVua25vd24gYXJndW1lbnQ6ICctbicNCj4gwqAgbWFrZVs3
XTogKioqIFthcmNoL3VtL2tlcm5lbC9za2FzL01ha2VmaWxlOjE5Og0KPiBhcmNoL3VtL2tlcm5l
bC9za2FzL3N0dWJfZXhlLmRiZ10gRXJyb3IgMQ0KPiDCoCAuLi4NCj4gDQo+IEkgaGF2ZSBsb29r
ZWQgdGhyb3VnaCB0aGUgR0NDIG1hbnVhbCBhbmQgb3B0aW9ucyBpbmRleCBidXQgSSBkbyBub3QN
Cj4gc2VlDQo+IHdoYXQgJy1uJyBpcy4gV2FzIHRoaXMgaW50ZW5kZWQgdG8gYmUgcGFzc2VkIHRv
IHRoZSBsaW5rZXIgbGlrZSAtV2wsLQ0KPiBuDQo+IG9yIHdhcyB0aGVyZSBzb21lIG90aGVyIG9w
dGlvbiB0aGF0IHRoaXMgc2hvdWxkIGJlPyBJZiBJIHRyeSBkcm9wcGluZw0KPiBpdCwgSSBlbmQg
dXAgcnVubmluZyBpbnRvIGFub3RoZXIgaXNzdWUsIHdoaWNoIGNvdWxkIGJlIGVudGlyZWx5DQo+
IHVucmVsYXRlZC4NCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LCBpdCB3YXMgc3VwcG9zZWQgdG8gYmUg
cGFzc2VkIHRvIHRoZSBsaW5rZXIgYW5kIHRoZQ0Kb25seSBwb2ludCBpcyB0byBtYWtlIHRoZSBl
bGYgYmluYXJ5IGEgYml0IHNtYWxsZXIgdGhhdCB3aWxsIGJlDQplbWJlZGRlZCAodGhlIC0tbm1h
Z2ljIGxkIG9wdGlvbikuDQoNCkFueXRoaW5nIHdvcmtzIGZvciBtZS4gV2UgY2FuIGNoYW5nZSBp
dCB0byAtV2wsLW4gaWYgaXQgd29ya3Mgb3IgZXZlbg0KanVzdCBkcm9wIGl0IGVudGlyZWx5Lg0K
DQpCZW5qYW1pbg0KDQoNCj4gwqAgJCBtYWtlIC1za2oiJChucHJvYykiIEFSQ0g9dW0gTExWTT0x
IG1ycHJvcGVyIGRlZmNvbmZpZw0KPiBhcmNoL3VtL2tlcm5lbC9za2FzLw0KPiDCoCAvdXNyL2Jp
bi9sZDogYXJjaC91bS9rZXJuZWwvc2thcy9zdHViX2V4ZS5vOiBpbiBmdW5jdGlvbiBgX3N0YXJ0
JzoNCj4gwqAgYXJjaC91bS9rZXJuZWwvc2thcy9zdHViX2V4ZS5jOjgzOigubHRleHQrMHgxNSk6
IHVuZGVmaW5lZA0KPiByZWZlcmVuY2UgdG8gYG1lbXNldCcNCj4gwqAgY2xhbmc6IGVycm9yOiBs
aW5rZXIgY29tbWFuZCBmYWlsZWQgd2l0aCBleGl0IGNvZGUgMSAodXNlIC12IHRvIHNlZQ0KPiBp
bnZvY2F0aW9uKQ0KPiDCoCBtYWtlWzddOiAqKiogW2FyY2gvdW0va2VybmVsL3NrYXMvTWFrZWZp
bGU6MTk6DQo+IGFyY2gvdW0va2VybmVsL3NrYXMvc3R1Yl9leGUuZGJnXSBFcnJvciAxDQo+IA0K
PiBDaGVlcnMsDQo+IE5hdGhhbg0KPiANCj4gPiArdGFyZ2V0cyArPSBzdHViX2V4ZS5kYmcgc3R1
Yl9leGUgJChzdHViX2V4ZV9vYmpzLXkpDQo+ID4gKw0KPiA+ICsjIGVuZA0KPiA+IMKgDQo+ID4g
wqAjIHN0dWIubyBpcyBpbiB0aGUgc3R1Yiwgc28gaXQgY2FuJ3QgYmUgYnVpbHQgd2l0aCBwcm9m
aWxpbmcNCj4gPiDCoCMgR0NDIGhhcmRlbmVkIGFsc28gYXV0by1lbmFibGVzIC1mcGljLCBidXQg
d2UgbmVlZCAlZWJ4IHNvIGl0DQo+ID4gY2FuJ3Qgd29yayAtPg0KPiA+IMKgIyBkaXNhYmxlIGl0
DQo+ID4gwqANCj4gPiDCoENGTEFHU19zdHViLm8gOj0gJChDRkxBR1NfTk9fSEFSREVOSU5HKQ0K
PiA+IC1VTlBST0ZJTEVfT0JKUyA6PSBzdHViLm8NCj4gPiArQ0ZMQUdTX3N0dWJfZXhlLm8gOj0g
JChDRkxBR1NfTk9fSEFSREVOSU5HKQ0KPiA+ICtVTlBST0ZJTEVfT0JKUyA6PSBzdHViLm8gc3R1
Yl9leGUubw0KPiA+IMKgS0NPVl9JTlNUUlVNRU5UIDo9IG4NCj4gPiDCoA0KPiA+IMKgaW5jbHVk
ZSAkKHNyY3RyZWUpL2FyY2gvdW0vc2NyaXB0cy9NYWtlZmlsZS5ydWxlcw0KDQpJbnRlbCBEZXV0
c2NobGFuZCBHbWJIDQpSZWdpc3RlcmVkIEFkZHJlc3M6IEFtIENhbXBlb24gMTAsIDg1NTc5IE5l
dWJpYmVyZywgR2VybWFueQ0KVGVsOiArNDkgODkgOTkgODg1My0wLCB3d3cuaW50ZWwuZGUNCk1h
bmFnaW5nIERpcmVjdG9yczogU2VhbiBGZW5uZWxseSwgSmVmZnJleSBTY2huZWlkZXJtYW4sIFRp
ZmZhbnkgRG9vbiBTaWx2YQ0KQ2hhaXJwZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOiBO
aWNvbGUgTGF1DQpSZWdpc3RlcmVkIE9mZmljZTogTXVuaWNoDQpDb21tZXJjaWFsIFJlZ2lzdGVy
OiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIgMTg2OTI4Cg==


