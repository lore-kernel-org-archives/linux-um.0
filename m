Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B265EDEBEB
	for <linux-um@archiver.kernel.org>; Tue,  3 Mar 2026 19:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1cg/0uRdxzNa6fXupnoKN1SuvGIxXIxO5vFL/AQ6K0=; b=ZxXkjHCHYsYgOIZJhDdwVBWGb4
	56L596M/Jay9PpYyRLWp/H233fyrckblqL/Ju/kHMxQ9b/5q8TLk238A8RTU1ssKek4O3iDEXRyCw
	agtKidvO6Lr5ps9qbNvREa/LO8dDwpHk5SHADckCrofsKcgu07lW0g4vTkFbBh8J1HbL5adVexYG/
	PxjiAqV29T9nGsSfc0xFVa/NkQNOECtV3zRoASW8Y+mWNE3+kV5+XWcatdmNGBsRkMnC4M3c0rTZ+
	ME0wre9tQ8E1Or0y2qnM4lhUnr5M9muwmsS8rKXYZVBIrI4hZUWo8l6X9er9/uS5l1lVUBrAr2qCP
	BwPsIahQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxVqt-0000000FrLM-2JIm;
	Tue, 03 Mar 2026 19:56:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxVqq-0000000FrKM-1TTZ;
	Tue, 03 Mar 2026 19:56:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A583F40684;
	Tue,  3 Mar 2026 19:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1644C116C6;
	Tue,  3 Mar 2026 19:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772567774;
	bh=9sr6A1ZQ/OAOM0MyaKuNScWB7UA08hne7lVI9ssYSPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHMra/+se8TmXPAvXWkLhgpf0kETRB4dEaJCtUtlUTftYpe0ReqfitRfwD4MGq4+T
	 WuzDe+k5qMfwF8Pvg7plbRdHjZuWKh+IB7lEOogeIHeGkKvwd2/EpZagMr99KeT7V+
	 XN7WYkTp/J6gkuhSVqd3D55QMpvT59XaPLLtFxjhlFBUF5SPdV1HoakLZQKIIo/fdH
	 BGibgd4432V2o3DyL8VfocxjZKarY5SdEW/Gzxyc6CkyylsV/unCa5mrJJyTo1wkxn
	 QMVCX29BeW41faad8f8MgUVR1waChaWC40npYyOs3agb3dJecKXchWeHWLYBSYXFrd
	 nwEHrCxoK1HSw==
Date: Tue, 3 Mar 2026 11:55:17 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 01/25] xor: assert that xor_blocks is not called from
 interrupt context
Message-ID: <20260303195517.GC2846@sol>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-2-hch@lst.de>
 <20260227142455.GG1282955@noisy.programming.kicks-ass.net>
 <20260303160050.GB7021@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303160050.GB7021@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_115616_435289_0CAC4101 
X-CRM114-Status: GOOD (  19.58  )
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

On Tue, Mar 03, 2026 at 05:00:50PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 27, 2026 at 03:24:55PM +0100, Peter Zijlstra wrote:
> > >  	unsigned long *p1, *p2, *p3, *p4;
> > >  
> > > +	WARN_ON_ONCE(in_interrupt());
> > 
> > Your changelog makes it sound like you want:
> > 
> > 	WARN_ON_ONCE(!in_task());
> > 
> > But perhaps something like so:
> > 
> > 	lockdep_assert_preempt_enabled();
> > 
> > Would do? That ensures we are in preemptible context, which is much the
> > same. That also ensures the cost of this assertion is only paid on debug
> > kernels.
> 
> No idea honestly.  The kernel FPU/vector helpers generally don't work
> from irq context, and I want to assert that.  Happy to do whatever
> version works best for that.

may_use_simd() is the "generic" way to check "can the FPU/vector/SIMD
registers be used".  However, what it does varies by architecture, and
it's kind of a questionable abstraction in the first place.  It's used
mostly by architecture-specific code.

If you union together the context restrictions from all the
architectures, I think you get: "For may_use_simd() to be guaranteed not
to return false due to the context, the caller needs to be running in
task context without hardirqs or softirqs disabled."

However, some architectures also incorporate a CPU feature check in
may_use_simd() as well, which makes it return false if some
CPU-dependent SIMD feature is not supported.

Because of that CPU feature check, I don't think
"WARN_ON_ONCE(!may_use_simd())" would actually be correct here.

How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
of the context restrictions correctly.  (Compared to in_task(), it
handles the cases where hardirqs or softirqs are disabled.)

Yes, it could be lockdep_assert_preemption_enabled(), but I'm not sure
"ensures the cost of this assertion is only paid on debug kernels" is
worth the cost of hiding this on production kernels.  The consequences
of using FPU/vector/SIMD registers when they can't be are very bad: some
random task's registers get corrupted.

- Eric

