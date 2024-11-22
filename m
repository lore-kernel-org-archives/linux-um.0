Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE47DD75E21
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lMGdHsqNqh1v7r8W9JaBn48wYrxm2/opKnLPrG3GmUY=; b=KNXV819Z1pznYl4C1Hq6Jf0Dda
	N+6XMgjr/zru5fmq19uv7b6gUSN1406hPWE15AdTadnGycNguCiijmO6lQJHFAurQcBoSrqEfHDeL
	fZwjJd6mChGHxsc+HpBLOdGmiTxZ+G4Z9BNYASpTC9VdlnCgkXbmypp/LyFJvyC55dIU9f1QV6/Fo
	taxJ3yP7/HYTldK4oqtQ2S6E0dsERKruiqFvgK/M0P24AOqpRHXQsmzT85T2zSS9hSw1ina4oPtfV
	9XVDy59P4Panimi4LIJDn2X+8WumuQ9j7gYwCqDkan99WuqgDL0osftpZQYUrqyLo2eLa3zopP0+P
	N3gc+Abg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEQvV-00000002FrM-0Ew1;
	Fri, 22 Nov 2024 10:30:13 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEQvS-00000002FqX-1d8Y
	for linux-um@lists.infradead.org;
	Fri, 22 Nov 2024 10:30:11 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1uZSu015952;
	Fri, 22 Nov 2024 10:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lMGdHsqNqh1v7r8W9J
	aBn48wYrxm2/opKnLPrG3GmUY=; b=kZpoD6uHWie2Q3TVZathej39hMyVc+ER27
	VarvEfmw3QSZ4+RA/vwyxBUKyYT5KQMDNs98DRie/xFRfBNdEPJuZEz3lIAoE1mN
	CsIIIirzqtyYQ1hvYBixDOfJyYGZc34QXmLouWPkE4jIhl4uLs1ynfAo2Xl/Ed8y
	WeNglEFvmSbPzJgZAUdzWmRKe52W3c8OkbJNn4o5voogV+W9SRaHxyzysfGHkyFS
	RpEdkIigLLt2QXcQcZBv7hHD6mpFbuS0BKFZ6/XKPnwLvLQM3hkJJcapzLa+yDYI
	S0QzRTvQZQGTW8OZnenZt3KxnCaIrzvR/JkuLs49+rpNDnBS+PSQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyykmcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 10:30:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMATULW037426;
	Fri, 22 Nov 2024 10:30:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhud61fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 10:30:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5Be9dSKKsAJvODmUUjPyPbhlnorW1/CHVu05t3JEJKkKusZ19djEPJ/EoDQG2ULRIlDfAn4hXFjZUwTISctUC4Qqqnfl3Rfj3nS1ia6RWLiaLR/7HHqytoORHFt2AFZHEo8BXL3Xi58M9AYsCL1wnFRtG1/OFBmRQUpMqTCaEMBcMbJ0wJI8t7v9HbR0l/6KF5oeTZzmht2Q4lujsKTa1Wj8YcltDbPAJJdIDOKsjU2DtDz585ahpx5YGqkTdh6Y5sni1VPfRjd7fqDeud7T13G+LBhIdWHJBhCEXKzrDhIcNsOv/3qB7MbFBYajSnc7CLJJpaSQFCgzAUqlJ7/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMGdHsqNqh1v7r8W9JaBn48wYrxm2/opKnLPrG3GmUY=;
 b=grVgcgnyk9DqFJh/vOOSqwQMXVVZAPMopyDM504wVSa+pQM9Gh+mm8DlnbCLHMSjIpuJsQff1jWfffoBIzMkfplV7zlygQjAdzbWUmE854z4yv4QiN3/sJKEMabHggWm1gjgPz86spVEzdq4o8h2xX38gBES7ci93qbWRqspoAHa3XIK6T4mxYgvf6jTdqWFYSwfm1m0D1KImanOGRwvE/Q9k50TEob3hUG0XeEzq9F2Ye+n5yrLS6k7HbhTF0otB2XG6Xfm+fXO+voGehf6V8Rs1lrbDNaR3cnJ3PeMMMjY7miGQKFAKGZmBoCiufZN7FiEonCg7ZxZg+2FjxZYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMGdHsqNqh1v7r8W9JaBn48wYrxm2/opKnLPrG3GmUY=;
 b=HyZio5tHNGOMDFEcwZIKJ0BYim+8RnPk+HSDD5Mz9GHIbzvJibyLim0g5hZZpwaWq1q1d0VvgCVagh9kkR1wvzpOnw/EJVAh4xI+5sWYUhmoT2SE8sWe/xichbfTjQAUukJYhVBzDVyM0GFgzcVcFnUyyiNKqYBfw6g97MuCi/Y=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM3PR10MB7946.namprd10.prod.outlook.com (2603:10b6:0:4b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Fri, 22 Nov 2024 10:29:48 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 10:29:46 +0000
Date: Fri, 22 Nov 2024 10:29:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        ricarkol@google.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        linux-mm@kvack.org, Jann Horn <jannh@google.com>,
        Christoph Hellwig <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH v2 00/13] nommu UML
Message-ID: <93dea534-793d-42bb-a2f7-b14e85082b34@lucifer.local>
References: <cover.1729770373.git.thehajime@gmail.com>
 <cover.1731290567.git.thehajime@gmail.com>
 <77ab71c7-3608-4636-a618-3044c2316a92@lucifer.local>
 <0930a0fa8e28ecaf92727229e6633278399409e7.camel@sipsolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0930a0fa8e28ecaf92727229e6633278399409e7.camel@sipsolutions.net>
X-ClientProxiedBy: LO4P265CA0285.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM3PR10MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 509e8e81-46b3-44cb-1056-08dd0ae09629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LcxfBN4VOXTc9jMRNCjWZ6ratL6JkBo+5LqnXvHmT42cSOtnHJ57E6ezRIPs?=
 =?us-ascii?Q?2g83HUaxE7N9QZ6kklyUQwHMCWo2nxNo+wj3bdSAuzM9DNNc0EKSIti9xC43?=
 =?us-ascii?Q?SCaMfOjcZQi8rh+cU3sOe5tkKPF7JDrXoWYKxrQ0mXmkH8p0OozGsryv+IFo?=
 =?us-ascii?Q?+8ZmyGa20E2KYDVmnFL8prDdD5L2uVQzT82zRTXQdUx4rjm7G89QkkaoZ1oa?=
 =?us-ascii?Q?4/CsEn1KFrYlnd5uz+aqb3V0kMuVtSrJik+7IMoemgl9/BQ8eOrlHuAdS+cC?=
 =?us-ascii?Q?Adq6MNd8GKbzwuY+nVLi/xuEx38IzacfeKzc2ut1nI0lNzNmLzJbKDVn2nuD?=
 =?us-ascii?Q?CuMsyZGbqVuSbhUo4NPlDfvjSRDzQSvg5Av0o//gt0KBiAdV5naFEeIw9Bmm?=
 =?us-ascii?Q?AjVMnpNQhsjnKF4OKNGRLfqgXcwYX1MROc+h1RabtjX69qr84seUhWE7SMAS?=
 =?us-ascii?Q?DJ3lmPyyQXxO8lconEX2SkCorP5YK7mcGLQhywFT34n7orL1P60cNfF0iveM?=
 =?us-ascii?Q?0sJjiHp3IkBdKAKZQGQpmxBRtV+xUKI1NE9lk+dEpIFQMwHHR3seqYQOUyTY?=
 =?us-ascii?Q?7X/xm6pD+4ZvKIiL2JFmyqYg4e3gclc2KAXvHLh1sPxODVs7Hvr2tlwKD2xc?=
 =?us-ascii?Q?x36FHfC4Ff2iWRT1xpdxB7RjMJHPjdKSZunShifwHFOwRdE2vRhiK8x/Nb3U?=
 =?us-ascii?Q?2Qmgsll2pcyDyRKAmrkYREQNMlA4nTtFtXtkbey4DUM7UfomPgRcOWEZCAbg?=
 =?us-ascii?Q?qH5QYKyZ29iNyB1ysyS7J9a2h3Gl7/Hk8ugjIGUIzsI/1gaChSAZiRuZweN0?=
 =?us-ascii?Q?So8jFNq95Hsxgcf0PxaXckeM0v1p9kK4pMsFFg8Vx5+MYlJqm8g2KvdSWQOV?=
 =?us-ascii?Q?jOVGvbRRBZHDyFd6JlUdiciViUJFFcGxGF5ONG7EBH9lDFQJLq8YjUS3WH97?=
 =?us-ascii?Q?mMocUjxUF8qlvHO2x5kIMKHHRCvnAfpxRQqPTpf/xNriangoCjzx8huRmyO3?=
 =?us-ascii?Q?q7QSp3my7i60/6Xei4mrTkea6a/E64d14IaDqV/2plNMv0Bd7Zo831sVoSjK?=
 =?us-ascii?Q?eulTCdFTZNdpRVvk69Motr90zegIXJn9rmk08D05fb/kCNtSuoB2SpOO34U3?=
 =?us-ascii?Q?9eCZqsgYRWAlNErObY7GVWfuRi8VzL6vAg1hNOOHHlTFMwrD+f51W0dSXss9?=
 =?us-ascii?Q?XsF9HSPAuUFprckozwTgrIrIq4zyVRROMaWJNZL8//nBFJ81LkIoREe4iPL1?=
 =?us-ascii?Q?4csLvRr79jsb80EpVosUNy9RsAjrfRc5QHldZyxeGDjSdZYgMvgt7jIiIoCM?=
 =?us-ascii?Q?1JA6GUHiIhVoy0SHFq/XxZK6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdqAHikHSGPUMiZYjGTDKByU1GyK2TN4UGTf8vcrAUm/MnHhxoGCuM8+v1Am?=
 =?us-ascii?Q?g6fPZusVq9x1R0u/EKbvQ/UztlSEMRJta5JWAWGfysEL+mdvirQV60++nypB?=
 =?us-ascii?Q?YUz1JJN+QZDQl8PPB+MF9FZYerNg8//J9cZA5HHAv+u342ORYqQ5+4wbBi3h?=
 =?us-ascii?Q?TLxdBvjTUE2JX/ES39w8yaRxEM7H5Ta9nvsGgCMSOJCNyhu12vbFrmv6vlNW?=
 =?us-ascii?Q?TjameZUR7DmDPmXFVocSVJ375aNz0DRbLpEpRep8k/A/BDjSMeLNGQ2mkV9k?=
 =?us-ascii?Q?0iJ+CDWUQGM0d+s43dz6P+x36YYieN9KwlGjT9sKPQeKlm+2DaikakWnrjL0?=
 =?us-ascii?Q?52D6KBNa2OWo8+LRIwT+g6Fma4oZ+GDb4/MIPRSiw6akD3voKKzTx2vbxjnS?=
 =?us-ascii?Q?Vbr68lmXblyAb/Obd0/Y5Darw3lXUaueJSBxEaYL9Y+5e2Pg5B74LuE2HuT3?=
 =?us-ascii?Q?JY/tBT4WhD0efoa72KRlu9XJDW69TYMdom8k3/hLcJYyxdJALakoO9nurBFt?=
 =?us-ascii?Q?u7X76WjVuWQtnIv8kiu2QkAnWuUxZZz2ZzcdgoWGVAC3EWmCgOR2+vTzh/i4?=
 =?us-ascii?Q?qfz4JeeMpPKr2VtyvjaNUSgfocXV+U92dcyInlCWLh7eP4WZpRA+Im2djpMo?=
 =?us-ascii?Q?mJ/h87prq7KQuSCJ+HpXQ55kj2GV7idJ3xP4W7Wd42Wr0mLZTe4zzVq7uCsq?=
 =?us-ascii?Q?gIva2lXcp+xJOuIdbcYi5r0w50RrYcPW4v9frtPqQBg3fQYrTzFkcpyv01Fv?=
 =?us-ascii?Q?tR7K1SGCFT1ZQK8jJOJrjitXvF68naTJRZ4INuIqYpghTLzsvrw2IPLynrwY?=
 =?us-ascii?Q?mQuZw3zbjoBEjVF1gcF38xjc1aapJjtk4xJYQXXagJjUj/ZIT+AtYeLJUts8?=
 =?us-ascii?Q?J9jVDoBqJpSAnTY9AiklwbtztZ/Z/1iOWUt8Fh38k60F9M9upBTE9Sz6ZW6z?=
 =?us-ascii?Q?N3eiqgG08l7IXXvcl4d2q3ML/+VHx1nd1qz6aFFqDYxtSjtUCw+9KKd7zwza?=
 =?us-ascii?Q?O3jZ0AOX2itiRGPdAEkcX+8wP4ji1tYiLdeX1EbaHe1xsEutBQNaTaE7oENO?=
 =?us-ascii?Q?Q1GuVDwnTX4s1BS5lrZdMeiuw0OQ+ZLP70cap2un/EtKQcQDabd7/DF+MELH?=
 =?us-ascii?Q?W8R0AY40jEK8KQXZyaaG0bGHKzMSPwSz/pbS68nzlmUtqrjYNJIkymtYLi10?=
 =?us-ascii?Q?D4NaaDI3PmIXdlQ6HsWcbKRJlAko1J0vFVPDr/4xjuvOXUKZv2cwHYhQqYgg?=
 =?us-ascii?Q?KznCHtypGB5iTl48Bn7eRzOoXDq62hoVxeWCxLN6nI8Geaxyja3+4M4RaHfK?=
 =?us-ascii?Q?fHD+PqI3j9FG42s+1BFzuZmg3LK9wd5BRlmFNzpMnLH6NHcDCZmNN/fYPYpx?=
 =?us-ascii?Q?OoLw8Dyj0jCiC+BhDnrpAWhrKC8GN399BObC1EXd26vvX6hY2fM3TkIC6exl?=
 =?us-ascii?Q?diH92gde10pDWOrwsZi47YG1jJtQAB8uzEkvec552McfijC0K6TEBc+jdL+T?=
 =?us-ascii?Q?koaDJYXWgnrYM6HiBwo6RyIvS/eMW6s0RojlyF8B5GqGIn2SFMovdYyLF/9Z?=
 =?us-ascii?Q?CIVFRoIdr26ropicAqNNdpJKfysZMKFCooHI28HJ+rFmYzYwaaYOU0WerLsy?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pz4pCRCyEQMYCzyw74oS4gmDzMccFeQR2845BdgWy6g/RXhcg0y4ZpLhz3v/rJBgka/doT6wMqQQez9SAOBDJED4/0fTy2OczOMGPdNpQtDpIPIXKA8cL79IzRq7IZ2AIiAxuHIrITT4MGdIsBbfuLEwLgPtZ4O6xRMdir9fYcypsAg9GHO9UskJi8Dz3rdjaIy9brbmeifuq8YZNU9Y/ap9sNhT261M9/W2AyZW/YipKF0J0hrPyVTRqYXRgqu9Q8HZyQhxbGrfnYbp3f+mAYYTRfRHxR9aI8PJgnQ5KZrDUZFbraALgIna5gmB7xgxa3m5FqLW8cwYy+vEp4XlmSaHREFgaFkQCipXXzdrnqMqdtzKvNtDmYEjkRTtm7O16aRj1y0RGSQRJ6emnR1XtH5QaWjYvtS5AnXjzyUItxOlBZ3HhDi0nCTHjLKpcVnqovGWbKCW/nyXvMBGcpNrrZswFYsZEmBKlVp1BmP3X5h+qJrkGXZDV6yWWfAoKZhsiGqsmteTanXGgo6zc7HUU5zIIkFOHyq57wRDz4NYThjfeivUSYpEHhM3X4fzeoi0XsS6XE1aWEU1+HaqxOJcFqtDCEb5NYkuQ4g0L1Kufhw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509e8e81-46b3-44cb-1056-08dd0ae09629
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:29:46.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwgVvsKqK0ZtpOJJoW6VNus7GYq+glaU+iWkdLBTZGfzTw0YO+SWUZfe4I5Np+skMFCR7i2ms1a5IpRktGLCFut/BIw0nNi3x8MRF1Gy2XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_04,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=798 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220089
X-Proofpoint-ORIG-GUID: lCEZ4yGIDTRwjSngYWUMuAXmt9JVQhgy
X-Proofpoint-GUID: lCEZ4yGIDTRwjSngYWUMuAXmt9JVQhgy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_023010_444216_79FA86A7 
X-CRM114-Status: GOOD (  29.85  )
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

On Fri, Nov 22, 2024 at 10:53:18AM +0100, Johannes Berg wrote:
> On Fri, 2024-11-22 at 09:33 +0000, Lorenzo Stoakes wrote:
> >
> > In general, while I appreciate your work and don't mean to be negative, we
> > in mm consistently have problems with nommu as it is a rarely-tested
> > more-or-less hack used for very few very old architectures and a constant
> > source of problems and maintenance overhead for us.
> >
> > It also complicates mm code and time taken to develop new features.
> >
> > So ideally we'd avoid doing anything that requires us maintain it going
> > forward unless the benefits really overwhelmingly outweigh the drawbacks.
>
> :)
>
> There aren't really any benefits to ARCH=um in *itself*, IMHO.
>
> > There have been various murmourings about moving towards elimination of
> > nommu, obviously this would entirely prevent that.
>
> No objection from me, but e.g. RISC-V added nommu somewhat recently?
> (+Christoph, Damien)

I mean it's not my place to object to this of course, but ideally we'd
avoid supporting the truly low spec RISC-V arches which do not have MMUs (I
wasn't aware there were some but I am wholly unfamiliar with RISC-V so
plead ignorance!)

>
> So we could argue the other way around and say that while we have other
> architectures with nommu (like RISC-V), having ARCH=um could simplify
> testing by e.g. allowing a kunit configuration in ARCH=um which is
> simpler (and probably faster) to run for most people than simulating a
> foreign architecture.

Yeah and this is the flip side of the coin, I mean it's actually very
useful to be able to test nommu stuff easily (I've had real issues getting
nommu m68k working in qemu for instance), but my concern is by adding more
dependency on this mechanism it makes it harder to remove later.

I would support this if in future there wouldn't be too much objection to
_this_ feature being removed should we come to a point where nommu removal
happens.

If a large part of the motivation is testing nommu arches, and we at some
point eliminate them, then I think hopefully given this would in that case
be the raison d'etre for the effort it'd not be too egregious to remove at
this point.

In which case, the flip side of the coin is that I am in fact positive
about the testing possibilities here :)

>
> Anyway, I think that's where I am with my partial (and very limited)
> ARCH=um maintainer role. I don't really care for having the feature in
> UML itself, but if it's useful for testing nommu architectures for
> someone else, it doesn't seem too problematic to support. And testing
> such things is also a big part of the argument Hajime was making,
> afaict.
>
> johannes
>

Thanks, and again I don't mean to be negative or difficult about this
series, I just want to raise the fact that 'in the wind' so to speak there
is desire to eliminate nommu at some point.

How realistic that desire is, I am not sure...

Cheers, Lorenzo

