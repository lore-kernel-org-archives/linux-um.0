Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B09EC87FCB
	for <linux-um@archiver.kernel.org>; Wed,  6 Aug 2025 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pDOCIZR6gSwH1CTXkpwwYCK6HLPl+F0ICSkVzqPXsh0=; b=uCMJBl7Qa0qvJuCWCUf4h2pwFl
	6TUQTay/YhB9eWGgat214uzQD0myWQbkFLnNQ8vyxwyUA8ksX2s9K6UMLJKvT+8h8XN9BgXftPXs7
	WOr/QNS4Ekkl7rtsQr/Q8XodwUcLyT1kSbwBO/bJOZPbJIIa6bgQ5O154HcjM5Y/+KTd9cyfRo5oe
	wBJTi7Jo96yNseQUeuykZT7G+n4c1M+lPmljksVV9VRLY0hDMk19ZLswtRi6gjqNVG3WQVR4INeSK
	kV699FfhQbTjxKosT1mVBNLu1d90LSHobOvYA99G5wVXSUI2EJ3+x9HQANiQ0HoLcQP7mahtN8oKN
	J7/pBW6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujefi-0000000FMe9-3Slk;
	Wed, 06 Aug 2025 13:59:14 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujeWy-0000000FLDq-1jcP;
	Wed, 06 Aug 2025 13:50:13 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-332468a0955so7034261fa.1;
        Wed, 06 Aug 2025 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754488210; x=1755093010; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDOCIZR6gSwH1CTXkpwwYCK6HLPl+F0ICSkVzqPXsh0=;
        b=LhebYhjalqT+HfvXipRUx1FbhnKTYQccQ0udjhV4Ag+k58MzIrcGpJVXuexEff56un
         jNQEAw7h+R7eY80FBx8ieyqrf18hbSuuZ4fyHFg4vAokmsvFkhLQgqMLLxNCbrkMwXAw
         QBx7g3BzswfzGv1GNzCW/rpwrfF+5ywnZWSb3FZZGYHx1CXdUZf/OzWmsCXvwkW+EE6o
         TP8t4XnpcGtbWa5CTlkmFtxm6TVgWuf0pKPD4diucfHnzTXrR3gjI8WreXPryUnliq8B
         OqJODdcVjEIotM7SJpdRON26G1Q8lPvDBQV0q+2TD2mUYKfWd8Y6A1YbpO75gmO61myJ
         cycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754488210; x=1755093010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDOCIZR6gSwH1CTXkpwwYCK6HLPl+F0ICSkVzqPXsh0=;
        b=IrWSPd4w045TUtpMnhTFoO+Hl8DxjNJ8T8DZ4ua7vDz7gEhvm8WsefOKxioiPhcoVG
         3a8tNTViKEIqfVuC2ToN8fwojpvvWkZDjws1XXnRy0tLEpupP3WfOBCJC6YLS0ybTKCW
         bm51w6b9uFf0JR5ThSavwZydCVsWoz/FTOrtYnF2clAc80sj96w9VvbObM3PTvg3V+rN
         Zk5rxCAtssL4ufoDfzwdPySHiG5nq57tKLzPvsQVfJZwYFJE5tGkDIULq/ZN3EajMnIR
         YIK3PU3dg6UKGDnqUNwOAwG7Jo9TVLd+NrgowweWpZS4VFYeLzR525A56RQqXtog5+WM
         iM/w==
X-Forwarded-Encrypted: i=1; AJvYcCUXJ5mKkYeFlJh8pvgX3eB7DZGD8+nbGVs31sQ1zqek3aaA5ZwTV4ikO8ju6PrviPH+OgX72h83uhY=@lists.infradead.org, AJvYcCXQj+9HvDewrBgGeF1pVrpnDhxgot8ZiSUxhHIqnzmX2LWPmtpM3vR0bJ7bUxsi7RlSQUvwfy3VeJoPOA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxc6WhnAr8ArFkdJjowbn+IiqfE9Sr92cMjmurNqo/b4YjQi6xG
	yX3/uXdU5pPE+IU/r3r710xHDQOes9Yhqk5NUrMpUKOjtaXgHhSj+od4
X-Gm-Gg: ASbGnctDHSONwb2Ks6cnl6n6kuV0IUHsnY8EG4ltSIkulpypmuoS6UX8/w93wvh7peX
	BotWURbxbrI7cy6Zb9m9x+OllrtLnoBnphskGdf813gbCKW/tnw6gAid4HZN35rldg/Mls0kCnD
	L8GmTfjr/SHVBTk/zURWROeg6xk3tLVGRwd+7S5ZL34ePpnmsLpFDa79c9T8wy/YycvpAFfgZFK
	o3YmbK8mSIARUmHHUq1N/lMDctFKBhNO21bwsI+aTSayHutNhBSWIpMUofkgnz/Som6UYQ4/kGJ
	S4MlA8QvUYW1Q1fIEMui8nsA5ajziaZi5/Efpr7QJTws+IC8j/A5PXG0P7z9flHELkO89iPJTua
	ZHvrlXY+aMBCx8pTltozuoRs+uLMVjU/Agsd4pV5v/D8xL4yPig==
X-Google-Smtp-Source: AGHT+IEsyaC4e5C8bAXA34DF26BCI2kUm+pbeFPiYngQRQqOaMh9b3JgYLiHo/Ul9EDDlBD4plM96A==
X-Received: by 2002:a05:6512:3b1f:b0:550:ecdf:a7f9 with SMTP id 2adb3069b0e04-55caf35fc1amr414988e87.10.1754488210277;
        Wed, 06 Aug 2025 06:50:10 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabbd8sm2356761e87.149.2025.08.06.06.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 06:50:09 -0700 (PDT)
Message-ID: <ece4aab9-a195-47c9-b370-c84f5dcc0098@gmail.com>
Date: Wed, 6 Aug 2025 15:49:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] kasan/um: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, zhangqing@loongson.cn,
 chenhuacai@loongson.cn, trishalfonso@google.com, davidgow@google.com,
 glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-7-snovitoll@gmail.com>
 <60895f3d-abe2-4fc3-afc3-176a188f06d4@gmail.com>
 <CACzwLxhs+Rt9-q6tKi3Kvu7HpZ2VgZAc4XEXZ4MEB60UbFjDKg@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CACzwLxhs+Rt9-q6tKi3Kvu7HpZ2VgZAc4XEXZ4MEB60UbFjDKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_065012_463892_358586A6 
X-CRM114-Status: GOOD (  18.11  )
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



On 8/6/25 6:35 AM, Sabyrzhan Tasbolatov wrote:
> On Tue, Aug 5, 2025 at 10:19 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>
>>
>> On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
>>>
>>> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
>>> index 9083bfdb773..8d14c8fc2cd 100644
>>> --- a/arch/um/Kconfig
>>> +++ b/arch/um/Kconfig
>>> @@ -5,6 +5,7 @@ menu "UML-specific options"
>>>  config UML
>>>       bool
>>>       default y
>>> +     select ARCH_DEFER_KASAN
>>
>> select ARCH_DEFER_KASAN if STATIC_LINK
> 
> As pointed out in commit 5b301409e8bc("UML: add support for KASAN
> under x86_64"),
> 
> : Also note that, while UML supports both KASAN in inline mode
> (CONFIG_KASAN_INLINE)
> : and static linking (CONFIG_STATIC_LINK), it does not support both at
> the same time.
> 
> I've tested that for UML,
> ARCH_DEFER_KASAN works if STATIC_LINK && KASAN_OUTLINE
> ARCH_DEFER_KASAN works if KASAN_INLINE && !STATIC_LINK
> 
> ARCH_DEFER_KASAN if STATIC_LINK, and KASAN_INLINE=y by default from defconfig
> crashes with SEGFAULT here (I didn't understand what it is, I think
> the main() constructors
> is not prepared in UML):
> 
>  ► 0       0x609d6f87 strlen+43
>    1       0x60a20db0 _dl_new_object+48
>    2       0x60a24627 _dl_non_dynamic_init+103
>    3       0x60a25f9a __libc_init_first+42
>    4       0x609eb6b2 __libc_start_main_impl+2434
>    5       0x6004a025 _start+37
> 

No surprise here, kasan_arch_is_ready() or ARCH_DEFER_KASAN doesn't work with KASAN_INLINE=y
This configuration combination (STATIC_LINK + KASAN_INLINE) wasn't possible before:

#ifndef kasan_arch_is_ready
static inline bool kasan_arch_is_ready(void)   { return true; }
#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
#error kasan_arch_is_ready only works in KASAN generic outline mode!
#endif



> Since this is the case only for UML, AFAIU, I don't think we want to change
> conditions in lib/Kconfig.kasan. Shall I leave UML Kconfig as it is? e.g.
> 
> select ARCH_DEFER_KASAN
> 

No, this should have if STATIC_LINK


