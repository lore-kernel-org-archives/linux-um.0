Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889E4D116F3
	for <linux-um@archiver.kernel.org>; Fri, 28 Nov 2025 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcb229vvLyBxSU063HYeCn4lxqy1srWBTS640feRync=; b=Yv20ZALJqRJuas5Tz1ybg230KD
	l2ZNuy+FxUthFx0Mwc2y7SFwp7h+9FfCXNZfzmpzEoEZn3FgrGJ+XFrmMjLI1Pug/lWXXJ8zLH+Go
	os5GIB89EFxReCbK74XoPaIBdARlFJier4PswE8EyU9307UyrBYETdUBUT6MccCHmVH+Yj8Vu/Zmu
	zQCHEuUe9sxuYOCF/aTRke5Z4pIaB2/njRv4pbylIRWHALqUw2aTmO47AdlI4KlYu7ue3wyFFdwT1
	j7OXJd3MfRVa+mtHitMRy8QymqWJkJTSAprc+rtdpS21SUpvJbNbMdHk/RwdYhCexRjr1HRibs7no
	7d+/esYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOxd1-00000000Qk3-3fce;
	Fri, 28 Nov 2025 12:31:11 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOxcw-00000000Qje-32uR
	for linux-um@lists.infradead.org;
	Fri, 28 Nov 2025 12:31:10 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4775ae77516so18985245e9.1
        for <linux-um@lists.infradead.org>; Fri, 28 Nov 2025 04:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764333065; x=1764937865; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcb229vvLyBxSU063HYeCn4lxqy1srWBTS640feRync=;
        b=eww+fP4S2PIzx4KSYob2EJ7fj9OhKEQJoDUnsbKsgaMmnnKwn8jklIRhNX/ats+QW9
         b5WTtOwpl0K9EwFFyl3IV8diewiVRhjcFwdHt/yc6cIJeYXSReUGOoM/du+fs0fOCEL/
         3IPMkoBEK5I0i2EGgin3wh5RtPzYl87cHjsY3CJ7wi1LzQSssk0t7qxDgsI7bsZw62an
         biJj5AszELS5t+dE1KfXXIcnaETroW3uFhYuTzUjdhYTwb5pUIl6/E92Geu4ouK1W2cp
         oLx+zJiv5eh23BqIepoO0HXYX7IIFHVlcpt4RqmkHe9gUVNVIxM121Sx2doXO+6lMjJQ
         ljxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764333065; x=1764937865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcb229vvLyBxSU063HYeCn4lxqy1srWBTS640feRync=;
        b=YmIqn+UP89W9ica2i8zXWFgjsnxs2eWT0DNn/E8CRfOrUiXh7nl6BYoL1v4F6r29xU
         vj3AoQGHldmKF7lXZUaNaP/r2aqSvD4WflCJjgffLLIwDBEo3pSVODis+nB/BZjzktRz
         Xwgn9jRJxv5UCsvmIoKIciLZM4ti9zBrVjR/py+a3ZWWHea3EUvIh5Vylb66wN4k1aVR
         wwwtmEAlRH2t4HEHMfrLrbZLq+9wzGOjWMSwSz90XM03v7teYy2u2ElSCbDWX/C1WFtG
         h6TP8KMgbUIjSiPG76obNWkZFPduRLknUnPfxqrUtnDVySwLRoYbYXjAbUEmhesFfl9f
         TRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtSFmKmV8g4rM9GoYVA8g35DJyICim0AuYl5mct7t1kCstafw3f4/ofnf8OUYY1LFg8B0FWyUQcQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxGq4iQrxfERVCSlBHaQvlH3QArCr4s16QgnSRx0dgPghDvmjFF
	q2LyLvtIThePz2Qg8/XiUtEzlZsINtfGYSvH3XWv10aoHHBuBcFtcvRMzaoSLhjqP9Q=
X-Gm-Gg: ASbGncvPTrmGqsTmSfrAt5pyptBMSMqhbQmb8osk2lUHadhIB+fWPTTd1RT43uj17Y7
	7MNZMe+Rre38oXHKx9bVya8cKSk7wda2NazIylH0+hD9vfCJn1Avgf/s41Lpc9JVPXwiUB7dc2F
	CjJfSr+e4lccDGPm30D/LdmzMGrAM8kPaRGjersq8Pw1jLTtErgZVXeJF3BBKbuvsNPAiA8/u7B
	c48/gLTPLD9qC/pzMGWde+HoDSjfSJadhtKLkUygGP9oNusD5ixjrtqxBfFeRT0oe8vui+l05kt
	LjrVujrXaYyNx0HjPjPnZ1qIkxZnQFomNbkNokHH+CoaR4TLy0W0wp6VZFeGzr1T/UaMuuC7fFa
	YfAtjpAMRdKa1p8KDt7llKMx2228qVDSW/nyR8eXvzRpGEA65dz3JvyhXoGJ0Qcc59JKxYNaiC+
	0hRxu0KqhgrJ00oQ==
X-Google-Smtp-Source: AGHT+IHRcq2FJ5WThogfhlAWqk7vaz8fGAovTB+lQ9cVsK0w612w7DjIt7QhCUcTVHzHz5dbtHK8GA==
X-Received: by 2002:a05:600c:450f:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-477c1124ecfmr270011685e9.27.1764333064798;
        Fri, 28 Nov 2025 04:31:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a3e4sm9837124f8f.25.2025.11.28.04.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 04:31:04 -0800 (PST)
Date: Fri, 28 Nov 2025 13:31:01 +0100
From: Petr Mladek <pmladek@suse.com>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 0/4] printk cleanup - part 2
Message-ID: <aSmWBYRmH_BNM4kg@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <aShr0DZRmpDnL0nz@pathway.suse.cz>
 <aSlw2AHo_AWzjH-s@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSlw2AHo_AWzjH-s@aspen.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_043106_807680_C1611317 
X-CRM114-Status: GOOD (  21.17  )
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

On Fri 2025-11-28 09:52:24, Daniel Thompson wrote:
> On Thu, Nov 27, 2025 at 04:18:40PM +0100, Petr Mladek wrote:
> > On Fri 2025-11-21 15:50:32, Marcos Paulo de Souza wrote:
> > > The first part can be found here[1]. The proposed changes do not
> > > change the functionality of printk, but were suggestions made by
> > > Petr Mladek. I already have more patches for a part 3 ,but I would like
> > > to see these ones merged first.
> > >
> > > I did the testing with VMs, checking suspend and resume cycles, and it worked
> > > as expected.
> > >
> > > Thanks for reviewing!
> >
> > > Marcos Paulo de Souza (4):
> > >       drivers: serial: kgdboc: Drop checks for CON_ENABLED and CON_BOOT
> > >       arch: um: kmsg_dump: Use console_is_usable
> > >       printk: Use console_is_usable on console_unblank
> >
> > These three patches were simple, straightforward, and ready for linux
> > next.
> >
> > I have comitted them into printk/linux.git, branch rework/nbcon-in-kdb.
> > I am going to push them for 6.19.
> 
> I pointed the kgdb test suite at this branch (as I did for the earlier
> part of the patchset, although I think I forgot to post about it).
> 
> The console coverage is fairly modest (I think just 8250 and PL011
> drivers, with and without earlycon) and the suite exercises features
> rather than crash resilience. Nevertheless and FWIW, the tests didn't
> pick up any regressions. Yay!

Great news! Thanks a lot for doing the test and sharing results.

Best Regards,
Petr

