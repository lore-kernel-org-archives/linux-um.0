Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F1AC83F26
	for <linux-um@archiver.kernel.org>; Tue, 29 Jul 2025 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTilVCpqvxH+4gYgNeiGBFREOhDOFzc+K7BZeKbL4sU=; b=nhZwEZB0bR1+BKvBKZnKYHPivz
	faAdl/njCgI1N4AKeP7ax5j+FD2FH+bGivchujy8kHo4AGUwpenNsFdmDrLNEp2zw0KFwYpEGcWrc
	79GrbNAzckiHSFx7/Pb/04ex6VsD74BMkoiYAtY4fVHsgCqwiYE4GUmeoPRBUJvR5OAJpknXFXgDi
	MqNI/r/MSwd5ACO8H5BD0BbdmfgLwJ/COrJX5FtqvMlp2CPsPQM870WVd/1UJBEcVVd9pclssLb4h
	hkCCFpyKzNUrAc2YYD7tN0ri4kx3tdu2/7MCFQm0WxC35JuMEpZYtzxnrn6k0sPQG+Dzk86E4ITMO
	+ghQwVsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglvK-0000000GzVO-3oZJ;
	Tue, 29 Jul 2025 15:07:26 +0000
Received: from out-172.mta1.migadu.com ([95.215.58.172])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglvI-0000000GzUE-0iON
	for linux-um@lists.infradead.org;
	Tue, 29 Jul 2025 15:07:25 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753801641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTilVCpqvxH+4gYgNeiGBFREOhDOFzc+K7BZeKbL4sU=;
	b=BFtYeS5P+X9efbIIHY66JKozTTmsQlW+Cn6QSgRwiVAdET5Ex5Utw9SfrzGMHe0uvhr3jk
	zuTQOPV4ZRIAft3Lxmb1dl7uVVxDuZvW1FiQNyL2bA+V6M+KbfxejQoA0dKivmr2uvfBiD
	R4UTslYF3H5GpeKJAtj6UoIf7zHtOnk=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH 9/9] um: Add initial SMP support
Date: Tue, 29 Jul 2025 23:06:51 +0800
Message-Id: <20250729150651.1957466-1-tiwei.bie@linux.dev>
In-Reply-To: <1310a0eaf8c8e3a1e944ad3f4f289f02164702cf.camel@sipsolutions.net>
References: <1310a0eaf8c8e3a1e944ad3f4f289f02164702cf.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_080724_495728_5B10E8D6 
X-CRM114-Status: GOOD (  17.12  )
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

On Mon, 28 Jul 2025 18:27:53 +0200, Johannes Berg wrote:
> On Tue, 2025-07-29 at 00:04 +0800, Tiwei Bie wrote:
> > > > +++ b/arch/um/include/asm/spinlock.h
> > > > @@ -0,0 +1,8 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef __ASM_UM_SPINLOCK_H
> > > > +#define __ASM_UM_SPINLOCK_H
> > > > +
> > > > +#include <asm/processor.h>
> > > > +#include <asm-generic/spinlock.h>
> > > > +
> > > > +#endif /* __ASM_UM_SPINLOCK_H */
> > > 
> > > Do we need this file? Maybe asm-generic should be including the right
> > > things it needs?
> > 
> > I added this file to include asm/processor.h; otherwise, there would be
> > a lot of compilation errors. Other architectures seem to do the same:
> > 
> > $ grep -r asm/processor.h arch/ | grep asm/spinlock.h
> > arch/arm/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/alpha/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/arc/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/hexagon/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/parisc/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/x86/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/s390/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/mips/include/asm/spinlock.h:#include <asm/processor.h>
> > arch/loongarch/include/asm/spinlock.h:#include <asm/processor.h>
> 
> Except for loongarch they all do something else too though. Feels to me
> um (and loongarch) really shouldn't need that file.

Sorry for the confusion. My point is that since other architectures
also do this, it seems common practice to include asm/processor.h in
asm/spinlock.h when necessary.

The reason we need to include asm/processor.h in asm/spinlock.h on UML
is because:

ticket_spin_lock() (which is an inline function indirectly provided by
asm-generic/spinlock.h) relies on atomic_cond_read_acquire(), which
is defined as smp_cond_load_acquire().

On UML, smp_cond_load_acquire() is provided by asm-generic/barrier.h,
and it relies on smp_cond_load_relaxed(), which is also provided by
asm-generic/barrier.h on UML. And smp_cond_load_relaxed() is a macro
that relies on cpu_relax(), which is provided by asm/processor.h.

If we don't include asm/processor.h in asm/spinlock.h, ticket_spin_lock()
will fail to build:

./include/asm-generic/ticket_spinlock.h: In function ‘ticket_spin_lock’:
./include/asm-generic/barrier.h:253:17: error: implicit declaration of function ‘cpu_relax’ [-Werror=implicit-function-declaration]
  253 |                 cpu_relax();                                    \
      |                 ^~~~~~~~~
./include/asm-generic/barrier.h:270:16: note: in expansion of macro ‘smp_cond_load_relaxed’
  270 |         _val = smp_cond_load_relaxed(ptr, cond_expr);           \
      |                ^~~~~~~~~~~~~~~~~~~~~
./include/linux/atomic.h:28:40: note: in expansion of macro ‘smp_cond_load_acquire’
   28 | #define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
      |                                        ^~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/ticket_spinlock.h:49:9: note: in expansion of macro ‘atomic_cond_read_acquire’
   49 |         atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~

I can add a comment for it like this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/sparc/include/asm/spinlock_32.h?h=v6.16#n14

Regards,
Tiwei

