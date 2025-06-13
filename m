Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4D7C71136
	for <linux-um@archiver.kernel.org>; Fri, 13 Jun 2025 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oFsHs2L6+8EBoJ/ILRzyWwmWoJe5zrU0k/YrygGMeNA=; b=HnhjnaEVaJqbY6xE1LQBmFaCcs
	w10WkXSZsu2xBqcRb2AVool7YtmE6bj0eZ8calOo1vApssLuc7yXdPDhvCQPu4to14JUBMd6Frvvx
	cVgXX0j9OAQONkHb3Vm6tPB6bdB/sfluomj4eTZigqtj1L9yjCqUXirr3KIQbFonF50wTiXoThe8Z
	Cf0W25xke5zkh9x7ikhPR1OUR/01ylLxUDibuSN1oRNUuapd+InBM+WeNWhWGTXM62jgpqSyoexuL
	0aFoIb2iU0UfqbTFSHFBCbdlnz2TsIuOkyqKe3rbwQBltTdCG3kjR4URMUIBTOAzsqeoR2semYhSz
	BAKEFngw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ8ya-0000000HHtn-0uQM;
	Fri, 13 Jun 2025 18:18:04 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ7W5-0000000H4zo-0puK
	for linux-um@lists.infradead.org;
	Fri, 13 Jun 2025 16:44:34 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-b2fb8226e1cso3433641a12.0
        for <linux-um@lists.infradead.org>; Fri, 13 Jun 2025 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749833071; x=1750437871; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFsHs2L6+8EBoJ/ILRzyWwmWoJe5zrU0k/YrygGMeNA=;
        b=kXfoXCmwPtfkcGk2NI+1EKKIYEanaxSxhOX2NB0La2MSyNfgKknK6FQSuozkPuG8qg
         UWkOlNRly7NAcDuEO9+w8tXSVBUJR4j2LkxkvCTzuByOOTHq1fcdi0YBxgn1VuVD1nmZ
         ZhRYPl1N+wzQZLY84f6r1kJval7j6TfQV+WOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833071; x=1750437871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFsHs2L6+8EBoJ/ILRzyWwmWoJe5zrU0k/YrygGMeNA=;
        b=pQDk5DWHlHFwLuVNY4SeiGEdnzLANflp27ObmNknPhkXP3rTPbVNxYrNOXWipJzzaK
         EowZsi9yTnsPlQmy864Cbcr54x8KjwjtvnUSW0QkZA4FhxYAx1OvDcZFCwFjE2H+BgDh
         xXGzbmyHELGoeRa2AZkUiOugHHiNaYmg/vgSIs7miJBqYHs7XUs/1bbRpm3rM1aHHw0A
         i0dzG2pkxoGvCm5nIF5HCrEFO7MjKy0E+DbVvdliilxTCBWclwnioQMe1gbNNUBblyfG
         LPiY2oMDS1Ie6MQEfPyKHfLqlGquW7GK5Pt3/IVpKYuMiRDbUlb6DhjI22Xw3Nhgmw8W
         2c/g==
X-Forwarded-Encrypted: i=1; AJvYcCWR2354IctzcY6jMECmQG4FgszV0LdrjsmtsGZJTwcK6Dy3VeG7x8PzSwCZJG5rl/e7VyMK2T473Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJisae4cBu4hdtN3/TlmpV28CAmegyi46svaH8UJFmBmVGU3u9
	S68+pqZvtbNuBE/lqt/ZX8is/DweNnir3yJASBukt+MIy6hD7RVPHO9xAF0nL4ZTL7/7/99LW6J
	ew8I=
X-Gm-Gg: ASbGncvSMroAauTZcMu4le3slc+fIgEMTHjWEWO3kNCsJq/WhWUTjWXAShva+PJJ/B3
	gCQXNu4zcEP68+aiqVLpd4A8KTTA+pqTSemtlShPqKcvcq686LYfMJn/sdz0JxbHkNLhcA1V7L7
	tQmOVjRIhwb7F4EEGDrDlPSbZXbGUJnvDRFoQcW90VqJ1FvtCZfK/fzA4xEOK+Zmm5aP7SwJ8wu
	4XUCsw4WMrOq/GtUZrti4k7J29ti83ByCELkW98j7LlZu5xLBenA7QsAPdYrvhDDdaOEJO07Irf
	Ah2u1Qz6sprHMajTn4zQSCps4c05Ou+SGfHPx8++GaSFVpV0eU28ZYQXUDOfDChmyUXOQQLV9eZ
	xxIM6Qp46r0Sx/K+GkwKV8Sy/8ukVyQ==
X-Google-Smtp-Source: AGHT+IG+oRYxM+Qm/j3zaB5AuSTofnBV9LPWO6iMsFpuNMsIkWdIPV5IuOB5I1X/nH5Z1gvEek3hGQ==
X-Received: by 2002:a17:902:ccce:b0:234:9ef7:a189 with SMTP id d9443c01a7336-2366ae41300mr5288355ad.13.1749833071185;
        Fri, 13 Jun 2025 09:44:31 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0d0c26sm16452745ad.249.2025.06.13.09.44.29
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 09:44:30 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-236192f8770so17027175ad.0
        for <linux-um@lists.infradead.org>; Fri, 13 Jun 2025 09:44:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEG7T27ywaRJzIhotSIx/MqUiy7NR94g96mcneqNgtncrH7Bi/6TEfY1aAtMPxAeeHDtOVpYBBuA==@lists.infradead.org
X-Received: by 2002:a17:902:fc84:b0:234:9fe1:8fc6 with SMTP id
 d9443c01a7336-236678a6caamr20933585ad.18.1749833069252; Fri, 13 Jun 2025
 09:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
 <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com> <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
 <aErcrCKcsi9cpANY@pathway.suse.cz> <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>
 <aEwC81RhvveGP73Y@pathway.suse.cz>
In-Reply-To: <aEwC81RhvveGP73Y@pathway.suse.cz>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Jun 2025 09:44:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XwJ8b2Qd52dUG7DrbkVz2XdjCgXoThh2i3gi=+vGqFAw@mail.gmail.com>
X-Gm-Features: AX0GCFsbz4DtEeKeZs4XLMlp6WpvZqtedSANACGhbS0pNgSY94ZUMPk-yfpPG_M
Message-ID: <CAD=FV=XwJ8b2Qd52dUG7DrbkVz2XdjCgXoThh2i3gi=+vGqFAw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20250613_094433_273888_5031279B 
X-CRM114-Status: GOOD (  53.14  )
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

On Fri, Jun 13, 2025 at 3:52=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Thu 2025-06-12 16:16:09, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jun 12, 2025 at 6:57=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
> > >
> > > > > > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(ch=
ar
> > > > > > > *opt)
> > > > > > >         console_list_lock();
> > > > > > >         for_each_console(con) {
> > > > > > >                 if (con->write && con->read &&
> > > > > > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &=
&
> > > > > > > +                   (con->flags & CON_BOOT) &&
> > > > > > > +                   ((con->flags & CON_SUSPENDED) =3D=3D 0) &=
&
> > > > > >
> > > > > > I haven't tried running the code, so I could easily be mistaken=
,
> > > > > > but...
> > > > > >
> > > > > > ...the above doesn't seem like the correct conversion. The old
> > > > > > expression was:
> > > > > >
> > > > > > (con->flags & (CON_BOOT | CON_ENABLED))
> > > > > >
> > > It is easy to get confused by the register_console() code. And
> > > it has been even worse some years ago.
> > >
> > > Anyway, the current code sets CON_ENABLED for all registered
> > > consoles, including CON_BOOT consoles. The flag is cleared only
> > > by console_suspend()[*] or unregister_console().
> > >
> > > IMHO, kgdboc_earlycon_init() does not need to care about
> > > console_suspend() because the kernel could not be suspended
> > > during boot. Does this makes sense?
> >
> > Yeah, makes sense to me.
> >
> > > Resume:
> > >
> > > I would remove the check of CON_ENABLED or CON_SUSPENDED
> > > from kgdboc_earlycon_init() completely.
> > >
> > > IMHO, we should keep the check of CON_BOOT because we do not
> > > want to register "normal" console drivers as kgdboc_earlycon_io_ops.
> > > It is later removed by kgdboc_earlycon_deinit(). I guess
> > > that the code is not ready to handle a takeover from normal
> > > to normal (even the same) console driver.
> >
> > I'm not sure I understand your last sentence there. In general the
> > code handling all of the possible handoff (or lack of handoff) cases
> > between kgdboc_earlycon and regular kgdboc is pretty wacky. At one
> > point I thought through it all and tried to test as many scenarios as
> > I could and I seem to remember trying to model some of the behavior on
> > how earlycon worked. If something looks broken here then let me know.
>
> Later update: The code is safe. The scenario below does not exist,
>               see the "WAIT:" section below.
>
>
> I am not familiar with the kgdb init code. I thought about the
> following scenario:
>
> 1. kgdboc_earlycon_init() registers some struct console via
>
>         kgdboc_earlycon_io_ops.cons =3D con;
>         pr_info("Going to register kgdb with earlycon '%s'\n", con->name)=
;
>         if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) !=3D 0) {
>
>    and sets
>
>                 earlycon_orig_exit =3D con->exit;
>                 con->exit =3D kgdboc_earlycon_deferred_exit;
>
>
> 2. Later, configure_kgdboc() would find some "preferred" console
>    and register it via
>
>         for_each_console_srcu(cons) {
>                 int idx;
>                 if (cons->device && cons->device(cons, &idx) =3D=3D p &&
>                     idx =3D=3D tty_line) {
>                         kgdboc_io_ops.cons =3D cons;
> [...]
>         err =3D kgdb_register_io_module(&kgdboc_io_ops);
>
>    , where kgdb_register_io_module would call deinit for the
>    previously registered kgdboc_earlycon_io_ops:
>
>         if (old_dbg_io_ops) {
>                 old_dbg_io_ops->deinit();
>                 return 0;
>         }
>
>    , where kgdboc_earlycon_deinit() might call the .exit() callback
>
>                 kgdboc_earlycon_io_ops.cons->exit(kgdboc_earlycon_io_ops.=
cons);
>
>
> BANG: If both "kgdboc_earlycon_io_ops" and "kgdboc_io_ops" pointed to
>       the same struct console then this might call .exit() callback
>       for a console which is still being used.
>
>       But I am wrong, see below.
>
> WAIT:
>
> I have got all the pieces together when writing this mail).
> I see that the code is safe, namely:
>
> static void kgdboc_earlycon_deinit(void)
> {
>         if (!kgdboc_earlycon_io_ops.cons)
>                 return;
>
>         if (kgdboc_earlycon_io_ops.cons->exit =3D=3D kgdboc_earlycon_defe=
rred_exit)
>                 /*
>                  * kgdboc_earlycon is exiting but original boot console e=
xit
>                  * was never called (AKA kgdboc_earlycon_deferred_exit()
>                  * didn't ever run).  Undo our trap.
>                  */
>                 kgdboc_earlycon_io_ops.cons->exit =3D earlycon_orig_exit;
>         else if (kgdboc_earlycon_io_ops.cons->exit)
>                 /*
>                  * We skipped calling the exit() routine so we could try =
to
>                  * keep using the boot console even after it went away.  =
We're
>                  * finally done so call the function now.
>                  */
>                 kgdboc_earlycon_io_ops.cons->exit(kgdboc_earlycon_io_ops.=
cons);
>
>         kgdboc_earlycon_io_ops.cons =3D NULL;
> }
>
> It calls kgdboc_earlycon_io_ops.cons->exit() only when
> unregister_console() tried to call the original con->exit()
> which was reassigned to kgdboc_earlycon_deferred_exit()...
>
> Updated resume:
>
> It looks to me that even normal console can be used by
> kgdboc_earlycon_io_ops and we could remove even the check
> of the CON_BOOT flag.
>
> My expectation:
>
> If a "struct console" is registered then the driver is used
> by printk() and it should be safe even for kgdboc_earlycon,
> as long as it has both "con->write" and "con->read" callbacks.
>
> So the check in kgdboc_earlycon_init() might be:
>
>         for_each_console(con) {
>                 if (con->write && con->read &&
>                     (!opt || !opt[0] || strcmp(con->name, opt) =3D=3D 0))
>                         break;
>         }
>
> Heh, I hope that you were able to follow my thoughts and I did not
> create even bigger confusion.

I didn't go back to the code and trace through every step you made,
but it sounds like the code looks OK even if it's a bit convoluted
(sorry about that! at least it's commented!).

I agree with your final suggestion for the check. That has the side
effect of also being less of a change from what we had before. Because
of how the code was written before, it would have allowed any console
because it checked for "enabled or boot" and all consoles were
enabled. So just getting rid of the check for flags seems reasonable
to me.

-Doug

