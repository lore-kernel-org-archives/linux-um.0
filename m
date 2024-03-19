Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A80C54E68
	for <linux-um@archiver.kernel.org>; Tue, 19 Mar 2024 22:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLckV8zdpwBC7lLU1aS75M7QQR1x8wHlYNEMkhCPHqY=; b=N90w42/yAI7UArl4zqot8oFPOG
	90ETHVww6h4LqRP/f1IcqdsqA6XrUxa/hOQacn62BF2FltZ/80m3TursgNblNd3zkIbwmnHwmVYJJ
	lKgqVvvSenfWjWHUjXBlabKRJ6Enj09fKHv9zg+p/BrGv2tKONkVl3Rc0mpsSM0iKKduUPZFULeWp
	45wGT8zFz+PvYWVNVSRzKnTDA31+cvikaNKANryexxW8fZqFXmF7CZUblUK8whyF6DXi5MdQFuR5Y
	5mQVfTvSBZX/KkImifpHoP8HSPhj2eHRQhZkr4DWxV71SpCftbFcKQ2Dqbqjxn9N3OTc2E/3Nlz2Z
	5ZVrM5qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmhmr-0000000ER4M-307w;
	Tue, 19 Mar 2024 22:18:25 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmhmf-0000000EQw9-0scx
	for linux-um@lists.infradead.org;
	Tue, 19 Mar 2024 22:18:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6DD706450963;
	Tue, 19 Mar 2024 23:18:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id eBsVIj-qbrJE; Tue, 19 Mar 2024 23:18:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5F2536450966;
	Tue, 19 Mar 2024 23:18:06 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wa50cn74hycn; Tue, 19 Mar 2024 23:18:06 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 194C86450963;
	Tue, 19 Mar 2024 23:18:06 +0100 (CET)
Date: Tue, 19 Mar 2024 23:18:05 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	petr <petr@tesarici.cz>
Message-ID: <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at>
In-Reply-To: <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com> <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com> <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: oops on accessing a non-present page in the vmalloc area
Thread-Index: OdzHbbhSrpqdStaC7MekET1pCSEHow==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_151813_496775_7B6A37EA 
X-CRM114-Status: UNSURE (   9.51  )
X-CRM114-Notice: Please train this message.
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org>, "=
linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "petr" <petr@tesaric=
i.cz>
> Gesendet: Montag, 18. M=C3=A4rz 2024 14:09:07
> Betreff: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page =
in the vmalloc area

> On 3/12/2024 4:07 PM, Petr Tesarik wrote:
>> On 2/23/2024 3:04 PM, Petr Tesarik wrote:
>>> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>>>
>>> If a segmentation fault is caused by accessing an address in the vmallo=
c
>>> area, check that the target page is present.
>>>
>>> Currently, if the kernel hits a guard page in the vmalloc area, UML bli=
ndly
>>> assumes that the fault is caused by a stale mapping and will be fixed b=
y
>>> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by access=
ing
>>> a guard page, no mapping is created, and when the faulting instruction =
is
>>> restarted, it will cause exactly the same fault again, effectively crea=
ting
>>> an infinite loop.
>>=20
>> Ping. Any comment on this fix?
>=20
> I don't think I have seen a reply from you. If you did comment, then
> your email has not reached me.
>=20
> Please, can you confirm you have seen my patch?

Yes. I'm just way behind my maintainer schedule. :-/

Thanks,
//richard

