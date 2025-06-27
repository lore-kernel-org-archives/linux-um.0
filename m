Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B0AC77B7F
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Er5yzRbxAzEONxojnd+XiqNzcC4mWTkPWEuVaxn0Exk=; b=4vv8a3YKToGjfub4F3m2xWVrCZ
	i7xJ87HWf1PKrtmSJw0j3IfST6ZIGbZFkgIMYMLsTkqtCQI1kAwsUHa1U2Zz+Iwc+3xuYf2Fcc2ZQ
	wRppKg5ueFtydfJ2bp/HCsYCYRawRrtD+4DePqMJoAmCsOG3YEVwGqLEO+ZPbb1CYvEc+up5BbZPa
	riUYD+cJlOC1+/tRyc//1P2Rj/ITH/Nfs25adCXwqiH2oSt05SJw5di7Inbks0c/CiUsZfuaxK37U
	Im1wA6wzzFzeyaL7aTAPl4bzQVLRGeF/+cYQzHN0B0nEtuAwzVe8m1s0RoRZlbrNPKaijJt/yNm/P
	SrmvmEyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV9uj-0000000Esqv-02q6;
	Fri, 27 Jun 2025 14:18:49 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV9Te-0000000EpOD-1dgN
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 13:50:51 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1653929b3a.2
        for <linux-um@lists.infradead.org>; Fri, 27 Jun 2025 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751032249; x=1751637049; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Er5yzRbxAzEONxojnd+XiqNzcC4mWTkPWEuVaxn0Exk=;
        b=i4fPu+JCSL3Bim+HSGTt9Di1GKajMqePH6Vxk/aTt7Bv6U5L8gRNExQjY1MApRA2ck
         OwGmPlJ5w84RI/V60tJTCAqeKDWm77MgCkGqgjWN52Chsm76V96z0UgOVOGHpRqHXshm
         ZzIuOxb9vwMI3AWHbPgRF9/a8F8+g+nMw3mU0Dkk0jaunJf9OladsU1alK9JY4eeJCNf
         FbQB9qX5N19ms0vyWsBubZoRBU3eGiPGeY/iK5LvS6v2iu+O9ADYUbzJ3Q5uBFrZhE5R
         wqmRTb+g7HAX+/Tjknynr6WSXw4M1X3PejjN5c8lTAGWPkzTb2OH826njD7MMVYzGuer
         BpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751032249; x=1751637049;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Er5yzRbxAzEONxojnd+XiqNzcC4mWTkPWEuVaxn0Exk=;
        b=lSQUPaxdYj312MjQ1ClS5AQdEngsoU9LAdsgpxRESnoFrfg0+d5/WgdFWsqrVLDnr/
         sW6JY4/FadG6iGUs8KDaT7le+j9fhhZgYQR2ix3tvo9w1vs5IT5/lTOoKBsgoV13jd4r
         FOPMRp6z/vdQWqKVfWDLkItst4UhgxlO87DpZlRjQE1GYkPTWrFYN5QgS5FJpOrYzdue
         NVxoVghs0wdyYeb3tI2qSr1f7GHMO0/1kTZeab4bDpOwykIVWzE5uqVliM6CTEShMb3Y
         VRzi7HO0NUE/SQ+HNbYPbQq4l9MCXhC1QMmyBLwZVCXWubW7eVQC5+ovT320m4JgOzat
         VsFg==
X-Gm-Message-State: AOJu0YwSrMZzw3dkI0BU5zEKkaA4mjmsaRYMPZEHoyAg8k966JGJ6FoB
	YUUPo3vbjuBkvAGzQweqf+AERpqhrBeblD8YpkB15bGHGsXKnAb442c7
X-Gm-Gg: ASbGncvYvIZhcel1WDCm0NprXl/da8QqtnZ+jH9J8tNRldZ8HvOtLlraLAMCnnCWH2y
	Fz5za5cHdmiC2T4DBNvxg4qtHJwTxJ9oErHMxD/y3nv3NBRNW+EgzTxGxDa6zB2OmWnVCcfb+Nt
	LH+ksXvwZFZKhJ2fzSzwPfs+pBEssTlU5KyenZwo6RxylIvfi8z4KCJEj9XsBR1cc4Qze1nmmsD
	4yceD9MVUs9/UQenw5WRI96naRJVeniqkUybL1AdekTIVBaZahmE1sGUXtzy5/xie/wbtpkJnKE
	6vN0WDRHBy6velN/chi7E4sY5EtiqzEjShmISrPvG6w5cLNUI7Cqb2qaE1u/Wd1ZATE21p9r/JX
	z7iRUvXr+Skb3uFQgS8EsgL5HZjIqgh0ajzo8wjbCw1XLe1BD
X-Google-Smtp-Source: AGHT+IHm0tIQwqMArAkM6EsZ4e/IJxZXd3aeraDsPj/38phu/wRCS2B3aMR4ToaySdgBCXkERG+hHw==
X-Received: by 2002:a05:6a00:2302:b0:748:1bac:ad5f with SMTP id d2e1a72fcca58-74af6f22722mr4532045b3a.12.1751032246276;
        Fri, 27 Jun 2025 06:50:46 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3008194sm1698813a12.9.2025.06.27.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 06:50:45 -0700 (PDT)
Date: Fri, 27 Jun 2025 22:50:41 +0900
Message-ID: <m2sejl47ke.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 09/13] x86/um: nommu: signal handling
In-Reply-To: <3b407ed711c5d7e1819da7513c3e320699473b2d.camel@sipsolutions.net>
References: <cover.1750594487.git.thehajime@gmail.com>
	<548dcef198b79a4f8eb166481e39abe6e13ed2e3.1750594487.git.thehajime@gmail.com>
	<3b407ed711c5d7e1819da7513c3e320699473b2d.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_065050_433973_84A7D7B6 
X-CRM114-Status: GOOD (  49.41  )
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


Hello,

thanks for the comment on the complicated part of the kernel (signal).

On Wed, 25 Jun 2025 08:20:03 +0900,
Benjamin Berg wrote:
>=20
> Hi,
>=20
> On Mon, 2025-06-23 at 06:33 +0900, Hajime Tazaki wrote:
> > This commit updates the behavior of signal handling under !MMU
> > environment. It adds the alignment code for signal frame as the frame
> > is used in userspace as-is.
> >=20
> > floating point register is carefully handling upon entry/leave of
> > syscall routine so that signal handlers can read/write the contents of
> > the register.
> >=20
> > It also adds the follow up routine for SIGSEGV as a signal delivery runs
> > in the same stack frame while we have to avoid endless SIGSEGV.
> >=20
> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> > ---
> > =A0arch/um/include/shared/kern_util.h=A0=A0=A0 |=A0=A0 4 +
> > =A0arch/um/nommu/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0=A0 2 +-
> > =A0arch/um/nommu/os-Linux/signal.c=A0=A0=A0=A0=A0=A0 |=A0 13 ++
> > =A0arch/um/nommu/trap.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 194 ++++++++++++++++++++++++++
> > =A0arch/x86/um/nommu/do_syscall_64.c=A0=A0=A0=A0 |=A0=A0 6 +
> > =A0arch/x86/um/nommu/os-Linux/mcontext.c |=A0 11 ++
> > =A0arch/x86/um/shared/sysdep/mcontext.h=A0 |=A0=A0 1 +
> > =A0arch/x86/um/shared/sysdep/ptrace.h=A0=A0=A0 |=A0=A0 2 +-
> > =A08 files changed, 231 insertions(+), 2 deletions(-)
> > =A0create mode 100644 arch/um/nommu/trap.c
> >=20
> > [SNIP]
> > diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/=
os-Linux/mcontext.c
> > index c4ef877d5ea0..955e7d9f4765 100644
> > --- a/arch/x86/um/nommu/os-Linux/mcontext.c
> > +++ b/arch/x86/um/nommu/os-Linux/mcontext.c
> > @@ -6,6 +6,17 @@
> > =A0#include <sysdep/mcontext.h>
> > =A0#include <sysdep/syscalls.h>
> > =A0
> > +static void __userspace_relay_signal(void)
> > +{
> > + /* XXX: dummy syscall */
> > + __asm__ volatile("call *%0" : : "r"(__kernel_vsyscall), "a"(39) :);
> > +}
>=20
> 39 is NR__getpid, I assume?
>=20
> The "call *%0" looks like it is code for retpolin, I think this would
> currently just segfault.

# if you mean retpolin as zpoline,

zploine uses `call *%rax` so, this is not about zpoline.

> > +void set_mc_userspace_relay_signal(mcontext_t *mc)
> > +{
> > + mc->gregs[REG_RIP] =3D (unsigned long) __userspace_relay_signal;
> > +}
> > +

This is a bit scary code which I tried to handle when SIGSEGV is
raised by host for a userspace program running on UML (nommu).

# and I should remember my XXX tag is important to fix....

let me try to explain what happens and what I tried to solve.

The SEGV signal from userspace program is delivered to userspace but
if we don't fix the code raising the signal, after (um) rt_sigreturn,
it will restart from $rip and raise SIGSEGV again.

# so, yes, we've already relied on host and um's rt_sigreturn to
  restore various things.

when a uml userspace crashes with SIGSEGV,

- host kernel raises SIGSEGV (at original $rip)
- caught by uml process (hard_handler)
- raise a signal to uml userspace process (segv_handler)
- handler ends (hard_handler)
- (host) run restorer (rt_sigreturn, registered by (libc)sigaction,
  not (host) rt_sigaction)
- return back to the original $rip
- (back to top)

this is the case where endless loop is happened.
um's sa_handler isn't called as rt_sigreturn (um) isn't called.
and the my original attempt (__userspace_relay_signal) is what I tried.

I agree that it is lazy to call a dummy syscall (indeed, getpid).
I'm trying to introduce another routine to jump into userspace and
call (um) rt_sigreturn after (host) rt_sigreturn.

> And this is really confusing me. The way I am reading it, the code
> tries to do:
>    1. Rewrite RIP to jump to __userspace_relay_signal
>    2. Trigger a getpid syscall (to do "nothing"?)
>    3. Let do_syscall_64 fire the signal from interrupt_end

correct.

> However, then that really confuses me, because:
>  * If I am reading it correctly, then this approach will destroy the
>    contents of various registers (RIP, RAX and likely more)
>  * This would result in an incorrect mcontext in the userspace signal
>    handler (which could be relevant if userspace is inspecting it)
>  * However, worst, rt_sigreturn will eventually jump back
>    into__userspace_relay_signal, which has nothing to return to.
>  * Also, relay_signal doesn't use this? What happens for a SIGFPE, how
>    is userspace interrupted immediately in that case?

relay_signal shares the same goal of this, indeed.
but the issue with `mc->gregs[REG_RIP]` (endless signals) still exists
I guess.

> Honestly, I really think we should take a step back and swap the
> current syscall entry/exit code. That would likely also simplify
> floating point register handling, which I think is currently
> insufficient do deal with the odd special cases caused by different
> x86_64 hardware extensions.
>=20
> Basically, I think nommu mode should use the same general approach as
> the current SECCOMP mode. Which is to use rt_sigreturn to jump into
> userspace and let the host kernel deal with the ugly details of how to
> do that.

I looked at how MMU mode (ptrace/seccomp) does handle this case.

In nommu mode, we don't have external process to catch signals so, the
nommu mode uses hard_handler() to catch SEGV/FPE of userspace
programs.  While mmu mode calls segv_handler not in a context of
signal handler.

# correct me if I'm wrong.

thus, mmu mode doesn't have this situation.


I'm attempting various ways; calling um's rt_sigreturn instead of
host's one, which doesn't work as host restore procedures (unblocking
masked signals, restoring register states, etc) aren't called.

I'll update here if I found a good direction, but would be great if
you see how it should be handled.

-- Hajime

> I believe that this requires a second "userspace" sigaltstack in
> addition to the current "IRQ" sigaltstack. Then switching in between
> the two (note that the "userspace" one is also used for IRQs if those
> happen while userspace is executing).
>=20
> So, in principle I would think something like:
>  * to jump into userspace, you would:
>     - block all signals
>     - set "userspace" sigaltstack
>     - setup mcontext for rt_sigreturn
>     - setup RSP for rt_sigreturn
>     - call rt_sigreturn syscall
>  * all signal handlers can (except pure IRQs):
>     - check on which stack they are
>       -> easy to detect whether we are in kernel mode
>     - for IRQs one can probably handle them directly (and return)
>     - in user mode:
>        + store mcontext location and information needed for rt_sigreturn
>        + jump back into kernel task stack
>  * kernel task handler to continue would:
>     - set sigaltstack to IRQ stack
>     - fetch register from mcontext
>     - unblock all signals
>     - handle syscall/signal in whatever way needed
>=20
> Now that I wrote about it, I am thinking that it might be possible to
> just use the kernel task stack for the signal stack. One would probably
> need to increase the kernel stack size a bit, but it would also mean
> that no special code is needed for "rt_sigreturn" handling. The rest
> would remain the same.
>=20
> Thoughts?
>=20
> Benjamin
>=20
> > [SNIP]
>=20

