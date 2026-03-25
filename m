Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA8C109C05C
	for <linux-um@archiver.kernel.org>; Wed, 25 Mar 2026 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z3awqpGH+qDQnmpMIXhzeGdXvp+XuKXejLNw+4PmwpI=; b=2zoWToEGdtyrQVMlObbUQccWh6
	+4PXHWSidzqH6j8tGNHB3KjDtPc0SO9bSDSzJka9fc6AH8+F+yfEi8DAo8VoCHJ9jeKqb3f+Fg+43
	9GJccSxMHdgCXRbpPtXWQt+6uZ6tO6oWgkYVYeCcYomXDFP9gnXkEqjBjum5wLh7OXWWs6z0zi1s4
	GCY085qPSk05WgcBeXKFj6hw057E/FA34JwzJFZOnbKbXZ//LTV2ng17axXiBeIj42phjd37JslzA
	gXB5Y4p9Wx3AD2poZh7chzd71UA9zCIGL7I7rKmiEPcE5rXseFkLUa1084q+gLwrIkD0zp8udDx6c
	930JMHHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5U5J-00000004AY9-1Pmw;
	Wed, 25 Mar 2026 19:40:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5U5H-00000004AXh-0vzj;
	Wed, 25 Mar 2026 19:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z3awqpGH+qDQnmpMIXhzeGdXvp+XuKXejLNw+4PmwpI=; b=FndVcTXMMo9yqoo+jEqIDxqmf7
	XSAV880/ydz/Q4g3dKlzgvdiDIRnrPSADoXAlRoTL68wDu304TdwwVFDn0/6Dpmm36fCucjirQfNk
	gISliIDFE/Jy4WRsqYTC+PMfk9HpVz/pD4P7h9wA/9yV8vccPwNeiFD/qiw67JtP9T6JP+5Azk7Io
	rXUi+4A9dCM60410h4DBfM19MtbhgIhGVFifhVJZ728pgyBhHzIxdskOFgqsZUjGR9GuGOGYZ9VwK
	R+V5etTnnjQeN0dpZjJVqsNDb7hlmFRbYvwIeeI72+eYsSW2IcWFL8XJoJGo5qX1aB+Mu2NDqERzC
	Yk+7/siQ==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5U5D-00000006xOj-3LdZ;
	Wed, 25 Mar 2026 19:40:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 97FD843B76;
	Wed, 25 Mar 2026 19:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86172C4CEF7;
	Wed, 25 Mar 2026 19:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774467599;
	bh=vgzmS++XGgEKBkb/yAjVP8Sp4H+rVjAZlzJWbYtNQ5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DygY0E8wyP/P9Q9kZFKoknR4RxtR6GMi9PjYKJh3Sbc2gqAytguh48eGOTnsx3c56
	 Q2YVatKuDK+N4nU8v6AxKOfcBzhChhEI3Df1zCL0wcOyAKNQgEB7oAOxflILmausqP
	 WOCeoLY2lmAchg2c7NGHGU4qpdmOxFI+jpbH1K0Ei46HKczGrbgGRBm1sI8nru20Vm
	 WRYSdUfozTetH29mYvuSFOROlG1SXAHZGao0e1tIcm/PcakbXOz5jtLmbmhcaQDLw8
	 UHpO2j30RaryLjmXyqJNpFRWy5VPKjdg008B9pxWETSOv3xeW2U6bVqeyivRW/5e7y
	 efVryfxsae7fQ==
Date: Wed, 25 Mar 2026 12:39:54 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20260325193954.GC2305@quark>
References: <20260324062211.3216301-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324062211.3216301-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_194004_191037_1A4A229E 
X-CRM114-Status: GOOD (  23.09  )
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

On Tue, Mar 24, 2026 at 07:21:36AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> the XOR library used for the RAID5 parity is a bit of a mess right now.
> The main file sits in crypto/ despite not being cryptography and not
> using the crypto API, with the generic implementations sitting in
> include/asm-generic and the arch implementations sitting in an asm/
> header in theory.  The latter doesn't work for many cases, so
> architectures often build the code directly into the core kernel, or
> create another module for the architecture code.
> 
> Changes this to a single module in lib/ that also contains the
> architecture optimizations, similar to the library work Eric Biggers
> has done for the CRC and crypto libraries later.  After that it changes
> to better calling conventions that allow for smarter architecture
> implementations (although none is contained here yet), and uses
> static_call to avoid indirection function call overhead.
> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/misc.git xor-improvements
> 
> Gitweb:
> 
>     https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements

This generally looks good, but yes, please check the comments from
https://sashiko.dev/#/patchset/20260324062211.3216301-1-hch@lst.de, as
Andrew mentioned.

The bug where the test generates length 0 is definitely real.  I
verified it causes the test to crash on some platforms.

raid_run_ops() calling xor_gen() (indirectly) with preemption disabled
looks real as well, though I haven't tested it.  If preemption is indeed
not the right thing to check, then I guess (following up from
https://lore.kernel.org/linux-crypto/20260303195517.GC2846@sol/) it
would need to be something like:

    WARN_ON_ONCE(!in_task() || irqs_disabled() || softirq_count() != 0);

Ugly, but we're running out of options.

(This sort of thing is why the functions in lib/crypto/ and lib/crc/ are
just supported in all contexts instead.  If FPU/vector/SIMD registers
cannot be used in the current context, then a scalar fallback is used.)

- Eric

