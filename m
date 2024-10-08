Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2141FCFA757
	for <linux-um@archiver.kernel.org>; Tue,  8 Oct 2024 09:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iKjoBjJae/pLRQ1aSfDOaPKKJm7Eygw6jfdHNjoeJSw=; b=XOwojK7PCJyWpyZWD8HxUuTAe2
	6Ev/aAU8V+6oo01UHnxzyYPdiQHnnQIi1m0RYg4BzGJoQ1tLxnIibppfVwn27uAUPcxsyIXXLmjnm
	qo9ZeEQwOvkqVO9+/4p95EH5I6Ll0PK1LyiRrTKEQ3yyQK+PTTBNP961foQTt8VVJS8Xw13fXtlfX
	qCgxJ2psMvaQMORS3CubZyOiGreaGRDgMNRYM5TWWwwkmYDX3oA7WAAco86DmqyHRmQqNajhXu7+5
	hMpRsOkrjO666RaEMhPHn2ibdfMbBPFYJtFLSU6KXIB29aQ7bFO5lK2DhaXFGtQbJZxaM41i5LnaS
	YTxSztoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy65L-00000005C7W-1gRI;
	Tue, 08 Oct 2024 09:00:51 +0000
Received: from smtpout42.security-mail.net ([85.31.212.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy50F-00000004sdq-2Xze
	for linux-um@lists.infradead.org;
	Tue, 08 Oct 2024 07:51:36 +0000
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 435CD3CB59B
	for <linux-um@lists.infradead.org>; Tue, 08 Oct 2024 09:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373889;
	bh=ZQQgRQ5129j5X1/NdSKrMYZVyLQUuTmIGFdtLtf9lDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VwbPp1/s/fem0W7Zjy5RYLbC4euyT+BEowAU00d8rb3+lWFKL4h6VFLTtgjZSK1+P
	 nhzrsDWrnc127wX8S7w4ndUAbonfB7RSibi+1i3ayjh/AyeRfD9/wrei7NWRadh79F
	 Bol65vpb8aCtYI+rkwQYkwnCtT4qMY6l8FHF/3uc=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 62E5A3CB528; Tue, 08 Oct 2024 09:51:28 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012051.outbound.protection.outlook.com
 [40.93.76.51]) by fx302.security-mail.net (Postfix) with ESMTPS id
 787233CB712; Tue, 08 Oct 2024 09:51:26 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR1P264MB3357.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 07:51:25 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:25 +0000
X-Secumail-id: <14243.6704e47e.76931.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+XBqN2dpBtW3AFkzmG4gn1yfztySbvITFxIXZaMI+oe9jBJj8FfD8MGLZLfSD9aAX6IHfvvajX/cGPJjqBKUod6/MAmVMwIrhe74PK3KM6FR02ztGmVge19hRO0hGZSCZfTzqNynrMR1l/QOBCl74clsXLcq+KQ2S6AzeXC3gLFu4bzEi5A4Zt6vtpEVzjiM5CM04II5YIneb82ckOMlFtYZL6jfU4WmtD0KtuJxFtJjdNWhslKOHE0XHUU/XKsEz9QCVJ7xztE9b2K0V8kZxVV61uDqCjRLD1bb03POta2ok4vqmhCCfiajfJQm8VLSzGUeYIpYl633pVPlwusRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKjoBjJae/pLRQ1aSfDOaPKKJm7Eygw6jfdHNjoeJSw=;
 b=qqxkEN46v9BvwJ74WACkVcQPBOpZOvuA+k/OvY+7z+AeZL5/MhyGRmAC9HF57KmS2lIb7cF1+aTn+sHDMXq4Vd1qinNI1G+FLPPbj8zXvvnhtU37O/q5utYXV+PkQFa0Br17L58AhsZGlPNvZkjRbIgCK2A/+ZL0Oyh4/X8hnCFDGrLqxj1HIGAPTHrrZjoPvLHWYII8JbgA3L6/LThsjBLjKzb+c8rYv5gwe38onU34M350etZuoe9jXwMDMPObr22xwOVp/CdFXjBgRi5n84/3B4aYAwPMax1Lq+j2VlSPktLjTANlMrfUtTLHhGX/HbMYSZFyyIj/Emo/41Uv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKjoBjJae/pLRQ1aSfDOaPKKJm7Eygw6jfdHNjoeJSw=;
 b=QMmDI8+mi0dLsfyowsFA93vxgja8hl9ZDVisq3caUB6XW9CBNvLCbayGTtDPuwo4M7ZRuYu9HHVf7zNhpv4dCEFkynQnugRh8eZkUaPG9zmkVsvhw1RPhFlvENMBiC0MrUdVXcDWKATLBvFO3quuzAgw7fyVnT3rjov8lxnoZ3Z1dx+d7AVBAtMCVj3ok6eZo3ZjeKHkW8kfZvTjOE77AIl9xsgVrsm56VVq2kka44HNhmFN+/PBlDy3UuJIXRguxr8StQSkrVFpL/NsOqeA1+U6KUO2wVdghLmknUTWn1FghyJZ/6n/Xx6jAP9uvOFfqgpgM3s1F1McQhiNJ4+liA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-sound@vger.kernel.org, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v8 13/14] mtd: Add HAS_IOMEM || INDIRECT_IOMEM dependency
Date: Tue,  8 Oct 2024 09:50:21 +0200
Message-ID: <20241008075023.3052370-14-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008075023.3052370-1-jvetter@kalrayinc.com>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:205:1::32) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR1P264MB3357:EE_
X-MS-Office365-Filtering-Correlation-Id: f34ee43d-9581-4c22-aa4a-08dce76e0250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: AM0M0y+WnO9ZEQuKsDISlV4BgXHh/2cmXbIi0aNMRS4exbHFzSIhRMIbE1M2K0epyTPi1La26brtNL/1FS8975sp3Sup8t75QuSYyr/IUzOrjxw0ld7bMBa1IJ+04joyVxMWKjKLPxbgEA0mKN4TvBEd7YslKVN++NB1hsRW/a8yESCbfJ3JlXYxNZCyqkKim2qK4WBoa1gXT4lvk5o/4t03tZMJ5RGK+YOQK8cDgIW0hCK1GX4cB94yCBka8P32b6Sm0FQnDhS0AKv8F6rzvTrbr50E3Pt7ZOuc3XObaIWMrEt3KRaHVmYnEczIlmYdjjDWV49Rwf600LaHEsQtVOoDaUY3XXV21A7lS8hxofvjeWmtYvLPKWT1yu9I89jy4uQ1z4cYMELxUw+5KQ1z62AEhJxsSauw5t+YElqIRpkBicaIxr0Qjf99ano/0VHaRAEUvrVH8MMNX/w35b2x8aqGlV9LLnqOUMpThXaPABinV96ZXbgsV5RAg4RMgeVnrC5l/VWw84iOBmy+sf/WmKVzh1AysCXYhElgc1oHCmPJ+jVdPfuc0aSKWGMxJdsdzEOtfDkt/ugzcGXwC4AM0IA6rrC+eyDOGW4iawhv22FK/QAcShdHLp5HyxMGQOYwBo7aQptzT9Y/xTv7M4WUF6zD/3Wl+j/qFm9z61qDl0MU6VcdKsswYTZyDzCHNYKZ6Y93qn7zy0R6sTr0I8isUZH18Yn00HH9WM9sRNHVwKYVXGurnSntfgFaFNBReUv88PWmLTJFtL61SEUa9Xl7IWwwSDHgYdZAe4ghXsYfGCPtzs/Izf6J1uFGbfLNCXVARehfPH/O8JE1Eo3qh2Anj8QXkex3foeIB6B6hGKQb5vtl92Dxzf0fPA2OJr1saQe8oBfkGOmLXl4KsKWLQC9BBBKCiGTS+Q0t029gRMhg42Z38aOmJ2rQKSCFk5BVubqms8
 qY9RmXOcQxuR1+0L+wvLHbvQe5MtiWRRq+WZyQhyBHONRqKrfmfU8mnrm0V/WimqoKWaxItWiII+yxA0moduPuxnqMiLFsqQS0X5OPzCHZeoaDc0hIQtYZYTE7iHM4WL3fb5Ti2mTGOOto5iwdkgwiAJYfkvo3oZVBC0xSnf9nzTUd+Cpq8PC2k7YtUukw08HAHlXh8lRQyX3iwUJJ3VAiUey8suEYZ3tkIW2m3A8Qp3Ji19M/hRrnLII1y8K4+aWhR8CRh5EFQKMCbQ1Kc73kYHd76jJiLv2dx0BDfZxGmrwS4k+HN/bGWkWbQtuUX/0aRUqZD8uKNgoR1b/mIvEV2vDCIXTB+dqKnKZ4/Fr+zRI9z2A6Oh79dWBVruUePcL1nU/K5+ck+I6s9/2I1uPz/ju6c9GzslA3c3RARw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3X1ymQ75KFMjLD0NYYliIw0eNCyaxdD/5L4345EcLrsmEYR4DCtX2Jn+leAArhK8PliOnXL3znhF0q/TExup3Np1kxZH3gJI+KLTAd+FVPrds86QPtWLQ7fq9GXxJCqrMY6VvIwgb7vgAOb6sbP9HHXG9rLln+Eyu7xmhOUXSNAFW5yTEvn+pFLVSZvwqNJl/EvzIjbc7+I8PVBleyYiSSX6+llII4UFWXlWpBDPJWapntnncRuJFnxPWLE4eEFJlaDp5dgi8hNAtsEMcvmphyn/jd9/P36Q35uR6W3kN8wV6OLyRG29MF2Ixjt21MhDccppRRlzNs3N6xlC1ZYhuini9LPoJcWWv/dLKqqpLqCKnec6Rrhx9y1X4utevgajr6oVCO8n1isx+9OZ9YP7YkC6lxrPxvLaGS14lHZ+uf0YfzTTCnn09wwRUYec01eVOwrQAXGjFPRXECLmomh4nQE2XTzQlb5Oh1fLv3RqND3jfyVw73SvbB4wBhOwoWUt9cvzoeSkW0Fatyc/fL8JljMktc+HrSuyxQG6FBbMscMlOCBWLeQ2qyH40wDXWQ4DnR3hzvQnOMmRY06HXEh/hxtzWEGE6G9zmJ6UgQl4rUgkgJLThy9RRv1UDOpOhxbHHB7GU5P+XkuS54gt56KyHRbA+hfUbOZfheTJwbWgrv3zo9hEpPluJgT5lHg+BzwLJWZrhhyV+JTmrg4seqLiPu12tP82eWHa/HHNZGfMgnk6UbgsvIlSiJfgvEIfOWNUGF6Ct13d6Tb6CLX0bdr1hj3Rcehssc1bqXINx6gk2wQTZJUr6OZL2pIUqq+vsyON/8BB1LTpYbZk8JrorYvbLfHXVK38WHr695x3M26Pns0WFiXT5jPHkUGejZx/YqbzgijwlILzRwxBs1NcrYvta+Ar1eMhkYz0GSGvNwKLkfzjNu8e682G4FcfuIxB000D
 pkiicF4NdoHy82m0n/2HeaT168ARLVGi5oE8poZ4PS/mH40CwdhjK+N0S8GT+XnX4Tf1ykiTrPcfxB96XrWz4cQg8yFhOegejGcHMrk+PNsp5e1wIpYOdViTZWKIpVgRi5eh0tqrHe1aOXiOZ5h8YDHyvUIvrvTSiMX3/zjMVc2NP3oK1tDu6107Y0jmKWcdaXoASra5MeJUvEJLM6gBBjKCQwxj2AVAzcWSqSLtbt4JZYaTbLoxzZ5DRlKEEYXgUS66AD7IC4zHAGDP1w7zuOz23u6VCejnY0A/HlprRPqlemIRq82b36pwz7S1AiQHfXOdXyyTg6hw/SYdEaxvxLCRzOVo4wVw2XQklvvvKCzWes90ifoie/oYNHvFizzH7w0VY6embSiD3loHSF3W07jDfYXTRn8DUI7FvBzmDjvbFT6texLsn5e9RK7QW1ZJezJ6iHuOPpA2Yh6NGLMuiXS8fCXX5Im2QMaQOypEGscILpRkPTTKn1yfIICKa6BL0DyqY3A7oBNgpfANAMyNHKmA89bUqKzOekl1tkU8hcUT47/BLvg9UJPvcLMfrzMvjcKAGFptGcanMl9XTar2B2fnYhVosXx94KMEeHWGPp/63DVXwot9/qzWRNZfiWaX
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34ee43d-9581-4c22-aa4a-08dce76e0250
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:25.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnKpxADPBy/fTQuXFvrhuVj3mLUqKJykxTH9nGOZDw5fLgFyQN3U16pSYTylBPjHaPWlGf3QU6LaHr6kyggJsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3357
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_005132_128874_8DFE596A 
X-CRM114-Status: GOOD (  11.91  )
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

The UM arch doesn't have HAS_IOMEM=y, so the build fails because the
functions memcpy_fromio and memcpy_toio are not defined anymore. These
functions are only build for targets which have HAS_IOMEM=y or
INDIRECT_IOMEM=y. So, depend on either of the two.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- New patch
---
 drivers/mtd/chips/Kconfig | 4 ++++
 drivers/mtd/lpddr/Kconfig | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index 19726ebd973d..78afe7ccf005 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -4,6 +4,7 @@ menu "RAM/ROM/Flash chip drivers"
 
 config MTD_CFI
 	tristate "Detect flash chips by Common Flash Interface (CFI) probe"
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	select MTD_GEN_PROBE
 	select MTD_CFI_UTIL
 	help
@@ -16,6 +17,7 @@ config MTD_CFI
 
 config MTD_JEDECPROBE
 	tristate "Detect non-CFI AMD/JEDEC-compatible flash chips"
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	select MTD_GEN_PROBE
 	select MTD_CFI_UTIL
 	help
@@ -211,12 +213,14 @@ config MTD_CFI_UTIL
 
 config MTD_RAM
 	tristate "Support for RAM chips in bus mapping"
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  This option enables basic support for RAM chips accessed through
 	  a bus mapping driver.
 
 config MTD_ROM
 	tristate "Support for ROM chips in bus mapping"
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  This option enables basic support for ROM chips accessed through
 	  a bus mapping driver.
diff --git a/drivers/mtd/lpddr/Kconfig b/drivers/mtd/lpddr/Kconfig
index 0395aa6b68f1..f35dd8052abc 100644
--- a/drivers/mtd/lpddr/Kconfig
+++ b/drivers/mtd/lpddr/Kconfig
@@ -4,6 +4,7 @@ menu "LPDDR & LPDDR2 PCM memory drivers"
 
 config MTD_LPDDR
 	tristate "Support for LPDDR flash chips"
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	select MTD_QINFO_PROBE
 	help
 	  This option enables support of LPDDR (Low power double data rate)
-- 
2.34.1






