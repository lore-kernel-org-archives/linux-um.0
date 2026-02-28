Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DF4FEE4C4
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 04:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a4/HdkUFGu6SFVOsDJPzYjExpCDKt+qABe3apagq8N4=; b=rfOx9S+RdOWHKsFHDeQeXYdZ17
	ep0Xd5NTcPWBh6oAFw2qAwIcaojj0nLoqmP7IFgWwGGcpBgycUeCs4mHQrMBSiFTTmaRTeZhHgKZT
	COpyDK6gAWnGbrMrJejuTUE+/zMKLR1u5Ucb49vjFa2YINJE7EchcLpvtdT0cs2Q0g+ea7Zmcq8ug
	W6Vo5JHw8Vmb64wHbQQtP2Vc3n0q1d35RU4xa5srwwR42m1TBwnhF7P0/3nrPvAjeC7QTHhJXsUIg
	3JK3Pqit2j7gqOY6MHwEFXl6GAQIYzD3sfOteZIrPi/yyWeREoqjBW2dFOpDMLU3NxP9yn5N4x0un
	MRniE/yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwC3B-00000009UHR-3giT;
	Sat, 28 Feb 2026 04:35:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwC38-00000009UGt-1Qrv;
	Sat, 28 Feb 2026 04:35:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7D89B43B42;
	Sat, 28 Feb 2026 04:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FD3C116D0;
	Sat, 28 Feb 2026 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253327;
	bh=7zmaVKtAh2Ji/dO9zQKMopZe2cxR3kulm8/sTdUvOcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvLMWT5QPfWf5fqwCu0b6jyf1JkY8VhTv+hzjbPZJIShl575Kc/hb2XB6K7qkymfN
	 qwBqh029UG4QDt1k4o+yWv6HUuKWpWsplNNhaICJZz2k0ORPmJLnhkHAyONmX7M+TQ
	 zDX6zjqvLirKpTtriXBUSdvtk9Yk8/30R2kYnR4XhUkO0qR3hMOqza11uJQ08QFz4S
	 oQboCK+Z7P0MYthrxKSIcy3roPsAHLbVtIrOmNmHcNMgysOz0VoIhFow1SEkkuFGuP
	 DaFupym5qTt9eY/XGsZgNFTL4RRcp5VoPtcdKHWNHmTzORlfM9TjONCOU+EFM4pkgz
	 p45HIHdqNKblg==
Date: Fri, 27 Feb 2026 20:35:23 -0800
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
Subject: Re: [PATCH 04/25] xor: move to lib/raid/
Message-ID: <20260228043523.GB65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_203530_540892_8805D601 
X-CRM114-Status: GOOD (  14.45  )
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

On Thu, Feb 26, 2026 at 07:10:16AM -0800, Christoph Hellwig wrote:
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 0f2fb9610647..5be57adcd454 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -138,6 +138,7 @@ config TRACE_MMIO_ACCESS
>  
>  source "lib/crc/Kconfig"
>  source "lib/crypto/Kconfig"
> +source "lib/raid/Kconfig"

This adds lib/raid/ alongside the existing lib/raid6/ directory.  Is
that the intended final state, or is the intent for the code in
lib/raid6/ to eventually be moved to a subdirectory of lib/raid/
(alongside the "xor" subdirectory)?

> diff --git a/lib/raid/Kconfig b/lib/raid/Kconfig
> new file mode 100644
> index 000000000000..4b720f3454a2
> --- /dev/null
> +++ b/lib/raid/Kconfig
> @@ -0,0 +1,3 @@
> +
> +config XOR_BLOCKS
> +	tristate
> diff --git a/lib/raid/Makefile b/lib/raid/Makefile
> new file mode 100644
> index 000000000000..382f2d1694bd
> --- /dev/null
> +++ b/lib/raid/Makefile
> @@ -0,0 +1,2 @@
> +
> +obj-y				+= xor/

Probably should add an SPDX-License-Identifier to these new files.

- Eric

