Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5866FEE4CB
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 06:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6IUKgULF8ycn4aiMjxbWgi7kwhcuo5AKCMo5sVjVXSI=; b=CjXDak0cX0/30tVWPfHofcU1hE
	0GoTxCA3XklQhTMeDB1VvHx5oAIxDx/GitcJ8q1xnAJpF5Cj5bJss/VsOYilA2PCqRZAn/5y/apFs
	Vr+U4L3k8vTF3DeSuk56Hpa4Ad4wAvFqrgNkUy0YyEJx5ey3JkIpHXFN3xSvWfpXdncr3T8RNhXSV
	Gq7eIFYKFqAhHumhL+kpUbT3XyLoYp8DUBK4gOMQhDfGkDFVy++HAOf9VNwMrfetChHreclkFVdZt
	BdpwixpEY0V1oMQALtlpNigLvZlJ/3pGTWcmDkCV4xDk36gm9lrNxJya8Na2N6jFbE1gy6jL5JmKb
	3JF6fTgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwE2T-00000009Z39-2m3i;
	Sat, 28 Feb 2026 06:42:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwE2Q-00000009Z2b-1j6Q;
	Sat, 28 Feb 2026 06:42:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 36ED940A5D;
	Sat, 28 Feb 2026 06:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FCCC116D0;
	Sat, 28 Feb 2026 06:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772260973;
	bh=RjXh+3ODcjpkGCclxlZLerhUTxAgrS3+Qw6tdSUsizg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YClOM9Wk3/7+pE7QyV7s9mlYuDllppl2YGLrTn0xkJ5pU3h4NtzzqxpXAgzhRI9N2
	 JuGJGprSvbiCiYCR4+DPFVLVUesA+9zY/ql1wKLu6GOJbDRJOE72dBApORguyRvSk0
	 Ip+z80iLf2XB3ZIQqPYK3ZEA4iixYi0/FOhgYq24wKd6cZqPgSNMaeZpzPpmIg/H3w
	 0n7sJMgccYUbEkKSe7BVVGr7K1ToaaAdi9JBbH+YWUnyRyLa4C5j5ZLWu0XZjJO8MA
	 f7GJPwidtEPGlIQhpocckRINXMDZxErl0fKAfQbViWFT5IVTuMqtgP4lHaU8x4cpN/
	 +BKrl6+TlJfNA==
Date: Fri, 27 Feb 2026 22:42:49 -0800
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
Subject: Re: [PATCH 20/25] xor: make xor.ko self-contained in lib/raid/
Message-ID: <20260228064249.GG65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-21-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-21-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_224254_491369_D99188B1 
X-CRM114-Status: GOOD (  13.17  )
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

On Thu, Feb 26, 2026 at 07:10:32AM -0800, Christoph Hellwig wrote:
> diff --git a/arch/um/include/asm/xor.h b/lib/raid/xor/um/xor_arch.h
> similarity index 61%
> rename from arch/um/include/asm/xor.h
> rename to lib/raid/xor/um/xor_arch.h
> index c9ddedc19301..c75cd9caf792 100644
> --- a/arch/um/include/asm/xor.h
> +++ b/lib/raid/xor/um/xor_arch.h
> @@ -1,7 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_UM_XOR_H
> -#define _ASM_UM_XOR_H
> -
>  #ifdef CONFIG_64BIT
>  #undef CONFIG_X86_32
>  #else
>  #define CONFIG_X86_32 1
>  #endif

Due to this change, the above code that sets CONFIG_X86_32 to the
opposite of CONFIG_64BIT is no longer included in xor-sse.c, which uses
CONFIG_X86_32.  So if the above code actually did anything, this change
would have broken it for xor-sse.c.  However, based on
arch/x86/um/Kconfig, CONFIG_X86_32 is always the opposite of
CONFIG_64BIT, so the above code actually has no effect.  Does that sound
right?

- Eric

