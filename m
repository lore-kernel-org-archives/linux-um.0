Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DABFB5EA8
	for <linux-um@archiver.kernel.org>; Tue, 17 Mar 2026 03:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5VINWEtY9aZvz9HaKBZW/WHE45MWpLM833fNP+ydNw4=; b=s3R0Yz0VYJzAPMixWMXp2bGF9A
	bVhm3fbJMTymm9cMJ2Hv8m5cjywMD11UItilUn7IpW6rNvXX6i+EhO6uBcbIHmER2+kmQUlFIixF9
	40nBsoYvaBusemTJAqw0MnXjxZyFYOQ9h7omqBzIzMoHHSkxD9tctpMStihc+TPJ3kODmGaYDLI+Y
	7I+he+709CmJXH+z2hZJb1Nz92gVaQ42xMR/VCfwmb7+X6lkmJqfezUof2I8nZNF4AQ+2DUz5ddHH
	eUFfggpDyXeclL38ikEuIv84mYVaVMWiAifiQe4MF3XYA9k3vJ+/whApI69nKTBzZ1wzlFZi8s5ED
	hMygBBfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2LRO-00000005LVl-0J4h;
	Tue, 17 Mar 2026 03:49:58 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2LRL-00000005LUi-3pn8
	for linux-um@lists.infradead.org;
	Tue, 17 Mar 2026 03:49:57 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-41576c5c01cso3285779fac.3
        for <linux-um@lists.infradead.org>; Mon, 16 Mar 2026 20:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1773719394; x=1774324194; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VINWEtY9aZvz9HaKBZW/WHE45MWpLM833fNP+ydNw4=;
        b=lzLBcAPYnTiT1ISF0rqDLliP4H64evqAf9iCHHeKm0m8d6Le0zErv6wHYHxzN4PDyF
         18GAV7a2HgPcE1KchOu3YobuEti0IESM6xy4FpE3o+C/UZf6sxSeMurtk5osV1wGEpQz
         Qgjsy7QWHfPgb2t3dt5Eae8KrHhA3XVj9YjFkmpnTMwHnmnSK3GtVO03IAfQUUMTkfLW
         VMPiWc4o/CPLQ/pdHPaF4QuRTXuI+J7Av3sn0a0L85nZOYw1Q4H0HI+N1pHfGAWafXhe
         1nc7lKAnWiz5YTKXez3oMaeMlgazBRhOYTPidKNldzmKKwYkDcEValsKg/QbFrOy9x+H
         wLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773719394; x=1774324194;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VINWEtY9aZvz9HaKBZW/WHE45MWpLM833fNP+ydNw4=;
        b=rH7D/m23vwSOcniXmngONBVqMPZ+q6OzpmW1PztSyU2lmGHugDKWParAg0YxOeGe1E
         UtmjOkTHCRd1dphd0kcm58twGp0vSS+5OGe4Jprl29MpB8MT9/mjGMhZgjTKcy5BC2oo
         tk4+JznSQeRbNsOkhUJzA0PH5PP2Wx7Jg0Ro8ivj5Dpp0tfrdHqI3IrK42gNNdLzAMmi
         uQebc4AjAIa5E9OUjvqCcYL/yBp/vWcmASpF4LNNH7o9Ks3eSwMrOHjO82GHxOn7Jsyy
         GOH04Rzhn5oT0ZjV/z7ls7kl/BcH9nfnAJfuEbvwyeguGE8owSXLnNOPMkBkOPslDnXL
         xPfA==
X-Forwarded-Encrypted: i=1; AJvYcCXn8muxAlbHVCQGc6z/bVfmaFJgGowqQnQZQpbfnqVJ0vL7OwPZ49pKGDy9golY8lCPN3XU0SvHAg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4xDwXlsk4auiw09VXb7go5blyw/026kBRfb7B0tsKLEDAU/RS
	6Ui8jTS4G02tzt8zAxJ3xzIYWqJrx7vADEL+TAGezfx3uw4Cwuz8frKARt51+itbEBM=
X-Gm-Gg: ATEYQzxiNNm6RQNj7TgxHM93hk64WZHSq4IzmR7u1fwlDCrP814DkMgL9Q7KChHh7mr
	cwO/E4EcH7bQi60/R67j/PELCLeRZW1ngAgp0ZDRbPhmw8sjbHVK+OlbAX2gK984SZw7FL1IFxw
	484DZrJdHjOgWo4R5g4sAMlC16IK/oETYnua4aAACahlJwDNO5dGqLo9nqsJkG8d+QaPECaKDBs
	lx5FLlzoXZ8oZkAuOwZduM+KEqiH5NQAVttF+RvGIUKHCcHhr/qUzrZKZ9UTBjYVvE6RdkymMIq
	huetRxR56fwS8qVIqaIazraHHJMWvpTxVP4PlGmYi1ozHOXLnnYAw23Ua8SOL5NAhyqEa5nBTsx
	Q9+sVKgW3grFiGXT7fpfgvABAO+1yoMmtXifMZRoVNDDiP/QeFogetgUEIY5FvzmFSGOyb43Qox
	Q53qEv+HvpC/CJjcZ3LaGkwWva
X-Received: by 2002:a05:6870:d406:b0:409:74c7:1cbb with SMTP id 586e51a60fabf-417b906d206mr9213737fac.7.1773719394528;
        Mon, 16 Mar 2026 20:49:54 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.103.33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm19148337fac.16.2026.03.16.20.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 20:49:54 -0700 (PDT)
Message-ID: <da8c8b57-6d5e-461a-83b3-9339a712aca4@sifive.com>
Date: Mon, 16 Mar 2026 22:49:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/15] mm/kasan: add document into
 kernel-parameters.txt
To: Baoquan He <bhe@redhat.com>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, andreyknvl@gmail.com,
 ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 x86@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
 linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-15-bhe@redhat.com>
 <f7054184-dca2-4c7c-9e2e-4a5e3e1c81da@sifive.com> <abjMP58VdUu_eElh@fedora>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <abjMP58VdUu_eElh@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_204955_974130_643C58E9 
X-CRM114-Status: GOOD (  26.03  )
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

On 2026-03-16 10:36 PM, Baoquan He wrote:
> On 03/12/26 at 07:53am, Samuel Holland wrote:
>> Hi Baoquan,
>>
>> On 2026-02-25 2:14 AM, Baoquan He wrote:
>>> And also remove the relevant description in dev-tools/kasan.rst
>>> which is hw_tags specificially.
>>>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
>>>  Documentation/dev-tools/kasan.rst               | 2 --
>>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index cb850e5290c2..e0115fad9e60 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -2899,6 +2899,10 @@ Kernel parameters
>>>  	js=		[HW,JOY] Analog joystick
>>>  			See Documentation/input/joydev/joystick.rst.
>>>  
>>> +	kasan=		[KNL] controls whether KASAN is enabled.
>>> +			Format: off | on
>>> +			default: on
>>> +
>>>  	kasan_multi_shot
>>>  			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
>>>  			report on every invalid memory access. Without this
>>> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
>>> index a034700da7c4..eaae83fcb5e4 100644
>>> --- a/Documentation/dev-tools/kasan.rst
>>> +++ b/Documentation/dev-tools/kasan.rst
>>> @@ -129,8 +129,6 @@ Hardware Tag-Based KASAN mode is intended for use in production as a security
>>>  mitigation. Therefore, it supports additional boot parameters that allow
>>>  disabling KASAN altogether or controlling its features:
>>
>> The sentence above is now incorrect as well. I would recommend documenting the
>> parameter earlier in the "Boot parameters" section instead of removing it from
>> this document entirely.
> 
> Good catch and the suggestion is good to me. Thanks.
> 
> Is below change OK to you?
> 
> 
> From 317be48b9c1bf9d33b8d8fff5e401e3155531d81 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Tue, 17 Mar 2026 11:28:39 +0800
> Subject: [PATCH] mm/kasan: adjust documentation

I'd suggest something a bit more specific, maybe like "mm/kasan: document kasan=
for all modes".

> Content-type: text/plain
> 
> To reflect the change of kasan=on|off.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/dev-tools/kasan.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index a034700da7c4..8e65bc04dbcd 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -103,6 +103,9 @@ Boot parameters
>  KASAN is affected by the generic ``panic_on_warn`` command line parameter.
>  When it is enabled, KASAN panics the kernel after printing a bug report.
>  
> +The generic ``kasan=off`` or ``=on`` command line parameter controls
> +whether KASAN is enabled (default: ``on``).
> +

This is in the middle of paragraphs describing the fault reporting options. I'd
suggest to move it to the beginning of the section.

With those fixes, you can add

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

>  By default, KASAN prints a bug report only for the first invalid memory access.
>  With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
>  effectively disables ``panic_on_warn`` for KASAN reports.
> @@ -127,9 +130,7 @@ modes below) support altering stack trace collection behavior:
>  
>  Hardware Tag-Based KASAN mode is intended for use in production as a security
>  mitigation. Therefore, it supports additional boot parameters that allow
> -disabling KASAN altogether or controlling its features:
> -
> -- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
> +controlling its features:
>  
>  - ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
>    is configured in synchronous, asynchronous or asymmetric mode of


