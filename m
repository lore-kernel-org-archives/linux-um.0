Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBA7C5B549
	for <linux-um@archiver.kernel.org>; Fri,  6 Jun 2025 07:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PaFljiz6nrAwTtEoCeSBu+rBeJFk0s0kLDoYDsYsb0o=; b=dkN4iiYl3RU5/BSsiAFpDkgHQx
	yRhEGWgz9al0fm6VlDSKt86JxvoDYNVQVcDq429AnQQSYEWAYh1/8sKXUZapGaZV3icvrcMGKQQN6
	9WJVQPJp5Si0tyNp02lMKrxW2mjikjbmXpCyLMDv4xWttlKk6ihPcDPx0d5dzJ75JIht3ERqFkQ+g
	3mSVJ129X+OSJyT6Ze/oJwNAy6w2WWDmlCTPYo8lT6t49tZMysj3M4pWimEnExfSRwuj0YlwIBlQ6
	1qPRQJFUgUMJ0x0ze/PkkrmqQ+vckeEB0zLG9B3YUwmLJOxztpowtKOcOMPBkeXeZIIlB2mV3re7h
	xTwqsZ1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNRUc-0000000HIzF-0JDX;
	Fri, 06 Jun 2025 07:27:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNRUZ-0000000HIyX-3jJ1
	for linux-um@lists.infradead.org;
	Fri, 06 Jun 2025 07:27:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749194874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PaFljiz6nrAwTtEoCeSBu+rBeJFk0s0kLDoYDsYsb0o=;
	b=Q0saTJqtFnO2/DnC9PHqEfnsOOXY4gTgNrkoJPtnR+7jVjpOp5Pd23rT9tEnA+zYAsdUIJ
	vZPM4Yys1K2AxkuXGVmtuafeLclUFst9lui3Rr7X49uQMXHZ5cjkcFFhiBNQGZAFKtKPSe
	9VMJ71lk9BF5PC4goDlr5AAQIFYCnFc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-p9sZs3JiOtOmKvy_WiWfVQ-1; Fri, 06 Jun 2025 03:27:53 -0400
X-MC-Unique: p9sZs3JiOtOmKvy_WiWfVQ-1
X-Mimecast-MFC-AGG-ID: p9sZs3JiOtOmKvy_WiWfVQ_1749194872
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451e24dfe1dso14404135e9.0
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 00:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749194872; x=1749799672;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaFljiz6nrAwTtEoCeSBu+rBeJFk0s0kLDoYDsYsb0o=;
        b=pKDKYNl7/uwwCwNU+97UCPGrj+M1BLrxR/BW3upc/ZpMbi1w2zeTpylNBTCSY5ls0R
         CdoH+3YEfWZK5VhW7N6TFRFUWlF7iE3zptRLDVweKsNomu+H6W/rrSg4d17C3vQm9oOm
         Cqk5z0wfXFi1n7jYV3YuojZjOtdpWmj+6h4LD47a7oKiby0KsIlrceJza8tCZqEe6O6N
         vSysrLfBAOb1rP3Ag2Pc6NVBcoSCAP8n5sOSAdaLcz6yH7m9g9cSc/ulLH+QPH040bJW
         mCyX3F2I5evUqWjU5CmwGk971yq7Mhf192JhPpDmbDkEB6uLv3V9uZR8FhTpUr9ZdxZQ
         RLVg==
X-Gm-Message-State: AOJu0YzwUoYxlvV3kaUVrFLiKZ+QaGbOJ4gfAHXcULswQVhlR6552W4B
	ADPslL6DmTERx+2acKhrfcx/iyu2uRsIesNmqIw93CLG14nHwMVW6oy1f91/k+XlkKxi/idbauH
	6RjGqBgcZGREDsMa0sAevSIKCsniltGTV2PipvTodm8wr4pGCdACyJxIV5woVCkWB3g==
X-Gm-Gg: ASbGncvkEnZfGoJUTg+HuPS11JVg7kOfGOUvQ3iIp2zsajk7xqepTeUybRpecakBll9
	Sjoj1gF1oe03s89ZxYFwOrdk5Ea9VkIsFecBts5Jlurv7EnECgwHHBBP6BhDXzfnuUmvVgSrQr6
	JyTHKJF7gOw9jGm5IUOGrk/Yqo6Xk/3chyvB420Pi+/lbJXKeIDBMhx8yAcIDCfhQRscPmhvfGK
	4aw+hkQCrBanlHuMCHPkecZBvr5AeSknWI2b90Mr0mXtLdk8jWFt1o74SVY398/ZpVcnQ5ADxNZ
	4Vu9R91DTvX6yR8U/nCOVlV4aN3PaR7H+7FZTVpSLfhN4VoGr78cGw==
X-Received: by 2002:a05:600c:6085:b0:442:f485:6fa4 with SMTP id 5b1f17b1804b1-452014ea837mr22480145e9.31.1749194871901;
        Fri, 06 Jun 2025 00:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCjDpJhgYbUiE+59r24xcVnW4s8YUIu3Eeubt74UJ+lIqwEHh+V7/hZ90q2F8j/eXnUAbQpg==
X-Received: by 2002:a05:600c:6085:b0:442:f485:6fa4 with SMTP id 5b1f17b1804b1-452014ea837mr22479885e9.31.1749194871391;
        Fri, 06 Jun 2025 00:27:51 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-50-214.web.vodafone.de. [109.42.50.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de48sm1088495f8f.10.2025.06.06.00.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 00:27:50 -0700 (PDT)
Message-ID: <8475d38e-a819-4956-b1db-df957fa842cb@redhat.com>
Date: Fri, 6 Jun 2025 09:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/41] um: Replace __ASSEMBLY__ with __ASSEMBLER__ in the
 usermode headers
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-36-thuth@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250314071013.1575167-36-thuth@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2jwJVMRqjRgfIWi3pBjDzE5xXXRYZBELOyt8JKBOB08_1749194872
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_002756_184177_CF94978C 
X-CRM114-Status: GOOD (  19.65  )
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

On 14/03/2025 08.10, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, so let's standardize on the __ASSEMBLER__
> macro that is provided by the compilers now.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
> 
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/um/include/asm/cpufeature.h     | 4 ++--
>   arch/um/include/asm/current.h        | 4 ++--
>   arch/um/include/asm/page.h           | 4 ++--
>   arch/um/include/asm/ptrace-generic.h | 2 +-
>   arch/um/include/asm/thread_info.h    | 2 +-
>   arch/um/include/shared/as-layout.h   | 2 +-
>   6 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
> index 1eb8b834fbec3..4354f6984271c 100644
> --- a/arch/um/include/asm/cpufeature.h
> +++ b/arch/um/include/asm/cpufeature.h
> @@ -4,7 +4,7 @@
>   
>   #include <asm/processor.h>
>   
> -#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
> +#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
>   
>   #include <asm/asm.h>
>   #include <linux/bitops.h>
> @@ -137,5 +137,5 @@ static __always_inline bool _static_cpu_has(u16 bit)
>   #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
>   					boot_cpu_data.x86_model
>   
> -#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
> +#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) */
>   #endif /* _ASM_UM_CPUFEATURE_H */
> diff --git a/arch/um/include/asm/current.h b/arch/um/include/asm/current.h
> index de64e032d66c1..8accc6d6f5026 100644
> --- a/arch/um/include/asm/current.h
> +++ b/arch/um/include/asm/current.h
> @@ -5,7 +5,7 @@
>   #include <linux/compiler.h>
>   #include <linux/threads.h>
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   struct task_struct;
>   extern struct task_struct *cpu_tasks[NR_CPUS];
> @@ -18,6 +18,6 @@ static __always_inline struct task_struct *get_current(void)
>   
>   #define current get_current()
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   #endif /* __ASM_CURRENT_H */
> diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
> index 3d516f3ca9c74..6f54254aaf443 100644
> --- a/arch/um/include/asm/page.h
> +++ b/arch/um/include/asm/page.h
> @@ -11,7 +11,7 @@
>   
>   #include <vdso/page.h>
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   struct page;
>   
> @@ -94,7 +94,7 @@ extern unsigned long uml_physmem;
>   #include <asm-generic/memory_model.h>
>   #include <asm-generic/getorder.h>
>   
> -#endif	/* __ASSEMBLY__ */
> +#endif	/* __ASSEMBLER__ */
>   
>   #ifdef CONFIG_X86_32
>   #define __HAVE_ARCH_GATE_AREA 1
> diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
> index 4696f24d14920..86d74f9d33cf2 100644
> --- a/arch/um/include/asm/ptrace-generic.h
> +++ b/arch/um/include/asm/ptrace-generic.h
> @@ -6,7 +6,7 @@
>   #ifndef __UM_PTRACE_GENERIC_H
>   #define __UM_PTRACE_GENERIC_H
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #include <sysdep/ptrace.h>
>   
> diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
> index f9ad06fcc991a..398e86fe3d051 100644
> --- a/arch/um/include/asm/thread_info.h
> +++ b/arch/um/include/asm/thread_info.h
> @@ -9,7 +9,7 @@
>   #define THREAD_SIZE_ORDER CONFIG_KERNEL_STACK_ORDER
>   #define THREAD_SIZE ((1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE)
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #include <asm/types.h>
>   #include <asm/page.h>
> diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
> index ea65f151bf484..07721d7210b1f 100644
> --- a/arch/um/include/shared/as-layout.h
> +++ b/arch/um/include/shared/as-layout.h
> @@ -26,7 +26,7 @@
>   #define STUB_DATA_PAGES 2 /* must be a power of two */
>   #define STUB_END (STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE)
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #include <sysdep/ptrace.h>
>   


Friendly ping!

Richard, Anton, Johannes, could you maybe pick this patch up via your "um" 
tree? (x86 and parisc already got merge via their respective architecture 
trees, so I guess the same should happen for this patch here, too).

  Thanks,
   Thomas


