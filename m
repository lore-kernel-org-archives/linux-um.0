Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1490CC677C4
	for <linux-um@archiver.kernel.org>; Wed, 11 Jun 2025 00:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mtgyGRFsx3W1moknyTRh8eklG3kKIqbE5e8lYnyeAfo=; b=LmNt01gA+ztioUhqeu6/RqjYq2
	EPlPTj6dxAlYFSuOlbyYvTJPmh0B78eFTkxIy/SPMKrTmSb6Jecpy4g/BBfVl7B5iXRWtpFz+3A2k
	W2OInJcR2K71q4F2iNHzt9iyMf4PEjAKdxfJD0S94D1ii4OOA1CW5784J88Lh85Vcsr/tBsnBsH2C
	IvfHnrhV1O5rh0XapqioflI5KUcTHrwLIanWfvkCy6pO8mk6ldye7a8gsleSR0aPISmNFN2IBeXB1
	F6pcEpnZVWhlBlLxXIOVFdmSoS65/JpcTr37MjPetVpFZHyy9JM7RRqWPRnlKLqjSj1EAVxl6ZSNm
	jHKAls2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP9G4-00000008TWC-07JB;
	Wed, 11 Jun 2025 00:24:00 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP8Et-00000008NUc-0Pqe
	for linux-um@lists.infradead.org;
	Tue, 10 Jun 2025 23:18:44 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2363e973db1so2788385ad.0
        for <linux-um@lists.infradead.org>; Tue, 10 Jun 2025 16:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749597518; x=1750202318; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtgyGRFsx3W1moknyTRh8eklG3kKIqbE5e8lYnyeAfo=;
        b=hYaB/V5+M7V8V+aA5mzcccv29/JUmA2BOEAhBQQ+GXT4Ef0n/0V/A9BdNJ0kEklkd6
         hhcFJxh8g5lbQEXxwwJqZOextfWAVMKKy6q1XP7NH+Sym+u8qyC5RLfmA/000k4w856x
         LWtoH1YnCfIvtVZOvwwl8S4BEsba4Cb0VqIe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749597518; x=1750202318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtgyGRFsx3W1moknyTRh8eklG3kKIqbE5e8lYnyeAfo=;
        b=qV04ebVrLEdsr+LS+u2yKt6t24rt+V7vb1FdcL9uJO21HMYULY9OUbmo6snLn7eJI8
         VRd2YU1MXxw//ugnWtM2uX/XcSSRCHiF0Rw5nNnfv0ohKHrez5UOopNrKU0jInGp5fLH
         CaUOr6dEJFKcchZOFu+sGvMj6VpuJuBmy/pTjdmfpdZxXE3aTaS2kAnHTqwmHWX6z8Eo
         A+H/K8PE3lkSp2Gb+YS/GTh0zopNrlsHCFnO6TCzOx+zelkLxm7LJynOQcwbChctUAx4
         5R4eGYUkQ23DzCdYfiQo9UaweXu15Ih5HOs7Cl2To0dSGU+TgFbRzMiCbj1jIL22sMxq
         9p1w==
X-Forwarded-Encrypted: i=1; AJvYcCX+eAvzuawSdFfwEeJLx/8t7fcH70FjyLE9IKEGKm8DL8pN20XVG0ausbtCnBlyHFMQdUS4QHsFVg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxPJ+dM3C+U4MIQMpLhCavUWKiOTDB5FcLaaUg8tEn8xNbZjYtm
	hleEotmVV84YSgK/ypi+DHZ61zpfVSRx+72Ff8maA8qfUcpsse40taOt8kcDVUSMqcuo22vyd2T
	thhc=
X-Gm-Gg: ASbGncsqt+pRtX0uzHIgWbf+KdaUoII9Ko/SXtt/VWJ80QAL+cCyPVe6HbGfTxFoX+f
	SpWxWVX6mcrg62NPKHjhjbpLLFkGsMKvb0abUaTTdpu+73LmJCg41VSQObL8XuVyUYWiMeD2hVa
	H+D6rG5pW8BycLzqFGSR2YxmY2pGX+BWXsUGRZsslTy6Pz/Kfiy43OQj4NqACGkc5URpS97i20e
	wNlrdfB2pa20Nn3BspRC9KFD/CGL4NlkiOBNmtoD9K7wWYpaZuYD26omeQcV33sZt3UsL1bwf4V
	lK243EXhQPnaC/lOKI7V6uQo+Nm8joRoeRG/P8qPwlygGwVGNA4FithcQikPoEN6wEvU/z2e7PO
	psC7wTBaI0HoKbm1+HuM9jpWHB/8GFA==
X-Google-Smtp-Source: AGHT+IE3v6LYFx1SoIADJFwcMBBGazlkR8HzeH38poEhgQ6gVhjY2BZg6qM9pBLSzRUUVTrSgvG+GQ==
X-Received: by 2002:a17:903:288:b0:215:b1e3:c051 with SMTP id d9443c01a7336-236416d6006mr14425805ad.11.1749597518288;
        Tue, 10 Jun 2025 16:18:38 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030789c2sm76031265ad.29.2025.06.10.16.18.36
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 16:18:36 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2fb8226e1cso340236a12.0
        for <linux-um@lists.infradead.org>; Tue, 10 Jun 2025 16:18:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoEjUP/BXz1NtKdieV/u/pR7yYC9Cx5yP8P4vjRSebiZuHNdK6U/aEAfmXC9jV+VhTE2jWGQVuxA==@lists.infradead.org
X-Received: by 2002:a17:90b:3908:b0:311:ab20:1591 with SMTP id
 98e67ed59e1d1-313af9711a2mr1450240a91.15.1749597515737; Tue, 10 Jun 2025
 16:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com> <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
In-Reply-To: <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Jun 2025 16:18:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
X-Gm-Features: AX0GCFt6n77pbmil8IDH9ETyvVBk9GLYcHe7RwT91u86Q2sJf5v-ZMY6TwpptAA
Message-ID: <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
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
X-CRM114-CacheID: sfid-20250610_161843_168296_3760CA2D 
X-CRM114-Status: GOOD (  41.93  )
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

On Tue, Jun 10, 2025 at 1:03=E2=80=AFPM Marcos Paulo de Souza
<mpdesouza@suse.com> wrote:
>
> On Mon, 2025-06-09 at 13:13 -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jun 6, 2025 at 7:54=E2=80=AFPM Marcos Paulo de Souza
> > <mpdesouza@suse.com> wrote:
> > >
> > > All consoles found on for_each_console are registered, meaning that
> > > all of
> > > them are CON_ENABLED. The code tries to find an active console, so
> > > check if the
> > > console is not suspended instead.
> > >
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > ---
> > >  drivers/tty/serial/kgdboc.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/kgdboc.c
> > > b/drivers/tty/serial/kgdboc.c
> > > index
> > > 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b
> > > 006b2923583a0d2 100644
> > > --- a/drivers/tty/serial/kgdboc.c
> > > +++ b/drivers/tty/serial/kgdboc.c
> > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > > *opt)
> > >         console_list_lock();
> > >         for_each_console(con) {
> > >                 if (con->write && con->read &&
> > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > > +                   (con->flags & CON_BOOT) &&
> > > +                   ((con->flags & CON_SUSPENDED) =3D=3D 0) &&
> >
> > I haven't tried running the code, so I could easily be mistaken,
> > but...
> >
> > ...the above doesn't seem like the correct conversion. The old
> > expression was:
> >
> > (con->flags & (CON_BOOT | CON_ENABLED))
> >
> > That would evaluate to non-zero (true) if the console was _either_
> > "boot" or "enabled".
> >
> > The new expression is is:
> >
> > (con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) =3D=3D 0)
> >
> > That's only true if the console is _both_ "boot" and "not suspended".
>
> My idea here was that the users of for_each_console would find the
> first available console, and by available I would expect them to be
> usable. In this case, is there any value for kgdboc to use a console
> that is suspended? Would it work in this case?
>
> I never really used kgdboc, but only checking if the console was
> enabled (which it's always the case here) was something that needed to
> be fixed.
>
> Maybe I'm missing something here as well, so please let me know if I
> should remove the new check.

So it's been 5 years since I wrote the code, but reading that I was
checking for:

  (con->flags & (CON_BOOT | CON_ENABLED))

Makes me believe that this was the case when I wrote the code:
1. Early boot consoles (earlycon) were not marked as CON_ENABLED but
were instead marked as CON_BOOT.
2. Once consoles became non-early they were moved to CON_ENABLED.

...and the code was basically looking for any consoles with a matching
name that were either boot consoles or normal/enabled consoles.

Is that a plausible theory? It's also possible that I just was
confused when I code things up and that I really meant to write:

((con->flags & (CON_BOOT | CON_ENABLED)) =3D=3D (CON_BOOT | CON_ENABLED))

...AKA that I wanted consoles that were BOOT _and_ ENABLED.

In any case, I booted up the current mainline and I put a printout here. I =
saw:

[    0.000000] kgdboc: DOUG: console qcom_geni has flags 0x0000000f

So that means that both BOOT and ENABLED were set. That makes me feel
like it's plausible that I was confused and really meant BOOT _and_
ENABLED. I didn't spend time trying to figure out how to build/boot an
old kernel to check, though.

In any case, given my test then I think your change should be fine.
Given that it does change the boolean logic, it seems like that
deserves a mention in the commit message.

-Doug

