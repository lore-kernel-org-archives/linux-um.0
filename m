Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E124606A326
	for <linux-um@archiver.kernel.org>; Fri,  6 Nov 2026 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WVlhkMrV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jPRtGsIMr+vS8k8SFEAZBCQ/fTK7nGN3sKe7Ag8BEKA=; b=WVlhkMrVbrQqsr
	riuOh3msfoVC2AH3msi8wZXXgTm8bhxPKIRkkJEjQyXHYn445uEQ+2YS4pRr2k833mh0Ob3qq+Cqi
	ULb05jsesXbwjZ0afPUfJd0bxOfY0O39QS5lExcxhH6PNO80m9PB0apW8T7ZPG1N2aAOj72OSL9H/
	Tmy3aLX59oY5ruy+0Z4tQeI0XxasuIKDh4avd3lWTpwFHL0TYfGyfJANIia+xrnoO7xpEkTamOQUY
	yYg5Py9uFJpqQaM3fPCXdaSzjzlNZvvRJI2VGuAn2sB62q4x9sjHavKfPNYmPYKopslXVNFStjX0o
	Q6GR71CHcm7kssNwCgEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPM6N-0000000CsWC-2scp;
	Fri, 06 Nov 2026 15:43:39 +0000
Received: from sphereful.davidgow.net ([2404:9400:4:0:216:3eff:fee2:5328])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPM6I-0000000CsU0-1HXW
	for linux-um@lists.infradead.org;
	Fri, 06 Nov 2026 15:43:37 +0000
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 843DF200BB3; Fri,  6 Nov 2026 23:43:24 +0800 (AWST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
Received: from [IPV6:2001:8003:8802:7000::41b] (unknown [IPv6:2001:8003:8802:7000::41b])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 7ACEF200BAB;
	Fri,  6 Nov 2026 23:43:21 +0800 (AWST)
Message-ID: <f0781521-3436-4651-82f0-f9fdfbe864de@davidgow.net>
Date: Fri, 6 Nov 2026 23:43:17 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] x86: make CX8 usage unconditional
To: Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner
 <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
References: <20261105163440.2381661-1-arnd@kernel.org>
 <20261105163440.2381661-4-arnd@kernel.org>
Content-Language: en-US
From: David Gow <david@davidgow.net>
In-Reply-To: <20261105163440.2381661-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_074334_607872_4D47F96D 
X-CRM114-Status: GOOD (  15.39  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>

Le 06/11/2026 à 00:34, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All supported CPUs now provide the cmpxchg8b instruction, so remove
> all compile-time and runtime checks for its presence and the fallback
> implementation, to assume it just works.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Hi Arnd,

As-is, this breaks 32-bit UML, as atomic64_cx8_32.S is removed from the 
Makefile. With that reinstated, 32-bit UML at least builds and passes 
some basic KUnit tests here (though I haven't tried it on actual 586+ 
class hardware yet, and building with CONFIG_M586TSC still fails the 
checksum tests[1]).

Reproduces with:
make O=.tmpuml ARCH=um SUBARCH=i386
or
./tools/testing/kunit/kunit.py run --arch um --kconfig_add CONFIG_64BIT=n

>   arch/um/include/asm/asm-prototypes.h  |   4 
>   arch/x86/Kconfig.cpu                  |   3 -
>   arch/x86/Kconfig.cpufeatures          |   6 +-
>   arch/x86/include/asm/asm-prototypes.h |   4 -
>   arch/x86/include/asm/atomic64_32.h    |  15 --
>   arch/x86/include/asm/cmpxchg_32.h     |  76 +---------
>   arch/x86/include/asm/percpu.h         |  14 +-
>   arch/x86/lib/Makefile                 |   4 -
>   arch/x86/lib/atomic64_386_32.S        | 195 --------------------------
>   arch/x86/lib/cmpxchg8b_emu.S          |  97 -------------
>   arch/x86/um/Kconfig                   |   2 +-
>   arch/x86/um/Makefile                  |   3 +-
>   lib/atomic64_test.c                   |   7 +-
>   13 files changed, 13 insertions(+), 417 deletions(-)
>   delete mode 100644 arch/x86/lib/atomic64_386_32.S
>   delete mode 100644 arch/x86/lib/cmpxchg8b_emu.S
> 

...snip...

> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> index 44b12e45f9a0..5b78440a78b9 100644
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@ -13,7 +13,7 @@ config UML_X86
>   	select ARCH_USE_QUEUED_SPINLOCKS
>   	select DCACHE_WORD_ACCESS
>   	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> -	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8
> +	select UML_SUBARCH_SUPPORTS_SMP
>   
>   config 64BIT
>   	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index 100b68f601f9..716da7b1e3e9 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -19,8 +19,7 @@ ifeq ($(CONFIG_X86_32),y)
>   
>   obj-y += syscalls_32.o
>   
> -subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
> -subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
> +subarch-y = ../lib/string_32.o ../lib/atomic64_32.o

Reinstate ../lib/atomic64_cx8_32.o here!

>   subarch-y += ../lib/checksum_32.o
>   subarch-y += ../kernel/sys_ia32.o
>   
> diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
> index d726068358c7..37af41df3e6a 100644
Cheers,
-- David

[1]: 
https://lore.kernel.org/all/20240720063937.2311958-2-davidgow@google.com/

