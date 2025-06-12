Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB648C71136
	for <linux-um@archiver.kernel.org>; Thu, 12 Jun 2025 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWIybPnFMO+iPTF1D7X2vHTnG4Ra9zFxBSdBlVwLzyQ=; b=ZOT5rgXc9tlhZPJUZ8r2THWH6z
	ssvR+Pc6wx5wx/EWPeX3rXoKuclUsAGRFcf9pfRRAEipYZfrtIpZ5ilLz3Cijj1zDoKceM9jfRcBZ
	ItDYy1vMEt7pe4zEq3PjLRBn21vM1btIdK71GbHm7Uh/B1t6MyNMPKGTWRkPsRe/WFTkRZby/IKsv
	GUkBOU4lKfS/OQSetWjSNowBskyn/PsNotl28tJZOYnuGVp9w3o5G4nrF4xQ7CzWqoCCRAnZHU5xv
	m4NnbYP7br5liifypWLkv/a3OxV7vvOh9KlcM80d28NQA6LwMT2zrJKgMOjXrDTlr/Eu+yQvskryL
	LporDnMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPnpB-0000000EGyJ-0FGP;
	Thu, 12 Jun 2025 19:42:57 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPiQj-0000000DXnE-331C
	for linux-um@lists.infradead.org;
	Thu, 12 Jun 2025 13:57:23 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so859731f8f.1
        for <linux-um@lists.infradead.org>; Thu, 12 Jun 2025 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749736640; x=1750341440; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uWIybPnFMO+iPTF1D7X2vHTnG4Ra9zFxBSdBlVwLzyQ=;
        b=IFGFQ8QvI85gNJbQMxeJDPsQwv1qb+wiekSQd/ZncPS5M2X0+t4vSanGmbG1OGqqAR
         gUrTMbn3k7VcZuYBpjphEQxGrdInxQ8Wzerx13Etp0SWWh1lsC3pTLUWol/9xjlszUCY
         wFlqjQ+BvEmih81vwSN8U3aqcEQ5sJAEKUVAZgUVhfpVs5HQqWSG9VWK0CIflozd9xx0
         J+7nJxENuplTmv7C1Kut2Y3wF+Sn0ZEMo5QHq8+IwGsGqoRdUmOCk1haR5Abda45VptQ
         1CjsTZ+iq254bkMk6Nv01Q8lY7Lhr1loEyFSluhDAFCMY3w28RLY0dxNoeDvoc1C2jeu
         mLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749736640; x=1750341440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWIybPnFMO+iPTF1D7X2vHTnG4Ra9zFxBSdBlVwLzyQ=;
        b=Lwm/1ngRP1I4BZV9pWOPzXSRwy0NJ4hHqO0wUTFMCtehvfdeZbWbkjHryY0um+fF4L
         PnDzg2Z0kgKDPxM0fpgjDnu4/pNBrwRtuLrZqRjVOSv67SVJZxCbJb42JpxP1CZrgs/D
         AXD4U5M54Jc/nwInC1ThUkLQ16PWL1z0hnb2pfAg/XAg0dsrHaXEhtMcom4MXZ4ACJ28
         zlJUWdDZEdNnaSJhFxq68uYr8L2ccOUZi/XgWMtGnmyyjJRZUl8qfQKN2paOXtw9Bbyg
         CBnkX0wK0D0gpixY6fpw1jbOSw1X1SZoSoh79ufFwn/i0d98YLK0SD2lZd0efxAqFfoY
         aKTg==
X-Forwarded-Encrypted: i=1; AJvYcCWPKu/xEQD/S4UZ1achQYNXa8Uo4xybm/DigEF0lVKu0HyPxO5aXmAnLunl5Awp2Eml9WZ9aYqW1g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyzLIIz7NmXR2/SvFFN+eKfnopoVYqxLVaqa5c+XVLnXXDcj4I7
	MuVcb42qrLCz0fnXUIqlin6t1Bd+I30TNMqD70cq6VMeyzqrJvT5TzHURZaX4ZwUZfQ=
X-Gm-Gg: ASbGncu0xzU5AY2dg7Dui+DJ+7FOfkVLD/B/+cFpKD4PdT/eBN4I94keEGx1yaGctwb
	2K1L36B6uMzABrBDKDIkklXGXAJKNS3g9KP1lOKlqvPY9pmz0M83hyY13QzxBJ3Ds+23+7oMFcm
	VlBHWiDVC+S+3ZdiuClvTzIjc2PXkVSpYFuy4+9JCW+GdfAcX19VkMgtv2RWHOttyYtApbqLTXn
	iTtoxS7/3BWEBsjE3VhmKq9a3YMZDMunMlAjTsuMQGO+dIK40QKRlFcS/vmCuQGgEeLWIQmtUGH
	GKyp6hMiKggXqqwRTNWdKBm0Ea9r8jq1YEz+3xnYjkTGSqKpnODZtNOg7sGbKf7G
X-Google-Smtp-Source: AGHT+IHHTgsF4plb+4cSFCswnZ1BoRaKntWrXC3dKLfejS0J5Ju71cHUfrXuDzUBs/xWMfkadhCSvw==
X-Received: by 2002:a05:6000:420b:b0:3a5:52b3:103b with SMTP id ffacd0b85a97d-3a5586dce0bmr5309298f8f.4.1749736639382;
        Thu, 12 Jun 2025 06:57:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e61b65esm14131675ad.12.2025.06.12.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 06:57:18 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:57:00 +0200
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
Message-ID: <aErcrCKcsi9cpANY@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
 <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
 <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_065721_764068_65A26E7C 
X-CRM114-Status: GOOD (  47.66  )
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

On Tue 2025-06-10 16:18:22, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 10, 2025 at 1:03 PM Marcos Paulo de Souza
> <mpdesouza@suse.com> wrote:
> >
> > On Mon, 2025-06-09 at 13:13 -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Fri, Jun 6, 2025 at 7:54 PM Marcos Paulo de Souza
> > > <mpdesouza@suse.com> wrote:
> > > >
> > > > All consoles found on for_each_console are registered, meaning that
> > > > all of
> > > > them are CON_ENABLED. The code tries to find an active console, so
> > > > check if the
> > > > console is not suspended instead.
> > > >
> > > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > > ---
> > > >  drivers/tty/serial/kgdboc.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/kgdboc.c
> > > > b/drivers/tty/serial/kgdboc.c
> > > > index
> > > > 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b
> > > > 006b2923583a0d2 100644
> > > > --- a/drivers/tty/serial/kgdboc.c
> > > > +++ b/drivers/tty/serial/kgdboc.c
> > > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > > > *opt)
> > > >         console_list_lock();
> > > >         for_each_console(con) {
> > > >                 if (con->write && con->read &&
> > > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > > > +                   (con->flags & CON_BOOT) &&
> > > > +                   ((con->flags & CON_SUSPENDED) == 0) &&
> > >
> > > I haven't tried running the code, so I could easily be mistaken,
> > > but...
> > >
> > > ...the above doesn't seem like the correct conversion. The old
> > > expression was:
> > >
> > > (con->flags & (CON_BOOT | CON_ENABLED))
> > >
> > > That would evaluate to non-zero (true) if the console was _either_
> > > "boot" or "enabled".
> > >
> > > The new expression is is:
> > >
> > > (con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) == 0)
> > >
> > > That's only true if the console is _both_ "boot" and "not suspended".
> >
> > My idea here was that the users of for_each_console would find the
> > first available console, and by available I would expect them to be
> > usable. In this case, is there any value for kgdboc to use a console
> > that is suspended? Would it work in this case?
> >
> > I never really used kgdboc, but only checking if the console was
> > enabled (which it's always the case here) was something that needed to
> > be fixed.
> >
> > Maybe I'm missing something here as well, so please let me know if I
> > should remove the new check.
> 
> So it's been 5 years since I wrote the code, but reading that I was
> checking for:
> 
>   (con->flags & (CON_BOOT | CON_ENABLED))
> 
> Makes me believe that this was the case when I wrote the code:
> 1. Early boot consoles (earlycon) were not marked as CON_ENABLED but
> were instead marked as CON_BOOT.
> 2. Once consoles became non-early they were moved to CON_ENABLED.
> 
> ...and the code was basically looking for any consoles with a matching
> name that were either boot consoles or normal/enabled consoles.
> 
> Is that a plausible theory? It's also possible that I just was
> confused when I code things up and that I really meant to write:

It is easy to get confused by the register_console() code. And
it has been even worse some years ago.

Anyway, the current code sets CON_ENABLED for all registered
consoles, including CON_BOOT consoles. The flag is cleared only
by console_suspend()[*] or unregister_console().

IMHO, kgdboc_earlycon_init() does not need to care about
console_suspend() because the kernel could not be suspended
during boot. Does this makes sense?

Also it does not need to care about unregister_console() because
the unregistered console won't be listed by for_each_console().

[*] The 1st patch in this patchset updates console_suspend()
    to set CON_SUSPENDED instead of clearing CON_ENABLED.
    It helps to make it clear that it is suspend-related.


Resume:

I would remove the check of CON_ENABLED or CON_SUSPENDED
from kgdboc_earlycon_init() completely.

IMHO, we should keep the check of CON_BOOT because we do not
want to register "normal" console drivers as kgdboc_earlycon_io_ops.
It is later removed by kgdboc_earlycon_deinit(). I guess
that the code is not ready to handle a takeover from normal
to normal (even the same) console driver.

To make it clear, I would use:

	for_each_console(con) {
		if (con->write && con->read &&
		    (con->flags & CON_BOOT) &&
		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
			break;
	}

And I would do this change as the 1st patch in the patchset
before we change the flag modified by console_suspend().

Best Regards,
Petr

