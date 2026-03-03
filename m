Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9715CEDA693
	for <linux-um@archiver.kernel.org>; Tue,  3 Mar 2026 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XBJwlrTdNJjmPV0S2dY1ySmJaA0aEJhhqGpkqw0Qvdg=; b=Y6J9n1LhZDhIFPrpvVoCmLZprc
	jYyZbNcJ2skgb4UHtXHOgPlJXhS1WYDMy3n/FpNyn5V6ahoyoLFiXer+dUVFGnI9sOWTuKvk8I7ow
	Chxkflbel9KeyUGarPRRxvH1QZesybL4Jdmo3mJGeb5vZJpJaJSRPjbPL1RBW4oWIHywPeKJs20OS
	6NYLNCISDgNSIjtscXlZ5iRnXTDBbk+Xl4D0+eUD/A4Q64rpnY0OETjdUtFupbYBtmx8LKOFjG7eg
	IP4rXssPcwZFgi5m45G9kHol6rwl7n6x+Nt7rg5ejYaj6Mnc0bmoH9kRt92sYabggwqCWYB2KYirz
	eTricz1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSGg-0000000FWFi-1JbB;
	Tue, 03 Mar 2026 16:06:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSGe-0000000FWEq-0ouE;
	Tue, 03 Mar 2026 16:06:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XBJwlrTdNJjmPV0S2dY1ySmJaA0aEJhhqGpkqw0Qvdg=; b=WXfdtJ+kZBZ4HJWzzvzSeki2v4
	9euh/EYvhRszvbC6+hf37iTcd1lf5imX01Hwavrq+94wdmuQhbkpAmhfclbJln1wEGcqPrXg7flzT
	rZ4PDb2laz9i/D46+JikQbm8YbMIATDgPOR97uzslCaZt4QlHDx3KwvSpfoZvbyXdoECCWk5ZOPG7
	gVwMBOUaGHVy1yYZFGaUSUax//Fm6EqmPKFBARoFQelTdmBx70bPVNI2d4gGoEmZkvEgSMvdFwe4O
	smfdGZiGpFd+0oM+EtHsexBxWW/iX5G4YLsCZ/HgFCrbMCO5+zOEpoxP4b+AGdc0nAkTBAAts7jbI
	Nyq24nHg==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSGb-00000002qMl-1509;
	Tue, 03 Mar 2026 16:06:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B41BF68BFE; Tue,  3 Mar 2026 17:06:34 +0100 (CET)
Date: Tue, 3 Mar 2026 17:06:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 20/25] xor: make xor.ko self-contained in lib/raid/
Message-ID: <20260303160634.GG7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-21-hch@lst.de> <20260228064249.GG65277@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228064249.GG65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_160637_387126_44A7A5D6 
X-CRM114-Status: GOOD (  20.93  )
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

On Fri, Feb 27, 2026 at 10:42:49PM -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 07:10:32AM -0800, Christoph Hellwig wrote:
> > diff --git a/arch/um/include/asm/xor.h b/lib/raid/xor/um/xor_arch.h
> > similarity index 61%
> > rename from arch/um/include/asm/xor.h
> > rename to lib/raid/xor/um/xor_arch.h
> > index c9ddedc19301..c75cd9caf792 100644
> > --- a/arch/um/include/asm/xor.h
> > +++ b/lib/raid/xor/um/xor_arch.h
> > @@ -1,7 +1,4 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -#ifndef _ASM_UM_XOR_H
> > -#define _ASM_UM_XOR_H
> > -
> >  #ifdef CONFIG_64BIT
> >  #undef CONFIG_X86_32
> >  #else
> >  #define CONFIG_X86_32 1
> >  #endif
> 
> Due to this change, the above code that sets CONFIG_X86_32 to the
> opposite of CONFIG_64BIT is no longer included in xor-sse.c, which uses
> CONFIG_X86_32.  So if the above code actually did anything, this change
> would have broken it for xor-sse.c.  However, based on
> arch/x86/um/Kconfig, CONFIG_X86_32 is always the opposite of
> CONFIG_64BIT, so the above code actually has no effect.  Does that sound
> right?

This whole thing looked weird to me.  I'll try to do a more extensive
cleanup pass on the um mess ahead of the rest of the series.


