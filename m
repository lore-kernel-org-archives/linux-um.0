Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0DCC47DDB
	for <linux-um@archiver.kernel.org>; Fri, 26 Jan 2024 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x2loWJgtIiYAU3JkiPQ2Kgc6YLbmwtXrr/lssGc0Kos=; b=OPUbsPLYhMrYH3RW2SnCOppbeH
	4awbgBprdtFwiLeP2qbtjmGumYPt+DwF/Rdc+EqoKu/xcaNDi8nG47D6PVCrCVl76b9AoSukEHE6f
	EbM44IhK1ywfMenhHrMruRyvRAs/TTLbs//VrGzOS01njV96zlqppnXroEJtqVOe19SA4q5gU0fYh
	9n1TQgdCQC5UhVnx+TND3651MD1hKfIwdhsxL9NzHhSf4Iy4b9WZ5+h1unvHxdbn1o0HXe6PYErsD
	j1wC6g61+sIIn6vP05u9l0R2GIKBRNbjOSbf2M+48gpGHawN6c9jW0VR7X0IeVqxJaVWyGU+WHFrJ
	Y+VMo0Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTIvf-00000003kaz-3eFw;
	Fri, 26 Jan 2024 09:55:20 +0000
Received: from bee.tesarici.cz ([77.93.223.253])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTIvc-00000003kXb-3o1J
	for linux-um@lists.infradead.org;
	Fri, 26 Jan 2024 09:55:18 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 638D518D315;
	Fri, 26 Jan 2024 10:55:07 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706262907; bh=98uBaqksOvo0/XWg1JQiFaXFzJAFgQLh1B1y254w2Xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QSiMTsIJxe31DkozMCoyJVoren/wta82mBeBHLVS6ZMxhSyeGQW5Nlhqj0lMpIoTH
	 /sjCikjm280U0Sp4MB7LoIaOkgstCZNlz4FJkUO9WMj9fd0JYxCH0mNcHeQljXpQDJ
	 qXVBPD0vmn4tsoZSr4vbYxTT+ukPLbKNfg+OBhzVHDMpBYLc1iWnTu8u6/08laDPaH
	 bY9rLJxJ8IWA3GPhIhWatpqud/QCZ0T0H4dHvahnBBvxf/SOOiiAqL/7UpCoRlv7lx
	 xOuVKFIXVgLEDMq3pq2w1xG+RewZgaRwWKTGUn9OWtgIM/SVWSRQ9godb5T+jcTvnj
	 fAohKhJTuhTAQ==
Date: Fri, 26 Jan 2024 10:55:05 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Richard Weinberger <richard@nod.at>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, anton ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH 0/2] um: improve UML page fault handling
Message-ID: <20240126105505.38440835@meshulam.tesarici.cz>
In-Reply-To: <20240105075109.4f0e2785@meshulam.tesarici.cz>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
	<435201914.200552.1704410531143.JavaMail.zimbra@nod.at>
	<20240105075109.4f0e2785@meshulam.tesarici.cz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_015517_129870_7D3A2457 
X-CRM114-Status: GOOD (  21.07  )
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

On Fri, 5 Jan 2024 07:51:09 +0100
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> Helo Richard,
>=20
> Am Fri, 5 Jan 2024 00:22:11 +0100 (CET)
> schrieb Richard Weinberger <richard@nod.at>:
>=20
> > ----- Urspr=C3=BCngliche Mail ----- =20
> > > Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
> > > An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridg=
egreys.com>, "Johannes Berg"
> > > <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org=
>, "linux-kernel" <linux-kernel@vger.kernel.org>
> > > CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, petr@tesarici.cz=
, "Petr Tesarik"
> > > <petr.tesarik1@huawei-partners.com>
> > > Gesendet: Freitag, 15. Dezember 2023 13:14:29
> > > Betreff: [PATCH 0/2] um: improve UML page fault handling   =20
> >  =20
> > > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > >=20
> > > Improve UML handling of segmentation faults in kernel mode. Although
> > > such page faults are generally caused by a kernel bug, it is annoying
> > > if they cause an infinite loop, or panic the kernel. More importantly,
> > > a robust implementation allows to write KUnit tests for various guard
> > > pages, preventing potential kernel self-protection regressions.
> > >=20
> > > Petr Tesarik (2):
> > >  um: do not panic on kernel mode faults
> > >  um: oops on accessing an non-present page in the vmalloc area   =20
> >=20
> > I think this is a good thing to have. =20
>=20
> Thanks for the feedback.
>=20
> > For the implementation side, this needs to use the oops_* helpers
> > from kernel/panic.c and taint the kernel, etc... =20
>=20
> Yes, I did see that coming but wanted to get some confirmation that
> it's worth the effort.
>=20
> > See arch/x86/kernel/dumpstack.c die() and friends. =20
>=20
> This implementation also calls die notifiers, but AFAICS different
> architectures are not very consistent in their use. Do you also
> require die notifiers for the UML implementation?

It seems I won't have time for this in the near future... Can I start
by sending a trivial patch that panics the kernel if kernel mode tries
to access a vmalloc guard page? That's something I can do immediately,
and it's still better than getting page faults in an infinite loop...

Petr T

