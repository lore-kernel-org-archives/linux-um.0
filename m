Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99BBC3DA6E
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3oaviC+uF9ihysRnDYnMixltc4fpclC1o6scnkW6iVs=; b=284xFddYfUNt6HfI0RMuqYUZol
	9cS7ojNpQFFAdfyy6LeUVnn9C0vbCRBsbUsunbZiYxJ2x+kbasPpLQmwd4AT2yCeQtpMeD0Ar1D4h
	zjLLM/M705N+ZroStg9NriNul2z5mhQcRJnssK6PFVKmenNHiQ38ghOyBknMJ817uCjphdaIIn8Hx
	dw7clW8MAENBzHb4vb3wTUXwqSOBk2PaKuw6SQsizu4sBwBl0Y1fhOGFq+cA1RI5I+hHaqzo9R0ue
	eRsTZAcasoQaCFldLR3PyyVmOKRXUo0PF3c54kGtIPn/pbNL2djPgKxRxcQ/dxA/47SAIBMRe7+3e
	9gy435gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLe3B-00G5tk-1z;
	Fri, 05 Jan 2024 06:51:25 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLe38-00G5tH-0L
	for linux-um@lists.infradead.org;
	Fri, 05 Jan 2024 06:51:24 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id CDA611A72AF;
	Fri,  5 Jan 2024 07:51:10 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1704437470; bh=NPN413BX7veL0ZZ7wcFpIrFwMjUtaFyf8fSTVWxL9IY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUZM2/BjJNY3By53aFMPeWST2d8QK3+nd6GJQtlK/Eua315I29ynJPJ7Sa5dsd4jC
	 i4DA2glt0PCNyqxeNhKN6wG8ECyQoaj4APHCrBNEe9V5iXyegI6B1eRFvA+mhRFXSN
	 oxUjV3B3dEU+Dc/Y4iitUaPs2eWirs0OFcALSvUWSQ+duXJNJfH/398JFDzcdoS0Pd
	 dIb3Q6H8p0wq8siy3wBQvc3RuDa8SUWg4AM3t6CAUXCuCDdkyw6CG506k8nLDVc6M3
	 tG4tp7vCuTo0v9rP5wUbiAaC79iBhYKzZSJeY/Yl9vA4xqxbYCpkd0azQW6iGzO1gW
	 p5u/R2FppHTvw==
Date: Fri, 5 Jan 2024 07:51:09 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Richard Weinberger <richard@nod.at>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, anton ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH 0/2] um: improve UML page fault handling
Message-ID: <20240105075109.4f0e2785@meshulam.tesarici.cz>
In-Reply-To: <435201914.200552.1704410531143.JavaMail.zimbra@nod.at>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
	<435201914.200552.1704410531143.JavaMail.zimbra@nod.at>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_225122_642422_CC02A687 
X-CRM114-Status: GOOD (  14.99  )
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

Helo Richard,

Am Fri, 5 Jan 2024 00:22:11 +0100 (CET)
schrieb Richard Weinberger <richard@nod.at>:

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
> > An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgeg=
reys.com>, "Johannes Berg"
> > <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org>,=
 "linux-kernel" <linux-kernel@vger.kernel.org>
> > CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, petr@tesarici.cz, =
"Petr Tesarik"
> > <petr.tesarik1@huawei-partners.com>
> > Gesendet: Freitag, 15. Dezember 2023 13:14:29
> > Betreff: [PATCH 0/2] um: improve UML page fault handling =20
>=20
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> >=20
> > Improve UML handling of segmentation faults in kernel mode. Although
> > such page faults are generally caused by a kernel bug, it is annoying
> > if they cause an infinite loop, or panic the kernel. More importantly,
> > a robust implementation allows to write KUnit tests for various guard
> > pages, preventing potential kernel self-protection regressions.
> >=20
> > Petr Tesarik (2):
> >  um: do not panic on kernel mode faults
> >  um: oops on accessing an non-present page in the vmalloc area =20
>=20
> I think this is a good thing to have.

Thanks for the feedback.

> For the implementation side, this needs to use the oops_* helpers
> from kernel/panic.c and taint the kernel, etc...

Yes, I did see that coming but wanted to get some confirmation that
it's worth the effort.

> See arch/x86/kernel/dumpstack.c die() and friends.

This implementation also calls die notifiers, but AFAICS different
architectures are not very consistent in their use. Do you also
require die notifiers for the UML implementation?

Petr T

