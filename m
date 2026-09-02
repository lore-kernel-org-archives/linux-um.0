Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D7CC624D6
	for <linux-um@archiver.kernel.org>; Wed,  2 Sep 2026 13:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OH53ybijunYoNfJAXp5YQ5Xv4Y7ODEOPTSxs+1JBmaY=; b=wFa7MRUgXHXaRZegUDPtzqKM0Y
	Vi76qRkoOI5TBAEAnZmPjs8lzBzfhzQCu6y5Xr2oxF3tfRTQ4K52zLRs68VhtKIYBYaqRo2llp5RY
	dL2dqeOogfHEOOFTpJYiYkwZzSLKA9bh1aghKH75DJhnSAzvPJfYdYfVNNN/ZrBovIdJ1yvXtUJSp
	4INbYb0Mny/KohcvOghiXIH/omSBkwQa90nWSkZ56zM/0ojPeQnkjMWhHg8CUbRgrP0AQRzRr+Hfq
	S+BbPGG95Hz9YK7povNc9okzFkzDXw/jfvIIrUbaKifPuNjKq3cLS3nrEcBT2AYZ808i6k0wHl82Q
	3gr7jjIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lG1-0000000EqAd-1PFs;
	Wed, 02 Sep 2026 13:44:05 +0000
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lFx-0000000EqA0-43yY
	for linux-um@lists.infradead.org;
	Wed, 02 Sep 2026 13:44:03 +0000
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-4b1ba286f6bso1574805b6e.1
        for <linux-um@lists.infradead.org>; Wed, 02 Sep 2026 06:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356639; cv=none;
        d=google.com; s=arc-20260327;
        b=jJuRZWZW0J0k6SHPIIYXY7nsG6twSTndTaEv/Bq5r5O+jS/nnl/cGDui1cmGT8RyS0
         f+sNFr0R/hcS3PjBv0DhDZC6jiB+hZovHh9Tnlsy/qZ80fFH/AChGL7skz81axX6gGtk
         aaGIu2QsJa/H9PakYZEvR9yHB1+4V4+RnLVzj/ZeTx6MHzG8gID4Sy83Z1PMDky3fXfo
         yoxBXfssx0apYlSL/7/3gxjFU/D9FwNE5i5tx0nwyP840VYluiWgvRspz5WtD07gmbsG
         Uj8jesDVDiwW6QgAa1zr1pH8lniwjlMtsEuifkLN4OvQU4QUsahyHLTTF95NManI4WxY
         LE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OH53ybijunYoNfJAXp5YQ5Xv4Y7ODEOPTSxs+1JBmaY=;
        fh=Qve61vYGjTu6E2AYPHS+a8goqo2zkKAnaJlOiRan1lg=;
        b=lquKBcMz8jY2C9B2DWDOg4KUm6HBmFQcIK2IO1h+qta8fEowUhPLO3WbTdB34pgOhw
         JdVcDJc387HO6zWPTN3I/sxrooW7O5X4WB9DpGwr2eMY//Pm+IjjFPUNhTzWABQFDYOs
         LzaMWfec9+Ni3IsQV0ZWnvmPqnUEiu0nZDqXjdyCUr5TPB4UN7ryNFXX1UT7axKO3AAa
         h7CG3ktJZrOHyRiiND0pyiIcmCyShxBYRgyAckjUYu1Per/cmuijIdNQ1F+gRUL57Jg+
         X1ZqpzD7hK3qf6SizN83CqgtJtQb+vKonsfWKCk7RP7GWxYnWwY2M25kGTjtreZHhqMq
         1gXA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788356639; x=1788961439; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OH53ybijunYoNfJAXp5YQ5Xv4Y7ODEOPTSxs+1JBmaY=;
        b=itEj/6kPQYHF0q3PyYtHhuBpYia/GtnC55AP5KT0JUoXTHqKx/YYAGc2lRVZc8AoY6
         I14MrjDBRn506JtrYIC/u9gLB8/SIsN/025jFqCOuG0L2zgVqlU7Zq+4NQSlZPE+bAT8
         qCZPWJkqdrSFvmtqS83q6K5Rmvhjpz0xE0clyODr2mFexUgh5U2CypYTEr8e+xhIAdtK
         zdPc59grWpL2+EviTiVBuYF3Fs2fY0eTJ9E9JSJMGW/0/aw25IE9CX6v5Uz/8GMIDVMA
         5GFa7mAb9sJr+l0hiDhRxWMG7fIGe8XuPeR2fPDomrYuY+r34nUrkz8xG3xp+OQhiNwW
         KMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356639; x=1788961439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OH53ybijunYoNfJAXp5YQ5Xv4Y7ODEOPTSxs+1JBmaY=;
        b=QZFUeFGHK4d6UWwYb/rkIEWvyMiS5rKc02QCbWikkSSSGnl06CEnMWWjjo2g2m+bEK
         zk6aqAh45Vgt3PlCZJZCQulLRa/cVF86hwlflxmopsyntiGJgX3k/ojQ+op/FtSV6QLZ
         /KqyE6FiQRWhy83ySEeuo0G0PRB1KeiDqujY8nXUYSFY9tTySFIUshW0AGyibJjDxyhg
         L7jL3jQhCEX/0b10wyVjhwvQQUGom50ZjMFOZl/EhOdYaarcWd4/7GgAqO+HEyvakXVF
         86zzpzNgOGH334G/CQZwr6bBB/OYyGtcwFu1pEJUfSRaA7zIFEK0ME8rXLQDiGvrCl1u
         q3ig==
X-Forwarded-Encrypted: i=1; AHgh+RpAcNvM9oX7nGOMS36/GyByPyMnYvvaUfoW0W4ILPnUs7zyNhH/Vwmbe9Ez681KiI36ksA0MoGEZQ==@lists.infradead.org
X-Gm-Message-State: AFuF++luJ5MdgKqBlrFauRfvVMXVuLaav1EmvifysEMhDXyAOZh9ghYN
	KcV/3YYE1vBGFkqi0IraE3C+a1AATF6dG2w2Qst9w9wOEDJoUePPw0tTDuH9Bdekq5GT8P+Q1tp
	+IFU+sVjx3Ogoc/UcyzNM0ug0nLM9h9DyT0Z4aluk
X-Gm-Gg: AR+sD115wdBsmeUobDYhm8i2SNSnu0e/lLBTRdK/zLIT+YXSdnlcmpfbu5i25tA+O3r
	1yV0dhQI4omRgMp6ctV5I8VdMzndkOKsfnEqL3w0gafEKsZQrVK7nPHjchPUQ0ZsEdqWO3kFJmC
	t2AKJ5pxPw49X/FsM+IR1jBsWSfK2LnOes0T38pW+2OKvMFPSqSa/jPoxZQPBUfD5m/Gjw8rMTl
	9GDhhIhofx3LsSQ2BNfhL+ZoHCUUlz8Qgw37HiPsrA1wdpzcJzIMrh7lWt4bxEvxJ2EHHrwNHhS
	h8KvWfjp84TUUvQmc/WhRT0ta23B1Z+WZ85rLaCaiw==
X-Received: by 2002:a05:6808:1795:b0:4b3:5da8:1da0 with SMTP id
 5614622812f47-4b71c52e940mr1827413b6e.5.1788356638926; Wed, 02 Sep 2026
 06:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com> <CAKwvOdkCGEYWnyJtWT=jArXkA47X==G0PU4UNV=s8htpA3Dg6g@mail.gmail.com>
In-Reply-To: <CAKwvOdkCGEYWnyJtWT=jArXkA47X==G0PU4UNV=s8htpA3Dg6g@mail.gmail.com>
From: enh <enh@google.com>
Date: Wed, 2 Sep 2026 09:43:47 -0400
X-Gm-Features: AcwNN1Ugm9qaNtJA4BValHn6hwKda3ef1jRT8zcSOcPUdm-ZVB0BjO70Z0pKBAc
Message-ID: <CAJgzZoqAqw6FzGVzr1=5n69xUFpE3krkzc4tbCDPjohFhz0zdQ@mail.gmail.com>
Subject: Re: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_064402_013818_AA12AD0E 
X-CRM114-Status: GOOD (  30.77  )
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

On Tue, Sep 1, 2026 at 5:45=E2=80=AFPM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Fri, Aug 21, 2026 at 3:46=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > The register offset macros in <asm/ptrace-abi.h> are guarded by
> > `defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)` for 64-bit, but
> > were left unguarded for 32-bit. This causes havoc for userspace that
> > happens to use identifiers colliding with these short macro names
> > (e.g., EBX, ECX, EAX, DS, ES, FS, GS, CS, SS). Without this guard,
> > userspace is forced to be super extra careful with include ordering to
> > minimize the chance of collision.
> >
> > Wrap both the 32-bit and 64-bit register definitions under
> > `#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)`, and ensure
> > User-Mode Linux (UML) defines `__FRAME_OFFSETS` for 32-bit as well.
> >
> > Assisted-by: Gemini
> > Link: https://github.com/llvm/llvm-project/issues/217413
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> + enh (who pulled this into android for testing)

for those who don't know me, i've been Android's libc maintainer for a
while now [was https://blog.linuxplumbersconf.org/2014/ocw/proposals/2337
really that long ago?!]... i applied this patch to Android's libc's
copy of the uapi headers (because Android uses the uapi headers
directly, unlike glibc, and exposes this header transitively from
<sys/ptrace.h>, also unlike glibc), and everything still built without
problems.

this does solve a real problem for us: llvm's coding style means they
have a lot of "FS" and "SS" identifiers that conflict with these
macros, and we see a conflict every few years.

Tested-by: Elliott Hughes <enh@google.com>

> Oleg, can I get an ack/nack here? Or someone who knows better the
> history of UAPI headers?
>
> (I think the Assisted-by tags need `LLM` now IIUC? Assisted-by: LLM Gemin=
i)
>
> We've worked around this now in lldb-server, but figured it might be
> nice to clean this up for the rest of userspace, too.
>
> > ---
> >  arch/x86/include/uapi/asm/ptrace-abi.h | 4 ++--
> >  arch/x86/um/asm/ptrace.h               | 4 +---
> >  arch/x86/um/ptrace_32.c                | 1 +
> >  3 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/include/uapi/asm/ptrace-abi.h b/arch/x86/include/=
uapi/asm/ptrace-abi.h
> > index 5823584dea13..3656955c6faa 100644
> > --- a/arch/x86/include/uapi/asm/ptrace-abi.h
> > +++ b/arch/x86/include/uapi/asm/ptrace-abi.h
> > @@ -2,6 +2,7 @@
> >  #ifndef _ASM_X86_PTRACE_ABI_H
> >  #define _ASM_X86_PTRACE_ABI_H
> >
> > +#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)
> >  #ifdef __i386__
> >
> >  #define EBX 0
> > @@ -25,7 +26,6 @@
> >
> >  #else /* __i386__ */
> >
> > -#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)
> >  /*
> >   * C ABI says these regs are callee-preserved. They aren't saved on ke=
rnel entry
> >   * unless syscall needs a complete, fully filled "struct pt_regs".
> > @@ -57,12 +57,12 @@
> >  #define EFLAGS 144
> >  #define RSP 152
> >  #define SS 160
> > -#endif /* __ASSEMBLER__ */
> >
> >  /* top of stack page */
> >  #define FRAME_SIZE 168
> >
> >  #endif /* !__i386__ */
> > +#endif /* defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS) */
> >
> >  /* Arbitrarily choose the same ptrace numbers as used by the Sparc cod=
e. */
> >  #define PTRACE_GETREGS            12
> > diff --git a/arch/x86/um/asm/ptrace.h b/arch/x86/um/asm/ptrace.h
> > index 2641d28d115c..439c4151f6b7 100644
> > --- a/arch/x86/um/asm/ptrace.h
> > +++ b/arch/x86/um/asm/ptrace.h
> > @@ -13,9 +13,7 @@ enum {
> >  };
> >
> >  #include <linux/compiler.h>
> > -#ifndef CONFIG_X86_32
> > -#define __FRAME_OFFSETS /* Needed to get the R* macros */
> > -#endif
> > +#define __FRAME_OFFSETS /* Needed to get the register macros */
> >  #include <asm/ptrace-generic.h>
> >
> >  #define user_mode(r) UPT_IS_USER(&(r)->regs)
> > diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
> > index 3af3cb821524..9e9155b0e918 100644
> > --- a/arch/x86/um/ptrace_32.c
> > +++ b/arch/x86/um/ptrace_32.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/regset.h>
> > +#define __FRAME_OFFSETS
> >  #include <asm/ptrace-abi.h>
> >  #include <registers.h>
> >  #include <skas.h>
> >
> > ---
> > base-commit: 26260251022fbc2f248a3d747a9b2b961b18d2d8
> > change-id: 20260821-ptrace_uapi-462350036cbd
> >
> > Best regards,
> > --
> > Nick Desaulniers <ndesaulniers@google.com>
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers

