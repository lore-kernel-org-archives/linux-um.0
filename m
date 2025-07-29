Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E75C87FC9
	for <linux-um@archiver.kernel.org>; Tue, 29 Jul 2025 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeQdashjdQNI8gbjgURwp4/QnqHp/DiqcU6QF/6BzDI=; b=UssPBkGvI3uL7d+ceumQOCGlfa
	L8R0EhIk50PBAMF7CMBB34kj159EIBvvnVyT4Ghyby145Vtt30zwPlrn9LToBsfFiSHFKhrKcBj8s
	H3uY/H3W9rCWA347SZQ4GpvQrxBBexKt3Q9Xn2IPVlFgH5nvcj9FfmhgPjRuUjcUC2q31lSEjiz6F
	0tw2KaAFGxn3YTLaAhpL1jRVnp/ETfBih9EM3o40XspOeVaZv+lmRF517Qm3n/gxuHBxnBYjUvjAY
	7JgzdjskaemzFBou5fpe5hNKU3heXecsv8fOCtOBnMpi1XFw/mck2ZgVVlnbNU61sdoS0VSCUKXyD
	X6GnUonQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugmQg-0000000HA6P-3RLv;
	Tue, 29 Jul 2025 15:39:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugmOQ-0000000H9nl-0iX2
	for linux-um@lists.infradead.org;
	Tue, 29 Jul 2025 15:37:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jeQdashjdQNI8gbjgURwp4/QnqHp/DiqcU6QF/6BzDI=;
	t=1753803448; x=1755013048; b=rYBogsgaK5jq7FxYx+y8ADV+QaWQGitV1YSJuusH4yZX03k
	5jUIQYXX7+NFN53CDZKDL7cERQSkbMDYFiO/ilYBCV4rftUycI6m+ICWf50ZlK5rUYkwXJbYtUG4D
	qEyuBfJktFa1on8l+BTbN/rnULJrELF7uqmCFnJUO5Gu0jnE21jtRRWjjCTa0YG5hU7Kz+TYBvsBR
	HbGT3YpJCqhD6fdKu84ai2Kf8e5tZ8AIkFf9Xd4aNlUBnvPRXN+w8X8n44IzBprr6J2BE/4FxhCs0
	HmeVQUptk4qGD3pzcQhfSyF1NaxmV48yDWPLKfViEglqVLIh7uLstNqhJ1Zsx1Mg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ugmOK-0000000EkPg-3Wtz;
	Tue, 29 Jul 2025 17:37:25 +0200
Message-ID: <8bfc7ba021d584d30ac25c06d142d06dd72f15d0.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 tiwei.btw@antgroup.com
Date: Tue, 29 Jul 2025 17:37:24 +0200
In-Reply-To: <20250729150651.1957466-1-tiwei.bie@linux.dev>
References: <1310a0eaf8c8e3a1e944ad3f4f289f02164702cf.camel@sipsolutions.net>
	 <20250729150651.1957466-1-tiwei.bie@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_083730_211879_43C47E6A 
X-CRM114-Status: GOOD (  23.39  )
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

On Tue, 2025-07-29 at 23:06 +0800, Tiwei Bie wrote:
> On Mon, 28 Jul 2025 18:27:53 +0200, Johannes Berg wrote:
> > On Tue, 2025-07-29 at 00:04 +0800, Tiwei Bie wrote:
> > > > > +++ b/arch/um/include/asm/spinlock.h
> > > > > @@ -0,0 +1,8 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +#ifndef __ASM_UM_SPINLOCK_H
> > > > > +#define __ASM_UM_SPINLOCK_H
> > > > > +
> > > > > +#include <asm/processor.h>
> > > > > +#include <asm-generic/spinlock.h>
> > > > > +
> > > > > +#endif /* __ASM_UM_SPINLOCK_H */
> > > >=20
> > > > Do we need this file? Maybe asm-generic should be including the rig=
ht
> > > > things it needs?
> > >=20
> > > I added this file to include asm/processor.h; otherwise, there would =
be
> > > a lot of compilation errors. Other architectures seem to do the same:
> > >=20
> > > $ grep -r asm/processor.h arch/ | grep asm/spinlock.h
> > > arch/arm/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/alpha/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/arc/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/hexagon/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/parisc/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/x86/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/s390/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/mips/include/asm/spinlock.h:#include <asm/processor.h>
> > > arch/loongarch/include/asm/spinlock.h:#include <asm/processor.h>
> >=20
> > Except for loongarch they all do something else too though. Feels to me
> > um (and loongarch) really shouldn't need that file.
>=20
> Sorry for the confusion. My point is that since other architectures
> also do this, it seems common practice to include asm/processor.h in
> asm/spinlock.h when necessary.

Yeah, I understand.

>=20
> The reason we need to include asm/processor.h in asm/spinlock.h on UML
> is because:
>=20
> ticket_spin_lock() (which is an inline function indirectly provided by
> asm-generic/spinlock.h) relies on atomic_cond_read_acquire(), which
> is defined as smp_cond_load_acquire().

Right, but that's not the architecture's "fault".

It seems to me that either spinlock.h should include asm/processor.h for
it, or (at least, but I think less appropriate) asm-generic/spinlock.h
should be doing this.

> On UML, smp_cond_load_acquire() is provided by asm-generic/barrier.h,
> and it relies on smp_cond_load_relaxed(), which is also provided by
> asm-generic/barrier.h on UML. And smp_cond_load_relaxed() is a macro
> that relies on cpu_relax(), which is provided by asm/processor.h.

In general though, there ought to be some definition of which header
file(s) is/are expected to provide smp_cond_load_acquire() and/or
atomic_cond_read_acquire(). And that header file/those header files
should be included by the files that use the functions/macros.


IOW, I think you've stumbled across an inconsistency in the generic
files, and hence we should fix that, rather than having each
architecture paper over it.


johannes

