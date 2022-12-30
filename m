Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4E0C4332F
	for <linux-um@archiver.kernel.org>; Fri, 30 Dec 2022 23:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q9sj6AlGSV6DXxuUDfyCbz3h8MGEnvvhCKwxmtfYn2U=; b=On/hdcQ2sQr5V8
	JZDpQXBKVwlvfQ3U+6e7v9oVrxhitou5FhmvtlpfygcUiztme2UP3wR5fgWIyENaO/abdNe5oyONV
	3oWDI10+XFo0y6iAsXBUAz16nrszk3ZKfjkqw0kPAqN3PK30CIuYfDksMNDnXOVamIZhmJiTfQ4ZB
	06QXsVUPMQhDSGLFrTeBhDbIF6QXZe8bxt9N6mnpTNh3r48N86uWAAuGy8Ygr/KR8sTmIeGxD7/kS
	Suvwe3bYPLYTwVvMsGDAtMxtxgA2oKH2uPB5/7ymmiNA1mvVZlpX5nuly8uX8K53SFSRoXIJ5+LEI
	/+FSqtBRBMGKN0sCYD2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pBP9D-00F29Q-Tq; Fri, 30 Dec 2022 23:50:47 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pBP8x-00F1mr-H0
	for linux-um@lists.infradead.org; Fri, 30 Dec 2022 23:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672444230; x=1703980230;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hgM2UEd3gMAQDUIrIkG30AoMQt4xG7B0VYWuOd4ceDk=;
  b=EZS3FmTp7b0kaQ26gD/HOXon2Rr5XsB7xdstZvtsy/2gOtKVTz+coc26
   bwm/cA0BJ5kEGpQd9pDKqXFBhVYDgBC9gZ+QtqCmJa0na/eSe4AWx168O
   B3ap0cRSCq0Lv+xNSHc/VkQXU0nHmBcK2gKGl0lgJBkYlGl4Faj9vTroN
   FPKVgnW/M6tuYXx3ya5Rcv7ia/ZmcG0sF5wmDyW+nfK/I7xfWaxQ7ACi7
   84vj+QaZe2fi/dQqg+UcBW77VUt4AsDOBoZB9nBoTHML2i702xqIdXDUO
   6MmJd60r3ZkLDY2Dcg9yLGHV2il284eW+waDQA19dcuKpqgPpVIB1ElZg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="323256191"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="323256191"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 15:50:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="982763588"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="982763588"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 30 Dec 2022 15:50:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 15:50:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 15:50:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 30 Dec 2022 15:50:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 30 Dec 2022 15:50:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R84UmuPQnJzSWFj2ubhUZGIw5YTzaGpQYHF+Fkyt1o0k4ZqSJI8EleeLCjwNcvawx2tQsyVeKW5+wY2vkkxd2rCF6fgDfVBuOkwfwqgMAe/fHwyr8WbHbXpH/1OB0agt2EWPOOAK9rcBuvk2CWYtt8a4ihIDJbQM21xVhy82A31v+6UQkzwFc2ryCLOeMbUguOOlS3wlOjZPQzVHhLHVgmP45xv59OEDYsCSupDyzCStioDjoKbczWgvVwVyA6ElcCO4FpF2KtXf2pQiwsoWZClar9Aud1JCQf2S0S3Apbq8VFPfK7KMo6YQKGMVBzuDQUaZ+yLd4xdQN7n09D5cJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBwzB22qvV8nA9yCHEmXtf6uMMy243RmrLZsuJbbKnw=;
 b=P04sX/DQ4LwER2vAqeAlyaC2Nh7aSCB0VqIbi6heH6tnYdjliyv2GelOsJDcSHY1SaHsdDgo33LR6nU4AtlLKbN++shGWyj+rq9lawbbPX1qEJ8/OUAAee9nOON2zrmERdpsup0ayciC++knm3q3d5NWtesaIFC8jeOmlLPqGJjwD/079WQU2AfvOkvJtuqEOTUnbY1mZ3flfmfmWW4D0S48ComeV8kpK5NV3QTmBDIrDAl8ks1sBvrc00m9WmEwE++8m3bRc0wzByt7l40VkclvPIrMwviU/0EwT/g5P3Dx+aC62dHKOcoc1v5/GAU1PY0C+HB0+RP2gVlqbIzxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by CY5PR11MB6235.namprd11.prod.outlook.com (2603:10b6:930:24::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 23:50:20 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::dcc2:a123:be56:c530]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::dcc2:a123:be56:c530%9]) with mapi id 15.20.5944.018; Fri, 30 Dec 2022
 23:50:20 +0000
Date: Fri, 30 Dec 2022 15:50:16 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>,
	<linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Subject: Re: [PATCH] fs/hostfs: Replace kmap() with kmap_local_page()
Message-ID: <Y695OHrq+UmvVeez@iweiny-desk3>
References: <20221013161700.11631-1-fmdefrancesco@gmail.com>
Content-Disposition: inline
In-Reply-To: <20221013161700.11631-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|CY5PR11MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 02586cfe-5418-48ea-68b3-08daeac09c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F44ehOLY2m6rlTbB+W8oQjtdjmgvbslMsyf8aHy5qAgWvvoOxLXHN9vZbgE+a/IcCmt9exmm0agTj4+rjt+T42PJPzBu78yHPyB08GK89KTv1pNOLPY7e3jDIx2s6OkCpKJUQcUnadF5YGhnE34FZLxPZPtpd7bfQFcEIWV9E4n59BxaLkh8/zaEtWZcK8OcHU0bo9CkLPVZvxox18oxYmlH+Og54ZoZ48WKKlYhNBvzK3jUnRiIGZaO48oYYbXFmknYTHfMXaf2XGFBl/RAn4qkDHdrhtXGvS4gbNSNt9GdLDKFXCPmKyBGRWH4KCBnV1BD6dVU8m3jVDjeY13DLNnYljoCQkLpMn5quryCvB5hx8JeQ+NgLjgWsCKMnYELrbbO8B2GVrildE5yKlDYjPG2dU4xh8HUkAg1GOoZpqGfJAkpvs1QJ0qlcEFuat1nbELSDr0aFEpxS8HSNSIk7nTDJK+prdFqHoYPE/7/BxWz+MPTQHIMZxYHvdFr9YnVUpypUsDm+/wL8gxQZ7GL2ykdM/b7gTzqhYvxZXECnxq172DmJyA/rK5xkkEguquq+0LVZPKh0R+zHla0M0CznexymNCtgG0wYi56P5NePDKOiLcO02DZgKzh/UmcRtblr+9CX9EWSTdLwml8ceHgMRB52QRxtk3VO9dGlV9A5SJmcmgOQjebxqIrUcH6hQad
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(66556008)(66476007)(4326008)(8676002)(5660300002)(66946007)(9686003)(44832011)(8936002)(6512007)(41300700001)(26005)(83380400001)(2906002)(6916009)(54906003)(186003)(478600001)(6486002)(316002)(86362001)(6506007)(107886003)(6666004)(33716001)(82960400001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdKYnY2ays3Z2ZVVi80Q290eXJGL2pobTU1LzAxTm52dE9lQldTUWppbzhY?=
 =?utf-8?B?Wm05WjAxdmI5RWh0eDQvdlo1MmRBd09YelVsUFNWV21ycnBsaEY2ajJqaTJG?=
 =?utf-8?B?NUExWVJTSXJFQldOb0xONGlaT1hSRVNjUE1zZ0U3NTY2Vll0NStSVy9zRWZM?=
 =?utf-8?B?Qi9rbGEzY2FxMmVqQ1Z6WVkyV3ZLdW5GVlp1SUF0UElqTzJ2SUgxYVdwYjBt?=
 =?utf-8?B?MHA3OWRESEhWbjFFTEJMRndaWE5DZGVWb1RBcEQ4ZDlDWk5aMTdJNmViR3pZ?=
 =?utf-8?B?LzdXVC96WjRJcGQzRVM1N0FidnlYT2RwaFVGUENpMG9FVG5rTHFpRXl3ZVRm?=
 =?utf-8?B?SGlpU1dDUzdMWU90MjFJVnZ0V3diMFZ0bzZ2TVd0bWY5ODdHdWdMNTltWFB5?=
 =?utf-8?B?aUEvVG9vZGQxYVNvZ0tGbFJFRzlIR2FXRlNKZENJUVhBUzJyVlIzK0ZkN0Ji?=
 =?utf-8?B?ZThvK1NsM0ZPZTQ1UUFZZUpFTmMvV2VQTlE0eitvWmJBV1g4UkRBZGkrNGNR?=
 =?utf-8?B?eEJkOVZlNTFGYTFoRGY0NVlJRVZPTUZERGFNc2tHaTJ5RTFmY3VVOWNtTEtS?=
 =?utf-8?B?NkxSQXB1NFFieTBneDVOZUhzNzM1NkRvdXphT0FYMkF6ZzBIQlRFaFY2NzV4?=
 =?utf-8?B?Wk13aGxBT2hDeU9iOHZEdjZoMVRyeVgybUFUYlJIM1JzWWhDTVFnVHphLzJu?=
 =?utf-8?B?eFhUa1d0VEYzeks4cldYa2FIdTduODQ4QUtRSHliVUJ5cEJVSHIzaTBRSlhY?=
 =?utf-8?B?MndVR0hSc3N2YmwxbnQ5STJyKzlZQ2RSb1Z0TDNlUDVaZEluVTBDbXJwaklE?=
 =?utf-8?B?d0lnTnVjd01LM213bURYaHJBNWw4Nlp3OThxQlBlVkZabXpBMmpqdWtveTNx?=
 =?utf-8?B?SWQ0Y1pRSmNvYUx6TDlQR0ZORXdVZXFucXhudTlNbGhxMmIyelZsYVgzNXBV?=
 =?utf-8?B?RXJWaG12UEk1eThKMkthVTJGcHdPRTNVOENxZVFYaSt3RVpNQ3FIVTIvNmhh?=
 =?utf-8?B?NGpSbmlrWmdYR2tUTHg2ZUNKa1crUTVZd2JUZmtuUitNdkJFaGFoc2FXQ1Nm?=
 =?utf-8?B?Y2FlWFZNQ3EwRnZvSDBoT05QQzkyd1VCVkYrNThiQVFWUG10Q1JNTjQ2RUVB?=
 =?utf-8?B?NjByUVVhZm9BK0FUdXRDWHU4U0szTDlJZWhjdlY3T3ZLRlgzZVU0WjA3WXJD?=
 =?utf-8?B?RG1KNHlmQUY5d0tRdithYyt0ZEJtQ1VtajAwd0tyNG51dG05MkZEZFVtREZ5?=
 =?utf-8?B?MXVBbEVoSmhGM1paUWpZcDNJK0tvaUVCVGUvaGY0c1d5S3d5RVZiNmx3Nnk1?=
 =?utf-8?B?NWJkYlpQUUhTRHJROCtDWTQwMEVLLzhwdU5PbUFYMkw2cmF5ZzNPZW5HNjhZ?=
 =?utf-8?B?dEN4TEhlWC8yaEhjMktKSEVQL1dnN21UcDFFQmpGNVprekFkclBsZ3hXWWFk?=
 =?utf-8?B?QktzYjM4djlNMFFrQkNTcUhvekZqUmRqOFkrSy9Yckd4QjJjcFNmL3BSSmo1?=
 =?utf-8?B?T0w5cTJxQUpZMURTSmtWaWVzdzg1K2luS0h5QkRFc0RyMDR0bnFEbTM3c0ZX?=
 =?utf-8?B?YjBoN2pzaHVxT25VOWk4QVJvQ0h6VU05TjkyZ0dmVkFTcWhuVzJ3UU53UnFG?=
 =?utf-8?B?L3ZOZUdrbVoxUEovZyt1bnQrY0xWSVRlM2U1Q3ppWmJaU2hPNDQ5ZmJHdVlC?=
 =?utf-8?B?U3NxT2MwNm02NlJZSWRlS2ZvMWFDb3EzZlZtUGRCLzVpb2FsVW1sQkpGQ2Jo?=
 =?utf-8?B?WmFBaEc2emhWdTJDZWl2aW5vZytocU5rczVOUXY4NnczbzQyNWtPVWVCY1U3?=
 =?utf-8?B?bnh5THVnbnZPT3plenk3NTNYQkxwNTNBdzh2cVZEYTZ2amc0ME1wd2duSkc5?=
 =?utf-8?B?clEwMVd0SEJIZnk2MXIxQTlDd3NMYVBnRVFuNlkrSGpxcHpnUlFhMzJkYXg3?=
 =?utf-8?B?RGVLSDdHZlNXWmFxNW5qNnpoZER4RytLK1RvcnZOdXFaKzBmSWMwc3VCbis3?=
 =?utf-8?B?VGhySFhtcWduOW1YVjRmSW5Cbno3Q1Vrbm91WldZZWR4dDkxMTBVWm9DL1N1?=
 =?utf-8?B?L3krZmcyRUdQV3pNbWZUZERBZ1RLU296dldTNGNDNDdJSUE5K00raS9obnMx?=
 =?utf-8?Q?pxT2hasgqcTKF4t8ShpiOxG5D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02586cfe-5418-48ea-68b3-08daeac09c63
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 23:50:20.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: En/VErmHfL8TqLvGQ1Y0EUxd2nUnlOLu588QLHMJNdQnUuXvf/JkgQ8ciY6e/MgiFOIUP4LepsLaIJx5ctVVfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6235
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221230_155031_703141_B33594CC 
X-CRM114-Status: GOOD (  27.05  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBPY3QgMTMsIDIwMjIgYXQgMDY6MTc6MDBQTSArMDIwMCwgRmFiaW8gTS4gRGUgRnJh
bmNlc2NvIHdyb3RlOgo+IFRoZSB1c2Ugb2Yga21hcCgpIGlzIGJlaW5nIGRlcHJlY2F0ZWQgaW4g
ZmF2b3Igb2Yga21hcF9sb2NhbF9wYWdlKCkuCj4gCj4gVGhlcmUgYXJlIHR3byBtYWluIHByb2Js
ZW1zIHdpdGgga21hcCgpOiAoMSkgSXQgY29tZXMgd2l0aCBhbiBvdmVyaGVhZCBhcwo+IHRoZSBt
YXBwaW5nIHNwYWNlIGlzIHJlc3RyaWN0ZWQgYW5kIHByb3RlY3RlZCBieSBhIGdsb2JhbCBsb2Nr
IGZvcgo+IHN5bmNocm9uaXphdGlvbiBhbmQgKDIpIGl0IGFsc28gcmVxdWlyZXMgZ2xvYmFsIFRM
QiBpbnZhbGlkYXRpb24gd2hlbiB0aGUKPiBrbWFw4oCZcyBwb29sIHdyYXBzIGFuZCBpdCBtaWdo
dCBibG9jayB3aGVuIHRoZSBtYXBwaW5nIHNwYWNlIGlzIGZ1bGx5Cj4gdXRpbGl6ZWQgdW50aWwg
YSBzbG90IGJlY29tZXMgYXZhaWxhYmxlLgo+IAo+IFdpdGgga21hcF9sb2NhbF9wYWdlKCkgdGhl
IG1hcHBpbmdzIGFyZSBwZXIgdGhyZWFkLCBDUFUgbG9jYWwsIGNhbiB0YWtlCj4gcGFnZSBmYXVs
dHMsIGFuZCBjYW4gYmUgY2FsbGVkIGZyb20gYW55IGNvbnRleHQgKGluY2x1ZGluZyBpbnRlcnJ1
cHRzKS4KPiBJdCBpcyBmYXN0ZXIgdGhhbiBrbWFwKCkgaW4ga2VybmVscyB3aXRoIEhJR0hNRU0g
ZW5hYmxlZC4gRnVydGhlcm1vcmUsCj4gdGhlIHRhc2tzIGNhbiBiZSBwcmVlbXB0ZWQgYW5kLCB3
aGVuIHRoZXkgYXJlIHNjaGVkdWxlZCB0byBydW4gYWdhaW4sIHRoZQo+IGtlcm5lbCB2aXJ0dWFs
IGFkZHJlc3NlcyBhcmUgcmVzdG9yZWQgYW5kIHN0aWxsIHZhbGlkLgo+IAo+IFRoZXJlZm9yZSwg
cmVwbGFjZSBrbWFwKCkgd2l0aCBrbWFwX2xvY2FsX3BhZ2UoKSBpbiBob3N0ZnNfa2Vybi5jLCBp
dAo+IGJlaW5nIHRoZSBvbmx5IGZpbGUgd2l0aCBrbWFwKCkgY2FsbCBzaXRlcyBjdXJyZW50bHkg
bGVmdCBpbiBmcy9ob3N0ZnMuCj4gCj4gQ2M6ICJWZW5rYXRhcmFtYW5hbiwgQW5pcnVkaCIgPGFu
aXJ1ZGgudmVua2F0YXJhbWFuYW5AaW50ZWwuY29tPgo+IFN1Z2dlc3RlZC1ieTogSXJhIFdlaW55
IDxpcmEud2VpbnlAaW50ZWwuY29tPgoKV2hhdCBjYW4gd2UgZG8gdG8gbW92ZSB0aGlzIHBhdGNo
IGFsb25nPwoKSSdtIG5vdCBhbiBleHBlcnQgYnV0IGl0IGxvb2tzIG9rIHRvIG1lLgoKUmV2aWV3
ZWQtYnk6IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4KCj4gU2lnbmVkLW9mZi1ieTog
RmFiaW8gTS4gRGUgRnJhbmNlc2NvIDxmbWRlZnJhbmNlc2NvQGdtYWlsLmNvbT4KPiAtLS0KPiAK
PiBUaGVzZSBjaGFuZ2VzIGFyZSBub3QgdGVzdGVkIGluIGEgMzIgYml0cyBWTSBhcyBJIHVzZSB0
byBkbyB3aXRoIG90aGVyIG1vcmUKPiBwcm9ibGVtYXRpYyBjb252ZXJzaW9ucy4gTWVyZSBjb2Rl
IGluc3BlY3Rpb24gbWFrZXMgbWUgcmVhc29uYWJseSB0aGluawo+IHRoYXQgdGhlIHJ1bGVzIG9m
IGxvY2FsIG1hcHBpbmdzIGFyZSBub3QgdmlvbGF0ZWQgYnkgdGhpcyBjb252ZXJzaW9uLgo+IAo+
IEZ1cnRoZXJtb3JlLCBJIGhhdmUgbm8gaWRlYSBob3cgdG8gdGVzdCB0aGlzIGNvZGUuIElmIG1h
aW50YWluZXJzIHRoaW5rCj4gdGhhdCB0ZXN0cyBhcmUgYWJzb2x1dGVseSBuZWNlc3NhcnksIGFu
eSBoaW50cyBhYm91dCBob3cgdG8gcGVyZm9ybSB0aGVtCj4gd291bGQgYmUgZ3JlYXRseSBhcHBy
ZWNpYXRlZC4KPiAKPiAgZnMvaG9zdGZzL2hvc3Rmc19rZXJuLmMgfCAxNSArKysrKysrKy0tLS0t
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZnMvaG9zdGZzL2hvc3Rmc19rZXJuLmMgYi9mcy9ob3N0ZnMvaG9zdGZz
X2tlcm4uYwo+IGluZGV4IDA3ODgxYjc2ZDQyZi4uMGM5Zjg5MzUyNjAxIDEwMDY0NAo+IC0tLSBh
L2ZzL2hvc3Rmcy9ob3N0ZnNfa2Vybi5jCj4gKysrIGIvZnMvaG9zdGZzL2hvc3Rmc19rZXJuLmMK
PiBAQCAtNDEyLDcgKzQxMiw3IEBAIHN0YXRpYyBpbnQgaG9zdGZzX3dyaXRlcGFnZShzdHJ1Y3Qg
cGFnZSAqcGFnZSwgc3RydWN0IHdyaXRlYmFja19jb250cm9sICp3YmMpCj4gIAlpZiAocGFnZS0+
aW5kZXggPj0gZW5kX2luZGV4KQo+ICAJCWNvdW50ID0gaW5vZGUtPmlfc2l6ZSAmIChQQUdFX1NJ
WkUtMSk7Cj4gIAo+IC0JYnVmZmVyID0ga21hcChwYWdlKTsKPiArCWJ1ZmZlciA9IGttYXBfbG9j
YWxfcGFnZShwYWdlKTsKPiAgCj4gIAllcnIgPSB3cml0ZV9maWxlKEhPU1RGU19JKGlub2RlKS0+
ZmQsICZiYXNlLCBidWZmZXIsIGNvdW50KTsKPiAgCWlmIChlcnIgIT0gY291bnQpIHsKPiBAQCAt
NDI4LDkgKzQyOCw5IEBAIHN0YXRpYyBpbnQgaG9zdGZzX3dyaXRlcGFnZShzdHJ1Y3QgcGFnZSAq
cGFnZSwgc3RydWN0IHdyaXRlYmFja19jb250cm9sICp3YmMpCj4gIAllcnIgPSAwOwo+ICAKPiAg
IG91dDoKPiAtCWt1bm1hcChwYWdlKTsKPiAtCj4gKwlrdW5tYXBfbG9jYWwoYnVmZmVyKTsKPiAg
CXVubG9ja19wYWdlKHBhZ2UpOwo+ICsKPiAgCXJldHVybiBlcnI7Cj4gIH0KPiAgCj4gQEAgLTQ0
MSw3ICs0NDEsNyBAQCBzdGF0aWMgaW50IGhvc3Rmc19yZWFkX2ZvbGlvKHN0cnVjdCBmaWxlICpm
aWxlLCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQo+ICAJbG9mZl90IHN0YXJ0ID0gcGFnZV9vZmZzZXQo
cGFnZSk7Cj4gIAlpbnQgYnl0ZXNfcmVhZCwgcmV0ID0gMDsKPiAgCj4gLQlidWZmZXIgPSBrbWFw
KHBhZ2UpOwo+ICsJYnVmZmVyID0ga21hcF9sb2NhbF9wYWdlKHBhZ2UpOwo+ICAJYnl0ZXNfcmVh
ZCA9IHJlYWRfZmlsZShGSUxFX0hPU1RGU19JKGZpbGUpLT5mZCwgJnN0YXJ0LCBidWZmZXIsCj4g
IAkJCVBBR0VfU0laRSk7Cj4gIAlpZiAoYnl0ZXNfcmVhZCA8IDApIHsKPiBAQCAtNDU4LDggKzQ1
OCw5IEBAIHN0YXRpYyBpbnQgaG9zdGZzX3JlYWRfZm9saW8oc3RydWN0IGZpbGUgKmZpbGUsIHN0
cnVjdCBmb2xpbyAqZm9saW8pCj4gIAo+ICAgb3V0Ogo+ICAJZmx1c2hfZGNhY2hlX3BhZ2UocGFn
ZSk7Cj4gLQlrdW5tYXAocGFnZSk7Cj4gKwlrdW5tYXBfbG9jYWwoYnVmZmVyKTsKPiAgCXVubG9j
a19wYWdlKHBhZ2UpOwo+ICsKPiAgCXJldHVybiByZXQ7Cj4gIH0KPiAgCj4gQEAgLTQ4NCw5ICs0
ODUsOSBAQCBzdGF0aWMgaW50IGhvc3Rmc193cml0ZV9lbmQoc3RydWN0IGZpbGUgKmZpbGUsIHN0
cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLAo+ICAJdW5zaWduZWQgZnJvbSA9IHBvcyAmIChQ
QUdFX1NJWkUgLSAxKTsKPiAgCWludCBlcnI7Cj4gIAo+IC0JYnVmZmVyID0ga21hcChwYWdlKTsK
PiArCWJ1ZmZlciA9IGttYXBfbG9jYWxfcGFnZShwYWdlKTsKPiAgCWVyciA9IHdyaXRlX2ZpbGUo
RklMRV9IT1NURlNfSShmaWxlKS0+ZmQsICZwb3MsIGJ1ZmZlciArIGZyb20sIGNvcGllZCk7Cj4g
LQlrdW5tYXAocGFnZSk7Cj4gKwlrdW5tYXBfbG9jYWwoYnVmZmVyKTsKPiAgCj4gIAlpZiAoIVBh
Z2VVcHRvZGF0ZShwYWdlKSAmJiBlcnIgPT0gUEFHRV9TSVpFKQo+ICAJCVNldFBhZ2VVcHRvZGF0
ZShwYWdlKTsKPiAtLSAKPiAyLjM3LjMKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K
