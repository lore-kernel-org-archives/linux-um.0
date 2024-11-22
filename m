Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6465FD75E32
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oe7aQZV70rEvjDjRGPjej6HjDoioRUK98LvEwrDWyEY=; b=ZAxnXnuFmTR12tCtNeDdmVBYcA
	WfqwZR5Xss5XguKiekqA0hPBHQmuTSlpxeV88vdQeC4I5/Qo6N4XohIX23q5xcbqgFLpcb3dRtzo/
	U+46wzG8sBOe8Hyb5LJVGlTPqniL1jW54HVA88c6xACG56wT6aPl3kL9ZqFDEU7JTqXjvwNhMLx5u
	J2TG/a6Yl0Lq5PKHX5daqewkGZBrdOdjH5WzQkNq1xDeH24MrdBsI9m0wV0Aw8HH3ch2LI13KKJ9R
	dNoLjGg3OMFyalnaKLy0hHgrLqIkZlTZuh6MNa9h0O26jYLJizFW0PQ2lRqD7VWpBU7habx7egMga
	6usU4Sdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tESjI-00000002RnR-3ss0;
	Fri, 22 Nov 2024 12:25:44 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tESjG-00000002RmV-0fUm
	for linux-um@lists.infradead.org;
	Fri, 22 Nov 2024 12:25:43 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1uCMl027942;
	Fri, 22 Nov 2024 12:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Oe7aQZV70rEvjDjRGP
	jej6HjDoioRUK98LvEwrDWyEY=; b=QNCGSlISndZDyZL+XH1zULdb0luj14Z5F5
	y4VJy421MUsN7mo0CyF3aBdmPta3x8zLBYVjOIetZgl3a80x859MSxeT7MT+L3y9
	SpG3T8TeIIDR5sO5VI38ismnS/yV5C/xGCt6C5rFVXda/nhgokVRfJiq/suJKfOz
	tHbgZdcPcJ+WE9CdKnJyO3r/+VXBh3GD6X/vO6axzNMrJeUTJt6BokssRqnUtILL
	Pfai5exoopdo5+NxmjJ2SnsE1ymJsXseOucRC5LM1Wlr1AXQbWGUmtM1uNEBhHmh
	LnQCgGgszQDs8pUIB96Q8x2U07F1L3aLYUQh2X32WbQOa/0dWLZQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430rs5f8uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 12:25:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMBusxd037033;
	Fri, 22 Nov 2024 12:25:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhud7a0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 12:25:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEDWXFR06T5/s8Gv+YEEZkD40VwjoFR6v40s8GnfxCrKrMhEWf4k9YJcHW1YFLQT8NMdSQ0wfpjn8il+3qKMKjmTOXMeu5iaSc8juqe7uFO3gewX9o7n0AJaMTY5ww2BvUcZ7lfVZArm9Fqn8JfH2KtFRzUUAfFMDlyRp8RcYH7d9cNpSZNhpiQiGkZMrKGaqyiIUm5ki9qmNgUxN/wr2d8/HH7gnshhiSKd3+gJwtTpRiZeMvBBmlWXDaL6MsDejZGjeo3OTJdnqSXokMFJhgfloFFP2yDZVNaxUfQHt+4/7PuW7FHxT0OfDmDoZ8WT70nUjhwtHFNPrekf/ARUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe7aQZV70rEvjDjRGPjej6HjDoioRUK98LvEwrDWyEY=;
 b=evZgYj0hZUlUeuA8JUHF0ymPqxkhLiLEgcyEFOsagHDV2NajDEc8f9l3rkw5aM0DEePpRdOcCRpmExI2+39yrp9+HupIacTMklEX22Yqsy8sX/1s1Rpz4deu+0g2dLsjxrifGz2lzEG4regUMZCVSSDD3gNlS34ECWViah2M2zifcZM8fBddiXnwdxOqBYQindXF/lNIbnhL7vYUR5YKE5D8tzauoN2ZmyThOyTfCM3BumDg73eYZVqV3eq6kv9qCcrDpnt2tUVpDRcAPPQjF698PjK5q8hh7t2eofEMHdoS5PvVRvN6phV7t0ci1vAfE4jpcoqdZIGA6lGpVMSHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe7aQZV70rEvjDjRGPjej6HjDoioRUK98LvEwrDWyEY=;
 b=NMTRsZZQwezAExWhTTXGpTN41/37TTcMYnCyVGgIRQL89HcxwokYQ1PtZW9de0RqJIalc726QBSqfchlXuCt1S7Pf4lKL+ZhN48mncaGIGdCUzxpeYvjJM0SS4jdxOAHT3UxRcxfxoMLcA01Mu3Wbg/XfmEljrP6cB2hadW3iW4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 12:25:31 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 12:25:31 +0000
Date: Fri, 22 Nov 2024 12:25:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        ricarkol@google.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        linux-mm@kvack.org, Jann Horn <jannh@google.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH v2 00/13] nommu UML
Message-ID: <d28480cc-2200-43bd-adb2-01bbcd8adb1c@lucifer.local>
References: <cover.1729770373.git.thehajime@gmail.com>
 <cover.1731290567.git.thehajime@gmail.com>
 <77ab71c7-3608-4636-a618-3044c2316a92@lucifer.local>
 <0930a0fa8e28ecaf92727229e6633278399409e7.camel@sipsolutions.net>
 <20241122121826.GA26024@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122121826.GA26024@lst.de>
X-ClientProxiedBy: LNXP123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 1126d97b-afb0-4a8c-a00c-08dd0af0c171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ACMVW1NvGxeaxA7rua2C4VLKl+sfkyERwRPi1m/0ZeO1E8ZmimmFMT2Ymybp?=
 =?us-ascii?Q?p2Oo1VthN+vVsKxd+2S36s8nuLzwBKa50ARfievZ0TYpR81R0PtUTO48scgr?=
 =?us-ascii?Q?aDP7kVRurMEOOOlh7MYKNOLeNcjFVu3QpBLzfv08iCRgoaQrSqFiXLj3jsIC?=
 =?us-ascii?Q?edJxAWePqGo+bdlxtT5le5ZsgZFWik0GGs/5e4e+xQ753/fs4fcsPPzNqyB4?=
 =?us-ascii?Q?vJpa77w+uDHrmR9RvwW/fyL+PFramFyjxipLkvQwv/lDKYK6FA9wqpgR/xuB?=
 =?us-ascii?Q?1i9cBICuDVsbgySUSUyV6SuVI81CSm4p6cn5n3sXKq2w71szLtpYOTk6A5MY?=
 =?us-ascii?Q?0iNJswh5phdWDJGPdiBIGicSNydz+DNvtG9iiSw9iGmoM2ZVkxKt5rsfoeem?=
 =?us-ascii?Q?K+lKfx1ZeA6T/pHQAYxZ2XIVU3ixD6O8HSJoF/taAi6jlQVUgOKtion8dSkm?=
 =?us-ascii?Q?KsV5o4+fMMpd5Rer1PmuKTrtThoDfDup9AuwZdMvO5rwZGXTB9IfrkP5mssA?=
 =?us-ascii?Q?BoEZo5u/SuW4vfSENOqKUt6QHfJdHhgozRalEsoxneCMEGRAxG/Kj+PvXeyQ?=
 =?us-ascii?Q?NiWqEw40rn1d1fyT+3ZTeZckkezAZvzYoKmkueVE2QoGUpXQaSCfWMEX4VKP?=
 =?us-ascii?Q?41CLeMky1gtE/W4VFaT5jKJ6CCP49bywz2/v/x6mw0sWpMVQVHUiGOT7QKTP?=
 =?us-ascii?Q?um76TH4dTpspfI+NaBHAkrbwrEuqVgZPoah5WSBVf9ydZ8/vdfTPyTx3YeXP?=
 =?us-ascii?Q?N66fJxSCnqShaykQ0dEJEOlhhOioVk7RByFuSWbbSSHhGasCTP7PoelCK/oX?=
 =?us-ascii?Q?h7BP9HdxvxKqBDwtLXfgc+G0LsOoHr7NBtz43nC1+LmksH8pyF5ETrMKIrLZ?=
 =?us-ascii?Q?0SbsMvqQuZq0rk75wz6HdA6uktfiJeFXY8dBaTWAnzVyOBtKh51f8YmlUF7B?=
 =?us-ascii?Q?kOViYAArKSWnkbQlsiVbfb2Wwt81/mhHi2IYuh8IdSz99iFNmsbXzpcV8BoN?=
 =?us-ascii?Q?7nlU8yJ3o74kdyOVEy8tKStjhjL57lL3daRVts5XkFubZtSlS3vitvcnnizM?=
 =?us-ascii?Q?1OF40rH7ADU933adzt7Z4FPOUqIhdweF+wRmFDIt1bHIeJE+ZkkQBsRcnGKi?=
 =?us-ascii?Q?5LA2AH19frm7ncz1JbeC/z5ZBXLkbAYY6F3aVJX9vy9oDsrpY7Sfa4mO5K+e?=
 =?us-ascii?Q?uZ02lc6xfLqIAaIpaBAfIQqEb35rZi3ovMKjl3eIwPZPdo8KiVW51kGlfWll?=
 =?us-ascii?Q?2ulwI4ZgZnLhhxhKht8m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8kPXAQ+LlkRtaghgR5Zz7e2kQUOPUD+4m0RiB5VCsifQvuj4RT2LDJWmlU0?=
 =?us-ascii?Q?XqXJFUMuDbe/OvQeOV7O4SlgNoY+W+byDQvk+POwmTks3GO7gADDF7/ZHAq/?=
 =?us-ascii?Q?5lGbOxpLqjLifxlojWYPBP7MrS2Z5jPoWGTDSwTUjs/iL7/YuQs1tHhewMJ0?=
 =?us-ascii?Q?YIWCiyYDLSYC+rKIP+LGapXbnSRaMaOX+2rurL9+Hy8romeMBh49BtdTvP9c?=
 =?us-ascii?Q?/XWk6EZJK3NSaMAgnfcuxY2ZzPICC8qdhxBsV3z2VIS91LIPUGXdgejVoE5Y?=
 =?us-ascii?Q?ugMXMeMwXiYj0XvdIE3bdu4sDEha3ZUJ/ypfEux5E9Z4LjWiAxCDLfDA71p9?=
 =?us-ascii?Q?LGLyvJnbEFsYo2jJzDbt8zQcJ3A2fWJe0c87fcYDx2fERc/UTjZ342yXAu5h?=
 =?us-ascii?Q?JI84AKCujiiUAjlIKD7rM97EhtcCAF59JuF5e00zXoXgvJCIJwGmVtFVrFk2?=
 =?us-ascii?Q?yk8alfI+d7v6H3VrTzOvvrYGJJH8RymrtLvrxRSvyfD/S5A8s1t848p/viHx?=
 =?us-ascii?Q?meucr3ffYAl6ocpoCPe91J28YhZgbFK5Tz4uo0P+0Qsi1E2/uAS013g5buXX?=
 =?us-ascii?Q?MNL694cleHxJKOfeghTkaxYODySO2PzTieu+MwvetM0GbCgZsjSbOvQNbTQB?=
 =?us-ascii?Q?G3UF3bckAPN0tcYVvue45G57FQg64P3UsWNce/92o2gdJvsPgGcM4gRk8lXI?=
 =?us-ascii?Q?NGivEyf0xW633KXuvvn9Mccg+1TLiq8EcsltnfVHDqLJxchSZzH38m7ZRqgI?=
 =?us-ascii?Q?HHgEVOPgyyuHoohxFYkE8NAbEmuYZgitSbrlT5v8OBZsECD0EhXRvLa81z0f?=
 =?us-ascii?Q?eQVdQfSdw/y9/C0sfuss4L3GBS8xnHq+zbC9I1i21mFwI5v2Ccomnb5+PN7B?=
 =?us-ascii?Q?f2Cvui2w9gyVBJU7fmR23ExyXHlrQxKgkTIn2T3CeH789K1InBRWblKhljwM?=
 =?us-ascii?Q?zsOMIUICGN7z6ExvZKXs6emRHxQDAx5gG+mLB/QlRD3EMqVVP78VIJ6tFQsY?=
 =?us-ascii?Q?9rsdkiqouATZOsTkqcuVNawi+8cRSHk7RkjiD+jYX/u1ZlInf22Bo1XUz+n5?=
 =?us-ascii?Q?3zav3kKFhtijjRqPNreHpVnEDQSxNZiS6S5VZwLnJvt45PFtMuLlSrPi24Gu?=
 =?us-ascii?Q?VsPMpnersKMNC9/1BZLnE0A7QyY7MlvjLFeBQ9VEDckmT32LHvBuqi1J5xrX?=
 =?us-ascii?Q?LNAquL5tKsI4k1JRqtJMHVeweEdG2QbGxWfhE71LabdT3Fqv8wyLNo3OP4rW?=
 =?us-ascii?Q?/gxO3rZQisU3vhzLeNXMRo5d9MEb/hKr5e2vX8nlQ3WCASlM3lz/PMOXg8cl?=
 =?us-ascii?Q?s9xSX/F83rwr2RmcRGoT2zQPeYpNB3OvYNaAYCzPGvGRGAKOEUfs+KhzQVas?=
 =?us-ascii?Q?nnw3FOWU6T/Er67wVkbf+OI5dtjIEbk62lDqXyGAUggOeWGFz0kZpgJEEWiv?=
 =?us-ascii?Q?cFh3l1vyxj/JildwQaDsGDwtFugoajJmAP94LWvoRHM6TN0CvDF+zWLYimZw?=
 =?us-ascii?Q?j0QkVFWeaXeK5Dp96JoxDmqwLCLqKY5Igljc5cv4pcRSLGky2xYHyUH500AO?=
 =?us-ascii?Q?lJE8uhXs952QW8JXHmHJ+k1gPwHfTcT6tl5v5udJrLhj9T8mWDyfy3TgBKiz?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WSn066kPERuX+u2kGVPXvPbbewZqG+CuzMze4qhZ6EN9LsdnjjGyb1zdnH3fZT5aiExprFxGYRHbGb6KjxJt4uslvw0oy4kt+VWrfEVfaOBjwT5KjOYJq0/KtKmL2TUieihXm05lqZuD0W6IKMb+3cvIbTARJXxAvnDVcwtyCdQnVSYFiDQSWAA6HJCRDkqE3V33X+z7ZimR7ctO/zCm8omJBWlPYLJb4IjVBN3jqZuA6N6ykt2+moINFlY6PSdzAZ0qyHWTz0Ig/h57RPbagY5luVifq7JGFyu3aejZIj0HiHa+SS7EaKWpYGUi5UZPWASswi1R3vGI9hDktvp3t9tG8jzsLxmgFy2MkhUYROp1Cltkh6dpGIfhDhRLrVVr93JMOk0sLnvMwkvL/EOhxwbUwcaPUVRsUNCl1cNyiYv0pZNE2vd4u8sb3PLA8/VSCZ9qgsWoXUOLq/2mneJn09SW8Lt3SxHJotrJucfcL/ZMKnsRnELZJFizEcnCYMpRIfLDflbI0N27YitcitWH6+C1gn0IAdG4j51/1SHlx4Ad+QewuyBS5d8oE0fBECmjb2lVhPGYpD37rh4IWDVdc1PkMyn6vwqpeBgO0Iij+RA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1126d97b-afb0-4a8c-a00c-08dd0af0c171
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 12:25:31.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqJGN2VXetXW3EVt6PMi4JHueFVZ8jZSNurMkySKhmKGRMgxqszIpwxmk9MTUfGmuDB45ZRVhtHeuxMAb8G78/uLOU6crcRAUYPdNHKnyfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_04,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=840
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220105
X-Proofpoint-GUID: ImCpaZ4ZGcDuhmZ_85PCdcr1R8sa0b-D
X-Proofpoint-ORIG-GUID: ImCpaZ4ZGcDuhmZ_85PCdcr1R8sa0b-D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_042542_270860_326D6BDE 
X-CRM114-Status: GOOD (  17.56  )
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

On Fri, Nov 22, 2024 at 01:18:26PM +0100, Christoph Hellwig wrote:
> Maybe I'm missing something, but where does this discussion about
> killing nommu even come from?  Nommu is a long standing and reasonable
> well maintained part of the kernel, why would anyone want to kill it
> for no good reason?  I know quite a lot of products shipping it.

It's an ongoing maintenance burden, discussions about seeing whether it's
feasible to remove it have been had in multiple places.

I have personally run into issues having to accommodate it on numerous
occasions, as have many others.

I'd be interested to know which products specifically ship this and also
require tip kernel, perhaps this is just a case of my not being aware of
certain architectures?

My impression was that only legacy architectures specifically needed this,
but I'm happy to stand corrected.

Discussion which prompted this is specifically around m68k over at [0].

[0]:https://lore.kernel.org/all/9be80a9f-1587-4e8a-98cb-edf4920e587e@lucifer.local/

>
> Btw, nommu UML certainly sounds interesting to me, at least indirectly.
> I have a project for next year or so for which the linux kernel library
> or something like it would be useful to run an in-kernel workload as
> a user space process if needed.  nommu uml sounds like a really good
> base for that as there basically won't be any userspace that needs
> memory protection to start with.
>
>

