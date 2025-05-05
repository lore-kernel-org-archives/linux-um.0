Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF549C3ABB6
	for <linux-um@archiver.kernel.org>; Mon,  5 May 2025 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f48gWfoQB8f6PR0QJ9Ho7JKsKFI+7uY2kvsnaTG46II=; b=POq3MnDoWYP6bvAt8OeFTgG3/A
	pVJSAp1kXIK3pFvtVitFpfA/KbJvN7/rVguRjUGbR/INK3BuKZ6WTnRuSQ+W/zKhAb1Xh0YhpmXle
	eE7q14eNeh4Vk5ulT7eokKjbdkPGzA0uhws5uAvQFQn5WNKZQUrskcO9io0UEeCGoqWunqvRF6A6Q
	+nI/BIbe8ynBSC/8ImWe0O9Qla0el8vqVz3h9oG4N5kMnepEG0iHdz9q2OM1iltZl7g98fx7fHigU
	At4vCY2GyZsnIpW0dcVksXmzYm8RmtGvRW9oi8+oolj9xG5eDQQZua+k4Fc7Ohxde8O2yNEE4wUjt
	p+jwoizQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrsX-00000006sen-0DS9;
	Mon, 05 May 2025 09:12:49 +0000
Received: from mail-vs1-f43.google.com ([209.85.217.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrsT-00000006sdl-2DAf
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 09:12:48 +0000
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4c326617e6cso1105164137.1
        for <linux-um@lists.infradead.org>; Mon, 05 May 2025 02:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436363; x=1747041163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f48gWfoQB8f6PR0QJ9Ho7JKsKFI+7uY2kvsnaTG46II=;
        b=u5FgNpqlSauNig92B3vV+s9ynUwzb0+Cyb9cz1BcYokERfSDxQYi+nEly58XmxLhCx
         XmdxPBFVbWdCPoTlNTeJgg+Yx9oWbpB63zer0yHqEdSW/xPckfWUNgg5DQAWNCrf6OJR
         UwHgcZeI7atD2mgtJg5k1lLNixb3/ovc6SN+d0OBqonRdkacTvmICRvZ4rA/fUIuFp/I
         QtIBbNFUUyccCH471VU82shVdoW6+PX/7qGmEolIq1FyigSd27tezk7G3ePT/Wwp53sE
         JRp8fVHbLP76mWXcbeOu3XlmQ5zVS5pVI4+r3KHKDGqtVsbnTQ5WFGtSSSS3MnIMayp5
         JB4A==
X-Forwarded-Encrypted: i=1; AJvYcCXzfnCs+CTD07bY13bYoGSur1Fcc2NOUva9BRsX4nasf5051UaAbLfF5Qdpt/6PkPwEcW5ZptHYdg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxdVWQATkJkF1e+SqrJllIEdl/EIUa6OLpXld+JOJsR38jXXwLs
	FApV00v9pBJpNO10l+qw/+ES6IxdcRY7CzR1M17xRjBnqGoFq1YoUMLwxWtP
X-Gm-Gg: ASbGncsV9LLNCKNr55oiZpqW6b7d0pl5sdSaWSRiMbHJE4pPbCmSxOeM/Vn/2t0UMXW
	nmUXwn167gw8FSX+4QpnPmL0g0Fuf30eW5WD3OSq5j1ya/ovMM4dczjV9FfrDpNNilCf/PQOEMI
	gd704qzKF4Ir0+U1ldJcJQbMn2h/rXm8pAKUT4Y9Gzzmj8jaGJaE4UwGRid1764nfquxI4SD5x5
	aq0f+rPEffgn908cQ9fjEeQGyx/N8P2/OC86136j4RyrtES8e/E4TLXsp4KxYCiacRazHYjVFyL
	Es1YGdk+XCdQDpoK6EyhkqId7zxLddpmAkgResTSfUvBAQ+tJKO6sk/i2EVj7Y9wrtKmQGNp9+R
	6tX4=
X-Google-Smtp-Source: AGHT+IFGNq7xSJDhydo2et6E0gFvDgR6gtnsKQS9b3Ev1bHxpJnuNuOaXmWr3o0roeIZiEeJAPPXsw==
X-Received: by 2002:a05:6102:3c82:b0:4da:e6e1:c3ee with SMTP id ada2fe7eead31-4db1475a896mr2836625137.2.1746436363426;
        Mon, 05 May 2025 02:12:43 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8780af50ec4sm1279349241.0.2025.05.05.02.12.43
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 02:12:43 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86fbc8717fcso985828241.2
        for <linux-um@lists.infradead.org>; Mon, 05 May 2025 02:12:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTNN4EzA3JRtXvBWZfdlvXtFerPIU6+KZfI/s4XPgxmE/9DaOKHFrVB8NKUAKNru27gL0EoyM87A==@lists.infradead.org
X-Received: by 2002:a05:6102:5681:b0:4c5:1c0b:4ee9 with SMTP id
 ada2fe7eead31-4db149206bcmr2629907137.22.1746436363016; Mon, 05 May 2025
 02:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250503051710.3286595-1-tiwei.btw@antgroup.com> <20250503051710.3286595-3-tiwei.btw@antgroup.com>
In-Reply-To: <20250503051710.3286595-3-tiwei.btw@antgroup.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 May 2025 11:12:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0Zc91nTtH7MPn5bSfV4AuZOrsNshFGYjKzsyRRdr0bw@mail.gmail.com>
X-Gm-Features: ATxdqUH5jafmpPjrE9cD7-qU8XL0Y2R638IZjPqxnuyc6iXj3WJ_Kh7WTgozKSA
Message-ID: <CAMuHMdX0Zc91nTtH7MPn5bSfV4AuZOrsNshFGYjKzsyRRdr0bw@mail.gmail.com>
Subject: Re: [PATCH 2/3] um: vector: Eliminate the dependency on uml_net
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_021245_564126_02FB1F25 
X-CRM114-Status: GOOD (  25.95  )
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

Hi Tiwel,

On Sat, 3 May 2025 at 07:17, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
> The only dependency on uml_net (i.e., the legacy network transport
> infrastructure) is the call to uml_net_setup_etheraddr(). Implement
> it inside vector to eliminate the uml_net dependency completely. It
> will allow us to remove uml_net in the next step.
>
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>


Thanks for your patch!

> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -27,7 +27,6 @@
>  #include <init.h>
>  #include <irq_kern.h>
>  #include <irq_user.h>
> -#include <net_kern.h>
>  #include <os.h>
>  #include "mconsole_kern.h"
>  #include "vector_user.h"
> @@ -1539,7 +1538,56 @@ static void vector_timer_expire(struct timer_list *t)
>         napi_schedule(&vp->napi);
>  }
>
> +static void vector_setup_etheraddr(struct net_device *dev, char *str)
> +{
> +       u8 addr[ETH_ALEN];
> +       char *end;
> +       int i;
>
> +       if (str == NULL)
> +               goto random;
> +
> +       for (i = 0; i < 6; i++) {
> +               addr[i] = simple_strtoul(str, &end, 16);
> +               if ((end == str) ||
> +                  ((*end != ':') && (*end != ',') && (*end != '\0'))) {
> +                       printk(KERN_ERR

pr_err() (and friends, everywhere)

> +                              "setup_etheraddr: failed to parse '%s' "
> +                              "as an ethernet address\n", str);

Please don't split error messages, as it makes it harder to
grep for them (everywhere)

> +                       goto random;
> +               }
> +               str = end + 1;
> +       }

Can this use mac_pton()?

> +       if (is_multicast_ether_addr(addr)) {
> +               printk(KERN_ERR
> +                      "Attempt to assign a multicast ethernet address to a "
> +                      "device disallowed\n");
> +               goto random;
> +       }
> +       if (!is_valid_ether_addr(addr)) {
> +               printk(KERN_ERR
> +                      "Attempt to assign an invalid ethernet address to a "
> +                      "device disallowed\n");
> +               goto random;
> +       }
> +       if (!is_local_ether_addr(addr)) {
> +               printk(KERN_WARNING
> +                      "Warning: Assigning a globally valid ethernet "
> +                      "address to a device\n");
> +               printk(KERN_WARNING "You should set the 2nd rightmost bit in "
> +                      "the first byte of the MAC,\n");
> +               printk(KERN_WARNING "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
> +                      addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
> +                      addr[5]);

Perhaps make a copy of addr[] with the bit set, so you can use %pM?

> +       }
> +       eth_hw_addr_set(dev, addr);
> +       return;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

