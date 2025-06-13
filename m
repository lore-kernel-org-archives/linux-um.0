Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4789C71135
	for <linux-um@archiver.kernel.org>; Fri, 13 Jun 2025 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DgWvQag2QGzdzZH71/CBz+H5MGX3oMtaddibtY3jjg8=; b=t8AG09HzDNX3nlzoe9KknGh5me
	4DNJk5n+8Lpf2eBC9kp0qICkDPCMNRLT7G9/oOUFLdJuQKeBExz9oFLb64b0oUSRuyheHEVh/MwpM
	USNR/ZT55aaOuRQLevqhu4amPD6nrrbZuLF7wrV73WiQyqPeY17twbYmMgrNpbPnbJs6gGRSjWM9t
	c3oM8LN8zDxBOf6nKJaZO+/Ga42qhHyDxMMF/9uKtZh9gtW+Ku3YXUKEeNlBoNJ+xa2/m82xcQ107
	OzJ4qFOnIk/WRiPfIa58bae9j/KHI5btUlssvAjtleF6FtcoylBJ6pTWivv5eN6sIxiTXKJ1zl3MA
	tITREANQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ2dD-0000000GC8B-0QYD;
	Fri, 13 Jun 2025 11:31:35 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ21o-0000000G7fq-423k
	for linux-um@lists.infradead.org;
	Fri, 13 Jun 2025 10:52:58 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3a522224582so1125502f8f.3
        for <linux-um@lists.infradead.org>; Fri, 13 Jun 2025 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749811975; x=1750416775; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DgWvQag2QGzdzZH71/CBz+H5MGX3oMtaddibtY3jjg8=;
        b=BE/bXp3R5iKdTWODJIdr7KhEkUZfV8vTKWuBOlN+BpQQXqavg30ZaiCkMFulO45tUF
         awCOZy1LZbD63kGjTLXGh6PkL5jTcr/DCIEn0wEytBNZOqcd4lrglb5d6X79DYnt0uQU
         XQkMoqqLEWhf24oWErFf/VjNkdiCwnj2Ftz2jlm4A1P0DP2av1VMlCQQ0cyi4HUIb+br
         Hf0+3PN9Df9YqbH2Vz+8W9eIpSMb5H6+VFvl4wMk4ttIvka9+W5mV2NqtFaX4ymQoaTQ
         +ryd/SfenbOS3GlSL8mw27OxF+AwGNrTj3N0d26VUK4DJkRAIaELYF3fS4H1wbG7BjbW
         hE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811975; x=1750416775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgWvQag2QGzdzZH71/CBz+H5MGX3oMtaddibtY3jjg8=;
        b=Wcnz7OPzG2xNy7NbwDtK1fVW2+mEaiz8gSCCskuDgWO7OtU65dL+8ug2Ms0R2rtHum
         Fmyoicggts5K28qCEveiaQ0UWGDJhv9ln+2+w8ahhF03t5czp3YLj3LJv+Ftx/Q/thUg
         ++U++owiGzAVOnTsfTA6voy+XCmMJLDkzqXMOnZo7y8kqcvTxkYAj+KIXYg+gzG4Ed2X
         BBWY5raKpc/GgPE30iQIM7eclfCZ9V5YMVgDxqv4IxS1yHZt0SGqvyiYC81BKBFXNrGl
         pCFvtgH+oXuNNg+4qwrdc32iXDOBRMFQVW7K26xC6wYGdUJEwkLXXyjA+xR9e8URXdtt
         pC2A==
X-Forwarded-Encrypted: i=1; AJvYcCVKiH7Xh0ph65rNhbiP7jxhkK0H3j4SIE+rphehuqlLyKGd0okgPIxBAh2abKEtg5WtOaYMUv+SSQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwvzcMfZfFyx9E/RdYfnRzs0ljlP+HKPlhMyYmHL8Ll83ajvMf+
	mlGzBDaI+lwxPGfNj3C/JTR6lhAAwbx33yo3asK613V7wLKpzp2+KtrEfRjY2gu0nJA=
X-Gm-Gg: ASbGncuxJGCyMSkuGP9jyBfh1F5qn2WzldD5fPcHQ2OCxERGAe3w15spd9raBCVEau3
	DAAN2Ijt1WW2H3Iq/uVZ+dLpd9tf+mNu2EKxWbWrANyUdP/9Lni4CxljYZOFxCyUwWmtJ6HzX7Q
	4iR0E4cYTi0v1ywJ7mob0kAzKT0G2B9p+ns7qvYGHZq0J1oNxgce4/FUe2t+UTQiU9zhYeMK7W+
	oNv12zdlyGwQpp2mpahLxjDfk5mVt5JPkCmAxlNlBnbWW/qms3v/e/kuNjAYQNC/Uh+qYVtz/m4
	UsS6F2kmfTDPeeEm/mUhzphrSvT5FHzTYsKvDWMXPwavltlvtGY7cFyh3reKtwTq
X-Google-Smtp-Source: AGHT+IHJOeLrZP5NvvZh4tWyIjAn3K7bzr2Vcb2r/+QXO+h/w0YFHvsR1/KLQStT6Bew+1GfqtSw2g==
X-Received: by 2002:a05:6000:2582:b0:3a4:f722:f00b with SMTP id ffacd0b85a97d-3a5686e4287mr1798399f8f.11.1749811975195;
        Fri, 13 Jun 2025 03:52:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900060c5sm1273973b3a.45.2025.06.13.03.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:52:54 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:52:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
Message-ID: <aEwC81RhvveGP73Y@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
 <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
 <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
 <aErcrCKcsi9cpANY@pathway.suse.cz>
 <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_035257_004490_D6F4011A 
X-CRM114-Status: GOOD (  40.03  )
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

On Thu 2025-06-12 16:16:09, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 12, 2025 at 6:57 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > > > > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > > > > > *opt)
> > > > > >         console_list_lock();
> > > > > >         for_each_console(con) {
> > > > > >                 if (con->write && con->read &&
> > > > > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > > > > > +                   (con->flags & CON_BOOT) &&
> > > > > > +                   ((con->flags & CON_SUSPENDED) == 0) &&
> > > > >
> > > > > I haven't tried running the code, so I could easily be mistaken,
> > > > > but...
> > > > >
> > > > > ...the above doesn't seem like the correct conversion. The old
> > > > > expression was:
> > > > >
> > > > > (con->flags & (CON_BOOT | CON_ENABLED))
> > > > >
> > It is easy to get confused by the register_console() code. And
> > it has been even worse some years ago.
> >
> > Anyway, the current code sets CON_ENABLED for all registered
> > consoles, including CON_BOOT consoles. The flag is cleared only
> > by console_suspend()[*] or unregister_console().
> >
> > IMHO, kgdboc_earlycon_init() does not need to care about
> > console_suspend() because the kernel could not be suspended
> > during boot. Does this makes sense?
> 
> Yeah, makes sense to me.
> 
> > Resume:
> >
> > I would remove the check of CON_ENABLED or CON_SUSPENDED
> > from kgdboc_earlycon_init() completely.
> >
> > IMHO, we should keep the check of CON_BOOT because we do not
> > want to register "normal" console drivers as kgdboc_earlycon_io_ops.
> > It is later removed by kgdboc_earlycon_deinit(). I guess
> > that the code is not ready to handle a takeover from normal
> > to normal (even the same) console driver.
> 
> I'm not sure I understand your last sentence there. In general the
> code handling all of the possible handoff (or lack of handoff) cases
> between kgdboc_earlycon and regular kgdboc is pretty wacky. At one
> point I thought through it all and tried to test as many scenarios as
> I could and I seem to remember trying to model some of the behavior on
> how earlycon worked. If something looks broken here then let me know.

Later update: The code is safe. The scenario below does not exist,
	      see the "WAIT:" section below.


I am not familiar with the kgdb init code. I thought about the
following scenario:

1. kgdboc_earlycon_init() registers some struct console via

	kgdboc_earlycon_io_ops.cons = con;
	pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
	if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {

   and sets

		earlycon_orig_exit = con->exit;
		con->exit = kgdboc_earlycon_deferred_exit;


2. Later, configure_kgdboc() would find some "preferred" console
   and register it via

	for_each_console_srcu(cons) {
		int idx;
		if (cons->device && cons->device(cons, &idx) == p &&
		    idx == tty_line) {
			kgdboc_io_ops.cons = cons;
[...]
	err = kgdb_register_io_module(&kgdboc_io_ops);

   , where kgdb_register_io_module would call deinit for the
   previously registered kgdboc_earlycon_io_ops:

	if (old_dbg_io_ops) {
		old_dbg_io_ops->deinit();
		return 0;
	}

   , where kgdboc_earlycon_deinit() might call the .exit() callback

		kgdboc_earlycon_io_ops.cons->exit(kgdboc_earlycon_io_ops.cons);


BANG: If both "kgdboc_earlycon_io_ops" and "kgdboc_io_ops" pointed to
      the same struct console then this might call .exit() callback
      for a console which is still being used.

      But I am wrong, see below.

WAIT:

I have got all the pieces together when writing this mail).
I see that the code is safe, namely:

static void kgdboc_earlycon_deinit(void)
{
	if (!kgdboc_earlycon_io_ops.cons)
		return;

	if (kgdboc_earlycon_io_ops.cons->exit == kgdboc_earlycon_deferred_exit)
		/*
		 * kgdboc_earlycon is exiting but original boot console exit
		 * was never called (AKA kgdboc_earlycon_deferred_exit()
		 * didn't ever run).  Undo our trap.
		 */
		kgdboc_earlycon_io_ops.cons->exit = earlycon_orig_exit;
	else if (kgdboc_earlycon_io_ops.cons->exit)
		/*
		 * We skipped calling the exit() routine so we could try to
		 * keep using the boot console even after it went away.  We're
		 * finally done so call the function now.
		 */
		kgdboc_earlycon_io_ops.cons->exit(kgdboc_earlycon_io_ops.cons);

	kgdboc_earlycon_io_ops.cons = NULL;
}

It calls kgdboc_earlycon_io_ops.cons->exit() only when
unregister_console() tried to call the original con->exit()
which was reassigned to kgdboc_earlycon_deferred_exit()...

Updated resume:

It looks to me that even normal console can be used by
kgdboc_earlycon_io_ops and we could remove even the check
of the CON_BOOT flag.

My expectation:

If a "struct console" is registered then the driver is used
by printk() and it should be safe even for kgdboc_earlycon,
as long as it has both "con->write" and "con->read" callbacks.

So the check in kgdboc_earlycon_init() might be:

	for_each_console(con) {
		if (con->write && con->read &&
		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
			break;
	}

Heh, I hope that you were able to follow my thoughts and I did not
create even bigger confusion.

Best Regards,
Petr

