Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FDB109E552
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 05:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xPd+Xwid+sFQehqOxG5aK9WXqz3DxjadA95L9h7hKac=; b=Tx7MwES8cPNuQfSu5f/xh9Smqu
	S3Uh3SyvbxLqXa4PDHiaZ9zV/BTM637Hu8Tt9AXa/vaDi28pN+8Ee7jSQCR8Ze4uOWKTyle8aYR42
	zD1f6snHsg1W1GED7dCRPXKQGSl7MhnsJLxkMtSJ8Fdyarj98cs9Tc52WmOq8cWWBxs3NuYJfX4qT
	Ktjo4GUy82rtW2b0TZV011KXO1iFBmtMFDs60kAN7kcS4+cD3hOXqvYdhIlpiL3eBTfcpzfXm7YAH
	QRlS+pxUuaZZmg+jq1Cg2sqSd48x5JA2AXrr0fCDy2a35z5q0z8/O1GWm/GNYl6TedM6JQIh/PE8r
	UpOGTUzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5d7M-00000004jSJ-1yve;
	Thu, 26 Mar 2026 05:18:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5d7J-00000004jQt-0rPP;
	Thu, 26 Mar 2026 05:18:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7351F68B05; Thu, 26 Mar 2026 06:18:37 +0100 (CET)
Date: Thu, 26 Mar 2026 06:18:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
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
	Li Nan <linan122@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: cleanup the RAID5 XOR library v3
Message-ID: <20260326051837.GA22847@lst.de>
References: <20260324062211.3216301-1-hch@lst.de> <20260325193954.GC2305@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325193954.GC2305@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_221849_395117_87A6AD10 
X-CRM114-Status: GOOD (  22.28  )
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

On Wed, Mar 25, 2026 at 12:39:54PM -0700, Eric Biggers wrote:
> This generally looks good, but yes, please check the comments from
> https://sashiko.dev/#/patchset/20260324062211.3216301-1-hch@lst.de, as
> Andrew mentioned.

Yes, I've looked into them and fixed the, the current version in the
git branch already has the changes.

> looks real as well, though I haven't tested it.  If preemption is indeed
> not the right thing to check, then I guess (following up from
> https://lore.kernel.org/linux-crypto/20260303195517.GC2846@sol/) it
> would need to be something like:
> 
>     WARN_ON_ONCE(!in_task() || irqs_disabled() || softirq_count() != 0);
> 
> Ugly, but we're running out of options.

So far I've just reverted back to the in_interrupted() check we had
before.  I can switch to the above, though.

> (This sort of thing is why the functions in lib/crypto/ and lib/crc/ are
> just supported in all contexts instead.  If FPU/vector/SIMD registers
> cannot be used in the current context, then a scalar fallback is used.)

We could do this fairly easily, but I'm not sure it is a good idea.
The callers of these routines are extremely limited, so we'd have to
add code for this which will then only be used by the new extensive
test code we'd have to add for it.


