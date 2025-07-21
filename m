Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CCEC83F26
	for <linux-um@archiver.kernel.org>; Mon, 21 Jul 2025 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I50g8CBYTAJgx5jeL63ocp0XmC4ojzYZYl9cwyXAxL0=; b=HM16+uDlmHf0wQ2qYljRYy5wGt
	jTrkYyBV46gy0Dzw2wEuFnPwmyPRZZ6nwJl7VC3W/dapRc9n9BjtNMQI1gKL+X1gwgET0r4Rupn7k
	xwL+env7CJm4ffqHEWeHTmsUavHqK9Ni6Nrrgix7tJUxiNWhOKQgU40TxMtYNuFpkyIQLodkyaYpi
	BNSjZszuATgJkLyTZkpXV/OOYkNJJqlSv8CbgszUMIQsB+WvXZWf3pbzpAG2cvAbmLJuUD0WprQEf
	m54Urn1qp5qKUJ5Vk87df2tsofCdbh9tJV93ZSAVeC4dqynyR/U0jesJ7cLdfbUFo8a23RBEL1b4p
	LzjjjE7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzUi-00000000qQV-1eWq;
	Mon, 21 Jul 2025 23:00:28 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzUf-00000000qN6-0MU9;
	Mon, 21 Jul 2025 23:00:26 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-ae3a4a773e1so67162766b.1;
        Mon, 21 Jul 2025 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138823; x=1753743623; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I50g8CBYTAJgx5jeL63ocp0XmC4ojzYZYl9cwyXAxL0=;
        b=f8yF8OdYcEJQBR3EPM1sp8lR3T9le0jfUotZv/fLqvcfZp3vClLcBvDBFisba609KU
         GvEV8pfE9DHFsKR6Oie28fGu4ZIQvsXEVa036euxRZFmhKa9Ba7wzT32yI1i0ONiPmit
         YBwMMR1v9tv1WXlt6E5W3ni52BW4wKnWAnPPApJKExC11H+lhuCNHrAlCr8cDddJpMg6
         HlHaQta4fimtb6kZxvF3vRB101JVF1XmNBZZY3kvzy0hcxNsFl0TGksq6nHu8OusW8Ln
         deiqyu2y83GQ3DhrlXQK6bAdktC3c9ePuLEs9RYQ6DanmGsCAqKJ6w2roqmsqZiBf6HD
         ZhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138823; x=1753743623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I50g8CBYTAJgx5jeL63ocp0XmC4ojzYZYl9cwyXAxL0=;
        b=CFgwq4qPoPzLjIvfRENSYT+mn5/CLj8BMEaWRpL7H32Q1DAaRqfQ9erdjeGTEToJ0h
         uW1qRpfREKehNVd9DDqsUQQ0pNXgrFVwQ7MOa8GOJgpn3glywhFXLP5W0EfQougojCrw
         Arbv0/DvrlmGVJRCDzi+kAJfgp09O/sCfUoOXU6L2V+wh7yQAo8Oo9GrdLaafNW/vb1P
         S1GUbxtKHSJ4eIUe2DoGxZCjy/emSp4xDIPpXyGegRlPXFEFE6PvPyjZ7hoIScaYCX7y
         aFL4+ArOLcO2lug3D4zYRX6Rn69KCvRQ0vhFP6d5EHQkTeHoOMK0LBBVog0n4/mkfcVm
         RrMw==
X-Forwarded-Encrypted: i=1; AJvYcCUw+ZdH5DoxMF/gVA7gqEpZZsFCPEzwEieQMKycrH1N+dsbwJ49bVQRJpg87jTkv9Opr+cZsOE+jzPdSQ==@lists.infradead.org, AJvYcCV5lvt3tcL4REFu7B8NciYr0CH6mEgV7VjTeRPqreArV4oI0GKwjDsG2xG3ZugEXlr/xRdKVZQmLrM=@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7XgQ/dlUGtVFNpp6FRQw6WUN5HtTaMq8JLxqRWg2k1Ho6e4G3
	HJ6f1T8dd5vMyiZuetsmMInb8BA7onr7A5MH6++hudFMg5nNJWXlPZzg
X-Gm-Gg: ASbGnctW4TAJEDcfTUR2AfoUWANcplhd93TuI40P8OBLpccRigwPZaNxiGNDMlCjEZx
	gh9HJ6Mhk8UxmYxRyXjgixOKT/r9gAUn5MsRkqrxWQKtsOzViR9ZOpKMta/5u8XLzB66nNzDTBh
	Ul5HduVdAs7KKYIPHDaGnDL+qw2jAkv/QOevqHiNwQOPjcGfneUBfvRT0nVkNOaaPmJrf/U/MtU
	MoLU0l5gGXr4qmQhOmxToIWvH0gDDa1ga1/hPfW3II6YsXVTnjtOKYm2xnB2llN53i4sy8tpmIq
	PhAmexLU63MeZ1bLqcnLOAXbi80VZ8lBmj+IogPs+JV6hUOE2rlKHYBNoyOyI246wMrkXTlhhR2
	nEiiY5AIpwjgVxOiuqynnrcAVhcu5wpfnJBP9uBqcvJWR6LNSwLOnpz60Rs1fU5AMkXIV
X-Google-Smtp-Source: AGHT+IGYzqj0kH8wn480kr3FBbj99pmKP5/Eu4pwQHjyBRT16VOhkTt/2Q3FevKH1201wdR/kcGe2g==
X-Received: by 2002:a17:907:db15:b0:ad8:882e:38a with SMTP id a640c23a62f3a-ae9c9b8e572mr853708966b.14.1753138823178;
        Mon, 21 Jul 2025 16:00:23 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d8357sm753164466b.52.2025.07.21.16.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 16:00:22 -0700 (PDT)
Message-ID: <85de2e1f-a787-4862-87e4-2681e749cef0@gmail.com>
Date: Tue, 22 Jul 2025 01:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] kasan/um: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-9-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717142732.292822-9-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_160025_142477_7D3AEF8B 
X-CRM114-Status: GOOD (  18.48  )
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



On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
> UserMode Linux needs deferred KASAN initialization as it has a custom
> kasan_arch_is_ready() implementation that tracks shadow memory readiness
> via the kasan_um_is_ready flag.
> 
> Select ARCH_DEFER_KASAN to enable the unified static key mechanism
> for runtime KASAN control. Call kasan_init_generic() which handles
> Generic KASAN initialization and enables the static key.
> 
> Delete the key kasan_um_is_ready in favor of the unified kasan_enabled()
> interface.
> 
> Note that kasan_init_generic has __init macro, which is called by
> kasan_init() which is not marked with __init in arch/um code.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v3:
> - Added CONFIG_ARCH_DEFER_KASAN selection for proper runtime control
> ---
>  arch/um/Kconfig             | 1 +
>  arch/um/include/asm/kasan.h | 5 -----
>  arch/um/kernel/mem.c        | 4 ++--
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index f08e8a7fac9..fd6d78bba52 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -8,6 +8,7 @@ config UML
>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	select ARCH_HAS_CPU_FINALIZE_INIT
>  	select ARCH_HAS_FORTIFY_SOURCE
> +	select ARCH_DEFER_KASAN
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_STRNCPY_FROM_USER
> diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
> index f97bb1f7b85..81bcdc0f962 100644
> --- a/arch/um/include/asm/kasan.h
> +++ b/arch/um/include/asm/kasan.h
> @@ -24,11 +24,6 @@
>  
>  #ifdef CONFIG_KASAN
>  void kasan_init(void);
> -extern int kasan_um_is_ready;
> -
> -#ifdef CONFIG_STATIC_LINK
> -#define kasan_arch_is_ready() (kasan_um_is_ready)
> -#endif
>  #else
>  static inline void kasan_init(void) { }
>  #endif /* CONFIG_KASAN */
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 76bec7de81b..058cb70e330 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -21,9 +21,9 @@
>  #include <os.h>
>  #include <um_malloc.h>
>  #include <linux/sched/task.h>
> +#include <linux/kasan.h>
>  
>  #ifdef CONFIG_KASAN
> -int kasan_um_is_ready;
>  void kasan_init(void)
>  {
>  	/*
> @@ -32,7 +32,7 @@ void kasan_init(void)
>  	 */
>  	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
>  	init_task.kasan_depth = 0;
> -	kasan_um_is_ready = true;
> +	kasan_init_generic();

I think this runs before jump_label_init(), and static keys shouldn't be switched before that.>  }
>  
>  static void (*kasan_init_ptr)(void)


