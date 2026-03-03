Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04D3EDA68D
	for <linux-um@archiver.kernel.org>; Tue,  3 Mar 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZwhrmuRPeFiAL7U9ekfKCBSdNddOHmeVRgOtJ35nGY=; b=5D8GcTNdrUcNXz2pRhkxKnd/U3
	iswZvyPAdhvmLCzQz1c9WTAiotDAvwvJMKW7yi0garQo3/MPSeQi5fHeKASx4kxGVRw8uOhP0PNNG
	5g5cZFa0tq05yfd0X3yv2K6caxEmvnhTaIJMPONhvSIW55E4lrsoeXx57etJNlhxxYubHYZ4Vomu1
	uIR1pn7DAyS1db9N07FY/V2Vhe9pgZt2Nvm30jpiIbpk8luBWGMb4Nd8xOnPqvMcHUf16dPLx1JwV
	u9e3exm7ltFmUJ5p1LRS5jImX9D0BdkD40caTTUcwDvpxXJrOUwztqWdJ0N3fJaZurfdNe16e+6rV
	S+sEDfWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSJu-0000000FWsd-2Jqz;
	Tue, 03 Mar 2026 16:10:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSJr-0000000FWrN-1WvC;
	Tue, 03 Mar 2026 16:10:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BC1768C4E; Tue,  3 Mar 2026 17:09:55 +0100 (CET)
Date: Tue, 3 Mar 2026 17:09:55 +0100
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
Subject: Re: [PATCH 24/25] xor: pass the entire operation to the low-level
 ops
Message-ID: <20260303160955.GJ7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-25-hch@lst.de> <20260228065810.GJ65277@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228065810.GJ65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_080959_552504_0A80F872 
X-CRM114-Status: GOOD (  15.86  )
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

On Fri, Feb 27, 2026 at 10:58:10PM -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 07:10:36AM -0800, Christoph Hellwig wrote:
> > +#define __DO_XOR_BLOCKS(_name, _handle1, _handle2, _handle3, _handle4)	\
> > +void								\
> > +xor_gen_##_name(void *dest, void **srcs, unsigned int src_cnt,		\
> > +		unsigned int bytes)					\
> > +{									\
> > +	unsigned int src_off = 0;					\
> > +									\
> > +	while (src_cnt > 0) {						\
> > +		unsigned int this_cnt = min(src_cnt, 4);		\
> > +		unsigned long *p1 = (unsigned long *)srcs[src_off];	\
> > +		unsigned long *p2 = (unsigned long *)srcs[src_off + 1];	\
> > +		unsigned long *p3 = (unsigned long *)srcs[src_off + 2];	\
> > +		unsigned long *p4 = (unsigned long *)srcs[src_off + 3];	\
> 
> This reads out of bounds if src_cnt isn't a multiple of 4.

Assuming the compiler doesn't do the obvious optimization and
drop it, but yes, should be easy enough to avoid this.


