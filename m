Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6765606A329
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Fwhc31mr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUGFXC4W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cAaMsyaxq/hzUovbQXWov0zOr3rsEyWtdK5HVY2JsZc=; b=Fwhc31mrwTkk3e
	HAPxTHzC+cHh5JxS5MR5eMwGoqYcYNbkQIDl0WDkOk0+m2TF3lbGpuxddF4KFkDiMDXuEZs7ylR3Q
	JNTc9B9WeM08uVfkrzSR9TrB8SXyTH3rxYjLvWUGQ+UaYS3iKVjySzJRMLC4kQHk0/Ni/52RW1Jtz
	/+k3pRxp6sCBAoCDRjaC4frqhtM8WZDb6gAgDUvnGnzbJEVDalm/Ham7rtRqRvM700jhUjsJBUMu4
	mrWDZ6ADf1j/Pte/egKJqNASi0oDXzHMKyUH3zvEczMbHqgqd53X1uf/bC6xTQ2tMcgBnVlmBeJs3
	+OHtP1T4oC5Yb1cbA4wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP5yO-0000000Ao4T-3X8R;
	Thu, 05 Nov 2026 22:30:20 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP5yI-0000000Ao28-1xD0
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 22:30:19 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-490d59c3edaso16300f8f.1
        for <linux-um@lists.infradead.org>; Thu, 05 Nov 2026 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917812; x=1794522612; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAaMsyaxq/hzUovbQXWov0zOr3rsEyWtdK5HVY2JsZc=;
        b=QUGFXC4WzhYyJZ1IjA4/lNNQRDdyteZHoOUIWAch7hmQhMhRkZW8PcrIDG7oZ5yiUN
         loFDihD25mGfwwF+w9yrgp075LduLOO6jDOhriyRQmxA/cWQgE6CLAyl2Dg748s4iYLK
         3mkAm1bvjJpINXdOpYbfzAZehkF5cY08m5UewWWdOZWx7o1snaZ7fd/i0USQokrSgEmk
         gHB5R5jN/5jxn66nkWEuPvOTbsi4XhH3HOxs8TDZE4dcq2IDJaKr190kXkyiZHuzfEMn
         qDOBQAn8SQao2PedHJMRBhDMorPNCf0OWvJ5ZuGul06yd9DJsGNme8MuZoZ1Gs4r3MQB
         5ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917812; x=1794522612;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAaMsyaxq/hzUovbQXWov0zOr3rsEyWtdK5HVY2JsZc=;
        b=GlpEYTHJazVFNslKnQVJ3QSyskhmgyd45yow9p/Yg0MoSzLZbqGDw2nPzffu/lFqdY
         rEwzFxCN3upA3n3PcMNKueOO2t38GNXr+VqGtDOOWWGU3pRlktvVwuYrzknkQUFjRJq/
         MdJoQu+uw1Fh0/n8YGlgRlmQN6iJfncoBS7t8m5Jo/x2Zg9dgqOD9PAkjYf9EEIAVRbR
         TMA1AFocqX29ChVHKHpuI9NexUoPt3sPhnSh4i66uXJ+U+qceTudfC8sxcuswxB39VO9
         jgHwiJjFey19u7LhX+cab8j3nzWlZlDhwqScFwksLyVvIJNI0MCD6Jpk+pyD56dHafeT
         d6Gw==
X-Forwarded-Encrypted: i=1; AKwUvBxvOc/GGUsZ9f7ujw/cJunbc8DmkPdbnkVlEPf/1H043ykSDd1xMRcXnwIr+JUAvCkHtx3cFye0WQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z9+a/VyPm2jSv+WprzQwTBVR0mN8J9PyLQHXD3IjY6/A+mPnzhh
	R6y1QF/cA3nLBI7VBjMDHZ3uCQOmj8/42pAhm3TprGjd+7GBkSbJen46
X-Gm-Gg: AYBFou20FdCbJqciPU/QQCzUvFhWVMMGcL7JcA/0+gB3ksKoLKZPIFbtfLZsTNMwnxg
	4M10hMlHmuFgKeMBjvrot41gCZw5rv05dAbmPFlTuUiHansNdmg6Qb52R4N1wYtbw92IqYe5MF/
	W4VC3daPWB6WHJLdgBSMVtCU5gYTUbc5io51Mkgqr8vY5IlwPlu0dAX0Ws72UslXjS1JXZ58rYw
	2ZEIZhi7RSSMLvPBVHfHDGLOk0NLMifa3b8bOZY8CRqg73BUDtKHWk4Fp7GrKh6WttAZrUgevIh
	1971LscAZchG9E5169PeOXCrB1N0BbOqdus/si2YLWKgAJfVXL1NtE8smaVGn7f3LwRrg/hdWYc
	Bi3bw9yT4Esdhj/R8CNp364EH2VU04w8ZzrcO3OHIZVPObn5FC1HzvwkDyiGGARe0asBWpTdDKU
	Z+K1fZqqRdjvxuW81u6Ai4nUvY1X2Vw/EAwTCsCkCJil85WGBeI6MW0Y6SLmeXzzBs1cv/CLyJ3
	pqrk6y21bSz3TV6C7PqMcTZcSF7DDJVZSUpGTOtUQE4gaYpqtmY5vVO32Cm9/w2X45+LDD9yjdG
	hhJMSgYfQ2ljPLETO2nyJS2FFJPrzRmysMfMmNKMgteufgJDck5bPIi9zoMhiHklwPdZBL3/z98
	DTh0PJgm6BZuoGB9Pa2SlQJidvrcT9sfWsgpaI1Oef1+yO4Yd5hXu9E+/P5UrPbMVwQPVRQo+Ic
	ZnK6Kts9k2dWwS
X-Received: by 2002:a05:6000:3c4:b0:48d:f852:c66b with SMTP id ffacd0b85a97d-4911a58b726mr7341283f8f.22.1793917811398;
        Thu, 05 Nov 2026 14:30:11 -0800 (PST)
Received: from ?IPV6:2a01:261:818:9401:46b1:9fe8:a5e3:32be? ([2a01:261:818:9401:46b1:9fe8:a5e3:32be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7702477sm37694f8f.41.2026.11.05.14.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 14:30:10 -0800 (PST)
Message-ID: <56e7300b-cd1c-4fb4-b269-2243394c6df0@gmail.com>
Date: Thu, 5 Nov 2026 23:30:08 +0100
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
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20261105163440.2381661-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_143015_806792_10BDA9D0 
X-CRM114-Status: GOOD (  23.07  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/5/26 17:34, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All supported CPUs now provide the cmpxchg8b instruction, so remove
> all compile-time and runtime checks for its presence and the fallback
> implementation, to assume it just works.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/um/include/asm/asm-prototypes.h  |   4 -
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
> diff --git a/arch/um/include/asm/asm-prototypes.h b/arch/um/include/asm/asm-prototypes.h
> index 408b31d59127..b446eec98ed8 100644
> --- a/arch/um/include/asm/asm-prototypes.h
> +++ b/arch/um/include/asm/asm-prototypes.h
> @@ -1,6 +1,2 @@
>   #include <asm-generic/asm-prototypes.h>
>   #include <asm/checksum.h>
> -
> -#ifdef CONFIG_UML_X86
> -extern void cmpxchg8b_emu(void);
> -#endif
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index f2c1f544f5f9..832e4bd9f6e0 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -274,9 +274,6 @@ config X86_HAVE_PAE
>   	def_bool y
>   	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC7 || MATOM || X86_64
>   
> -config X86_CX8
> -	def_bool y
> -
>   # this should be set for all -march=.. options where the compiler
>   # generates cmov.
>   config X86_CMOV
> diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
> index 09833c88f9ff..e0f2ff65377d 100644
> --- a/arch/x86/Kconfig.cpufeatures
> +++ b/arch/x86/Kconfig.cpufeatures
> @@ -40,9 +40,6 @@ config X86_REQUIRED_FEATURE_NOPL
>   	def_bool y
>   	depends on X86_64
>   
> -config X86_REQUIRED_FEATURE_CX8
> -	def_bool y
> -
>   # this should be set for all -march=.. options where the compiler
>   # generates cmov.
>   config X86_REQUIRED_FEATURE_CMOV
> @@ -59,6 +56,9 @@ config X86_REQUIRED_FEATURE_SYSFAST32
>   	def_bool y
>   	depends on X86_64 && !X86_FRED
>   
> +config X86_REQUIRED_FEATURE_CX8
> +	def_bool y
> +
>   config X86_REQUIRED_FEATURE_CPUID
>   	def_bool y
>   	depends on X86_64
> diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
> index 11c6fecc3ad7..6ec680a36dea 100644
> --- a/arch/x86/include/asm/asm-prototypes.h
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -16,10 +16,6 @@
>   #include <asm/gsseg.h>
>   #include <asm/nospec-branch.h>
>   
> -#ifndef CONFIG_X86_CX8
> -extern void cmpxchg8b_emu(void);
> -#endif
> -
>   #ifdef CONFIG_STACKPROTECTOR
>   extern unsigned long __ref_stack_chk_guard;
>   #endif
> diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
> index ab838205c1c6..e3da5d0094c4 100644
> --- a/arch/x86/include/asm/atomic64_32.h
> +++ b/arch/x86/include/asm/atomic64_32.h
> @@ -48,7 +48,6 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
>   	ATOMIC64_EXPORT(atomic64_##sym)
>   #endif
>   
> -#ifdef CONFIG_X86_CX8
>   #define __alternative_atomic64(f, g, out, in, clobbers...)		\
>   	asm volatile("call %c[func]"					\
>   		     : ALT_OUTPUT_SP(out) \
> @@ -57,20 +56,6 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
>   		     : clobbers)
>   
>   #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
> -#else
> -#define __alternative_atomic64(f, g, out, in, clobbers...)		\
> -	alternative_call(atomic64_##f##_386, atomic64_##g##_cx8,	\
> -			 X86_FEATURE_CX8, ASM_OUTPUT(out),		\
> -			 ASM_INPUT(in), clobbers)
> -
> -#define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8); \
> -	ATOMIC64_DECL_ONE(sym##_386)
> -
> -ATOMIC64_DECL_ONE(add_386);
> -ATOMIC64_DECL_ONE(sub_386);
> -ATOMIC64_DECL_ONE(inc_386);
> -ATOMIC64_DECL_ONE(dec_386);
> -#endif
>   
>   #define alternative_atomic64(f, out, in, clobbers...) \
>   	__alternative_atomic64(f, f, ASM_OUTPUT(out), ASM_INPUT(in), clobbers)
> diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
> index e85c221ed1c9..1019c4bce620 100644
> --- a/arch/x86/include/asm/cmpxchg_32.h
> +++ b/arch/x86/include/asm/cmpxchg_32.h
> @@ -68,8 +68,6 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
>   	return __arch_try_cmpxchg64(ptr, oldp, new,);
>   }
>   
> -#ifdef CONFIG_X86_CX8
> -
>   #define arch_cmpxchg64 __cmpxchg64
>   
>   #define arch_cmpxchg64_local __cmpxchg64_local
> @@ -78,78 +76,6 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
>   
>   #define arch_try_cmpxchg64_local __try_cmpxchg64_local
>   
> -#else
> -
> -/*
> - * Building a kernel capable running on 80386 and 80486. It may be necessary
> - * to simulate the cmpxchg8b on the 80386 and 80486 CPU.
> - */
> -
> -#define __arch_cmpxchg64_emu(_ptr, _old, _new, _lock_loc, _lock)	\
> -({									\
> -	union __u64_halves o = { .full = (_old), },			\
> -			   n = { .full = (_new), };			\
> -									\
> -	asm_inline volatile(						\
> -		ALTERNATIVE(_lock_loc					\
> -			    "call cmpxchg8b_emu",			\
> -			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8)	\
> -		: ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))		\
> -		: "b" (n.low), "c" (n.high),				\
> -		  [ptr] "S" (_ptr)					\
> -		: "memory");						\
> -									\
> -	o.full;								\
> -})
> -
> -static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
> -{
> -	return __arch_cmpxchg64_emu(ptr, old, new, , "lock ");
> -}
> -#define arch_cmpxchg64 arch_cmpxchg64
> -
> -static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
> -{
> -	return __arch_cmpxchg64_emu(ptr, old, new, ,);
> -}
> -#define arch_cmpxchg64_local arch_cmpxchg64_local
> -
> -#define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new, _lock_loc, _lock)	\
> -({									\
> -	union __u64_halves o = { .full = *(_oldp), },			\
> -			   n = { .full = (_new), };			\
> -	bool ret;							\
> -									\
> -	asm_inline volatile(						\
> -		ALTERNATIVE(_lock_loc					\
> -			    "call cmpxchg8b_emu",			\
> -			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
> -		: ALT_OUTPUT_SP("=@ccz" (ret),				\
> -				"+a" (o.low), "+d" (o.high))		\
> -		: "b" (n.low), "c" (n.high),				\
> -		  [ptr] "S" (_ptr)					\
> -		: "memory");						\
> -									\
> -	if (unlikely(!ret))						\
> -		*(_oldp) = o.full;					\
> -									\
> -	likely(ret);							\
> -})
> -
> -static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
> -{
> -	return __arch_try_cmpxchg64_emu(ptr, oldp, new, , "lock ");
> -}
> -#define arch_try_cmpxchg64 arch_try_cmpxchg64
> -
> -static __always_inline bool arch_try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, u64 new)
> -{
> -	return __arch_try_cmpxchg64_emu(ptr, oldp, new, ,);
> -}
> -#define arch_try_cmpxchg64_local arch_try_cmpxchg64_local
> -
> -#endif
> -
> -#define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
> +#define system_has_cmpxchg64()		true
>   
>   #endif /* _ASM_X86_CMPXCHG_32_H */
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index cef9a4ca9841..539abf94828d 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -330,11 +330,9 @@ do {									\
>   	old__.var = _oval;						\
>   	new__.var = _nval;						\
>   									\
> -	asm_inline qual (						\
> -		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
> -			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
> -		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
> -				"+a" (old__.low), "+d" (old__.high))	\
> +	asm_inline qual ("cmpxchg8b " __percpu_arg([var])		\

This can be plain "asm" instead of "asm_inline"; there is only one asm 
instruction in the asm template.

> +		: [var] "+m" (__my_cpu_var(_var)),			\
> +				"+a" (old__.low), "+d" (old__.high)	\
>   		: "b" (new__.low), "c" (new__.high),			\
>   		  "S" (&(_var))						\

The line above was needed to force address of _var in %esi. This is not 
needed anymore.
>   		: "memory");						\
> @@ -359,10 +357,8 @@ do {									\
>   	old__.var = *_oval;						\
>   	new__.var = _nval;						\
>   									\
> -	asm_inline qual (						\
> -		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
> -			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
> -		: ALT_OUTPUT_SP("=@ccz" (success),			\
> +	asm_inline qual ("cmpxchg8b " __percpu_arg([var])		\

Also here, use "asm" and remove "S" constraint. Please see [1].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?h=WIP.x86/cpu&id=8cfdd354dae90a3db46c351d15c801dfbf76fc5a

Uros.

> +		: "=@ccz" (success),					\
>   				[var] "+m" (__my_cpu_var(_var)),	\
>   				"+a" (old__.low), "+d" (old__.high))	\
>   		: "b" (new__.low), "c" (new__.high),			\
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 2dba7f83ef97..210af275f468 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -48,10 +48,6 @@ ifeq ($(CONFIG_X86_32),y)
>           lib-y += strstr_32.o
>           lib-y += string_32.o
>           lib-y += memmove_32.o
> -        lib-y += cmpxchg8b_emu.o
> -ifneq ($(CONFIG_X86_CX8),y)
> -        lib-y += atomic64_386_32.o
> -endif
>   else
>   ifneq ($(CONFIG_GENERIC_CSUM),y)
>           lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
> diff --git a/arch/x86/lib/atomic64_386_32.S b/arch/x86/lib/atomic64_386_32.S
> deleted file mode 100644
> index e768815e58ae..000000000000
> --- a/arch/x86/lib/atomic64_386_32.S
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * atomic64_t for 386/486
> - *
> - * Copyright © 2010  Luca Barbieri
> - */
> -
> -#include <linux/linkage.h>
> -#include <asm/alternative.h>
> -
> -/* if you want SMP support, implement these with real spinlocks */
> -.macro IRQ_SAVE reg
> -	pushfl
> -	cli
> -.endm
> -
> -.macro IRQ_RESTORE reg
> -	popfl
> -.endm
> -
> -#define BEGIN_IRQ_SAVE(op) \
> -.macro endp; \
> -SYM_FUNC_END(atomic64_##op##_386); \
> -.purgem endp; \
> -.endm; \
> -SYM_FUNC_START(atomic64_##op##_386); \
> -	IRQ_SAVE v;
> -
> -#define ENDP endp
> -
> -#define RET_IRQ_RESTORE \
> -	IRQ_RESTORE v; \
> -	RET
> -
> -#define v %ecx
> -BEGIN_IRQ_SAVE(read)
> -	movl  (v), %eax
> -	movl 4(v), %edx
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %esi
> -BEGIN_IRQ_SAVE(set)
> -	movl %ebx,  (v)
> -	movl %ecx, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v  %esi
> -BEGIN_IRQ_SAVE(xchg)
> -	movl  (v), %eax
> -	movl 4(v), %edx
> -	movl %ebx,  (v)
> -	movl %ecx, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %ecx
> -BEGIN_IRQ_SAVE(add)
> -	addl %eax,  (v)
> -	adcl %edx, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %ecx
> -BEGIN_IRQ_SAVE(add_return)
> -	addl  (v), %eax
> -	adcl 4(v), %edx
> -	movl %eax,  (v)
> -	movl %edx, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %ecx
> -BEGIN_IRQ_SAVE(sub)
> -	subl %eax,  (v)
> -	sbbl %edx, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %ecx
> -BEGIN_IRQ_SAVE(sub_return)
> -	negl %edx
> -	negl %eax
> -	sbbl $0, %edx
> -	addl  (v), %eax
> -	adcl 4(v), %edx
> -	movl %eax,  (v)
> -	movl %edx, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %esi
> -BEGIN_IRQ_SAVE(inc)
> -	addl $1,  (v)
> -	adcl $0, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %esi
> -BEGIN_IRQ_SAVE(inc_return)
> -	movl  (v), %eax
> -	movl 4(v), %edx
> -	addl $1, %eax
> -	adcl $0, %edx
> -	movl %eax,  (v)
> -	movl %edx, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %esi
> -BEGIN_IRQ_SAVE(dec)
> -	subl $1,  (v)
> -	sbbl $0, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %esi
> -BEGIN_IRQ_SAVE(dec_return)
> -	movl  (v), %eax
> -	movl 4(v), %edx
> -	subl $1, %eax
> -	sbbl $0, %edx
> -	movl %eax,  (v)
> -	movl %edx, 4(v)
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> -
> -#define v %esi
> -BEGIN_IRQ_SAVE(add_unless)
> -	addl %eax, %ecx
> -	adcl %edx, %edi
> -	addl  (v), %eax
> -	adcl 4(v), %edx
> -	cmpl %eax, %ecx
> -	je 3f
> -1:
> -	movl %eax,  (v)
> -	movl %edx, 4(v)
> -	movl $1, %eax
> -2:
> -	RET_IRQ_RESTORE
> -3:
> -	cmpl %edx, %edi
> -	jne 1b
> -	xorl %eax, %eax
> -	jmp 2b
> -ENDP
> -#undef v
> -
> -#define v %esi
> -BEGIN_IRQ_SAVE(inc_not_zero)
> -	movl  (v), %eax
> -	movl 4(v), %edx
> -	testl %eax, %eax
> -	je 3f
> -1:
> -	addl $1, %eax
> -	adcl $0, %edx
> -	movl %eax,  (v)
> -	movl %edx, 4(v)
> -	movl $1, %eax
> -2:
> -	RET_IRQ_RESTORE
> -3:
> -	testl %edx, %edx
> -	jne 1b
> -	jmp 2b
> -ENDP
> -#undef v
> -
> -#define v %esi
> -BEGIN_IRQ_SAVE(dec_if_positive)
> -	movl  (v), %eax
> -	movl 4(v), %edx
> -	subl $1, %eax
> -	sbbl $0, %edx
> -	js 1f
> -	movl %eax,  (v)
> -	movl %edx, 4(v)
> -1:
> -	RET_IRQ_RESTORE
> -ENDP
> -#undef v
> diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
> deleted file mode 100644
> index d4bb24347ff8..000000000000
> --- a/arch/x86/lib/cmpxchg8b_emu.S
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -
> -#include <linux/export.h>
> -#include <linux/linkage.h>
> -#include <asm/percpu.h>
> -#include <asm/processor-flags.h>
> -
> -.text
> -
> -#ifndef CONFIG_X86_CX8
> -
> -/*
> - * Emulate 'cmpxchg8b (%esi)' on UP
> - *
> - * Inputs:
> - * %esi : memory location to compare
> - * %eax : low 32 bits of old value
> - * %edx : high 32 bits of old value
> - * %ebx : low 32 bits of new value
> - * %ecx : high 32 bits of new value
> - */
> -SYM_FUNC_START(cmpxchg8b_emu)
> -
> -	pushfl
> -	cli
> -
> -	cmpl	(%esi), %eax
> -	jne	.Lnot_same
> -	cmpl	4(%esi), %edx
> -	jne	.Lnot_same
> -
> -	movl	%ebx, (%esi)
> -	movl	%ecx, 4(%esi)
> -
> -	orl	$X86_EFLAGS_ZF, (%esp)
> -
> -	popfl
> -	RET
> -
> -.Lnot_same:
> -	movl	(%esi), %eax
> -	movl	4(%esi), %edx
> -
> -	andl	$(~X86_EFLAGS_ZF), (%esp)
> -
> -	popfl
> -	RET
> -
> -SYM_FUNC_END(cmpxchg8b_emu)
> -EXPORT_SYMBOL(cmpxchg8b_emu)
> -
> -#endif
> -
> -#ifndef CONFIG_UML
> -
> -/*
> - * Emulate 'cmpxchg8b %fs:(%rsi)'
> - *
> - * Inputs:
> - * %esi : memory location to compare
> - * %eax : low 32 bits of old value
> - * %edx : high 32 bits of old value
> - * %ebx : low 32 bits of new value
> - * %ecx : high 32 bits of new value
> - *
> - * Notably this is not LOCK prefixed and is not safe against NMIs
> - */
> -SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
> -
> -	pushfl
> -	cli
> -
> -	cmpl	__percpu (%esi), %eax
> -	jne	.Lnot_same2
> -	cmpl	__percpu 4(%esi), %edx
> -	jne	.Lnot_same2
> -
> -	movl	%ebx, __percpu (%esi)
> -	movl	%ecx, __percpu 4(%esi)
> -
> -	orl	$X86_EFLAGS_ZF, (%esp)
> -
> -	popfl
> -	RET
> -
> -.Lnot_same2:
> -	movl	__percpu (%esi), %eax
> -	movl	__percpu 4(%esi), %edx
> -
> -	andl	$(~X86_EFLAGS_ZF), (%esp)
> -
> -	popfl
> -	RET
> -
> -SYM_FUNC_END(this_cpu_cmpxchg8b_emu)
> -
> -#endif
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
>   subarch-y += ../lib/checksum_32.o
>   subarch-y += ../kernel/sys_ia32.o
>   
> diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
> index d726068358c7..37af41df3e6a 100644
> --- a/lib/atomic64_test.c
> +++ b/lib/atomic64_test.c
> @@ -251,15 +251,12 @@ static __init int test_atomics_init(void)
>   	test_atomic64();
>   
>   #ifdef CONFIG_X86
> -	pr_info("passed for %s platform %s CX8 and %s SSE\n",
> +	pr_info("passed for %s platform %s SSE\n",
>   #ifdef CONFIG_X86_64
>   		"x86-64",
> -#elif defined(CONFIG_X86_CX8)
> -		"i586+",
>   #else
> -		"i386+",
> +		"i586+",
>   #endif
> -	       boot_cpu_has(X86_FEATURE_CX8) ? "with" : "without",
>   	       boot_cpu_has(X86_FEATURE_XMM) ? "with" : "without");
>   #else
>   	pr_info("passed\n");


