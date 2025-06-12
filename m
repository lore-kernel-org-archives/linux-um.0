Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8386C71136
	for <linux-um@archiver.kernel.org>; Thu, 12 Jun 2025 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VX2tp7vE9Xc39hTYGYaV6T2gV76j7v4yp4p4MnAvSyU=; b=PiJs3PR5Ddnko5LGPFeIz16dgm
	W74cnKuhU1RwVUs3kTfSr8cG0KLlHfmwPZ6RQ2JwftqgyIy9sAC+KauX/SMOYcHGNS/AbPBqkLybw
	iYWdHz3dlWU93m/0TVdF0zxXi4nPUgBQYflxfqb58+fEQQ8vBmlXtq1mH2h9Za0uXp5zxhYHKNz/t
	pvgKPJYZd4J4luf6BU4A/HFRbuKZfDxDJQLAmiwjc9lKKDRutIUW3/au+P2XArMBUU7BddBHsSKyj
	OBuWIksy5cDNQi5rC4e0Y1U681zDOAjR5rGHFtasxE23nIaq5ew8NA/1/32TIeI8tjSBFilY4bzWT
	nTAQlWrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPr9o-0000000EqZX-3TJd;
	Thu, 12 Jun 2025 23:16:28 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPr9m-0000000EqZ9-3D9x
	for linux-um@lists.infradead.org;
	Thu, 12 Jun 2025 23:16:27 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b2f645eba5dso1999677a12.1
        for <linux-um@lists.infradead.org>; Thu, 12 Jun 2025 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749770184; x=1750374984; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VX2tp7vE9Xc39hTYGYaV6T2gV76j7v4yp4p4MnAvSyU=;
        b=KnARN+wsHu+/mDxLvYVO4Ejqn3GaI+j87Dhwwtvo8ylFrJUFD54e9NvGUAbOaLJ3FU
         8GdWLh6yX9/sfAzYzHT+cs8EreE9iBTvym5zCVejHCxzFKZ4GR7iTu53vqUfWBCAZiVm
         9C2rqCKoZaxnfpcdg2tmtENkb1AKE5vk5XyE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749770184; x=1750374984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VX2tp7vE9Xc39hTYGYaV6T2gV76j7v4yp4p4MnAvSyU=;
        b=Owni/ZHUVS22SIYsg+4DslToYTZ/j7rVEOwWLAKiqXYtopLptdHef01kgFbWKC3+qb
         rPd7YCsoZ6rtwdm+MNRG9/flf033FA/vmzMw1ne6jRXdqznWYtl74egC8FOxwfMJooO6
         uF2z7cFnoRFRj+uUMBf7R6AU7AaYhvnGEJSOhZxzQlT49oWd1ISIvxYZCq9XCFMNwrqO
         IFn9iAjLXRAOMIKb4kDuQ+NRyc9uvuyQ2mBRtRzDFbbxWhbbEcBU7wuOVks5a3wi2Krb
         gUph/JKwSGWzf+sSh3mWMlUG59k96pFaKDS7MrrbAHfgKPKIiaUdQhdlvzwCyPwUIEg+
         Glrw==
X-Forwarded-Encrypted: i=1; AJvYcCWwbdBgMFKpRoSYi/ib0A5aI/RLfJoDg3K8Kg6toK+UCAUc/ne5JlCsPSVKGeGy8RJpmLu3/ZwT2g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzLzB0P77xlP0kwtFsNzkTHEhZjxTVHH/oWSZjqNJNAM1d2cccC
	KuigBLshNPbi1rv+V1JTwzPH/d1tn0DW81o3JKxVQA1j+fGr+ZlsG3IgJ5bSmH6iQ147NeNFLHx
	LxSo=
X-Gm-Gg: ASbGncshPgxodWAn6lPiz2zOz0i6PrO2BO/5W2/K60+tUeimBGV5k7XGVxi6EdxaZv0
	LYxr4OxTt5BIbGFlnYxai++N9dVi4pUm9wqbzr4xqkpSq57/VxpXjj6525bfRXlRPuPu0VhnhPn
	T82LMb9qFFA0qiYlDxrnCK/UkI//pXA82uqeug+H01a99yxFEGubLciBvPHRCnDt/cqUG9NUV61
	EfHO6swxmBTEcEO59NUc9I2HTVSL9W0gcIY1b0DxkGmSyAKqp6byuHqnVOlFIDAuK5nD1gYjrXZ
	wlSBth9Q67kwqxi+ZDyocSom9RKmR9mHNcoVnQHFm9Pxx83fIqxN1BDohl1+grn//GA+++k0Q8N
	x+n15w4J8LyCdQTTHHdWxS5qRvZHG1edLxjc+Ehtg
X-Google-Smtp-Source: AGHT+IFPUGcdIK5LySw2M7QVfcnuBn2zCW88CeKII2JP1fQL7IvYkX0ORqypbU5vLYauul8nPU9wAw==
X-Received: by 2002:a17:90b:2248:b0:312:e73e:cded with SMTP id 98e67ed59e1d1-313dc2ba75bmr479285a91.16.1749770183646;
        Thu, 12 Jun 2025 16:16:23 -0700 (PDT)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com. [209.85.215.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c5fd7esm2068442a91.37.2025.06.12.16.16.22
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 16:16:22 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2c4476d381so1369677a12.0
        for <linux-um@lists.infradead.org>; Thu, 12 Jun 2025 16:16:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULfCI8lIaDcUZN7xnGD0eNA9sZpQXDltJBq+bGp4po0jjiO8kxPdpnxHAYJ/MoiiA8W8Krmavu1g==@lists.infradead.org
X-Received: by 2002:a17:90b:588b:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-313dc227afamr497218a91.4.1749770181738; Thu, 12 Jun 2025
 16:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
 <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com> <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
 <aErcrCKcsi9cpANY@pathway.suse.cz>
In-Reply-To: <aErcrCKcsi9cpANY@pathway.suse.cz>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Jun 2025 16:16:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>
X-Gm-Features: AX0GCFujYjZY5QQA0SHYIPZy8d0O0rad7ID3hPYo1lls7-hp2LxFCT3Du9JnL2k
Message-ID: <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_161626_822555_C18EF214 
X-CRM114-Status: GOOD (  45.19  )
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

Hi,

On Thu, Jun 12, 2025 at 6:57=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> > > > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > > > > *opt)
> > > > >         console_list_lock();
> > > > >         for_each_console(con) {
> > > > >                 if (con->write && con->read &&
> > > > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > > > > +                   (con->flags & CON_BOOT) &&
> > > > > +                   ((con->flags & CON_SUSPENDED) =3D=3D 0) &&
> > > >
> > > > I haven't tried running the code, so I could easily be mistaken,
> > > > but...
> > > >
> > > > ...the above doesn't seem like the correct conversion. The old
> > > > expression was:
> > > >
> > > > (con->flags & (CON_BOOT | CON_ENABLED))
> > > >
> > > > That would evaluate to non-zero (true) if the console was _either_
> > > > "boot" or "enabled".
> > > >
> > > > The new expression is is:
> > > >
> > > > (con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) =3D=3D 0)
> > > >
> > > > That's only true if the console is _both_ "boot" and "not suspended=
".
> > >
> > > My idea here was that the users of for_each_console would find the
> > > first available console, and by available I would expect them to be
> > > usable. In this case, is there any value for kgdboc to use a console
> > > that is suspended? Would it work in this case?
> > >
> > > I never really used kgdboc, but only checking if the console was
> > > enabled (which it's always the case here) was something that needed t=
o
> > > be fixed.
> > >
> > > Maybe I'm missing something here as well, so please let me know if I
> > > should remove the new check.
> >
> > So it's been 5 years since I wrote the code, but reading that I was
> > checking for:
> >
> >   (con->flags & (CON_BOOT | CON_ENABLED))
> >
> > Makes me believe that this was the case when I wrote the code:
> > 1. Early boot consoles (earlycon) were not marked as CON_ENABLED but
> > were instead marked as CON_BOOT.
> > 2. Once consoles became non-early they were moved to CON_ENABLED.
> >
> > ...and the code was basically looking for any consoles with a matching
> > name that were either boot consoles or normal/enabled consoles.
> >
> > Is that a plausible theory? It's also possible that I just was
> > confused when I code things up and that I really meant to write:
>
> It is easy to get confused by the register_console() code. And
> it has been even worse some years ago.
>
> Anyway, the current code sets CON_ENABLED for all registered
> consoles, including CON_BOOT consoles. The flag is cleared only
> by console_suspend()[*] or unregister_console().
>
> IMHO, kgdboc_earlycon_init() does not need to care about
> console_suspend() because the kernel could not be suspended
> during boot. Does this makes sense?

Yeah, makes sense to me.


> Also it does not need to care about unregister_console() because
> the unregistered console won't be listed by for_each_console().
>
> [*] The 1st patch in this patchset updates console_suspend()
>     to set CON_SUSPENDED instead of clearing CON_ENABLED.
>     It helps to make it clear that it is suspend-related.
>
>
> Resume:
>
> I would remove the check of CON_ENABLED or CON_SUSPENDED
> from kgdboc_earlycon_init() completely.
>
> IMHO, we should keep the check of CON_BOOT because we do not
> want to register "normal" console drivers as kgdboc_earlycon_io_ops.
> It is later removed by kgdboc_earlycon_deinit(). I guess
> that the code is not ready to handle a takeover from normal
> to normal (even the same) console driver.

I'm not sure I understand your last sentence there. In general the
code handling all of the possible handoff (or lack of handoff) cases
between kgdboc_earlycon and regular kgdboc is pretty wacky. At one
point I thought through it all and tried to test as many scenarios as
I could and I seem to remember trying to model some of the behavior on
how earlycon worked. If something looks broken here then let me know.


> To make it clear, I would use:
>
>         for_each_console(con) {
>                 if (con->write && con->read &&
>                     (con->flags & CON_BOOT) &&
>                     (!opt || !opt[0] || strcmp(con->name, opt) =3D=3D 0))
>                         break;
>         }
>
> And I would do this change as the 1st patch in the patchset
> before we change the flag modified by console_suspend().

Seems OK to me.

-Doug

