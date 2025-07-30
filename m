Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5855C87FCB
	for <linux-um@archiver.kernel.org>; Wed, 30 Jul 2025 04:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KJZ2Xdj7Q+MZcbLlvMM9U359yJ94gJvtKBItcmsRF+0=; b=r5Oxt6m42B1bDHSklIz4xiIEP1
	s4BJONzpdF7rOGRpxcSOR3QfFptpRc32vUXklkpwpY525Z2XRz2Ii3uYaZxxh+nKk0tkdoqudBjnK
	W9SxcRpsYBdOYWPp2zmzZRxEYUQ2xWN5axTXmMfb9Xg7gagtcGazh0cWoiPlG4LY7pujX3N/HWE4G
	rDSWA57Jshw9yvgdDwZA4MmNcUAFZBjwRSH9SngHoyL02Uvp7FxSAKvkxpg+IZqLGnBFvo1bVHGwz
	HBLbgn2qFCFVs0GNOriU/oWUJXH2NarPR7DQWNcLvoP/QaJGu+P4vSptMt+LPTx1osTHZBTDWKgr9
	jBWA3KDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugyJe-00000000fjG-1Vyj;
	Wed, 30 Jul 2025 04:21:22 +0000
Received: from out-185.mta0.migadu.com ([2001:41d0:1004:224b::b9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugyHT-00000000fXC-3CV0
	for linux-um@lists.infradead.org;
	Wed, 30 Jul 2025 04:19:10 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753849133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJZ2Xdj7Q+MZcbLlvMM9U359yJ94gJvtKBItcmsRF+0=;
	b=mXdQpiuERJ/szZLSa+HIe1frE8Nh8q8KH3xJJ9ssfQNK3ieWrfGXR98n4kwZG4sHR5Yea0
	uzCfYbW59jAl8v45r4gzkUP2WL3uvtaPfxfDLSbpsxSSK0lvhT4SvB/FpWGMFXDbPT/2m+
	rkkbSBGWMY+MA5L1UFlXq52M3kTNaMc=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH 9/9] um: Add initial SMP support
Date: Wed, 30 Jul 2025 12:18:38 +0800
Message-Id: <20250730041838.1821401-1-tiwei.bie@linux.dev>
In-Reply-To: <8bfc7ba021d584d30ac25c06d142d06dd72f15d0.camel@sipsolutions.net>
References: <8bfc7ba021d584d30ac25c06d142d06dd72f15d0.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_211907_948634_D1D05274 
X-CRM114-Status: GOOD (  26.32  )
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

On Tue, 29 Jul 2025 17:37:24 +0200, Johannes Berg wrote:
> On Tue, 2025-07-29 at 23:06 +0800, Tiwei Bie wrote:
> > On Mon, 28 Jul 2025 18:27:53 +0200, Johannes Berg wrote:
> > > On Tue, 2025-07-29 at 00:04 +0800, Tiwei Bie wrote:
> > > > > > +++ b/arch/um/include/asm/spinlock.h
> > > > > > @@ -0,0 +1,8 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > +#ifndef __ASM_UM_SPINLOCK_H
> > > > > > +#define __ASM_UM_SPINLOCK_H
> > > > > > +
> > > > > > +#include <asm/processor.h>
> > > > > > +#include <asm-generic/spinlock.h>
> > > > > > +
> > > > > > +#endif /* __ASM_UM_SPINLOCK_H */
> > > > > 
> > > > > Do we need this file? Maybe asm-generic should be including the right
> > > > > things it needs?
> > > > 
> > > > I added this file to include asm/processor.h; otherwise, there would be
> > > > a lot of compilation errors. Other architectures seem to do the same:
> > > > 
> > > > $ grep -r asm/processor.h arch/ | grep asm/spinlock.h
> > > > arch/arm/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/alpha/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/arc/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/hexagon/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/parisc/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/x86/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/s390/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/mips/include/asm/spinlock.h:#include <asm/processor.h>
> > > > arch/loongarch/include/asm/spinlock.h:#include <asm/processor.h>
> > > 
> > > Except for loongarch they all do something else too though. Feels to me
> > > um (and loongarch) really shouldn't need that file.
> > 
> > Sorry for the confusion. My point is that since other architectures
> > also do this, it seems common practice to include asm/processor.h in
> > asm/spinlock.h when necessary.
> 
> Yeah, I understand.
> 
> > 
> > The reason we need to include asm/processor.h in asm/spinlock.h on UML
> > is because:
> > 
> > ticket_spin_lock() (which is an inline function indirectly provided by
> > asm-generic/spinlock.h) relies on atomic_cond_read_acquire(), which
> > is defined as smp_cond_load_acquire().
> 
> Right, but that's not the architecture's "fault".
> 
> It seems to me that either spinlock.h should include asm/processor.h for
> it,

+1

> or (at least, but I think less appropriate) asm-generic/spinlock.h
> should be doing this.
> 
> > On UML, smp_cond_load_acquire() is provided by asm-generic/barrier.h,
> > and it relies on smp_cond_load_relaxed(), which is also provided by
> > asm-generic/barrier.h on UML. And smp_cond_load_relaxed() is a macro
> > that relies on cpu_relax(), which is provided by asm/processor.h.
> 
> In general though, there ought to be some definition of which header
> file(s) is/are expected to provide smp_cond_load_acquire() and/or
> atomic_cond_read_acquire(). And that header file/those header files
> should be included by the files that use the functions/macros.
> 
> 
> IOW, I think you've stumbled across an inconsistency in the generic
> files, and hence we should fix that, rather than having each
> architecture paper over it.

That does make sense. I will prepare a patch for that. Thanks!

Regards,
Tiwei

