Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E837C87FD2
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q/FfZaSan1eV7HDF3Wa83lEa0xPcSUpZYrzYE5G9wjk=; b=bwFWkjbJhwRmMTAlcVTXO9ssA4
	S38kZ/LYGj1MqZUAfmEQi00CiK4h0bODh7fQvG4HoxPUck0ylcfT0YwM2vDoNG20JvVZjE2qGrwj2
	SKiApQAh0rwWxHhrE0N5M3uoRPfj3NdrOB93KXYDNvLVwFO71ndKsL0qomHCRzRuZIamwaI0xD1WX
	zzCHsNhTj/OkktB1xtRFQNoB6EUqoBZ/zapquubu3haSPD0rSyrrpI4XVYKBOmd+awKw93Y2NnLyw
	Y2375WuxWZSnTCLkmOSNNxgov1UDBm/0TU+L2iW5GTyVhCBIWuD7oe1v9Jh/MGvJlmMRG+hZmg8jE
	Y9+RyE1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujLlk-0000000DT20-3N2P;
	Tue, 05 Aug 2025 17:48:12 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujLKQ-0000000DPdn-1Vou;
	Tue, 05 Aug 2025 17:19:59 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-55b858e8778so214017e87.2;
        Tue, 05 Aug 2025 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754414396; x=1755019196; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/FfZaSan1eV7HDF3Wa83lEa0xPcSUpZYrzYE5G9wjk=;
        b=g33GiZSXHE5WFOioqA+OyFumqb3YF0BJkmL649TYnPcassaYguH0IOJRZGy9t0A6eI
         GtrcYedVrASRIlDVBzEt4Dbqxft432gt2HkOlFNMiC1A4rdgKD8vHw1Ww6ANWHkg7ec2
         I0ctkRQk6eh//65nCLDqL9H7TqBj9DQcKbUWfWrDyu+IPle8tmUAI6DSaGuGxXEArrRQ
         pFAgeAx5xBB0Jvy1fuWxLsz9ZZWEsCABtS+wdvZ7oqIzIHeVz5jZlnUww4Ou1Sl1+fOO
         6eE4+/KaO7ZacWEbHliK9IXdi/gk/yAjgZPQqNsmZemgfMTGNWEUYivK5MHweprVySQx
         9jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754414396; x=1755019196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/FfZaSan1eV7HDF3Wa83lEa0xPcSUpZYrzYE5G9wjk=;
        b=q9daB202+B1wFi0nR0r2A5yXpulEF8UACVmVeXTMyEuz7HHPmshGMpFmIB8rt0ph18
         Zh4LeJSkoW9uiC6/NJpkXSpIgXsWgIjTkL6vihi5mMBfFlPEKSuWTWXOWh/h2tBGH3mp
         X7xr8W6l9WPQn5mgWoEWj/9xTCoetDaoR6q+i0itlm/57wdqO1uB1ODhi2Oj3v1YY0f8
         sR/9CQ33QONJ0cWllclam3ed8bY9BRjlIdcMMfWE9TW1BzxEJsOpEPtdZcLp6rDVfqgs
         lCvJbjI5kJU9/k1s49qCPaDSKBFQT46Vi/48ukuL9/RqMamThP4QQiCBY2E8MZ3Yl5RL
         koxg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Do58xiKE5BXzffPg0m3rPyenMnf+RNJFmKr3faKEjOlm1KD7BoEVSO1JUaHxglTkkBhgrqBS79o=@lists.infradead.org, AJvYcCVSR6jDDmHL54K1YhP8rlNWFFcuuJc8MxSamCjF9STxJ2qi/qt8sA9HKewYbKKQKIzbIzWtZQ1lw3lS0Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4ZYjzyuU4qpX9ytXk3dWrQ8wQLEAdeJdOyXiJpPbqByLGQ/Zi
	VCMKOnITBqrdyuwmcm8v+6uVkMm4KVKBYswD9tyX0ekwxam+XWogf2KG
X-Gm-Gg: ASbGncs8pR+hvUQbpGlChaMssG6J2gj6E4nwvntbTYcGRnaDg6Ty4nD/y2AJMKN8GGh
	ffqIp3z2R0Fx1ZN7hq16Ec3em6CVHe8ldn1awifYLFJZGJ3oJhP5WkcLTXfQz5A+4xcq7jus44e
	xWUcRbX0GZDzXKN53w83iZMLSYKbZrRk8gFvCiUMRWxd1MrsMhfOB2rsH3SYfvodVREfi38yEIo
	jF7xo73NtgPFy/Selr4GwmW5hiYJCzeBQVqzHFoTWfRq/aGOIMRsqjJVfAyyBl2VWakx9f1u3v9
	JpeykoRCHdH0x7a7GRKT0kCCDVqPKm4tj+vqXb/JJNPCx0VJv/4QQdixi6aYPtXSjlaS+rIT2/7
	lFrioujiyEavEUESWByu7XEU4aBIM
X-Google-Smtp-Source: AGHT+IFZ9pdK1jvsk2cxgalB1qSoH0zZWAWc/VG+Lc+QySUYQJ+aNEU1tTzI15MgaTEZ+riRKR17/A==
X-Received: by 2002:a05:6512:6d1:b0:553:2480:230a with SMTP id 2adb3069b0e04-55b979b819amr1540170e87.0.1754414396425;
        Tue, 05 Aug 2025 10:19:56 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a9483sm19586481fa.23.2025.08.05.10.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 10:19:56 -0700 (PDT)
Message-ID: <60895f3d-abe2-4fc3-afc3-176a188f06d4@gmail.com>
Date: Tue, 5 Aug 2025 19:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] kasan/um: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 trishalfonso@google.com, davidgow@google.com
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-7-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250805142622.560992-7-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_101958_403499_E40B4D75 
X-CRM114-Status: UNSURE (   9.45  )
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



On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 9083bfdb773..8d14c8fc2cd 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -5,6 +5,7 @@ menu "UML-specific options"
>  config UML
>  	bool
>  	default y
> +	select ARCH_DEFER_KASAN

select ARCH_DEFER_KASAN if STATIC_LINK

>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	select ARCH_HAS_CACHE_LINE_SIZE
>  	select ARCH_HAS_CPU_FINALIZE_INIT
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

