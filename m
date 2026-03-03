Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15796EDA693
	for <linux-um@archiver.kernel.org>; Tue,  3 Mar 2026 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oN/fEll4fZvv2uEfMJ3TecbdzRhyRWVxsV4r7G2PpRY=; b=0v+oZIVxsrbE3geg7qy0KOyfPc
	TUzgr+AQf25GLg6DlOXjpzQ4WadOffcC/yGYbVXGagze7BgdcnTe+r2Fs+wXjrYTzcZu6R194fXMS
	KWDHjlj5/K5XgLvOy4zqC27+flY1TZ/2cz6aNp1sjzayObwqShM+JBPOL84UiNjyUEY/0XB6t2XWa
	HRUcPwtvGAJbOKVb4mWEo82BRmSUfqijwUy0bC3UtF9yijh/8taPtO2XUkPsvT8JVmDGRJyV2L1zL
	J6bLMxtqvFRszRDdEZian5mT/J9+x40G9G+rjl8dKJyFyJJlIsVx4grvJzehbPyLHkSHDwN76yd+6
	IeeHBoBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSLi-0000000FXCe-17Ex;
	Tue, 03 Mar 2026 16:11:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSLf-0000000FXBy-1URB;
	Tue, 03 Mar 2026 16:11:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4C7E68BEB; Tue,  3 Mar 2026 17:11:45 +0100 (CET)
Date: Tue, 3 Mar 2026 17:11:45 +0100
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
Subject: Re: cleanup the RAID5 XOR library
Message-ID: <20260303161145.GK7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260228073553.GL65277@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228073553.GL65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_081151_542429_FC2DF970 
X-CRM114-Status: GOOD (  16.88  )
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

On Fri, Feb 27, 2026 at 11:35:53PM -0800, Eric Biggers wrote:
> >     https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements
> 
> Overall this looks great.  xor_gen() really needs a KUnit test, though.
> Without that, how was this tested?

fio data integrity testing on degraded raid.  But yes, a unit test
would be nice.

> Later we should remove some of the obsolete implementations, such as the
> alpha or x86 MMX ones.  Those platforms have no optimized code in
> lib/crc/ or lib/crypto/, and I doubt anyone cares.

I'd rather leave that to the architecture maintainers, but overall I
ahree.

> Also, I notice that no one has optimized this for the latest x86_64 CPUs
> by using the vpternlogd instruction to do 3-input XORs.  That would be
> another good future project.

Yes, as would rewriting the routines to deal with more than 4 + 1 stripes
as that is a really narrow raid these days.


