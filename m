Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6E4C7EE30
	for <linux-um@archiver.kernel.org>; Mon, 30 Jun 2025 01:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlOAT/47QVs7CQTjytp1gWpZj88+lZThU0ABfu6V9ew=; b=ktBZ4uldxUsv7n+q75EeaGat69
	3LyeBVy8S6Dwk5o3GoBtz7jjI2359sm4ZAg7C5TUavAmodbxYb+Gp3RXwCQc/qXkPKKBtxgNezQsS
	57eQLqMOQJqfKXAhlvoe1CEglxBZNLG1mhnZOISy1oQpwnwEPVR9omWFGh/5qoS99NCTnKo9UpYBe
	6sAN0pUMULBnH86Q9v5nZCODnd8g1H5eSvUu/jbRdnEOt8bqReWEf6TV7CCwUA6SobKYR5VPvhZZi
	qwHnZXgm3CLhKqkDPy8WsEIcEdb0hEzToiibvOs97Lo1DRRZ8SjYYeH1KgClZqLlvXqvhPw9a75sS
	YiCj+uVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW2wK-00000000wdD-1ONn;
	Mon, 30 Jun 2025 01:04:08 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW2wH-00000000wcl-1OSJ
	for linux-um@lists.infradead.org;
	Mon, 30 Jun 2025 01:04:06 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-747ef5996edso1392671b3a.0
        for <linux-um@lists.infradead.org>; Sun, 29 Jun 2025 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751245444; x=1751850244; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SlOAT/47QVs7CQTjytp1gWpZj88+lZThU0ABfu6V9ew=;
        b=hIrzs/b3rkGSrdDA5idBnI4jvrK7p5nBL9OjJAdgqUG2YToJiT0twYCVmm8yiS+c38
         hiXkc85FrR45KzY7jPe5ZlFvYXH0JazhZ469TXL48Bsl1pcTnBW2l5RpAwr+zsPEpnlG
         +9Z/mtZe8rr8h1N8u16+Ehsd/+00/jSTfZGWJefc5ezFGs5CP5l5Lmk8aAc3j0AVnx5r
         JyLyNfiHCSIV+rCYX5iB9pTuZECSiy9QBYA/e3tovLaiQQwvGj9faRwVE0t/+3mE4RZg
         m3vUHI/sYiKI5dL082UiDLszj9KXHsLWU7N2SeSR69aRYmwlEzX9gtfs13m0QmaPltjh
         TZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751245444; x=1751850244;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlOAT/47QVs7CQTjytp1gWpZj88+lZThU0ABfu6V9ew=;
        b=Cen8mLMz0k8QZNbbj79XEgmsix4KFAMttdhLMamya37eUhiHLCJpbIJfeyUcLj9NOv
         qrYV7VHgHq02Qx3EmIHpLk/wmf3yd8jgNJIbGW45TDd1H1ZZ+NWorvaRG8ez7P2hOh+8
         ZoZ5A9KWIWrrQej37dX9tQHqpu8UWklk8/S3ky7+6DYrZXp1sbJg6buq9JjDJzroq6aB
         MxHlm5Ew021knMZt6nCzxjLOotdJB3ldM/ziLadRtzpr+L3t92aYds3Czm6sI+R9Ts0r
         WIeRCY6T4hfsE84HBJJbAJSCVDyr7RIwGLEhzJIT8BHKPKDJ0BKXhdZlhRn34icu9Kh9
         bJ9A==
X-Gm-Message-State: AOJu0Yzlbl2mt9NCr/5qD74hYnG8Lhwlt44dsF8q/+sIT2sZPJyXOYdZ
	9OR7uPXcs3yFe7pHE+iueIIE5pfqtL4fKBIdoA4iPPR0gVURRm4HuiEz
X-Gm-Gg: ASbGnct8Q5PWyDQ0ZoiT1yMury3v26jc207A+LKLJB/O7ip/hwAIh1Itk+16AAqWjfq
	mAtZzFbsctIDmujzE8OWdANFgs/inQ31190iAxOfgshONWB30PC948igl29qKkA95Afpv8oMgTz
	ADJAcYtTg2R2plSEUXi8c2tcY/VnR4TvN7VOTsXSZVe1RdLbFX87BvHGalzEDHU31LUvFjsnUUz
	Qs//F/7jhfw4tfeoEsOj0ri5JCPLhL/fpxuXvedhGEamo1veyaknUkoCuKJ4snnNDmV91VwAvSS
	TtWPAtx+kf+lbwB3Dpx2qj4W9s9HgiTamoIcSAp1QxMylvrZetOouEF/gvgwDO7Lz80Reozn2r+
	1zhm8LpuPZuLQq171FWgKC0jGtW9B6H7Z/EGO/ti7aBkJr/0mnlx9wMs96aY=
X-Google-Smtp-Source: AGHT+IHkXJytyRhZUeC401afzY6yfzKABPO7AHRa1WPBnc8Z/NN/IJ7+8l2r99Z4yrTKx1FuMO5Tsw==
X-Received: by 2002:a05:6a00:cc1:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-74af6f227a3mr13983922b3a.15.1751245443894;
        Sun, 29 Jun 2025 18:04:03 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b203sm7582860b3a.8.2025.06.29.18.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 18:04:03 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:04:00 +0900
Message-ID: <m2plem3urj.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 09/13] x86/um: nommu: signal handling
In-Reply-To: <734965ac85b2c4cf481cc98ac53052fd5064d30e.camel@sipsolutions.net>
References: <cover.1750594487.git.thehajime@gmail.com>
	<548dcef198b79a4f8eb166481e39abe6e13ed2e3.1750594487.git.thehajime@gmail.com>
	<3b407ed711c5d7e1819da7513c3e320699473b2d.camel@sipsolutions.net>
	<m2sejl47ke.wl-thehajime@gmail.com>
	<734965ac85b2c4cf481cc98ac53052fd5064d30e.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_180405_376829_BFD3CECA 
X-CRM114-Status: GOOD (  71.45  )
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


Hello Benjamin,

On Sat, 28 Jun 2025 00:02:05 +0900,
Benjamin Berg wrote:
>=20
> Hi,
>=20
> On Fri, 2025-06-27 at 22:50 +0900, Hajime Tazaki wrote:
> > thanks for the comment on the complicated part of the kernel (signal).
>=20
> This stuff isn't simple.
>=20
> Actually, I am starting to think that the current MMU UML kernel also
> needs a redesign with regard to signal handling and stack use in that
> case. My current impression is that the design right now only permits
> voluntarily scheduling. More specifically, scheduling in response to an
> interrupt is impossible.
>=20
> I suppose that works fine, but it also does not seem quite right.

thanks for the info.  it's very useful to understand what's going on.

(snip)

> > > > +void set_mc_userspace_relay_signal(mcontext_t *mc)
> > > > +{
> > > > + mc->gregs[REG_RIP] =3D (unsigned long) __userspace_relay_signal;
> > > > +}
> > > > +
> >=20
> > This is a bit scary code which I tried to handle when SIGSEGV is
> > raised by host for a userspace program running on UML (nommu).
> >=20
> > # and I should remember my XXX tag is important to fix....
> >=20
> > let me try to explain what happens and what I tried to solve.
> >=20
> > The SEGV signal from userspace program is delivered to userspace but
> > if we don't fix the code raising the signal, after (um) rt_sigreturn,
> > it will restart from $rip and raise SIGSEGV again.
> >=20
> > # so, yes, we've already relied on host and um's rt_sigreturn to
> > =A0 restore various things.
> >=20
> > when a uml userspace crashes with SIGSEGV,
> >=20
> > - host kernel raises SIGSEGV (at original $rip)
> > - caught by uml process (hard_handler)
> > - raise a signal to uml userspace process (segv_handler)
> > - handler ends (hard_handler)
> > - (host) run restorer (rt_sigreturn, registered by (libc)sigaction,
> > =A0 not (host) rt_sigaction)
> > - return back to the original $rip
> > - (back to top)
> >=20
> > this is the case where endless loop is happened.
> > um's sa_handler isn't called as rt_sigreturn (um) isn't called.
> > and the my original attempt (__userspace_relay_signal) is what I tried.
> >=20
> > I agree that it is lazy to call a dummy syscall (indeed, getpid).
> > I'm trying to introduce another routine to jump into userspace and
> > call (um) rt_sigreturn after (host) rt_sigreturn.
> >=20
> > > And this is really confusing me. The way I am reading it, the code
> > > tries to do:
> > > =A0=A0 1. Rewrite RIP to jump to __userspace_relay_signal
> > > =A0=A0 2. Trigger a getpid syscall (to do "nothing"?)
> > > =A0=A0 3. Let do_syscall_64 fire the signal from interrupt_end
> >=20
> > correct.
> >=20
> > > However, then that really confuses me, because:
> > > =A0* If I am reading it correctly, then this approach will destroy the
> > > =A0=A0 contents of various registers (RIP, RAX and likely more)
> > > =A0* This would result in an incorrect mcontext in the userspace sign=
al
> > > =A0=A0 handler (which could be relevant if userspace is inspecting it)
> > > =A0* However, worst, rt_sigreturn will eventually jump back
> > > =A0=A0 into__userspace_relay_signal, which has nothing to return to.
> > > =A0* Also, relay_signal doesn't use this? What happens for a SIGFPE, =
how
> > > =A0=A0 is userspace interrupted immediately in that case?
> >=20
> > relay_signal shares the same goal of this, indeed.
> > but the issue with `mc->gregs[REG_RIP]` (endless signals) still exists
> > I guess.
>=20
> Well, endless signals only exist as long as you exit to the same
> location. My suggestion was to read the user state from the mcontext
> (as SECCOMP mode does it) and executing the signal right away, i.e.:

thanks too;  below is my understanding.

>  * Fetch the current registers from the mcontext

I guess this is already done in sig_handler_common().

>  * Push the signal context onto the userspace stack

(guess) this is already done on handle_signal() =3D> setup_signal_stack_si(=
).

>  * Modify the host mcontext to set registers for the signal handler

this is something which I'm not well understanding.
- do you mean the host handler when you say "for the signal handler" ?
  or the userspace handler ?
- if former (the host one), maybe mcontext is already there so, it
  might not be the one you mentioned.
- if the latter, how the original handler (the host one,
  hard_handler()) works ? even if we can call userspace handler
  instead of the host one, we need to call the host handler (and
  restorer).  do we call both ?
- and by "to set registers", what register do you mean ? for the
  registers inspected by userspace signal handler ?  but if you set a
  register, for instance RIP, as the fault location to the host
  register, it will return to RIP after handler and restart the fault
  again ?

>  * Jump back to userspace by doing a "return"

this is still also unclear to me.

it would be very helpful if you point the location of the code (at
uml/next tree) on how SECCOMP mode does.  I'm also looking at but
really hard to map what you described and the code (sorry).

all of above runs within hard_handler() in nommu mode on SIGSEGV.
my best guess is this is different from what ptrace/seccomp do.

> Said differently, I really prefer deferring as much logic as possible
> to the host. This is both safer and easier to understand. Plus, it also
> has the advantage of making it simpler to port UML to other
> architectures.

okay.

>=20
> > > Honestly, I really think we should take a step back and swap the
> > > current syscall entry/exit code. That would likely also simplify
> > > floating point register handling, which I think is currently
> > > insufficient do deal with the odd special cases caused by different
> > > x86_64 hardware extensions.
> > >=20
> > > Basically, I think nommu mode should use the same general approach as
> > > the current SECCOMP mode. Which is to use rt_sigreturn to jump into
> > > userspace and let the host kernel deal with the ugly details of how to
> > > do that.
> >=20
> > I looked at how MMU mode (ptrace/seccomp) does handle this case.
> >=20
> > In nommu mode, we don't have external process to catch signals so, the
> > nommu mode uses hard_handler() to catch SEGV/FPE of userspace
> > programs.=A0 While mmu mode calls segv_handler not in a context of
> > signal handler.
> >=20
> > # correct me if I'm wrong.
> >=20
> > thus, mmu mode doesn't have this situation.
>=20
> Yes, it does not have this specific issue. But see the top of the mail
> for other issues that are somewhat related.
>=20
> > I'm attempting various ways; calling um's rt_sigreturn instead of
> > host's one, which doesn't work as host restore procedures (unblocking
> > masked signals, restoring register states, etc) aren't called.
> >=20
> > I'll update here if I found a good direction, but would be great if
> > you see how it should be handled.
>=20
> Can we please discuss possible solutions? We can figure out the details
> once it is clear how the interaction with the host should work.

I was wishing to update to you that I'm working on it.  So, your
comments are always helpful to me.  Thanks.

-- Hajime

> I still think that the idea of using the kernel task stack as the
> signal stack is really elegant. Actually, doing that in normal UML may
> be how we can fix the issues mentioned at the top of my mail. And for
> nommu, we can also use the host mcontext to jump back into userspace
> using a simple "return".
>=20
> Conceptually it seems so simple.
>=20
> Benjamin
>=20
>=20
> >=20
> > -- Hajime
> >=20
> > > I believe that this requires a second "userspace" sigaltstack in
> > > addition to the current "IRQ" sigaltstack. Then switching in between
> > > the two (note that the "userspace" one is also used for IRQs if those
> > > happen while userspace is executing).
> > >=20
> > > So, in principle I would think something like:
> > > =A0* to jump into userspace, you would:
> > > =A0=A0=A0 - block all signals
> > > =A0=A0=A0 - set "userspace" sigaltstack
> > > =A0=A0=A0 - setup mcontext for rt_sigreturn
> > > =A0=A0=A0 - setup RSP for rt_sigreturn
> > > =A0=A0=A0 - call rt_sigreturn syscall
> > > =A0* all signal handlers can (except pure IRQs):
> > > =A0=A0=A0 - check on which stack they are
> > > =A0=A0=A0=A0=A0 -> easy to detect whether we are in kernel mode
> > > =A0=A0=A0 - for IRQs one can probably handle them directly (and retur=
n)
> > > =A0=A0=A0 - in user mode:
> > > =A0=A0=A0=A0=A0=A0 + store mcontext location and information needed f=
or rt_sigreturn
> > > =A0=A0=A0=A0=A0=A0 + jump back into kernel task stack
> > > =A0* kernel task handler to continue would:
> > > =A0=A0=A0 - set sigaltstack to IRQ stack
> > > =A0=A0=A0 - fetch register from mcontext
> > > =A0=A0=A0 - unblock all signals
> > > =A0=A0=A0 - handle syscall/signal in whatever way needed
> > >=20
> > > Now that I wrote about it, I am thinking that it might be possible to
> > > just use the kernel task stack for the signal stack. One would probab=
ly
> > > need to increase the kernel stack size a bit, but it would also mean
> > > that no special code is needed for "rt_sigreturn" handling. The rest
> > > would remain the same.
> > >=20
> > > Thoughts?
> > >=20
> > > Benjamin
> > >=20
> > > > [SNIP]
> > >=20
> >=20
>=20

