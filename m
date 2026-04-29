Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2C6CCFA13
	for <linux-um@archiver.kernel.org>; Wed, 29 Apr 2026 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=goNuGKh90jfzrTtcM8AQu4/qcccrIqr5mhqWXnjaDnA=; b=wDIhnr747aNsRTlLYAYQo5itDw
	axVMgXzLQYkccTU9aDkDq9UphzU/6gjngg7KxObcaNiDudi8DmuovafcWB8tEbYkXsnrteTmtF5Xn
	1XSuTMsW2AYQz0O5BfUv4BksG820/OFww49qLpEjEsxNxQGrlZH97LJGxEA8W7Csu9lvJLv56vDLV
	uD2+RxYSxwJyyRpnnTPR5nNED/UcUz3un8GCdnyMNq9xCbaBmBhFKaMYsVBnWuqQLQNryVhYQspm3
	ZYph8592qPWWLIaiS9gHFHmO3YT+j2aWdvB3WQnyVUvrhcnOpgC0C08lHFNBPzkMfpGhqLO/BaI+3
	FFxiMaXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI344-00000003WG6-3XlG;
	Wed, 29 Apr 2026 11:26:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI340-00000003WFQ-3rv1;
	Wed, 29 Apr 2026 11:26:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CA92D403EB;
	Wed, 29 Apr 2026 11:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158D1C19425;
	Wed, 29 Apr 2026 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777462002;
	bh=HgV0q/+gZ9n2giWTxhUD6P3yQ6wEmY66ZwCWQHhgQ2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejvHWE1zJ0tb1KwQu/gVCMj0KcNhlMqCOjLI4kQmWC01EPIO4HFDTFQg5PpNyMx2F
	 7OMWgwbyfp16yd5ZKGLwfDDMuBlWK8CK9qcSIqUHZRxyhnWE4iAN+OK+xmr5WBtr4T
	 BgqmCB7r/rsFvwFu/mT2z67QkDE/mDzOf7GDi68KHsQjYM3r7svy7TXqJDW5kWsfNa
	 xYHmkznhflijvwvOUJkH6AcM42ZHWo8kZp7k26fwbFC82N/jHC8/F/rL8GlM8z6Ksh
	 UMOZ5KVH94exo80oAIrmoHKOK/k/qke5mU8V2uOXUW3Mlxuf7JynBO/Edq8wMcfI5M
	 twwrBSWDcoLLw==
Date: Wed, 29 Apr 2026 12:26:30 +0100
From: Will Deacon <will@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
	catalin.marinas@arm.com
Subject: Re: [RFC PATCH v1 8/9] arm64: Add unsafe_copy_from_user()
Message-ID: <afHq5vyNUJzxVwDV@willie-the-truck>
References: <cover.1777306795.git.chleroy@kernel.org>
 <5b09e58a84c9edcfe5724db5cd57e45d96a96bfa.1777306795.git.chleroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b09e58a84c9edcfe5724db5cd57e45d96a96bfa.1777306795.git.chleroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_042644_999249_0BBC5DAA 
X-CRM114-Status: UNSURE (   9.91  )
X-CRM114-Notice: Please train this message.
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

[+Catalin]

On Mon, Apr 27, 2026 at 07:13:49PM +0200, Christophe Leroy (CS GROUP) wrote:
> At the time being, x86 and arm64 are missing unsafe_copy_from_user().
> 
> Add it.
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>  arch/arm64/include/asm/uaccess.h | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)

Why?

And please cc the arm64 maintainers on arm64 patches next time. You've
managed to cc most of the world apart from us.

Will

