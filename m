Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24AFFEE4C6
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 07:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bLTTwglhjt/rMyRmD7N1uMA/6y81Yd3OD4P95BY8oCY=; b=EYPt3eOeSyUd7TSCyObfhWFCcm
	rokyizHMnu+Yn/1acybc9SMspYGfkq3DGIUdYynnMomL1goHoY5d4OWmXK7rT4nXmTVzUsqQPOKLN
	i6ugj9jceX0BQ4yKCLMZBicBOXBjG1FpgoVDhicWt9MdTLwtV6LHUf7C4Q/wOcFjOXz2Bd67bQHxt
	tCpTr8DUMZv0jww8yMna0cQbxhiS1y2djhvUgis0a2JB0bx0UaiLXKZQV1nyYxmH6llL0LFpCIm1a
	E6t5EKgVcB/vuhIKV3KBaDkM/LwmvqtKPbrFULoTLGdyILEioVeRjLccV4ENVdCs51SBxK49LGj8i
	crv+CuQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwErp-00000009cVX-0vfF;
	Sat, 28 Feb 2026 07:36:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwErm-00000009cVH-2rMF;
	Sat, 28 Feb 2026 07:35:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3203760122;
	Sat, 28 Feb 2026 07:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7026C116D0;
	Sat, 28 Feb 2026 07:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772264156;
	bh=6sJNyE+VY1nO/tYyDnefgTdhbr4qcMLaxVtizhQQLOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9tdtdMWAI5Ijh2x1iw7nM2tuOn7VcN+8js+7SLSFQBQ9vU2vt9oqu+EgowziSK73
	 sAzO21bZJQxKxmtHlu0vSUH2tGUcQRgjFGbZX7mbQPKN8WjwpFmWL8+xDtI3qS0EtF
	 4Jfc+10mCY+RphkrG2fcHyK/TMz2wuYQYlWWVT80/0ZLPVgACgd9amxPCn3FPf0AgL
	 JgqFFYCABzbxFrg5KHqTTW/MBNJ7iUh+0uZMyEIV2cew4CSOzs95au6LqecDztGc2s
	 U0mqa9zSxlhCMSe8/lU1BD692HSjIX3cPWlCgttoWYJBTO4L+PB6fHsLYOLKccSpod
	 azry3uoyDBKgg==
Date: Fri, 27 Feb 2026 23:35:53 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20260228073553.GL65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-1-hch@lst.de>
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

On Thu, Feb 26, 2026 at 07:10:12AM -0800, Christoph Hellwig wrote:
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

Overall this looks great.  xor_gen() really needs a KUnit test, though.
Without that, how was this tested?

Later we should remove some of the obsolete implementations, such as the
alpha or x86 MMX ones.  Those platforms have no optimized code in
lib/crc/ or lib/crypto/, and I doubt anyone cares.  But that should be a
separate series later: porting them over unchanged is the right call for
now so that this series doesn't get blocked on debates about removals...

Also, I notice that no one has optimized this for the latest x86_64 CPUs
by using the vpternlogd instruction to do 3-input XORs.  That would be
another good future project.

- Eric

