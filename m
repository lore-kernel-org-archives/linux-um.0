Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E0ECD37AC
	for <linux-um@archiver.kernel.org>; Fri,  8 May 2026 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1DP+JuCnIiM0V9Dxy5rK6Ns6ZckVWIlwW+CDaFwu9r8=; b=MjFaY81gVgFaoOOQpZnfMEqVm2
	4KQPYipS1yA72W9+6wV4sb1wI37rvhAdXyih6aBCSJD9OcdrWcfh7zAxXVnqrE0gerHk+KL4A5oMW
	gv0mLCS33O+n5y89BsFlMLKgbHB6e5cNft+PVDN/9AFV+76l3MHLEQJrkoz1k+UmBhxhEEu7lpByP
	1Ou3KGSrrbpBwH0ky1I1uK5Jg2v06ZD3dgqeNa28sRfwy1WBiGvqEBvqS8BtuhdXH+rExcufBoVSR
	+pnDSHwKD0gklLBkbxkzsXUmv4K7sr8vVMwyoCVBC7liUqujks5MXrQBKBQwhkzKcJXfX3lwBiSve
	7GmHqVRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOvd-0000000783A-1yh1;
	Fri, 08 May 2026 17:23:57 +0000
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOvY-000000077ys-1hRf
	for linux-um@lists.infradead.org;
	Fri, 08 May 2026 17:23:55 +0000
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-7de7dc85b74so1924064a34.2
        for <linux-um@lists.infradead.org>; Fri, 08 May 2026 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778261026; x=1778865826; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DP+JuCnIiM0V9Dxy5rK6Ns6ZckVWIlwW+CDaFwu9r8=;
        b=LyYJ4epmFjOZdJwU5+W4cn6gHF5Yf67CA/tdxKo3TEmDw4jjlrcdcIoWvMGSsfc1x6
         hQkIpiwTlVHDKAIpd4S4ae/1jz5JW4JqR1bx5BANTQ6gfw407NFwx7eYNB/+Vx4LcQXh
         cSHLw+D7X0HwfYNlLziCmCB8UypC7t4YIvutA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261026; x=1778865826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DP+JuCnIiM0V9Dxy5rK6Ns6ZckVWIlwW+CDaFwu9r8=;
        b=aOKA2O55hVZ/gamnFRdik9/iWtxS7EtLuF5ZFKP61vyLMOfLG/K3uDpueG4wiptciu
         UKHgnxmMpsQIyM5ZvLYxCN99AtqxRcA0WG+M6DkCaRLsp9vcsJLSKsfu2ImJdMjhZkau
         O2HqHxMQuExCi2syqEhTeoalUNHHrJGhNeZG8w6aFqB4A9SyJvm4Cjh2vlbFLqdjqJEB
         i0hD89BwTafA8GWu8SckSgrUfp4Igh+5Op89P4q5V/446HAe/sdtg1ztH8aXizVGrPop
         biB3v1AVBf58mPKimLbwkWRqL1MIynK2GjRME/T5Qlsvs17yYEjXLxnYSjgl1YHQvKLe
         aHQA==
X-Forwarded-Encrypted: i=1; AFNElJ+97GHpqg9G3k+HjxPAYaeFdmhewA4CkrHZ6OQvFNybi+qZw4G7Swo20OF05+OQRWVtnR81SZZHsw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOYudBvVDH6lcuU5GCqBpb1Nod36Qaj+GREVJDI9zmRe2vFY8M
	k85SDwH8/Nv+Uk1baJH1tnhxIGBjjTqL5ULcrfJxEdfnea4Ejp4YrrrBwFglyXPSciA=
X-Gm-Gg: AeBDiesuwZL14RCjspGX8F6H1ri8UOW/PoZeXHneCYk7Ae81eVUf/dPQxmnNQzLQqd3
	ZbxkScYMI77DE980KVL9p3aUoK7MWIz/UlPJVJsLm077lE51nfhsE7zaEHKJV+4yKb4aVkt/Ps0
	jVXMo5aDMkSdCAlGYsNuSVnUIwfK3I2mYKKCZJ9ThyWtvHhPsaADViT5gIEwj0JdOCDgXI/qT8T
	jRhWbKosV4ll4dDZWRgxacKU3L1Ez7kgcVY4HS05usfGNKAJOEunXBkjFm5yMfgjQsomDCPNHi7
	V6ylEKWEWD/kVONJjHwOgw4RyettHXVda6t9WOkC0b2AVC9qyDe3Bwyw2btZCYz+O29PapP/SxI
	p6amXarT7rEqESijSfFlZ500x/pdX5UoRgJArYyKHqItUZOewJthz+JB9EL/CegOqCWGeF4S2PP
	RzI4mUmrDlqh1JcOD08wwRATLRnoGXhws=
X-Received: by 2002:a05:6820:178a:b0:696:982b:1c24 with SMTP id 006d021491bc7-69998d56a5cmr7340448eaf.57.1778261025735;
        Fri, 08 May 2026 10:23:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c1a58asm1448361eaf.1.2026.05.08.10.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 10:23:45 -0700 (PDT)
Message-ID: <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
Date: Fri, 8 May 2026 11:23:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
To: Adrien Reynard <reynard.adrien.08@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "open list:KASAN" <kasan-dev@googlegroups.com>,
 "open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_102354_349713_BA744A02 
X-CRM114-Status: GOOD (  22.85  )
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

On 5/8/26 10:38, Adrien Reynard wrote:

Missing commit log

> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> ---
>   Documentation/dev-tools/kasan.rst                   | 2 +-
>   Documentation/networking/switchdev.rst              | 2 +-
>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 4968b2aa60c8..3a8bd40ad905 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -392,7 +392,7 @@ reserved to tag freed memory regions.
>   If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
>   will not be enabled. In this case, all KASAN boot parameters are ignored.
>   
> -Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
> +Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being

This is correct the way it is - no need to change this. "results in in-kernel"

>   enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
>   support MTE (but supports TBI).
>   
> diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> index 2966b7122f05..948bce44ca9b 100644
> --- a/Documentation/networking/switchdev.rst
> +++ b/Documentation/networking/switchdev.rst
> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>   monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>   bond will see its upper master change.  If that bond is moved into a bridge,
>   the bond's upper master will change.  And so on.  The driver will track such
> -movements to know what position a port is in in the overall topology by
> +movements to know what position a port is in the overall topology by

This looks fine.

>   registering for netdevice events and acting on NETDEV_CHANGEUPPER.
>   
>   L2 Forwarding Offload
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index c37e8e594d12..7b08738c30aa 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -1092,7 +1092,7 @@ be formatted as plain text.
>   
>   Developing always goes hand in hand with debugging. First of all,
>   you can always run UML under gdb and there will be a whole section
> -later on on how to do that. That, however, is not the only way to
> +later on how to do that. That, however, is not the only way to

This change is not needed. If at all add a comma after "later" to make
a distinction between the use two back to back "on"s

  "later on,"

>   debug a Linux kernel. Quite often adding tracing statements and/or
>   using UML specific approaches such as ptracing the UML kernel process
>   are significantly more informative.

With these changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

