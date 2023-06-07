Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8E7C7EE2E
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PiUJYIv+XJbYVdD+MO644pvPEyLpKoiTRDNHBoIWnMY=; b=ob24M0uK5Ruduj
	/iiNWEQ6PF73VIi/N2SR8TxhaMa2Y/AcIVzIs57lIJsbY0BMXJI+QlRf/aX1gRTX+rN+L0WG5eH0q
	Xb1Z87XY5epLFOPdXBw1eOjwgBKpZGNMrA2ZkSSDvBzIygvWzwXPHnKaVwvIK1fypK9Xe0Jy/NKRB
	DKfR2EqxhchZQmzrLf9Wr1KtB0tdPmj3sBnvyB+KNykbUalhAbQj/DJJxFsZ8CmVyn15zP1EYlnOV
	DubVu9WMZSXEhQk4ahKFdNxb4cfltmsgqNNvZZAwUd16/oF2Eizy5zU/fFHtwfar7Oo+wJn/zT/zy
	WikFVJqRAec2trTqMmKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6plq-005KZ4-0r;
	Wed, 07 Jun 2023 09:48:02 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pln-005KXc-0r
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 09:48:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686131279; x=1717667279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aTF4gfGAxzGMdNknwrnNoGjavxqjY96g0N9tUyPhzfI=;
  b=XH0qy/xE1uH0/tKZvZZ/vvFsC0OCLXCaWK04T2uEmvKw/84x+OW7iESp
   xP11WYW/mrBC85qXobRLDMjrzr98/ZnsBlNvefx5R1F3vgc1a/aFbd2tj
   5F+DHgK6LZ/d8lCUS9JtJDFE2v4oNORkY1Kd9zlwlMokdXOC2odEnk9yk
   bTCuxDjUGrbpjSlcoT50BYd+Wq+hvW7z6igHbk/xhQpJN2HOMtJnFLwy7
   7VQSurFBEUQO9CSTXabk+bXnCFHIjutDkTo3p06s+P4ldnuQSUQdpcE8m
   V+X3QuIA6NjY0T85qNbcM4LyAciNwuDxxxQtO7agJHW1vI/6pJj6E85Ru
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="346553170"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="346553170"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 02:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="883667329"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="883667329"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 07 Jun 2023 02:47:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 02:47:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 02:47:55 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 02:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noFxFGH0qvCu5jYQZqJxnW4cSaMHxVfDWljsaphhU5K8O6fUm3og3V503jT1brxFll0UfX1HLGyXSsPISxI8jl0mMEXlf8nY2yudomTAPPUTtM5yOH5DU0bCofX60R85/Iu2V1WAS9j0c/SJO1W40k47ufPyp5eehAv0ha3S9uaKmAxDVTMSMbw8BwHlg+cwUeS48G016NsBbsszpyiMQxdqoMD3rNgABYymyywqk/1VPzVFHTGROqOY/CshQFzRg3fxKIo1WX4SMovJHinr7aOZCmpOC9ZUX7gaOHMBTPjNzKGq5kyL8e2u+GivNEByrBqJMcg7M8OrWHVwJ4A2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWhxfLpR6mr4E1InuI+1J5i1R96zMMCWK0Rnvr40zmc=;
 b=ArYWqxz5CqOJbpwSaAUNOJjr9I1R2P6njA/2Y68vz7LjcIwWSUObzu80unAFmT0l2b//fmEjy4LiYt8qKyS6s2TDABmyrA1599WR9nd9406W6/ufgkD+MLtiOpyfjzWCf/ES0/FilDGxtXBOdoy5tK9MXLKLc4C7/Gz3jYz1J4kGftNCsn77fJEGLcBGkq7XFqoGLyQTMDRcf9cSNf0Du0FVso/AcMutw3Jabrqi0KCszzBHk9ZhqXa0eUJt2TGq4jxPB5Lc8n7Qp9bAvji5aB1mPO8iTjIsIwBxn76vFqFXAB9BaMuaAPWZ1/pilKGb8DQnHLItoz0MOT68JrR8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 09:47:52 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:47:52 +0000
Date: Wed, 7 Jun 2023 17:47:41 +0800
From: Philip Li <philip.li@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Richard Weinberger <richard@nod.at>, Eric Biggers <ebiggers@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>, Maxim Krasnyansky
	<maxk@qti.qualcomm.com>, anton ivanov <anton.ivanov@cambridgegreys.com>,
	linux-hardening <linux-hardening@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, kernel test robot <lkp@intel.com>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
Message-ID: <ZIBSPW0NYWaY4JFj@rli9-mobl>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
 <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
 <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
 <20230607042340.GA941@sol.localdomain>
 <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
 <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
 <ZIBJadzmheKWCErq@rli9-mobl>
 <a953b19efca20b470759b1d53beb957a11062ba1.camel@sipsolutions.net>
 <ZIBQWytL3zhWFLgd@rli9-mobl>
 <4b1c8af737eb5bccba12883f32ec43f9f292f70f.camel@sipsolutions.net>
Content-Disposition: inline
In-Reply-To: <4b1c8af737eb5bccba12883f32ec43f9f292f70f.camel@sipsolutions.net>
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH0PR11MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f404511-321a-4e9e-1186-08db673c42c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va3aJHQrcReC4SRHWTeD1rMsJHzw1UDuXlsO5J9xFtgUmklyN7aUZXxFR9PVLdCcFgifLntI7oeaS+NaA7Yxoxqbg1QX/PFzB2rs20bQ6nt8Pp8kkQdz9EWb3afcePws2XHtCg6TDwTN3VihpuUDFm30U6r0KIyRBU/iNUhFaMr6a6yBhnNsI+GHKDTaIVG+5tQmnpiAEqxqlVpAQY2SMZZ5RSv75Z02TiwniitEFLus/IG9L3KGjbH7fZ7oqNhvZcqp48VvxhejFAS/+01GBgda1pHa+VUC0eqlmGjW9J+70W1QxuP5M7YWw2e3B3f+jImFJfFCPGVUVDeNL3HtRfG/1ydADqpbYk0ipL6SY1BnfosQYS7yQvthVixVKFWOkCRmhwukgHw+QJBHMLG7tFjoK2+A4H0pSWq2k5LEsKwnH1XH56PrsPlLyuCUIsDGVzegZgiyPukHzurPqmcuUNuoDnpwNOo68XfsLpNXa/08btJu6o+2+dbv8Nboo+mCCjpbFtn+AkxDv0uf60nFT3B7ICbkE9hKS8vayygYBxjUoV+Mkhh1wXva0c7NSB14
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(478600001)(54906003)(107886003)(41300700001)(6506007)(5660300002)(6666004)(316002)(6486002)(26005)(44832011)(66899021)(4326008)(66556008)(66476007)(6916009)(66946007)(9686003)(6512007)(186003)(7416002)(2906002)(4744005)(38100700002)(82960400001)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yUOHsDHLKn/CHz7DRkGg+uVJLKG4TlJv0G2I45+ACoF+xIWAyxxnnIqzkk7Y?=
 =?us-ascii?Q?l6rMKsU6uHe3/CyeT80Inkw8Kt5dIlIPiYfDv3Bjv5OrUDIlZURVOny4+Mms?=
 =?us-ascii?Q?O+UfAKju2BeILh6mRGx6MXNk1irH4O1Z5zP4hrmQcafBJW6nmJi/IiSXA45Q?=
 =?us-ascii?Q?8RZH4KD4X920vk1xvaSyn/bNZHOJzaJspqY4HBkJrONnRHzyEIooctwHlOCg?=
 =?us-ascii?Q?CCjJhSvtFFw6JOiri/95h5StAohrUfb6EMuvSjAd4pVIMZT2RwohfS6Ugr0K?=
 =?us-ascii?Q?XUxSeQ8v4jJe9Q6SBTS+Kr2ZsG6EoBVCdDadstHODMpzFUzKv3Cbao43rTb4?=
 =?us-ascii?Q?sUOjaD10KtqO8sszfJ5OBxuYkQwVGq+VI6qRADpQ5uTwfHOYdsFn0adqrFJR?=
 =?us-ascii?Q?pTmODrc4j8FzHhUmzXozepLzq/aMzTawIuiXoNlN+oZgwgSf5muWpo+34rt3?=
 =?us-ascii?Q?uu5DTBVhfIozle/dHk47zU2qXMEJv+kzHNUSZ2vNkRYrA4lJarQoOmmewCSl?=
 =?us-ascii?Q?idLnlo3ki9FU13dDJ7Aen7LFMblSL0J+vbUR8PJCrBZuBvngr/rPmRBnp3Zn?=
 =?us-ascii?Q?gwwFnbWPtOGnLt54ZdGfBBbWtwqyOT7hpjnOvAAlIn8YOfq/XMPZQBAG8cME?=
 =?us-ascii?Q?r2R7NTpCYyKgSIFERdr24LlIPRQ9+f8NRYt3cgvaPrs0myXaVsnRgJHLYi1S?=
 =?us-ascii?Q?FreGrZXLmHeBOwEEXy5R39DLRyvs7yuoQAaX8UDVUFahOTsGiLcgUPElt7Og?=
 =?us-ascii?Q?Dc82hve7+f+dVVDnXjYmmRL4QT0fFER0ofnDuokIRYMki2Yw43o8z+0PjLRU?=
 =?us-ascii?Q?86dq4c73kizRR1lfKkj4QDERiM2XQ37dnAJPrHmk40vrZBq5Tz/LLjtskGcH?=
 =?us-ascii?Q?JqnQajOmBHFPOYb1nuv/Ssw4WKsQ3NOsXG0QdkcW0UQGNp46lIaaxVS0dRfX?=
 =?us-ascii?Q?13Io3NVmWF7AQmsF3DiS9rovZjGFH5tFlG5lsNnSJmDE6BDfuQspHV0nVePb?=
 =?us-ascii?Q?8El5lC8a6G+74H+VV2f7ySusVnZbnW+UE/L3EViurMR99J3gEwRP3b1VlAoZ?=
 =?us-ascii?Q?HHrVpk99spGq7eomN4dRi/50kMlA7yOEyo6S01Ov6x/tZabHjoS7dumZuhWB?=
 =?us-ascii?Q?jz/bo2rlju6iDMQ3Bs87O+VJ0Bzkd6ZM9yzLBx9G6sOp5IXh+rEr8fPvwi8O?=
 =?us-ascii?Q?i9kpX94uUSmx/ulnLkX0A3qy3J+ayNZIDQGWr5kTxOdixeH4rAOUncUItZQq?=
 =?us-ascii?Q?HISuF7gecWbk1vKZvRfOhmgNHY5QC5AgrEP7TsU7qk9nntkOrXJq1c3XBXjJ?=
 =?us-ascii?Q?yma4w/rhXxfAEU+dfpZQ+lTcUvMlNdPGDLWDQy/2Sc1ofQufDAAIEe3q1/u5?=
 =?us-ascii?Q?s13ZsFsdIq8M0qjveYWRoZW+YMYFNrDDK6CZQ4/ot8tBZ4eoWilfumaEJqKC?=
 =?us-ascii?Q?2bKxMK5Wy57J5vbTQvFLYQfPYpc5aI16+gHmKVoV0TOsvFS6IYul4lUlGQFl?=
 =?us-ascii?Q?svBMJ0IMsEsW8ywCzxRDtPwGW3sJw/e7CTBJMLKdlgAOSPS1nGL6mR1H4PqN?=
 =?us-ascii?Q?jxOffVTxKYDMB6bG1OSpOi73FE8XY9sosf/BmwIY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f404511-321a-4e9e-1186-08db673c42c5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 09:47:52.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6v0Dgfjj790D66QxSUmPwfcZtEUxypPmhCnB3CmYU4QLcN3o/RB29oeM6jvoezvchwVj3yM8uM4JLICJzPCMZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_024759_349392_F9D7E860 
X-CRM114-Status: GOOD (  19.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wed, Jun 07, 2023 at 11:43:11AM +0200, Johannes Berg wrote:
> On Wed, 2023-06-07 at 17:39 +0800, Philip Li wrote:
> > 
> > Is that ok we just take this phrase as a quick improvement for first step, which
> > is
> > 
> > "If you fix the issue in a separate patch/commit (i.e. not just a new
> > version of the same patch/commit), kindly add following tags:"
> > 
> > This could help remind for most cases if not all. Also this allows us
> > not doing "complex" judgement by the bot itself.
> 
> Sure, feel free. But yeah, that was the idea, that the decision logic
> wouldn't really need to be in the bot, that feels very difficult.
> 
> Maybe someone else on the thread will have a better suggestion :)

Thanks a lot, we will adjust the phrase like this as initial step to resolve
some confusions. And as you said, we welcome more suggestions to improve
the bot.

> 
> 
> johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
