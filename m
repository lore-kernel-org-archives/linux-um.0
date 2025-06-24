Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D136C77B7F
	for <linux-um@archiver.kernel.org>; Tue, 24 Jun 2025 23:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8gmztvWykFpmhkeFbGIlEUdI1CttO0IpihuArM71Qk=; b=3ZBAaVj7OYHFYWz8TDIfw12f6P
	saWJ+8aXfU/YmMmNvdpBksPQ0y5ipu+Cv6RZq9bgrtAqYq1H/+iM0Gi+Mzz+3WzkQ4FduHXhjLG7h
	RO6+qUyDruRN4H+dEZmrZptEsBq2gsCxoVGyxTJnqTDOAKqgoXvCpHS7PlRSkeXSQ955ZV5N9Z/Lr
	vVFsIKkHk7Q2qvjGK380JHI0ZVmra9MvdGpXNeV1vFzaWCSJmlvFzD3R1io558lDTqLuD6JBy5REW
	e+YLPy2VuqBZvYjqy7gHijZ0r+6luzv2iPVgOZD+yuqmlQNs5tbhH2KvTN2jlWTGDu4y5pyVItBIX
	egoUpyWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUCvy-000000075Pe-2WJx;
	Tue, 24 Jun 2025 23:20:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUCvw-000000075Oc-2bXi
	for linux-um@lists.infradead.org;
	Tue, 24 Jun 2025 23:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V8gmztvWykFpmhkeFbGIlEUdI1CttO0IpihuArM71Qk=;
	t=1750807206; x=1752016806; b=G/Ny7+BE4wJ36oUDKcrz6zUTEAGgJaXNglmdswdRSs51IC5
	OZuJxhp/bH/iGgN2fqmw1qXFhvnE7ho8XHaYnar4zXmo4YUgRpoZkeY33Tp9PNZuhoFCh57XMe1mQ
	3C93OF4ibmIFa5KUOG+WSxGrexfVsh47lTcEl8CITHDLhT72qqUuw9sgzSMGBD7HP6kfoBZD01ETL
	NjTdo9fWTTfr5rq4mPG95Oa1T/5Fp2x/hoFejKP8evod2+1VKdNC1vkmtSys4tzDzA6TvtK7tw6cp
	30IgDZ6LmNcWplOPp5VcvG5HuZ45N0DFtFG1LoSFLBw2Hi2HbWHm/j6kv6RHahxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uUCvs-00000009Aa0-0S6V;
	Wed, 25 Jun 2025 01:20:04 +0200
Message-ID: <3b407ed711c5d7e1819da7513c3e320699473b2d.camel@sipsolutions.net>
Subject: Re: [PATCH v10 09/13] x86/um: nommu: signal handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org
Date: Wed, 25 Jun 2025 01:20:03 +0200
In-Reply-To: <548dcef198b79a4f8eb166481e39abe6e13ed2e3.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
	 <548dcef198b79a4f8eb166481e39abe6e13ed2e3.1750594487.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_162008_683931_62910F87 
X-CRM114-Status: GOOD (  25.59  )
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

On Mon, 2025-06-23 at 06:33 +0900, Hajime Tazaki wrote:
> This commit updates the behavior of signal handling under !MMU
> environment. It adds the alignment code for signal frame as the frame
> is used in userspace as-is.
>=20
> floating point register is carefully handling upon entry/leave of
> syscall routine so that signal handlers can read/write the contents of
> the register.
>=20
> It also adds the follow up routine for SIGSEGV as a signal delivery runs
> in the same stack frame while we have to avoid endless SIGSEGV.
>=20
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> ---
> =C2=A0arch/um/include/shared/kern_util.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
4 +
> =C2=A0arch/um/nommu/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0arch/um/nommu/os-Linux/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 13 ++
> =C2=A0arch/um/nommu/trap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 194 +++++++++++=
+++++++++++++++
> =C2=A0arch/x86/um/nommu/do_syscall_64.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 +
> =C2=A0arch/x86/um/nommu/os-Linux/mcontext.c |=C2=A0 11 ++
> =C2=A0arch/x86/um/shared/sysdep/mcontext.h=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/x86/um/shared/sysdep/ptrace.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
2 +-
> =C2=A08 files changed, 231 insertions(+), 2 deletions(-)
> =C2=A0create mode 100644 arch/um/nommu/trap.c
>=20
> [SNIP]
> diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os=
-Linux/mcontext.c
> index c4ef877d5ea0..955e7d9f4765 100644
> --- a/arch/x86/um/nommu/os-Linux/mcontext.c
> +++ b/arch/x86/um/nommu/os-Linux/mcontext.c
> @@ -6,6 +6,17 @@
> =C2=A0#include <sysdep/mcontext.h>
> =C2=A0#include <sysdep/syscalls.h>
> =C2=A0
> +static void __userspace_relay_signal(void)
> +{
> + /* XXX: dummy syscall */
> + __asm__ volatile("call *%0" : : "r"(__kernel_vsyscall), "a"(39) :);
> +}

39 is NR__getpid, I assume?

The "call *%0" looks like it is code for retpolin, I think this would
currently just segfault.

> +
> +void set_mc_userspace_relay_signal(mcontext_t *mc)
> +{
> + mc->gregs[REG_RIP] =3D (unsigned long) __userspace_relay_signal;
> +}
> +

And this is really confusing me. The way I am reading it, the code
tries to do:
   1. Rewrite RIP to jump to __userspace_relay_signal
   2. Trigger a getpid syscall (to do "nothing"?)
   3. Let do_syscall_64 fire the signal from interrupt_end

However, then that really confuses me, because:
 * If I am reading it correctly, then this approach will destroy the
   contents of various registers (RIP, RAX and likely more)
 * This would result in an incorrect mcontext in the userspace signal
   handler (which could be relevant if userspace is inspecting it)
 * However, worst, rt_sigreturn will eventually jump back
   into__userspace_relay_signal, which has nothing to return to.
 * Also, relay_signal doesn't use this? What happens for a SIGFPE, how
   is userspace interrupted immediately in that case?


Honestly, I really think we should take a step back and swap the
current syscall entry/exit code. That would likely also simplify
floating point register handling, which I think is currently
insufficient do deal with the odd special cases caused by different
x86_64 hardware extensions.

Basically, I think nommu mode should use the same general approach as
the current SECCOMP mode. Which is to use rt_sigreturn to jump into
userspace and let the host kernel deal with the ugly details of how to
do that.

I believe that this requires a second "userspace" sigaltstack in
addition to the current "IRQ" sigaltstack. Then switching in between
the two (note that the "userspace" one is also used for IRQs if those
happen while userspace is executing).

So, in principle I would think something like:
 * to jump into userspace, you would:
    - block all signals
    - set "userspace" sigaltstack
    - setup mcontext for rt_sigreturn
    - setup RSP for rt_sigreturn
    - call rt_sigreturn syscall
 * all signal handlers can (except pure IRQs):
    - check on which stack they are
      -> easy to detect whether we are in kernel mode
    - for IRQs one can probably handle them directly (and return)
    - in user mode:
       + store mcontext location and information needed for rt_sigreturn
       + jump back into kernel task stack
 * kernel task handler to continue would:
    - set sigaltstack to IRQ stack
    - fetch register from mcontext
    - unblock all signals
    - handle syscall/signal in whatever way needed

Now that I wrote about it, I am thinking that it might be possible to
just use the kernel task stack for the signal stack. One would probably
need to increase the kernel stack size a bit, but it would also mean
that no special code is needed for "rt_sigreturn" handling. The rest
would remain the same.

Thoughts?

Benjamin

> [SNIP]


