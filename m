Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973D110ED655
	for <linux-um@archiver.kernel.org>; Fri, 27 Mar 2026 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CwDDZ0xuA60nrVV8S4QknF97+2IVtSx22G/TlvzHwhU=; b=eqy/kW+F+bQr4yVLh/cDB1uqA5
	Axt0que3MQlfQ4qZwIn1H3SkZWupAz6YAdCjxCZtot96leMpxBviSbUnlVE2ZSNp7nzLKszpDj4qK
	17ZZsh89KjYc6PkcUSsC8x1vK7tzhcMAcrBsQgIrmwP6otlKhYN4arNI7ZyoT2Nxf7rX7FRoHShjk
	g+9P+ptjCpDoaDtUdK59RD+Vc+zaRTfw4hVA4W4yV4lZ1utR31tg76xSGwSja90JQvqWCK1Cb9RBa
	J+oDkZ6/l2AHesh27f5Xez3aoTDeI7kPLU/OWT/HeStb6oFnmwAN38YZXURlZva1v35irnwAFzAPz
	ZVnM2ARA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w64Zs-00000007ANl-0qV5;
	Fri, 27 Mar 2026 10:38:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w64Zp-00000007AMU-077J;
	Fri, 27 Mar 2026 10:38:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 94D18443E2;
	Fri, 27 Mar 2026 10:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB526C2BC86;
	Fri, 27 Mar 2026 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774607883;
	bh=fO1n3N31Hq1DYtmMY0Uiqq1O7a3QRkcXqeW2ikYyR7Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KkG1yQlrWgKQ/NYWsbP/4gMcEzHO4FFs5XVqFPvgiTMUP5gZmxs+POHFYFovkQvMt
	 ulKEWCRxR0YDfHRt8rPQYguRQVuK+yV9E3+XJKAkiERR5OUi0MUsUzODRkVzLSK8wl
	 mgPgh6M/NwumgLGqAMTPdhbmpLX3dcSuTyZu0udCNjhz+Y8Frz/CN90C/9+aWLhebK
	 MDdGRpUGBTGS/T396mdT0nVUuXycuaIA6edQ5WansTtZpHThVi7voJ8vEHR0R3KtU8
	 kcqdtl17wUYyZItRMgb/WNrffJmfXB1VPcS0kRwnk+IxoDUY0asnuCh4K+PsSW9BgX
	 lyEpYqymiG2tA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id A301CF4007B;
	Fri, 27 Mar 2026 06:38:00 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Mar 2026 06:38:00 -0400
X-ME-Sender: <xms:CF7GabpHu3v_u6fV8V_mdHz6sop4veHr9gldlSZav8Jy0ecQbG2kZg>
    <xme:CF7GaQd6NTiStA_nuMJRyzxc--HbkJ0S1s7E49JLyq7o3XAbvBcTAa2AznFEPZAEY
    OUf40tcUbSe7ZiR4cCBxK1pUd7gZu4raTVHGizBZPvHpJbXfFxNKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedttdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeetgedvtddttdeuffegvdefgffgteeiueejuefhjefhvdekkeelkeduteej
    tdetheenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeelqdeffedvudeigeduhedqrghrug
    gspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrhgurdgtohhmpdhnsggprhgtphht
    thhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnke
    druggvpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdp
    rhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoh
    eprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegrnhhtohhnrdhivhgrnhhovhes
    tggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurg
    gssggvlhhtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpth
    htohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghu
X-ME-Proxy: <xmx:CF7Gaf8IJi0YURc1_Z-7XWWce32KTLQg0MgtSGjpDXebCVP8kjF1fg>
    <xmx:CF7GaVb8rMguERdYH-uRjKmkbehDdibFJGzRPHkCAhl6T7z96o-pOw>
    <xmx:CF7GaT-UHcu4LVpMMMFSjx_B0drCWxBBuaJzaeFjOkwZfnBqfgZ5rQ>
    <xmx:CF7GafjVFP_InYrNfGUVD88lIgjoTxwR9RfXopF528_clTsktrNsYQ>
    <xmx:CF7GaTly7jF5GPkZNeohixA93ZcJ20A7YlVUFe0lo5TI87Fbt8LPFZOZ>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D4BB700065; Fri, 27 Mar 2026 06:38:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AUjF8VgfYQMk
Date: Fri, 27 Mar 2026 11:37:39 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Magnus Lindholm" <linmag7@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Dan Williams" <dan.j.williams@intel.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Song Liu" <song@kernel.org>, "Yu Kuai" <yukuai@fnnas.com>,
 "Li Nan" <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Message-Id: <b5edd377-423f-4837-a622-ad78654811c4@app.fastmail.com>
In-Reply-To: <20260327061704.3707577-1-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
Subject: Re: cleanup the RAID5 XOR library v4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_033805_111845_99DACD2F 
X-CRM114-Status: GOOD (  26.20  )
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



On Fri, 27 Mar 2026, at 07:16, Christoph Hellwig wrote:
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
>     
> https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements
>
> Changes since v3:
>  - switch away from lockdep_assert_preemption_enabled() again
>  - fix a @ reference in a kerneldoc comment.
>  - build the arm4regs implementation also without kernel-mode neon
>    support
>  - fix a pre-existing issue about mismatched attributes on arm64's
>    xor_block_inner_neon
>  - reject 0-sized xor request and adjust the kunit test case to not
>    generate them
>
> Changes since v2:
>  - drop use of CONFIG_KERNEL_MODE_NEON for arm64
>  - drop the new __limit_random_u32_below for the unit test
>  - require 64-bit alignment because sparc64 requires it
>  - use DEFINE_STATIC_CALL_NULL to avoid exposing a specific xor_gen
>    routine
>  - keep CONFIG_XOR_BLOCKS_ARCH self-contained in lib/raid/
>  - don't select library option from kunit test and add a .kunitconfig
>    instead
>  - fix the module description for the kunit test
>  - add a case where buffers are at the end of the allocation in the kunit test
>  - use separate src/dst alignment in the kunit test
>  - fix and improve the kunit assert message
>
> Changes since v1:
>  - use lockdep_assert_preemption_enabled()
>  - improve the commit message for the initial um xor.h cleanup
>  - further clean up the um arch specific header
>  - add SPDX identifier to the new build system files
>  - use bool for xor_forced
>  - fix an incorrect printk level conversion from warn to info
>  - include xor_impl.h in xor-neon.c
>  - remove unused exports for riscv
>  - simply move the sparc code instead of splititng it
>  - simplify the makefile for the x86-specific implementations
>  - remove stray references to xor_blocks in crypto/async_tx
>  - rework __DO_XOR_BLOCKS to avoid (theoretical) out of bounds references
>  - improve the kerneldoc API documentration for xor_gen()
>  - spell the name of the srcs argument to xor_gen correctly in xor.h
>  - add a kunit test, and a new random helper for it.
>

For the series,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

As discussed, arm64 and ARM can share the NEON intrinsics implementation, which would allow for a bit of cleanup as well. I'll follow up with some patches based on this series.


