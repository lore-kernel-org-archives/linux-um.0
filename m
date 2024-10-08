Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41816CFA756
	for <linux-um@archiver.kernel.org>; Tue,  8 Oct 2024 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cSfEOYSJlceA0SFxEGdFb627GjEARw+Rg9XGXMt9lpk=; b=aurstAb8aYi7Ww+VolTXazsi9S
	c7FHsVQ7clnITdhSjsxawcrv15EKF+bIKymP6OTGczhw6y/qUbjnBA+quXOkgyoPRpXcgTagn5fxr
	B+eYKntprTlEYo1qNuQZENA7VUBini90la7FWdpVk+UMkyFDD5egQhPOmgahuhk5igPlTK/8/5TYo
	GiUGf69v/RCiwiBt6nD9QSSj0q8PYWQaT3+STZ6Hk2STDFe3CHtlABVzK58xPPOJbH0ldCvrhN05r
	gp1FlF1SSQeeA0355KbKmD87ALuvnR6KB+TzXQ1LaMLjKv6f2ReTO/xN4FsXDmCM8Y0nbU0MZXrqy
	aCpnlY1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy65K-00000005C6l-304s;
	Tue, 08 Oct 2024 09:00:50 +0000
Received: from smtpout143.security-mail.net ([85.31.212.143])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy50F-00000004sdG-0nT0
	for linux-um@lists.infradead.org;
	Tue, 08 Oct 2024 07:51:36 +0000
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 78EDC8A3245
	for <linux-um@lists.infradead.org>; Tue, 08 Oct 2024 09:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373889;
	bh=Wj0k0HE6mNzHb2zn4kh2iBXEfuN3+ij3lenZMtItV7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JxjZaskYmjOm8E9jA8nODhcbzuMiPyJrZylM0ZmwcsDEVi/Qmts7skrKZwWHr0USo
	 oWUYExzgLaET29d1hnFvR9ZG7vXfbVsCZ7nQja+8z60pvXa7uPm7Qyv95z+1RgyByt
	 Trwcl7psWRNcaToZFX8w2brsoHMVO5oXd+NasQEk=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id F1CA98A3244; Tue, 08 Oct 2024 09:51:28 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011026.outbound.protection.outlook.com
 [40.93.76.26]) by fx403.security-mail.net (Postfix) with ESMTPS id
 3881B8A3241; Tue, 08 Oct 2024 09:51:28 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR1P264MB3357.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 07:51:27 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:27 +0000
X-Secumail-id: <8aaf.6704e480.375e0.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEP836nzTVp406bt12bm5o4tEaL4T/F+51msHvgG4HP7mko9t8Ldpat6BfFfePvw3KM6xlkalvIYRVLA/AqelMZJA25W1uS9zyONWyDiogvCo5XAeI+ZJweNULVOS8GylTvYQ3G9j3TOYK5fHCsqOMygUw8a52DKFcm6A/rk5MkVDD+/lezMILnfS2SqvTKWNb4VaGX6BplkLIt/zkEa7x0DMfIeciNmHf93z12P6KAKDpEvJ/CeQhxMSoAnJi+2PEhGWUYHD5w4ZUX4N8GjNqPiKe94yKBVcQsgYBH6ucHAxn6JJq+eKb8F32yxEbfczDhTHP7g/e86TGhIekRrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSfEOYSJlceA0SFxEGdFb627GjEARw+Rg9XGXMt9lpk=;
 b=qkapIAzDf8c1C9ChQZ+G5pISO0Ee8dJwEjTUmiD1Ei2mbn/SHuqCFs9BAjqXnBQF3qoJJxrDmnZD4S+wXTR06jeWtJJahzMw2LdT+YAbLIuUAyBDGEIKwhYPEQpJPiZSjw0qSx2UvDk2fPDG9y0hVamY8S5qxmHeulXblrm2b4TTUGckEsyfSnfaUuNvkt5BJ9KK4bTZW6JMS423sNAFCbiiuEUXdFt6LlVbY5z0GWtx4hAJ6VMDxrMX91c4P8NNcMErte7S72S0wYkVYm6H00RVMA/VrbRxxS7ULaVPP3wZTZlL4/OoAxn1KC5+u/+J5ZlIkFHaqNVVGexmDVqTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSfEOYSJlceA0SFxEGdFb627GjEARw+Rg9XGXMt9lpk=;
 b=GiJ7w6ZDcCknfWb/23q0YZEcfLFcGpdl8iOslbf76+00IfxJjMeilucq9DmWVBLefv2bIKZtQJu3YxypNO9spAeNpZi7IZfk3LtEU/JlpLNyMaUKqd5zJitCyA8iw5A2t9SHCAQ/XEYMrJDwOyt/rOkep0XlEaMS4+/R52wz1Rnry5/eErDaOjOim7f2kIK8WrVXsSVBduNTNL7gs3BJzHIU0oUUOB7qKq8SPjF4tQtLl5WcsRB0rbWsqLJWGQzPuVFfiL3E0pLHLqa/ZeWj1nguxLiJF4jTBGu+H+Hyr0XcPK54s93HdlP9LeoI9JOY1o3yEIeDr0krqP8HMBkhhg==
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
Subject: [PATCH v8 14/14] sound: Make CONFIG_SND depend on INDIRECT_IOMEM
 instead of UML
Date: Tue,  8 Oct 2024 09:50:22 +0200
Message-ID: <20241008075023.3052370-15-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d24f36b-fb64-43dd-ead8-08dce76e0372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: TTCXJe3OiQagvF/xpSPrayZy9T5eEXvUe5EW7f0LKyDaWDKjtxkq8/kPrOI+ZAqKTuYch785IwdaXE/2UviYEE4XR72bMhSUTUxq2VVehA6pj4zuw/QXUFA6yD42eZ7KhZIlGTbkyOqXoHdyGJ1rQ3jn6sqKbejCUITr+heTK5Ooz+B4nbrKwoeJxkjsKLII0EjQkx1o6mxRnKvsJERK2BElKxIn+qJmNaKlGd2nBUfFk63JnWQi7vuC9N/rHHVF6dSJ7zPiIFIbK2nEJ5MkZfnhmau0NxqGHgSp6bgAt/RzZi5lS+5CBljBF+LMrptKaVn0xOrhAILhRAvM2o2Xhbd9EUhAC6NkvdPBoGSgGbwT5/cxTgmZ58ePW9lOf4U9IHhq6ryl7/n/DikaGhDG2rLlGta3OgHYsfPUAmJFOVnfnuIxSHCnva5EOPfKD4x0Zcny1/J+Cm19AYS15FPSRBhWj+EQLtKUIbpDt/VpRkh+bMKjlZwwOk8cXtj8ItkzVrZH50ugzjJmSQoQhWYaKbKqQ3IrXApXCDKgyklsjmCyswirDt7xGe62knBSieww68LfQ3S6XrGmHE1J+QSPAGAxaZ7dO136Wx+S6H6KZbiz6mHDp4brlxMnjdL2LZ6zMoSlB72b5DHhl5Fjm0in3hu9ZSDvu/Sl8R8wH5ZTDZAKzx0QZYjoD9TK9l0PCscimEYb+Kg1fTh8TfrClwP+uZVpk7xODJCWMYIyI5kTzzZeT+CUWBOQTHfp2TeFUhfV0ZU4z1QSG2xWjwwuc2Efx788BGaC7oVIQUXJZLhWCBlbLz6QxM82dvGvSCHuAEzXZ0L9jA0+aVQqnGaGxseEeky5fz5PueM84WkYR22TtdEampK+mmRVt3aqzEB6hPJnw6F8Z0GN+oI/HZmRzXVEnnrb9G6GxKLhHc8zU4MscK41AlPToJaFO7nY5jhQ21xPwl5
 f/uVINGyvtbd76K7Tmq53pwiIAxxEjfHimE/ez/+/THO++sqhv8pjGiHXy14ZRgGs63YQxLZCDsLcFRL3AnU6AsK5LKWliZvNJV3bDlF1dhzWpgjWbnfRTUNzeMzgn9VD48wpdcge+s5tX2UmivKbk+FlrLVtsDMpQrOPTCGHYrcG3HFUwtGdNno2ZJZR6E/gpwuBvfH89o1cAOOYOvHRsP4E+O3SpIrJXgrS07g0phxZ8RBRg83HV4CdT2SDtRPBoanqVYkYjiktabjrm3q+n25JF8Ut1OBHebn90yIqR3KJWCWbgSffriMkGbhlrF8aSBA41d1Cbh9ukZqfGift0XKZ+U5+K2c5JWS4DKfyqG9sWLpU6hnQKRsB+udmdvYzrvfXtraFZiQtAVcagaYbHPHUKR2CPwtriDymkrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JdJ2rb6vB8ZGY2TtE0VvyR78971KLEChghRrv8uU0vnnhURsFD5JFs9fj/o2DF8eC4KqXhAGGQ+Aqw0o8BE8sh9BfIYkRgvIjGuRKgXyw9oKTvZ9gnn1+Vu1BlIb19qLX8Jz00FuTVMeL0yMNa9RvQ9AcXKZeDsTST5nI3dO0BrbG1Ci/Gzz2KpRK9vhevw+zD7lfDSk4TlqczxOyb5Isdmc6KACYXk4GkpVewqj/rpxpRmNgGzRFxkww1YS/L6QDCzPUWTTX5Sdciwd/BZZR/m5/pESC49zs2iu5H0L2i5QKhu7XC3mwRKJcLlmJMNha8TWIrN0MhoO1xzof5rPqdNpFrbc3A1Ew0VSmlSItwv000DWUmw/fTCdFWi+5jIfHuOF9BTMtTf7w/onnx1lr18lWkT7v5lAMPWhrp9aw1KLKYIdrxQI4tA7kuLwnc76eyCmIzYU0Usr4gsaiPJBAsqbUtK1+8RKqh/vXkWFMzRuezM99/Qsid24m/nIsYOWOYbNpsRgmHO2ezUikCsAXwX+9oP9V3kCJWXu/yjpsgBBkRTx642sWga93LQZwMBCm489/CrHrBuHMjhdmNIl4rzQAB01nqcSMnYz6cf0TLZNRl3jWhZge4MUScFuT1XsCFJshAd+boZ5AGIjd68HQfdZEL4V0SM+w1NIVm4Hsz8ngpUPBptKd47CrFyn4fDIfDDjL1vcyMuqgLQD03DUURaCPxQsm6HenF/m5JKXb1qMDQx28sJbXkzHnLFKgKeC4q7qcOJJJxXSA1P79kFjIflpDOrWOqh0zNM+MP7UkYNTqLAJiaW9ZLnbzm619Jf76O+Cg5mBaUrY47jVGz18Fz0rQAmolF0dJhS4VeMfgR2rx2qmzi/oesf8z50/nfbNgXpD4yeTalevL/RrN0dXZYAepVtJJMrmUsjcnd4G61o25eEueF93hpC3UwYwdCK/
 M0T8jV9HtFX7mq8Iweu6iQcm0se1MY/ok3dOHk5tdERb+YCb6TYgVd5zqsR3x17xcjmcTFccfglFakcvBo+3gJpx61xh1id37Nj3ALM4NGKTzwqAw547Aw29y8QK4JG6ChyDpGFTcROoljCQfq1KTNYisEEhZC61t1zqEhmVn4tUM8gHvKYkNdlqByZxwkRnNHxiroTOatdQw4oAEc7L53fxvrLKzF2RfFehneCUOf9rb5gVARfOsyGWM5sLmtwWEntBTv/LAuDVdCl7pGuWMje5rJoutyT6FF2M14fgPqoalKe7/hhg87okQ+IOe/vXrCTRAEoJYYWY6Y+d4ew7FLgqGM5TT8YfsGJewTpLNTyU+MbZ8QKbGEb8mGdwfP08DP63S3I9KoTfsGK6KO0VU1AwIrwkiHXTpOm/BkFn74p1X1FxMEIoYIg+2Tovletzi5sjQpyTDb5MPFrqPn2JxFs671Bz68/YST0UPXzkMKVYTy8VJ5R8DhXPKvJwmtuMBnJOMtKQQzwS4Go65C/WV8c5YDtueba/XyKaXHGAW79LZ7J8Xm2RXrvVO//b6WRU4H02PEpmr1CeGud66Gt/qvynaaY4y24cxLFfX4OET2bQIrazJUM4KzGWLKk/KFWL
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d24f36b-fb64-43dd-ead8-08dce76e0372
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:27.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvCoB2WxIoI2yyvUCyqZNwQ93i99ATmajEv1VESZTxqvWvDCEMs1H8U1+9/byRKJTpxsOI1PhO04Ia6/MMWhjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3357
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_005131_655227_CCBFF2C0 
X-CRM114-Status: GOOD (  13.26  )
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

When building for the UM arch and neither INDIRECT_IOMEM=y, nor
HAS_IOMEM=y is selected, the build fails because the memcpy_fromio and
memcpy_toio functions are not defined. Fix it here by depending on
HAS_IOMEM or INDIRECT_IOMEM.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- New patch
---
 sound/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/Kconfig b/sound/Kconfig
index 4c036a9a420a..8b40205394fe 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig SOUND
 	tristate "Sound card support"
-	depends on HAS_IOMEM || UML
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.
-- 
2.34.1






