Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561DFFEFB56
	for <linux-um@archiver.kernel.org>; Fri, 27 Feb 2026 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lOp11MEHkYYwHRuUi0PZxSk1JN5+nTDJOLnSpDaUbDc=; b=TD11YSxMa6+eU3QKrdDa46PCEV
	/yZlZ3Dbuoar62XUIFoCM73Z18qz/6e2RBLexwQqiP7YQ7f+FueWetrIJ+vU4lRcehaEUnjNpd6i6
	TiHF8WCPVrimC2PmB1vY1Au/Jiz0YEDJUBwxqitIfjR1F2sr7KOw+GcYhiukD9cwHe5gtsHbt02bj
	9E5ODFPm8SasZUfvAhsiuhwm6xKrz24ohf5PwDrBnn8WEYa/qWO08YXSu1qqI0TcbKDalp/lu1oFb
	48OB7TTFwF/IVyziGRSVCSDdUOzbpptQoiE5utJX7I1OgGEO9YsFlWPBUKlW9UbAd94mCXe0tN6fG
	Reb6KHGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyrG-00000008V20-0JJo;
	Fri, 27 Feb 2026 14:30:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyrE-00000008V1j-3MoV;
	Fri, 27 Feb 2026 14:30:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lOp11MEHkYYwHRuUi0PZxSk1JN5+nTDJOLnSpDaUbDc=; b=Z9TK/udXiurPXiytUakXbFeev1
	ri7v9BFFO7R7ZiJvpbTW1JFNZRneKl3isIJyG3zHlkz9s2XQmusrQ/zacC5tOadz4Z7qmOWC49end
	3fVssHWiU1uZPXJxiiQFriaeu9YgtBdmdglQ2CtYVshTHvu5aWjnfh1f3CqeCm2LMKGKqofhFMRq5
	2FTQrOlmRLWH57X+/mT4zC19PNT7lNgxKvCQLn4m60NIZInXyfVhYVB3n68h6H+ZGw2r9VS0iGiNq
	QnT1zFqHAqIdiC0LM2DhVATtSnPcGUsNzzjMV7n5w3njjHXBfMs/S6eMK73CqMCrr/PUyh+1FLh1J
	kCLUtTiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyrB-00000004hgm-0psV;
	Fri, 27 Feb 2026 14:30:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B3685300CDE; Fri, 27 Feb 2026 15:30:16 +0100 (CET)
Date: Fri, 27 Feb 2026 15:30:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH 18/25] x86: move the XOR code to lib/raid/
Message-ID: <20260227143016.GH1282955@noisy.programming.kicks-ass.net>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-19-hch@lst.de>
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

On Thu, Feb 26, 2026 at 07:10:30AM -0800, Christoph Hellwig wrote:
> Move the optimized XOR code out of line into lib/raid.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/xor.h                    | 518 ++----------------
>  arch/x86/include/asm/xor_64.h                 |  32 --
>  lib/raid/xor/Makefile                         |   8 +
>  .../xor_avx.h => lib/raid/xor/x86/xor-avx.c   |  14 +-
>  .../xor_32.h => lib/raid/xor/x86/xor-mmx.c    |  60 +-
>  lib/raid/xor/x86/xor-sse.c                    | 476 ++++++++++++++++

I gotta ask, why lib/raid/xor/$arch/ instead of something like
arch/$arch/lib/xor ?


