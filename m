Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F36DC83F26
	for <linux-um@archiver.kernel.org>; Mon, 28 Jul 2025 17:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y4ljMbNbX+OMnkLybnUIH3jYWnqLfyv0p+qfTNsHIus=; b=BMHoWBBzm4C8stzocZSqCNSrIm
	wkUZ2O0GOpwI0kPphzC4OKmimydcUm1xfJR6h0E2fCzfJ1Bo4eb0PnwHFp2sLZ8BPPTHXrVFk+QQv
	QQltXazf0EyDUqkYirRJz4sHGkLDeAeToGaP9u4M6wMIAnwp/EN6gJzhI1rVM1yBviJzwJhyjaaS1
	kOj0+XXp+OzJsy6MPVdHTSppzowBnk3toctmLKbl2aB8BZeEYwb6Ps+qtUW+ylkt+reVoPXjSJ/WM
	FsgJa1L4vNztFTgEJVdmcU0dNp1rc3iMoiuxowwcbn6VpQFywiZMXP37r84R1Jq+zOolO9IV4TPAu
	yOfvFhhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugRaA-0000000F5q1-3jIT;
	Mon, 28 Jul 2025 17:24:14 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugQhg-0000000Eyqf-3Mms
	for linux-um@lists.infradead.org;
	Mon, 28 Jul 2025 16:27:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y4ljMbNbX+OMnkLybnUIH3jYWnqLfyv0p+qfTNsHIus=;
	t=1753720076; x=1754929676; b=ZXI1y21COngpEJDoY497zSAo0nBrttNcQfwu1crFYlcb8Qj
	K41jRsct6jpH6ZzWkrGKQgOnLH0orgEOpM1KsuDvr7x7xwkydDx0nGUMe6B/Wkg0otcD64pIUBHxz
	B0s61aeKeOmTyUeaqw4PlGKwYdxfOsrM/0suZ85Efs7ULNn5Jg5sQozNjpYA74gFsvdbU6cyiGYm1
	LXr3ez38P7JTsZKcZweQU4laYliZM16Pbuq+Ql9uJyb9qW7OK/P2dSsTuNuj1ao7mbIDp+Dz7wnuH
	g5cQRsG8exMsLn9yTFJ1IHYXrV3l9YlVFYp1yJKIDQ3FsYyG+xenokO0vjYXJAwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ugQhe-0000000D1aq-0lIZ;
	Mon, 28 Jul 2025 18:27:54 +0200
Message-ID: <1310a0eaf8c8e3a1e944ad3f4f289f02164702cf.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 tiwei.btw@antgroup.com
Date: Mon, 28 Jul 2025 18:27:53 +0200
In-Reply-To: <20250728160419.3256752-1-tiwei.bie@linux.dev>
References: <233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
	 <20250728160419.3256752-1-tiwei.bie@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_092756_840766_24BD4BDF 
X-CRM114-Status: GOOD (  18.10  )
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

On Tue, 2025-07-29 at 00:04 +0800, Tiwei Bie wrote:
> > > +++ b/arch/um/include/asm/spinlock.h
> > > @@ -0,0 +1,8 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __ASM_UM_SPINLOCK_H
> > > +#define __ASM_UM_SPINLOCK_H
> > > +
> > > +#include <asm/processor.h>
> > > +#include <asm-generic/spinlock.h>
> > > +
> > > +#endif /* __ASM_UM_SPINLOCK_H */
> >=20
> > Do we need this file? Maybe asm-generic should be including the right
> > things it needs?
>=20
> I added this file to include asm/processor.h; otherwise, there would be
> a lot of compilation errors. Other architectures seem to do the same:
>=20
> $ grep -r asm/processor.h arch/ | grep asm/spinlock.h
> arch/arm/include/asm/spinlock.h:#include <asm/processor.h>
> arch/alpha/include/asm/spinlock.h:#include <asm/processor.h>
> arch/arc/include/asm/spinlock.h:#include <asm/processor.h>
> arch/hexagon/include/asm/spinlock.h:#include <asm/processor.h>
> arch/parisc/include/asm/spinlock.h:#include <asm/processor.h>
> arch/x86/include/asm/spinlock.h:#include <asm/processor.h>
> arch/s390/include/asm/spinlock.h:#include <asm/processor.h>
> arch/mips/include/asm/spinlock.h:#include <asm/processor.h>
> arch/loongarch/include/asm/spinlock.h:#include <asm/processor.h>

Except for loongarch they all do something else too though. Feels to me
um (and loongarch) really shouldn't need that file.

> > I feel like probably this should at least for now be mutually exclusive
> > with time-travel=3D parameters, at least if it's not 1? Or perhaps only
> > with time-travel=3Dext?
>=20
> Currently, the UML_TIME_TRAVEL_SUPPORT option depends on !SMP:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/um/Kconfig?h=3Dv6.16#n218
>=20
> so they can't be enabled at the same time during build.

Oops, sorry, missed that. Good. I didn't see anything particularly wrong
in the time code, but I'm sure it won't work there :)

johannes

