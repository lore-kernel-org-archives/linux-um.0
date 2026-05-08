Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79190CD342F
	for <linux-um@archiver.kernel.org>; Fri,  8 May 2026 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVMKZWAk0SD1GHr6tr/9fhB28kwxhrp+So3ZgzrkNIs=; b=RyDj1meEMwj5Cn9BNE7mgefgZf
	JuPuX7KhoTWh2S/B3qOKI8s8lMKiByT1HGC/3vXCErqE9hxuirboj8J/Fsn+Y7/EEgw41uDvpIApI
	KTp3iw8y9bGbsoPx58YEL6bO5ZyI+WjN6vnipsOqOltPcZEvHkYXa5mYYHLIM8boErwUz6QyGnomP
	Fc9GIpo7Rh6uQH4pgwkLl+67zhbos8KWUgEmXbYKaI5I5RnHZsLNNENii1F5n3MCt7UjeS9HmbTHR
	CxaBo8eYyX50Ui1j2IUbWH/g85yJZV3Me1ilLbFWbe018d2hQPX6yjYIBe+he+BKi1GfO11tZbydQ
	AqQst0hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPwc-00000007GT7-2pnO;
	Fri, 08 May 2026 18:29:02 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPwZ-00000007GS9-3sUE
	for linux-um@lists.infradead.org;
	Fri, 08 May 2026 18:29:01 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso14614535e9.3
        for <linux-um@lists.infradead.org>; Fri, 08 May 2026 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778264937; x=1778869737; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVMKZWAk0SD1GHr6tr/9fhB28kwxhrp+So3ZgzrkNIs=;
        b=R6hSvTTjNcJ3u4sX0ztIbkRoUPjiB03jspB+kHRSljhFi01M3JOmrilhvwQkydCayr
         orF90r7YnwHL0XgPwvI0OC+Fs/OUHkmarfhyz7aWBsY/CilxQ+zpjZVuWnR6BQUdTEsv
         0Qnzf/LT91VBEVvthnGiVOs/9o3ApRJRzlpM5113i20UDphiy2VHSPI7unvZKJi9oDQk
         b0HJthoS8n4wKBxDmy9m09i8gVb/7PtIc2dTo+kPVoMWP1fm3ZBxDRt2F0cXfYIg0NBO
         /Z4VYWbOVLHWRj9bc/AgHWze6xRX+tj/3J08PQ7drNh1SA90niyPDLUtjD7tllMo5XW6
         A7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778264937; x=1778869737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oVMKZWAk0SD1GHr6tr/9fhB28kwxhrp+So3ZgzrkNIs=;
        b=FEdo3p3NvQAOuaINe5EspXhzhaUbN23fLFnoS77T0uOWkqUxrhQV3Dlo2vPpU0Sxqj
         XVSiFEPlxINQpr6A0TyzZ6rARgMeyzoi+wcWUI5BEIYofb9onlsYx+BlODC2LcU78qU2
         4IkG2DzfoNKweHfgX3YCZJPrcQyeecQsoKIRk1ntQdtiVlbtU0FP5Re7Tp1uzJJBAkE3
         oCOV2BCTzeztjJTBcGDZUiuEzGblMTRHeyqvsTAH6Djppdz3eEuz1ZnF9yexH68YwjT2
         GldoZtwyRujs8vhtwFGusoweNfu+PFCMhIZ+PTsZwnGCtpzoKBwu+8Dbe+atCCT2OYM6
         eDiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8w+1Ob+HPRPsFHbAi0Z+qot8/AwXHP6RypyW7SW6PCEP0gbo1SWzUQyZDZv04/9l4By+Z2Sj0/Mg==@lists.infradead.org
X-Gm-Message-State: AOJu0YydH1PiPaFI3GB3nCsaUHYBVnwaV9eIUJwAADZSMBzoTNrJPalh
	2JiIub8hXKVtOlBn0bDJUT/mXYZTtMG4efGbC4jVPc5IOYtQqupi4VqL
X-Gm-Gg: AeBDievaZPdaRohu9dt/wuXUov5jbUbsxbVP572+/twyKPnC2zVg3IEO3G+uas/CDJQ
	TbXuMbyCXSWyGomK7pf2jOzB/3mG2kbllRpYEssgT6ACguaj5vmRbRhAvy33YulDkbIFHb8Pg6d
	tEzk8r4AILb02zOP862PfzurAskyE7nhSoHYCK9j4avJNJ/yUtwy+OEnFPlilvkuJns8CMU/DOS
	x728qMRPoQfbi7A9opanr6+Mrh2Uh1IwH22c8rVLuDPk7Onck2pXontJEOm+dgRPslUHO6rIoj8
	n/mCLAx86B5AqL6i1CC7WiJ7lmQZWQKYe+S2lHxXhuy33tlPP8I4/b0czg32EDaQTRu9Utl5L7r
	+Z7m+SnLVBnP3EXPBgAdpg5tRaCN+SdhBK4yXsWmT8Zx0dy7Vpvg4OJAUtPBybnUYkP3uz/Y0Lt
	YeycdiQf89JekslarJdmq67bSh/0Y/+JZBgqO/yYRRPgvqdmqD4V95LYYGYZvhrZz7
X-Received: by 2002:a05:600c:8011:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-48e51e1a545mr213241825e9.10.1778264937224;
        Fri, 08 May 2026 11:28:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd3fd0csm10812815e9.14.2026.05.08.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:28:56 -0700 (PDT)
Date: Fri, 8 May 2026 19:28:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Adrien Reynard <reynard.adrien.08@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, kasan-dev@googlegroups.com (open
 list:KASAN), workflows@vger.kernel.org (open list:DOCUMENTATION PROCESS),
 linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list), netdev@vger.kernel.org (open
 list:NETWORKING [GENERAL]), linux-um@lists.infradead.org (open
 list:USER-MODE LINUX (UML))
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across
 documentation
Message-ID: <20260508192855.3b024c83@pumpkin>
In-Reply-To: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_112859_984959_78726834 
X-CRM114-Status: GOOD (  23.08  )
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

On Fri,  8 May 2026 18:38:03 +0200
Adrien Reynard <reynard.adrien.08@gmail.com> wrote:

Nope, all these are correct as is.
I'm not looking at any more.

> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> ---
>  Documentation/dev-tools/kasan.rst                   | 2 +-
>  Documentation/networking/switchdev.rst              | 2 +-
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 4968b2aa60c8..3a8bd40ad905 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -392,7 +392,7 @@ reserved to tag freed memory regions.
>  If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
>  will not be enabled. In this case, all KASAN boot parameters are ignored.
>  
> -Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
> +Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being
>  enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
>  support MTE (but supports TBI).
>  
> diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> index 2966b7122f05..948bce44ca9b 100644
> --- a/Documentation/networking/switchdev.rst
> +++ b/Documentation/networking/switchdev.rst
> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>  monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>  bond will see its upper master change.  If that bond is moved into a bridge,
>  the bond's upper master will change.  And so on.  The driver will track such
> -movements to know what position a port is in in the overall topology by
> +movements to know what position a port is in the overall topology by
>  registering for netdevice events and acting on NETDEV_CHANGEUPPER.
>  
>  L2 Forwarding Offload
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index c37e8e594d12..7b08738c30aa 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -1092,7 +1092,7 @@ be formatted as plain text.
>  
>  Developing always goes hand in hand with debugging. First of all,
>  you can always run UML under gdb and there will be a whole section
> -later on on how to do that. That, however, is not the only way to
> +later on how to do that. That, however, is not the only way to
>  debug a Linux kernel. Quite often adding tracing statements and/or
>  using UML specific approaches such as ptracing the UML kernel process
>  are significantly more informative.


