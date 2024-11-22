Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066A1D75E39
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4dNnGmC8mEqb4jAK2zyXLh+EPFp6oHud5x1sndf3maI=; b=pXD4vO4GSj2l/0siT6XBAzxpWU
	+bkitNZidKQFAootF0B2EXe3H6FqLndd00th0BGPQMPRKTDFkJCcrWMRThAdxab+9Xelt6rCglkeA
	r/WTODloXT97riFyGbZqOwvEIFFDqMVEgGnc/L3LeDYHaIStwUt7ueDKLp3bLivfrGiafcAXyDV3a
	TQCyWxcNHZCNkJDXteftxNe/K92NYJfgbrc83VWO+2qZOjDctlxuLRxf7p/pCImgt8QWPCc928eEs
	xsdavdnsPOl7J9X+or8Lz54fUYvZ+4I9SECPrrL+YU49OEy+zX7XXGmpNdQUADU4C08m3nncfpm44
	BjaxjFEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tET9z-00000002UYw-23t8;
	Fri, 22 Nov 2024 12:53:19 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tET9w-00000002UY6-0S3b
	for linux-um@lists.infradead.org;
	Fri, 22 Nov 2024 12:53:17 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1ton4001113;
	Fri, 22 Nov 2024 12:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4dNnGmC8mEqb4jAK2z
	yXLh+EPFp6oHud5x1sndf3maI=; b=YNLKCqby5/Iv/Fhx5qQApGDgbQrXCRL5BB
	L6ItrToOuKrxFll9sIh768OhGuBNfvqmZuXx/5O93stYAzJcNoo8qOnFphBfKZhy
	ZD0+2zBglPf2mjMJWBDUAdNbXmDIrRzC/X6bptq3MAsavaNUoN5U6Z9b66Nk3Kei
	8Q/Qsbewu0OFZd1R7oGgn52suYT+Js5UzaZhz1wo7JulAamJI0e/8EVyJf5F3hCQ
	hb6UjMJXVLWvixR/clLVkhFnWIkoa6GbFORpkDPufz6din7NGf+WDCX8qvX0Gm0T
	N/juTlUV5InQwqsiNjWuSvKLXq9AgLBGp8I1Wne7cIfQxNUR4Wlg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkec3yn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 12:53:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCAVpf039276;
	Fri, 22 Nov 2024 12:53:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhud25wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 12:53:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuIPVrysrZs1Ve7Pzf9dfcsFwrWWryRhr/tAugr/YAeOQBHzYzj2DwWXqC5nCpIiXgBHDjGWNhB1e4roJSDywz9ev0tDndu3eAc/gpepqEPAwywH1E197B/hbkWgE8s9tsFWhPr2lZaToR4jIDawwvmTC8QCI32kKwvKyHYN/VNviN9Yl8a/tpCkNVGrw5+FEHHKG5zJSD4Ua2+hNN6ag/MQ3BkRgSUFUAzR/4KNIP1NkBNu2DtkMSmyJ9hj9lnf6/HeTXov0FheOF+PGbGX5PPsXUN8Cj2CITywdAfPIph0Xvsu1CszE5J0o6r8ANR37iL4eeOcHpOx4vsCgTTmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dNnGmC8mEqb4jAK2zyXLh+EPFp6oHud5x1sndf3maI=;
 b=Uw9O2SM8aIfLQwLBuY/RMdduMSTY4ZuImw1CVdBwbLrNRsmiP06oR9rG9lV53vOC9+Goqa1o/Yb6P4bBF4NBWOiQXnbXKP10R+K664IddUVCmpvn4HouPQgeTxP9yYqGuwBvyPfdtxcghHfe0mxlXjDlEpAodMp5zELzCkA38dfmyMY/tcw+4qJTt9fZA++t3bBUub63y4CpuU1nvzFPuRKXfZVjGQC/Jf8t9uunQzJwEcJUAEkXkQyC3EauUboKhKpeuaCQP/TS9rXzP7YEjByk51BaIvfkE+1l3oFWjIQJ1bzXhl5I76dD4VzOMQr7hyCTe8Q1Y1CcudMhsF1YyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dNnGmC8mEqb4jAK2zyXLh+EPFp6oHud5x1sndf3maI=;
 b=y4By07R200AkDsyDAmQ3WcwTNfnjPBgwdB4uRdR6ejzvxS0CV/XO3Ddz4pXZGW3rPYBSKiWqqAcFUCTZJz8MsKe5V2GKidYc4cM0MT68EN2oYzPYL4Td4fV260HmyMnHcgvhYEuHEe0pgg0dLUSdayoCbNMujqEOglR0luWJitA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 12:52:58 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 12:52:58 +0000
Date: Fri, 22 Nov 2024 12:52:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: hch <hch@lst.de>, Johannes Berg <johannes@sipsolutions.net>,
        Hajime Tazaki <thehajime@gmail.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "ricarkol@google.com" <ricarkol@google.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH v2 00/13] nommu UML
Message-ID: <09060fcf-47e4-424f-9ab7-ee2f7919dbf5@lucifer.local>
References: <cover.1729770373.git.thehajime@gmail.com>
 <cover.1731290567.git.thehajime@gmail.com>
 <77ab71c7-3608-4636-a618-3044c2316a92@lucifer.local>
 <0930a0fa8e28ecaf92727229e6633278399409e7.camel@sipsolutions.net>
 <20241122121826.GA26024@lst.de>
 <d28480cc-2200-43bd-adb2-01bbcd8adb1c@lucifer.local>
 <20241122123833.GA26432@lst.de>
 <639c273e-0652-4d25-8385-fdddd7d1de78@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639c273e-0652-4d25-8385-fdddd7d1de78@wdc.com>
X-ClientProxiedBy: LO2P265CA0298.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: d9561367-6a9d-4139-5b0b-08dd0af496f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gFK/rrk9MY2I8CG8rHc4GajT0ZnZGVtxBFQWvpCCh+uJS78Nkbqtokqf89kI?=
 =?us-ascii?Q?/Tpac4nzGhxAWzmetTi04OK9J8fdkj4A6yphneZNcGR+zxlnmcBJeIJebema?=
 =?us-ascii?Q?GyajF396zIXc2CTvutmT4WBOejzOB3v6TlXdz8qPe4TstDiFFG1zR9ZyV9f2?=
 =?us-ascii?Q?u2SyaraSumPnCs8Ns0Xzg/R52XKlV+k4laRsxQA1kiHAaxBHpEL3cQgITt6f?=
 =?us-ascii?Q?a8yiuDMCTBXgAFLD10vSv+Kxh8LY/bKN4eFcWQl7XEVw1hkI5Ty2wg4AHuIh?=
 =?us-ascii?Q?hZoOY/cronBUcDdCY35c5PWjYmooIRlJZ8QxKMxwnkTGBbzxfE6aa1HYppBw?=
 =?us-ascii?Q?636PrQGWzF/ZVKL60N4JLK2wWqjLXN4DIBE1kPaSnLZoIzaXsMtV1tasJwzS?=
 =?us-ascii?Q?cPSDDzEnmf9KnBIY01XScw6WgIDQJ/uuvbYzSqCByYhqUq+cYbbbIY5L5nUo?=
 =?us-ascii?Q?tOtsP/4o5tvactcw2pzKvKHDJC/OOjtL9aJkGIQO+2RW3/gsRtDxK/40kAd8?=
 =?us-ascii?Q?BlusOxgWF0gKqY16BcwkjJ10pXYMVuZLIL3JMk5sz4ayvZA+h49UkP+DlouX?=
 =?us-ascii?Q?CXrTsAmysjLPpG/6tjmQm7fW3LaSmx/akuaT/9fYnrJ9uRRsQxWs0x0ZKG94?=
 =?us-ascii?Q?3Rty5S3VRIEAbrljR173MWd0ul0d0buUjrmyJ3Dot4y50HhbAreVU0gtCYW7?=
 =?us-ascii?Q?b0PS+vxs4+wOV/+Fg13mXQSa9ISeuzY5Fo+XbtFyU3WgvrpHmr7QFX+CY6Mw?=
 =?us-ascii?Q?ag/kYfiKwjbJlUuk1z9Lw8ZA0fZp8ss90K0P8Wg4MMH8Rw8scdUT5IZ156pm?=
 =?us-ascii?Q?D1jGqEydl4CkQksEWeTiaNbnxzF5AwT7TR9OKQ+oVjxY6LxrEkrxUL5+NvH9?=
 =?us-ascii?Q?AoL6aZWdvB8/bCTzNl1ZGyAEO7II+dXTLZM6ifAup7qOz31dunKTmnLPyVvY?=
 =?us-ascii?Q?9Lzhj71xX0Ux8yX2UIRde4PAQ6b2RgeZnbeY6FD5jgPGWg3xSwWBn6KtYfvk?=
 =?us-ascii?Q?tynSjbXhGdrlaSrHR6wFKrilyzvMTSPnbCnF2Z+BmeXwbjceXB71Y4f9WuH7?=
 =?us-ascii?Q?QQ7K28ShzZ5Ftb43qFi2Co1OiMmZjlxx2sa4qbM+hwVKqS86vf5U9Zbtq6Ut?=
 =?us-ascii?Q?c2eomp/4djnlNtwOxH/w3LdiQd4oza8CqySYZhRS61KMG4phKqcVk2WwczuX?=
 =?us-ascii?Q?qkiVyqZOdTskreG92b5mOZAhOAznHY9NFL3SFdHdCPsea1NzEeLWLqXc0dhI?=
 =?us-ascii?Q?Mco4O1IIFaVGNaF8MlRj9PW07Cw4M/Q0P/A7fvlUNR6VHfJN1OjOKQ9KnGfQ?=
 =?us-ascii?Q?AxhZ4bMqXg1L6P/unIJfKmK0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aCuMBvIGsT+amov1vH7TTy1PcMi7s9MPMw/vyqkct9xChmPuu6cm3F9jLBbH?=
 =?us-ascii?Q?IHgqhvDjS6QhtyKTeOeQT9fdvou4FvevrLbb0X9HDKFrasRN6VVHW4TYRXr8?=
 =?us-ascii?Q?gSLdEI5bx8Z0MJHNsCpxN8DQJHzCplMmkgOPkJ5IUb7CMrc2oK95LsOx2/6U?=
 =?us-ascii?Q?Mf1KWvNfEZWWQVd4ydSuIVaIn2CUQuo0cwCqRPJUVqBaYmSuBv0+TEfkA8qt?=
 =?us-ascii?Q?Dz5fyDCWe+SiEqzFWV91XbK4qW6NaPMAiZe4P+CHd+luF8/gE88Ouic4Bw98?=
 =?us-ascii?Q?C08Jw/UdwP+LYjwpHPVyyNvz7LLvEHM5ihvj50gxoQvBdVNij2g7mAMZiYn3?=
 =?us-ascii?Q?LNUF+CIgfnQpYdpx91V2MAA/Ea52FTDejYi0hZdDQz6xSAXtSyhMxVMLXEqI?=
 =?us-ascii?Q?XmrSD6f+OYgI/3hma/Bo519TqaFhryNJWh5d6gCMf9Q9ayPTfhQ5GKBwd3Ka?=
 =?us-ascii?Q?zV/M4TUeSiUteyX3weEuSYgfQZDNZkMWuvIPI9HQ2VeC3XxiCVIO2adpgzQ6?=
 =?us-ascii?Q?ztupRjTpwknXUHBnd8628UaapYpObqyKdpnwDvNM3MhMQ80UDMthQUeWw1wp?=
 =?us-ascii?Q?+rS9NnIqdfesQQwF2KB9tEr9XlCDvFcy9q2kbrRYZbwWf9/jXO9zlSEjL69w?=
 =?us-ascii?Q?otdT5VtJvjOn4ABS1DIzU6KYqPOTDNTJfSS8XQRzS0UiLC7A8fhsMLLbV99P?=
 =?us-ascii?Q?vD6kT7TccsTq7sSZv7NHRhkqAEaEi8ajJLFOIz/xZ9ZQoKX1ryTFNKzxqSRE?=
 =?us-ascii?Q?AvJFUIMZ6hOdptAKOi6Yka+43eFkP3dtFh1WoUTii8tv3MmmIQDvEGHfMer3?=
 =?us-ascii?Q?tltDCpqcyK91kmPmLrrqVz4+sEXbRctuVmKedJt0h70LE0rjqQJd3FZMuMgI?=
 =?us-ascii?Q?kpKb+VKvdLwLV0N0N0nBz15eIez2VTxh1anuU5C7zoD6Zep6eh8qdeZq7T9d?=
 =?us-ascii?Q?AsMgO3RF5B5ZcT1TG5lstEEGmjKuhg86WA/NvVf0fYg4FBp/SETg97dYdS6+?=
 =?us-ascii?Q?p+fTT0b+HYApeW3qr7BD9nDvILmGQ1oN3M39iu7ANoMETOWwGhs3SXzCR6sq?=
 =?us-ascii?Q?uFT/PEmR9Lb+5ZGxnqJKXKfv7PGm/gR4KO+VTebEzI6ZRqZ7xjAOzIyiiAie?=
 =?us-ascii?Q?wnOZX9lvUZB1P6kJ3XbrGktJhWlUZZRxwoY0UMz4S1k7ptRUkG8vhZ0QmD9k?=
 =?us-ascii?Q?vjNqLoQMgDE8k80e6pB7/Dt5WtHj9WzNcEh1imkSDC4/qZVnEBUWMe5gEcHS?=
 =?us-ascii?Q?ZVrFEQSwFRN3AjFDbzfZoN7L9cLRfpPScwLp1SS2kEmxkqmgle/lfzRKuZh7?=
 =?us-ascii?Q?KETsQbUtpgC6fgMH5rGBLoAynnLgEsGUtOE1RlFelBnFgtyXcWx+Nq8lE2QQ?=
 =?us-ascii?Q?xNTofIZHY5t6JHzmKKw1nt/3/X0QMVJ1A/aA50L/W1DF2Zkjd1v6D2R2u/WY?=
 =?us-ascii?Q?dzw5xIOjwTKIdrcElJQIhmxxNxVJIHntdmFpUynpBq6VdaBZ2egve6h5aZMH?=
 =?us-ascii?Q?JMZ9IkEJ9mmMkqTvpAj3maXe5DykuKGgyqNbus6tnQFMziuYKaeeiEE37rI/?=
 =?us-ascii?Q?YWLCXSY0yE+YdcVXZFCoDgDaASA4rHWdlZi1qJbjZmuIZsS3WxNkTFd5l8j+?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9msNf+TZdM66iCCp53F7nPsKM2gKzPRQ4OAxZzZbaqcXurOVFmVwYLvtek/uwdcWikwE2P/m5fXc8tsH55nG5wy4DOClu+fvgR5AMzdEn5hLI8nlrMSWm2VR5e/LEk4YizhEx9FPAe2t/vRzX4Qm8NtvAKGk0xb7xjzXCfvFMWqmMf+o9HeDojH2jtO0LehIPU11RiqtmRPc1CIgT2lA3NNqsJUBI1F823Yhy8D0HLfXt5QuEo6tzT4MY0ryAUN8dskJcBky8Msg4gbow74gGY9DOCIlcnh+E9Nk0nz3mNmiXkIhubtEUolDl1FjlFltKjkSXUHAxbqyVDGKdmebyX1CyS5bsfkc/QF/woJmddyY/3/Zd7pnJ+yALClF4flKqJMgfHivzslJxvV8hKDs21A5ALc6Rt2AU5B0CjdZ7WCX/w1kaZ+zb3WcbY8WKnl6Q4RJ7rKVgMSEPPdK//NCOqnww9um1HMvE/6DAZbVK8YURpcNePQpYdAx8HPE06wzU6BTj7izt7ElGmpsIwMSxUJaCrN2K7HAQo/fxM6+uMuXpaD3puwUh/qLq+mzUTs/n439L5k8v1PiVgSka8ignTTs3LN1T1efdBVoAUrazKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9561367-6a9d-4139-5b0b-08dd0af496f4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 12:52:58.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raQS1BNXeaHz+hkA20sNBcXo9AFh+g5uJmPnfUsfxDgFCLnhvKFbKVn/uHhy0fhOwuP1q3xv1uSD+AK1/MeZUGE1/GMIl4c8UUm0yWxPcAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_05,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=673 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220109
X-Proofpoint-GUID: QXV3gn9fnA88hcs0gwLqK3kzG29gcdsj
X-Proofpoint-ORIG-GUID: QXV3gn9fnA88hcs0gwLqK3kzG29gcdsj
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_045316_279998_2906293F 
X-CRM114-Status: GOOD (  21.96  )
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

On Fri, Nov 22, 2024 at 12:49:45PM +0000, Damien Le Moal wrote:
> On 11/22/24 21:38, Christoph Hellwig wrote:
> > On Fri, Nov 22, 2024 at 12:25:19PM +0000, Lorenzo Stoakes wrote:
> >> It's an ongoing maintenance burden, discussions about seeing whether it's
> >> feasible to remove it have been had in multiple places.
> >>
> >> I have personally run into issues having to accommodate it on numerous
> >> occasions, as have many others.
> >>
> >> I'd be interested to know which products specifically ship this and also
> >> require tip kernel, perhaps this is just a case of my not being aware of
> >> certain architectures?
> >
> > I can't tell you the products I know on commercial basis.  Most of them
> > are arm based, but I also know about at least one RISC-V one.    They
> > all used the latest long term stable at the time of release and tend
> > to stay on that.  And the involved vendors keep spinning out new versions
> > of these every few years.
>
> To add to this, we had a discussion at the RISC-V MC at plumbers last year (I
> think it was) about removing the K210 RISC-V SoC and associated RISC-V NOMMU
> support. But several people complained about that because several FPGAs
> implementing RISC-V cores are NOMMU (for obvious reasons for the FPGA case). So
> NOMMU is being used out there.

Thanks guys, appreciate the input, and this has made me aware of things I
simply was not before.

In that case, I am actually rather in favour of this series to make it
easier to test nommu things :)

>
> --
> Damien Le Moal
> Western Digital Research

