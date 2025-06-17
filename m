Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B9EC71136
	for <linux-um@archiver.kernel.org>; Tue, 17 Jun 2025 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IpyRO35mdNeXwjpxX8WgCP2jvjoVuRIOBEbtU0BIjNU=; b=vWeLFVKdsxMRjJVkY6to3UCsXW
	yWl/xt3AJoRW4KLOWg9F7E77D4tAK+wOeZ5VkF70H6l0dNUzid6dXDPK2yKIy8yL4VcpDDZZFnZjV
	Tya1C/gi4K1UXvu/HtIydUtsdZnrvrhvjONM0GsMga47Yzj2nJEhaeJPyrbR/to+0PFw+hrjJZ0tZ
	utHorNg+FHmkwpftyUh7bNMuJVQd/qPY5b/pzFyBiu7fjTPMeMpNxIDGvPQNtu4j6Z/9+bf9EE59C
	93EmNDMTbDdIqFZ6FY9epvEX2TR4goQnVa8l223FEJxYesQzZofY6uqIqMQGR59vT1FzzAxjSbTrv
	n0t222AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRTpr-00000006xPZ-162v;
	Tue, 17 Jun 2025 10:46:35 +0000
Received: from mail-vk1-f170.google.com ([209.85.221.170])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRSgS-00000006lVT-2PZS
	for linux-um@lists.infradead.org;
	Tue, 17 Jun 2025 09:32:49 +0000
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5316a5e4c6cso519423e0c.1
        for <linux-um@lists.infradead.org>; Tue, 17 Jun 2025 02:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152766; x=1750757566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpyRO35mdNeXwjpxX8WgCP2jvjoVuRIOBEbtU0BIjNU=;
        b=ULQ5nmfvMaBNzNNQOWNE9t724oCjHxtAhNnRC+mAGMkDaEwsxdeYaeGtWajnZPmAYy
         zcl1vep5gQjwpyflED3GfmVnV+JlepIeDTX6vvB+iezpLMc1mp1vJVqRewRUcrfZZDvd
         CP0VTqA9O3eOoJSaTWvzcksdbFpDZsncq3pGmLOX4jsm5ITZKZBBlNuEIPjNC+Wq0U1Y
         XzDF3oTYzQ3hr22+Bs6MO4egxCYzVXHfJqDWCtYF02mzCCkWKKWOr+6FEV48zRhJBaez
         vxF3b2SsTC8ZUlKtOEdBM1eBCNNqmWZDCdczPA5Mk4Sdi/xmyPIyt8JeexbCTNbjLxqs
         CVOw==
X-Forwarded-Encrypted: i=1; AJvYcCUBbzqXVBF4saw55HMn2w567L/Jh4k5aaA1/EAl+AoRRGwgj6rMXjdaqqX5l4152F+6joxPduQg7g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxNZzeUqfVKMjQGekmDKFxtjAw2+Ul98cmjusEXS5qk6HC8E1ru
	XnVjPbpFtGiPBFdZ8hUcREH8hTnVQHG17KRpIebAijRVWNgpIe/6D6rBaypoDroI
X-Gm-Gg: ASbGnctJULhZvLRaqhOEjdDT7DFTbnUSI7rdvwUmPYqVDVkFQEd59OSw5stwjYMKxve
	gk/ARMjASFyXm7jOWsAwdvTtfOYun+HcQEHM250F8ItzaK8LYGoY7AIeT7D0pOPJt/hOBygOfeX
	wXMjidXdCQnAZTxxzNfEN+GKmcEoG0UFmWOJau3Y0fP57N6J9CxQdVXngSvBBNfl4L8xdl8ImMJ
	D2S+kY0TBr8W+LfSLD/c5qVjhHMjuBPgYILWnF7q4cnvdwFocikXu6TEzAe+ewNVvi4/Flq5Hfg
	1qA7DjwqDUAE1RXN/r0O/D87xKA5S08NC54+fjLzZrydnVIoVCchxQ302+vGGs1wng8tlnL+IUb
	A91ILa5vx2dfANFdB2zRBTp5lWiBzXGEyGGBkdig=
X-Google-Smtp-Source: AGHT+IE3Ibm+0hueHs+awgihdmycm1vS7wtkZSnUOluLhOxXqlEnCv/fc/LvH6qLfSRbR34AxnT7+A==
X-Received: by 2002:a05:6122:547:b0:529:2644:8c with SMTP id 71dfb90a1353d-531497d3ee3mr7253865e0c.8.1750152766262;
        Tue, 17 Jun 2025 02:32:46 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5313e028cacsm1550198e0c.34.2025.06.17.02.32.45
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:32:45 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-53167fb5690so537990e0c.3
        for <linux-um@lists.infradead.org>; Tue, 17 Jun 2025 02:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQmAHLJU6A0kdb6VB9ZALnBk1iIoos0/l0+VR8jQyi3Pm5GIYSAkajZJFuwDM04MHVdtv1n4ST7Q==@lists.infradead.org
X-Received: by 2002:a05:6122:547:b0:529:2644:8c with SMTP id
 71dfb90a1353d-531497d3ee3mr7253853e0c.8.1750152765304; Tue, 17 Jun 2025
 02:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-7-f427c743dda0@suse.com> <aFAkD2i0ceH6qYQz@pathway.suse.cz>
In-Reply-To: <aFAkD2i0ceH6qYQz@pathway.suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Jun 2025 11:32:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXN4Xf1o03cYU3ug_gRdFtBXJC5Nvvt9U6UeP=U2AQTTA@mail.gmail.com>
X-Gm-Features: AX0GCFtvZQSD4F-97UDxOqiDqN4VEggSrDhztYpPcqEOiEQEvpc1f_0ccYJ9a2M
Message-ID: <CAMuHMdXN4Xf1o03cYU3ug_gRdFtBXJC5Nvvt9U6UeP=U2AQTTA@mail.gmail.com>
Subject: Re: [PATCH 7/7] printk: Don't check for CON_ENABLED on console_unblank
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_023248_617355_59594872 
X-CRM114-Status: GOOD (  25.67  )
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

Hi Petr,

On Mon, 16 Jun 2025 at 17:27, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2025-06-06 23:53:49, Marcos Paulo de Souza wrote:
> > All consoles found on for_each_console_srcu are registered, meaning that all of
> > them are already CON_ENABLEDed.
> >
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  kernel/printk/printk.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 658acf92aa3d2a3d1e294b7e17e5ee96d8169afe..8074a0f73691cfc5f637361048097ace1545c7c0 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3360,7 +3360,7 @@ void console_unblank(void)
> >               if (flags & CON_SUSPENDED)
> >                       continue;
> >
> > -             if ((flags & CON_ENABLED) && c->unblank) {
> > +             if (c->unblank) {
>
> It might actually make sense to check is_console_usable() here.

My first thought was: one more to convert to a better name!
But the actual function is already called console_is_usable() ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

