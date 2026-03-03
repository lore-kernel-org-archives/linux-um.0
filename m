Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605A7EDA68D
	for <linux-um@archiver.kernel.org>; Tue,  3 Mar 2026 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ERL2crkSWjiWFfCd5r7i8dDIcE1qMmW2T7rRhLnWeUk=; b=wHHUhzT6tMzSnhnCIQyJZTqTNM
	wZTojtFdV9CMn/G+o9zT9tV49mTlbsRU1y1d9V7xSFqsyXrnezPjT3fa0JA3W8ujGupG5kzyeYzl0
	8ODjhtMh2sPV8K1out3+ZnaQ3PXCBzb2sQMVw0zdfIchulB9ZzHwPBNP3amL9SiFRLWT3mq8rboQN
	t2dhH+0oCMg/O3+4Edzp+EJ97M4OlD267lTM3gOa5Xw4XmSOWfFGGx86lF+wlF2cZIYzZA4tZqj40
	kkfZfK5emicBrFDbD+K39Vzoqf7WKbXcExaTyNMTCpZI7m/wD1XiiSVpTUUGvraehEyjG7AAgvKd9
	4i95w/vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSEg-0000000FVpo-3VgG;
	Tue, 03 Mar 2026 16:04:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSEa-0000000FVoB-2C5i;
	Tue, 03 Mar 2026 16:04:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F91868BEB; Tue,  3 Mar 2026 17:04:29 +0100 (CET)
Date: Tue, 3 Mar 2026 17:04:28 +0100
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
Subject: Re: [PATCH 16/25] sparc: move the XOR code to lib/raid/
Message-ID: <20260303160428.GE7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-17-hch@lst.de> <20260228054716.GF65277@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228054716.GF65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_080432_859547_52968550 
X-CRM114-Status: GOOD (  22.49  )
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

On Fri, Feb 27, 2026 at 09:47:16PM -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 07:10:28AM -0800, Christoph Hellwig wrote:
> > diff --git a/arch/sparc/lib/xor.S b/lib/raid/xor/sparc/xor-niagara.S
> > similarity index 53%
> > rename from arch/sparc/lib/xor.S
> > rename to lib/raid/xor/sparc/xor-niagara.S
> > index 35461e3b2a9b..f8749a212eb3 100644
> > --- a/arch/sparc/lib/xor.S
> > +++ b/lib/raid/xor/sparc/xor-niagara.S
> > @@ -1,11 +1,8 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  /*
> > - * arch/sparc64/lib/xor.S
> > - *
> >   * High speed xor_block operation for RAID4/5 utilizing the
> > - * UltraSparc Visual Instruction Set and Niagara store-init/twin-load.
> > + * Niagara store-init/twin-load.
> >   *
> > - * Copyright (C) 1997, 1999 Jakub Jelinek (jj@ultra.linux.cz)
> >   * Copyright (C) 2006 David S. Miller <davem@davemloft.net>
> >   */
> >  
> > @@ -16,343 +13,6 @@
> >  #include <asm/dcu.h>
> >  #include <asm/spitfire.h>
> >  
> 
> <linux/export.h> can be removed from the two assembly files, since all
> the invocations of EXPORT_SYMBOL() in them were removed.
> 
> Also, xor-niagara.S ended up without a .text directive at the beginning.
> Probably it was unnecessary anyway.  However, this seems unintentional,
> given that xor-vis.S still has it.

I'll probably undo the split and just do the mechanical move for the
next version.  This was a bit too much change even if a split would be
my preferred outcome.


