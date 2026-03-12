Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181C1105A594
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ky7U0hmCeNi6OyUrf2MxogfDAlaxZWXxIQIvc2Y9k8Y=; b=kXuRM6nnpjVJu/LCCm7tjBO/YP
	T5tUz7B4qrPSjrMP9GBExLk/pRkb3ANM0jaOOAVsvqk0GN94pLnsUXMlwRjwomp5WG4AVjDUL5wEV
	g3UnpdS3ZOV7pAthjNj7BByBWQIOU0O5PR/2ptJoCICi7PU0YtLwz7aUAouBQKHosBoOotUQ0IcGE
	2RV8ji+FkMNNu5MFx7FizTGTOkmRFwZC9GCBph2GX5EfMBut4dxNrYAL6JvW2ilusRGppkD7LlJCM
	qjr2iPGfjzVNxOZvuO+Gge9aOb0IfwEyjdEC1x2WQVkLQwc9pSLGNWND1VmxMch4Iu1JHeh6fE5tX
	auCFYcqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0fY2-0000000E51k-2iuX;
	Thu, 12 Mar 2026 12:53:54 +0000
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0fXu-0000000E4yw-3e8X
	for linux-um@lists.infradead.org;
	Thu, 12 Mar 2026 12:53:49 +0000
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-4043b27ddeaso637494fac.1
        for <linux-um@lists.infradead.org>; Thu, 12 Mar 2026 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1773320025; x=1773924825; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ky7U0hmCeNi6OyUrf2MxogfDAlaxZWXxIQIvc2Y9k8Y=;
        b=PqKx9b8gCq1X4S5smoMl8y9rJhMPkJWPaAbrXVvWDmsnPs4tUnMako8OB+pUeId1eE
         7hVu8O6udJf/FOiFcNn6OdZCI8Th2KAKOAL5GscD75vh8H7wtOEo0rmv2MdsnaurOhb9
         kJr22L1Nxjw8UCfTn82G0B0lz8su5MWy68nURKKpNkryEhavSRp+MTJqzxHdUYOqp8WE
         XvVwwrsBIgu9NwNkHo1j+RBY1dRr3WOuV8f0ixBnXPZQFboAsPsITPzw2++37PjR1uqN
         zzuiW3E932+orTLSpT8roXMh5IpJW+LAIZ/IqDzSWKjrUCHMD9gImWCgOWF1yi+2sCJM
         wFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320025; x=1773924825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky7U0hmCeNi6OyUrf2MxogfDAlaxZWXxIQIvc2Y9k8Y=;
        b=a8UIW2to6q/Muq2G1OY/1AgqGujHNjMhIHB9FnT3DqiThkEm/ZFBkvN0/NRIgNcCxX
         YcbNv4g5Woxg0bio6PpISYliPdAX0P4FoDN4ADaQFD/sZo0QzXciwfgCz2vnU9wkXKiA
         5YBgFMxvlI519CmD6515XmUcC6zd/pR14ErJximQcBkV7Labe8IUVWXDhv5KpWElPzgs
         AOLfKawOM9EI72F6Dyg29hwAvQIp9q7vfXgtWha2AXAmvLlQncoguSkZByEpwo6ZWfUW
         SR2mIXe/axPfjt5bIFw1QUDewETLNeYydAOgwHeuIvYvHeHb+OD0TzdGzTu/exEn6zk8
         khfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmxfU2po5HrI02hrFduOB+Y11YWdNLBG+Yn06Ndyi7b6myVUm4kRGke2zoAyDq/2zrxwSkU2zoiw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzh1U4AAFw1sYIbIxplWA/Un0pCNtn2Gp0hu62LPp0nZqzEhqEt
	ZmYvI+YQkdETOohDhy5IKrjfdLWZJvCVKTTt0gNpfH3D2XwT4yrTNYeufgFYclW40rA=
X-Gm-Gg: ATEYQzxiQK2TZjW6fTV7xgW/hk5i0XhTRfjtnKwmkggCWTA+flXhpZ/0h3V7loU6vrw
	WcZWu1slJQzIQZO9VAn3DxLE2XeWim0bI6h3izUcZ76wLI8boIMrtK7pJjgPWyoxJLi+4kNFwjZ
	m4fQz4AYYS4L30H5Gihd9nrUDNXmB7BoC9CapfMVLLRWktqx4QkpXdoeQQiM6O/FLdkc4K0o3Nu
	UAvWXlpMdDS0/x37Kx+yaUDGQ0LPhXs50dDgyP6HL21vX/dEkdSPOlb7QWGh61EXqD/gsTTlHho
	fuU04LCnTWWUbBtkYFEuSI1sqw5JUmahzkI303iiT11nx60ipykdarLeNXtakoAShVx060kbiSH
	l4TTopWQVglBK+H64YqxV6c1C85lwkyY2LvxAVgFncEbgn5O9vVgyHAL0MhO7Wvch4/U265g8tN
	rO8NHlkScuXCB/hJ+8yQWTf7DCEPhlUkrbLHUmdwo=
X-Received: by 2002:a05:6870:649f:b0:409:74c7:1cbb with SMTP id 586e51a60fabf-4177c6f1d08mr3392540fac.7.1773320024820;
        Thu, 12 Mar 2026 05:53:44 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.103.0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41791432d87sm3765785fac.1.2026.03.12.05.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:53:44 -0700 (PDT)
Message-ID: <f7054184-dca2-4c7c-9e2e-4a5e3e1c81da@sifive.com>
Date: Thu, 12 Mar 2026 07:53:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/15] mm/kasan: add document into
 kernel-parameters.txt
To: Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
 glider@google.com, dvyukov@google.com, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, chris@zankel.net,
 jcmvbkbc@gmail.com, linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-15-bhe@redhat.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260225081412.76502-15-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_055346_951386_CBEC47C6 
X-CRM114-Status: GOOD (  16.07  )
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

Hi Baoquan,

On 2026-02-25 2:14 AM, Baoquan He wrote:
> And also remove the relevant description in dev-tools/kasan.rst
> which is hw_tags specificially.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
>  Documentation/dev-tools/kasan.rst               | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb850e5290c2..e0115fad9e60 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2899,6 +2899,10 @@ Kernel parameters
>  	js=		[HW,JOY] Analog joystick
>  			See Documentation/input/joydev/joystick.rst.
>  
> +	kasan=		[KNL] controls whether KASAN is enabled.
> +			Format: off | on
> +			default: on
> +
>  	kasan_multi_shot
>  			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
>  			report on every invalid memory access. Without this
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index a034700da7c4..eaae83fcb5e4 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -129,8 +129,6 @@ Hardware Tag-Based KASAN mode is intended for use in production as a security
>  mitigation. Therefore, it supports additional boot parameters that allow
>  disabling KASAN altogether or controlling its features:

The sentence above is now incorrect as well. I would recommend documenting the
parameter earlier in the "Boot parameters" section instead of removing it from
this document entirely.

Regards,
Samuel

>  
> -- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
> -
>  - ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
>    is configured in synchronous, asynchronous or asymmetric mode of
>    execution (default: ``sync``).


