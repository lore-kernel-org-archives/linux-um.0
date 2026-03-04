Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5C1EF8FF1
	for <linux-um@archiver.kernel.org>; Wed,  4 Mar 2026 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iW3zfO2CTrC6/poAO+d0nmHzr1OWHmvKQJevQ4s+9cU=; b=rD0aherR+9meNdcmRz8CYBH7um
	PVh0Pnl1HFwZCwkoFrCIvo/PZXatoJhxVayZ5xLIoPS3SQ9MDi8kdTMFBgJJGnVvSRx0SzBOne0yP
	gQ4jlpCxlQMK7eZQjlQ1ccSAdzlybDOrcAd4tsP0q+Mcwp6ErprN//ccsh12726TNNTAXsA9+N+LV
	Q4X0VF3c6AIeG7SMuYsc07DktU5iKgnW7LcD3/4dNPVDgrHHodZtdTXPolD9wW9ev43AfDyceZ/Q6
	rdgIpDzQ3iqrqLkC5egvlXNK7jW2EMpaNEeE4nPqIlxb2xsRMeBJZciiDfCnC8bXu4I2qFj4y3OTX
	4HIdsGVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnog-0000000HVqC-4BgB;
	Wed, 04 Mar 2026 15:07:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnoc-0000000HVpR-2D7T;
	Wed, 04 Mar 2026 15:07:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61CD968AFE; Wed,  4 Mar 2026 16:06:59 +0100 (CET)
Date: Wed, 4 Mar 2026 16:06:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20260304150659.GA23393@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-2-hch@lst.de> <20260227142455.GG1282955@noisy.programming.kicks-ass.net> <20260303160050.GB7021@lst.de> <20260303195517.GC2846@sol> <20260304150142.10892A0b-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304150142.10892A0b-hca@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_070710_722522_B455C64C 
X-CRM114-Status: GOOD (  19.45  )
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

On Wed, Mar 04, 2026 at 04:01:42PM +0100, Heiko Carstens wrote:
> > Because of that CPU feature check, I don't think
> > "WARN_ON_ONCE(!may_use_simd())" would actually be correct here.
> > 
> > How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
> > of the context restrictions correctly.  (Compared to in_task(), it
> > handles the cases where hardirqs or softirqs are disabled.)
> 
> I guess, this is not true, since there is at least one architecture which
> allows to run simd code in interrupt context (but which missed to implement
> may_use_simd()).

I'd rather have a strict upper limit that is generally applicable.
Currently there is no non-task user of this code, and while maybe doing
XOR recovery for tiny blocks from irq context would be nice, let's defer
that until we need it.  There is much bigger fish to fry in terms of
raid performance at the moment.

