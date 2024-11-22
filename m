Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C9FE65D3D
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 09:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/Q049Qe7xRDXT3gPuD9/2wknma7HqG1HGUSPki+HMk=; b=PQEcA1UnlvZV42JhLjRnw38RQ9
	x/p94oX5S+j+7j+jjrzrL4M5p6+PN8u47aafAFw0v8jwxu6gfPxsPm/5kmKfD823WiXt29bpKxV7y
	XzrEf01+wYcle+GhEOppju0Stn7HXX0/Wlg0GmWU2xyXZdPfO2bNuEShPtMQKIVKVRXFLfBgayfe8
	192U47d9pNucRg6gB/i9NOv9LcfF28z2sKJIFGR6Gl085tyPASeuJfJyktvtkrsUdvQ4C4aQ15W7e
	nbKs6XuGUK3WQhCHq6RSTCbuFVhK5GNNNrWsY74EdvwAKvnARTT0I9I3xXVh8VX2II3EOHDUuS96b
	ecvRJzzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEQ3R-000000026xs-0yQR;
	Fri, 22 Nov 2024 09:34:21 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEQ3G-000000026uv-1c8V
	for linux-um@lists.infradead.org;
	Fri, 22 Nov 2024 09:34:11 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1wRUY003966;
	Fri, 22 Nov 2024 09:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=U/Q049Qe7xRDXT3gPu
	D9/2wknma7HqG1HGUSPki+HMk=; b=bE2k6+ip652Ep4jlaQdy3uM0/ATFL9rJtX
	PkMqKNZTBiFkxM+ziwcrOCucwvjE+VjLGwHxQKyNsEUD4ZyIZ+WTObxGjyB0xMUd
	rGCjcXvkJeES/UHKFClFGuoqzF97N/tGWoFxteRdyiBAyT7loUhwu7PuDzxSVZZa
	Zp+/AtFdQiBPg0uTUFc9MAN2dPOOhq5LREnmXMOJbDCMZhUjIfkt5eyE1uajCxBS
	q/WaMs61KVE9dWQN3hOERw3dJ2B8747zew5Rp5TVdm8YwH+T5g/FPDcJrrQ9fJAZ
	/5xK6ZSo/Ngufh7Wx5J2gFZNfOxYdMXCA3FTHn7TKN7UGgnL08bQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtcbhs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 09:34:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM81P3M036993;
	Fri, 22 Nov 2024 09:34:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhud29qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 09:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UM6wM2IHcdbLFvVeP8aQXlH9RbsDPSzR/WbrYOhQY6726jxehp38g9VVDC7FmTGFBjqI222KXT1KZ+9Pha4tCvn3fiZDEO6FlqfESDPWNB5HmrPhhuaNvqZMBp18atdxlQpJ3zOaqDEvW/K9vYjNCamYzsMjVKbBcFcqLk2rokg7OO3bc/ijNfwu5xAtPr/KFzgqAB5SuGHDFkEYCrly3Wgosk2suKOOfcY2n4eH/CiePC2QIbZYlHzmB2I50IrlUXahjOzMuxjLrtH/5mmat2GDEImPSVu5y5aJEEvg3eiLy6aTVHyjxJf9VnVS76YNduldwjqrlsDBcurJ0urmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/Q049Qe7xRDXT3gPuD9/2wknma7HqG1HGUSPki+HMk=;
 b=OAi++4reyHzv62BE6jIO6CmSnkQRM0ThR3ygYQnrOIznU7yNJYnsdWpT54aAFwPIqJ8FlewkoTYef4Jp/t1LjRRd3ow1D0Og6vLVogHlP3s9xs/8MSX+KBedXlRzX6fJ1o/lk3kearlRT78iToVWtCpinXuKbA2lrbaRZE0hamqwuFKSEpXkHc2oB7janRmmE+yqgkAtlPt1hUaO4p74HXNtGvJ/jIBirit3hHGK1YfKNUA+0b2++CqLEi9u1FjQJAtzXOWeb+uH0I/janoI1dM96i1nR7HN+JZzvOJKkxhliVN1UGkpxNW7WxdJqCoDkNv9+sNEzSGp9SJI73mBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/Q049Qe7xRDXT3gPuD9/2wknma7HqG1HGUSPki+HMk=;
 b=HPg6C3lqHGBGCBqeTC7dIxYBtObqiMjuMr7HYwCqVfLYddQ3lraq7AhkNt/EjTuVy4C93o8aY34Rv5hWmcjP2wBn0XAZ5PQk4zfBU/XSund70LuqGyqKbxC+xFbY/rHM2RlzRrILTJprvNigDFe5QFO3Pv8ft14etUfyt6J0Yuo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB7325.namprd10.prod.outlook.com (2603:10b6:208:407::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Fri, 22 Nov
 2024 09:33:59 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 09:33:59 +0000
Date: Fri, 22 Nov 2024 09:33:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, linux-mm@kvack.org, Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH v2 00/13] nommu UML
Message-ID: <77ab71c7-3608-4636-a618-3044c2316a92@lucifer.local>
References: <cover.1729770373.git.thehajime@gmail.com>
 <cover.1731290567.git.thehajime@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
X-ClientProxiedBy: LO2P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::30) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: ac720276-275e-4ef0-5507-08dd0ad8cac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3I1rwb7FUzrOJrqwIFohAu99HOxa0ONtsieFmBscwTGLdUuyet5G7Als2via?=
 =?us-ascii?Q?cBjw5HON+rWaM9ILbG5pEMQNPCLQj8GitB8ywEh+uWIsTU6MFrOC9e916OD9?=
 =?us-ascii?Q?wLafP+r7SwZqlFBShc3gmY3hHix6laDEzo+y0LtTKe40dni9pBdHAxgPMlrw?=
 =?us-ascii?Q?DvCgFaXiEJ15uOlli9M80STx5Zqj6lFYMz80N7yi6K6bZAj9XUmkm2/YScsE?=
 =?us-ascii?Q?6IgrYKdekW96XGCU8JlQWBoBnhP17cWe0nnYjTV58phLrf3ZT64Isa9mFEnF?=
 =?us-ascii?Q?+fv9wkVpOYmNMqIC3PASnJQ8wO8Rouzy1qeKZ0HVuLWptNihiRLHlTzIhCyN?=
 =?us-ascii?Q?OpQVdzTCojnoc8FNfpciFWWyVy9S1Sq9xo6d7HVI61LrU+bbVyOofVuVjCgd?=
 =?us-ascii?Q?G3PFjbdpJuCANDfFQOOnPKaOt2JqJPXvuDWNqKI9bA1b+nYo+IvNVQ6UVJAF?=
 =?us-ascii?Q?ZXPqVl6oOukPT31c8J8a+zQ+y11TiXDMc1k7LyRzyTVGzDpsPTHOD1XVmBV+?=
 =?us-ascii?Q?LgXE9v5/TpuVBXHSOHACWkS5ltneF+cgrl4TWfQ1SESLVQBrKNcaAH7/LJhb?=
 =?us-ascii?Q?qAZPCWWzpXdofVWEZINIU8tvNKDozqGhUbP5TtNk4QhdzJ803Nv4IrFrUdML?=
 =?us-ascii?Q?JrX0/+HNbBhrP4avF3swr+k5Zszf7OLocZNovgVaGbXGdVZML1XxxoWSkWMr?=
 =?us-ascii?Q?2L1cKBClOcPfZYtbbwRTpNjfsT9cMz55QxPT8YjwughYYlPvcE17Id1yoB+1?=
 =?us-ascii?Q?sOJjbsiUsBH0BwZ+nSxKq8mwS1+MxC1/oyj5NzQOO620Rr0bNBG0Uc4KTuaa?=
 =?us-ascii?Q?nCEhlTBML2gVTvACEuL3vV+9s8m2DYdRTOPweROjljq2FwCAT1oz/fVkmB08?=
 =?us-ascii?Q?aislY6+ZLXgGoi5HJepuM67Z1Nczpn1xIaL0ULqgp6bAM5hrj2MxQ/34aZZ1?=
 =?us-ascii?Q?9b/G48M9P/Z1jDK3knIdsQ6O6l/SCaGOYf+vhEd2hxNIL3gtltml4hu34/wf?=
 =?us-ascii?Q?HRqwDB0WEGIsZ3AH+7Xve7RuTRRLwAunQPQTQUPecgQdsk2SllibGYtnF5Xa?=
 =?us-ascii?Q?5D7Aj1fpfBwKKrRWyGYfQpIdq28kgLh5wUj7IdByHJOClB2Lh9hTQseZ6E/p?=
 =?us-ascii?Q?qSKRXg31nY7+T5rlxxe8mb1ckX/y/UMdTpQg1FNIPlnJ1rJsaFSNIsf20d1l?=
 =?us-ascii?Q?EuTvrteWQUun5Hoq7ASgvT92AYksYerV3TbLxemARDfrLt2XtDLfrpJsNv76?=
 =?us-ascii?Q?J7Zg3luSlda/87iRfChi1E+4kBEPfnWxoBdynvSpvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DP2lziMNYQ95Qiqdl2dq04MWULGzKCZX05plzEj/rY6uFU+JWUcx++G3dr8Y?=
 =?us-ascii?Q?5oqRgUrysuc2FnCM/6IT9lPMyBQ4xlnEicnWShYn85JoDL+ljEMuIIJYsXqE?=
 =?us-ascii?Q?c4FeASHvb4zXUv2wQ47TyKt/8PgGUc4DY6lnkZcasDn+s/IFFx8ZCMvG1h0m?=
 =?us-ascii?Q?Tm0g47GJvjcsxU3gsc7noz0Bnwwwbvt/5zGAME9PjSnHbJS5m4JEWxIn+xMo?=
 =?us-ascii?Q?JQASsEWemLZlIDA04wMgbPlgeV8fabwNyYgEHpRwvIAGMD+RXi2zb3pif7cy?=
 =?us-ascii?Q?xLOxvkaRPrEdBhXkxxIrU4uAUCPBN9zb5IN4B76GC7h34OOmv84BLTXEhpjx?=
 =?us-ascii?Q?qWzWW1BHr5mLHz+HkjQBZDGCq5jQY17Ck9hyZuzKOqAgWw7idARYqKXkcGOs?=
 =?us-ascii?Q?3ZEDq2eE7sSW0h1NEZz0ithnF00u+TISLYGCxw7GEX1AQ9falp3xrIFweRLq?=
 =?us-ascii?Q?J7yWA8dP9Jtl398Btqe246mKxNZFYRaB1R5cyDddzyplpHmcYgAkROzWM4iF?=
 =?us-ascii?Q?29I3KU58AJX3pJkDviVKcUPuRiJ2GdreMIwv/TbmF66UqdVU2apMiewKywct?=
 =?us-ascii?Q?Wip639fAyW51bXVpkljNJwuzO8UrQcYZlklzlmvxhenMr232cqWxZWiEDmD5?=
 =?us-ascii?Q?z2Ho7QchNPUSBqGok3/nOldKy0fEsXEYzb53RAhSxr2Q9YbvmZ4faOqJ0lXe?=
 =?us-ascii?Q?r1tBj9MarmzVdASxlsrE1JDgR7VSF/aSeWFZ4v4xCvw3RgpKA4+VgFftg1wu?=
 =?us-ascii?Q?IwjbyV0E1vrtHyXXbF2dGy1EvBbXYqjsAUJatNy28V1m3AmFZSH850Pz+kCT?=
 =?us-ascii?Q?nJbvJOo7PS9fOMSvW8oGRPtN3dk74/SqgtJuk8hBV0nQR1r/jZWbxPW18Sbk?=
 =?us-ascii?Q?9QYPFt5Ug36fQoiVK3lBt0g2cGkQuO3a7QRIKN8bPDS5rnG8UmoBa9TW1GAA?=
 =?us-ascii?Q?FVIzYts8mYK8gx3o0l8pRKMmNJ6yKFgJqvg1VoMegWH8l2qi6Rt29rDM+4KQ?=
 =?us-ascii?Q?+cwoQyMs9cTg7fLq0ABehFRrWMGOgP8JFSdcMmWZDbBP7szvoXUsVqDv/Wk/?=
 =?us-ascii?Q?Z0SMYJR5w8iNERCE/VLddzb4vVHjP/HU0YY4vDaxWlnxDv6qcLJIa49l1Tge?=
 =?us-ascii?Q?n1h7u5CI0wlFci2H5W6n4SGeseJLFDHWuQYvx4UOpsS2IJXotJD49xJ1EfXT?=
 =?us-ascii?Q?g6pCTbiBY/ValsReL4joc1VHQjLPYwWZLNR/HDuXzCS0YBn+2kH4hO67Otdr?=
 =?us-ascii?Q?E/af8G+Wf4GFfFJQpiAmhKPmbnMvzfzkIWLqyF8hrW06XEaikELH1Cv11czu?=
 =?us-ascii?Q?E05CczPNQQMgM6w3rWNf42um0+lEIbaRMcqugsjC8SO9qlZ6QNIRl24KQVEk?=
 =?us-ascii?Q?C5YZnnEfs6HfqFoamJOxol7soaYvW0hI4Eg1NfFJi1edb1/DAedFHf7kdXEt?=
 =?us-ascii?Q?rcfna7tBulAoxZSAPVkt761U0XIQKiao/577UwGeuzL/U1qJzuYJGlzdiiIF?=
 =?us-ascii?Q?qAGHkGYvYJSA6B0HHzf6sNewM98o0MdAh+92tIXz1AJHbOQI6h4OLf675Qqm?=
 =?us-ascii?Q?/eSa2USa7RbM1h+zokkGJj8pjIXPUe99fH/YozjQ+zuyRPW77Eki20y9z279?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2vNl99eimYhCc3rKltgENtUXHnKR5DQxX31iuzTBpaOOSBwiBamafihqx2H63kBJ5wjXuRvwmjvRcQ9oAzUZ1Mp3YM5pxb3pzxGsWHttoykIw+ne1RkGV3ll+mYUjr06buPOjxZZLPLe7ur9mt2MWSKqCZd1TFmfzQl+4i0tuK9Ovmul/MlbUkp6o2hDRQZmCh8CD6gxcnfhwUuv6ryf3+TbSWMsw7rC0iJXA7OzKrbkxx76uzVzbBgB2Bcy5hkaRUiju2sAE7CFpzAkqPlb0Tz13bY0jYoWSLGHYda+S52L4N1WESCO8FXejeWM2mXglGfR5rLQNAFbT6QVVjco8IBj14WqZONzapzqua5Ze+KOqSsesRms8AhBtoVGmmDxPcTAWDLOTNvPLU80Ing8gbghOl7YbY38yoOs0xAu/+ZxoixWqEMmOoSaR+ubb/xSLXH73mhx+K9P1Aza3HPgzBcZz3nEGDrD7LE57S4OXbdqvv9MDlSiWc+VtSTVJKy8HXzW5Nhmkj9CWkifgzZhao9Gmrul2HDycW4zJKMtpHG9pAomtXLJxIjhmzini86S+r/E60xrB+nmpTwSh013hll7z14pvkPjTk4FCXaIN8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac720276-275e-4ef0-5507-08dd0ad8cac8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 09:33:59.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xrr5G/zX70C9vCRUiorJSIsoqvsqoLSlc4pB41Rs+PZTVT4KF636UZ8JN4F7Qjw0nDdejXfva/Hr8ShH7GkD/UzJ8cEPdBFhZb9oBKEQhOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_04,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220080
X-Proofpoint-GUID: Y37Fujj5SqOw8dk571kt1jSNsosIRHMU
X-Proofpoint-ORIG-GUID: Y37Fujj5SqOw8dk571kt1jSNsosIRHMU
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_013410_559744_DF162CA3 
X-CRM114-Status: GOOD (  23.57  )
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

+ VMA people, mm list

On Mon, Nov 11, 2024 at 03:27:00PM +0900, Hajime Tazaki wrote:
> This is a series of patches of nommu arch addition to UML.  It would
> be nice to ask comments/opinions on this.

In general, while I appreciate your work and don't mean to be negative, we
in mm consistently have problems with nommu as it is a rarely-tested
more-or-less hack used for very few very old architectures and a constant
source of problems and maintenance overhead for us.

It also complicates mm code and time taken to develop new features.

So ideally we'd avoid doing anything that requires us maintain it going
forward unless the benefits really overwhelmingly outweigh the drawbacks.

There have been various murmourings about moving towards elimination of
nommu, obviously this would entirely prevent that.

Thanks, Lorenzo

>
> There are still several limitations/issues which we already found;
> here is the list of those issues.
>
> - prompt configured with /etc/profile is broken (variables are not
>   expanded, ${HOSTNAME%%.*}:$PWD#)
> - there are no mechanism implemented to cache for mapped memory of
>   exec(2) thus, always read files from filesystem upon every exec,
>   which makes slow on some benchmark (lmbench).
>
> -- Hajime
>
>
> RFC v2:
> - base branch is now uml/linux.git instead of torvalds/linux.git.
> - reorganize the patch series to clean up
> - fixed various coding styles issues
> - clean up exec code path [07/13]
> - fixed the crash/SIGSEGV case on userspace programs [10/13]
> - add seccomp filter to limit syscall caller address [06/13]
> - detect fsgsbase availability with sigsetjmp/siglongjmp [08/13]
> - removes unrelated changes
> - removes unneeded ifndef CONFIG_MMU
> - convert UML_CONFIG_MMU to CONFIG_MMU as using uml/linux.git
> - proposed a patch of maple-tree issue (resolving a limitation in RFC v1)
>   https://lore.kernel.org/linux-mm/20241108222834.3625217-1-thehajime@gmail.com/
>
> RFC:
> - https://lore.kernel.org/linux-um/cover.1729770373.git.thehajime@gmail.com/
>
> Hajime Tazaki (13):
>   fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
>   x86/um: nommu: elf loader for fdpic
>   um: nommu: memory handling
>   x86/um: nommu: syscall handling
>   x86/um: nommu: syscall translation by zpoline
>   um: nommu: prevent host syscalls from userspace by seccomp filter
>   x86/um: nommu: process/thread handling
>   um: nommu: configure fs register on host syscall invocation
>   x86/um/vdso: nommu: vdso memory update
>   x86/um: nommu: signal handling
>   um: change machine name for uname output
>   um: nommu: add documentation of nommu UML
>   um: nommu: plug nommu code into build system
>
>  Documentation/virt/uml/nommu-uml.rst    | 221 +++++++++++++++++++++++
>  arch/um/Kconfig                         |  14 +-
>  arch/um/Makefile                        |   6 +
>  arch/um/configs/x86_64_nommu_defconfig  |  64 +++++++
>  arch/um/include/asm/Kbuild              |   1 +
>  arch/um/include/asm/futex.h             |   4 +
>  arch/um/include/asm/mmu.h               |   8 +
>  arch/um/include/asm/mmu_context.h       |  13 +-
>  arch/um/include/asm/ptrace-generic.h    |   6 +
>  arch/um/include/asm/tlbflush.h          |  22 +++
>  arch/um/include/asm/uaccess.h           |   7 +-
>  arch/um/include/shared/kern_util.h      |   3 +
>  arch/um/include/shared/os.h             |  14 ++
>  arch/um/kernel/Makefile                 |   3 +-
>  arch/um/kernel/mem.c                    |  12 +-
>  arch/um/kernel/physmem.c                |   6 +
>  arch/um/kernel/process.c                |  33 +++-
>  arch/um/kernel/skas/Makefile            |   4 +-
>  arch/um/kernel/trap.c                   |  14 ++
>  arch/um/kernel/um_arch.c                |   4 +
>  arch/um/os-Linux/Makefile               |   5 +-
>  arch/um/os-Linux/cpu.c                  |  50 ++++++
>  arch/um/os-Linux/internal.h             |   5 +
>  arch/um/os-Linux/main.c                 |   5 +
>  arch/um/os-Linux/process.c              |  94 +++++++++-
>  arch/um/os-Linux/signal.c               |  18 +-
>  arch/um/os-Linux/skas/process.c         |   4 +
>  arch/um/os-Linux/start_up.c             |   3 +
>  arch/um/os-Linux/util.c                 |   3 +-
>  arch/x86/um/Makefile                    |  18 ++
>  arch/x86/um/asm/elf.h                   |  11 +-
>  arch/x86/um/asm/module.h                |  24 ---
>  arch/x86/um/asm/processor.h             |  12 ++
>  arch/x86/um/do_syscall_64.c             | 108 ++++++++++++
>  arch/x86/um/entry_64.S                  | 108 ++++++++++++
>  arch/x86/um/shared/sysdep/syscalls_64.h |   6 +
>  arch/x86/um/signal.c                    |  37 +++-
>  arch/x86/um/syscalls_64.c               |  69 ++++++++
>  arch/x86/um/vdso/um_vdso.c              |  20 +++
>  arch/x86/um/vdso/vma.c                  |  14 ++
>  arch/x86/um/zpoline.c                   | 223 ++++++++++++++++++++++++
>  fs/Kconfig.binfmt                       |   2 +-
>  fs/binfmt_elf_fdpic.c                   |  10 ++
>  43 files changed, 1262 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/virt/uml/nommu-uml.rst
>  create mode 100644 arch/um/configs/x86_64_nommu_defconfig
>  create mode 100644 arch/um/os-Linux/cpu.c
>  delete mode 100644 arch/x86/um/asm/module.h
>  create mode 100644 arch/x86/um/do_syscall_64.c
>  create mode 100644 arch/x86/um/entry_64.S
>  create mode 100644 arch/x86/um/zpoline.c
>
> --
> 2.43.0
>
>

