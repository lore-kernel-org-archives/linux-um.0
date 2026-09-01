Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AA2C61DD6
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+cgiBuN8pwAqtwrYzI+JS4k8m7KC3ziuw/j4zEg8Z38=; b=HT7v78TLuhnAsh1ga0DjAeyhWJ
	TkiiBP/buCEXceQmBeZYub35uqqIKzJxpvK9dOTe80GFHFTW1zLQE52EQq5i9ymXceEAKCPIVCeyJ
	ArwG5ViZc8hziv3muf75v3xfXr0sgtJjhw8f+eoKFaVLosnzu1/+1iRya2yZgt4mXGnz9iowwQN/B
	+LrpcvEmGAgWo+EO9nG4MdXBl6qe7UAdzhg4/QFveCPdOf+zWF5YgSQ9zoc+knetG02eCFdOpXUCn
	vMCb2FWYz9sSwEk970qHUAsp1HfMrW2M6uGta4MRTj/8HnfpwhZ3AHciqKZmx1ifWYqFDgPT+UdPE
	JqRnsP2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1WIF-0000000DPjQ-2nvH;
	Tue, 01 Sep 2026 21:45:23 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1WIC-0000000DPj0-2HHe
	for linux-um@lists.infradead.org;
	Tue, 01 Sep 2026 21:45:21 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so1958985e9.1
        for <linux-um@lists.infradead.org>; Tue, 01 Sep 2026 14:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788299119; cv=none;
        d=google.com; s=arc-20260327;
        b=NmFb+PurMH+f5f1vOmfHwcQ+yvTgImnjKy7w9t/MCGkL1l+Q/OX53w+r1mYuvRAa9p
         /TtAMCUVYGP3M97CpI0aVv+Z5bODn9zr6G4C46ncFhBiFAZcqEusSqg94WqJPBp0DXnI
         R8ZpJrw876+XxuM9JyAb5GbiTpOXOSFOCvrLKI+3lxCf5sdSsiemm0L9J8/ZCt7uwgtP
         hWmjcvKPjXEft00edrLdj2yP96uEN/DQadNAz933/eyYQehup5W1uGhR7jnaCqJ1ZChl
         pTgIQHuh9YWFmXeU4YXFs23g1qHfOhKr617xyNBopXnId3R44xJZFg0FI+xprtPyccwR
         SuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+cgiBuN8pwAqtwrYzI+JS4k8m7KC3ziuw/j4zEg8Z38=;
        fh=EYnF2MRtlf+Dxel5lizi3fe3lUPAAIBm291Ooeu1V+w=;
        b=nIZub0FVAT/BEk8GNHPUSRZT3n/FiIoV7wmOqEtJZxLfxuoWTq1IBjSZkNYhSnZK7+
         Ls3czmS6Hjm9/z4sMUlZEKQoD+E3DcqBgn5dIunqZwRR274mSkBggS073rYdrY4cbuoR
         REtmaoA9C+tO31Q3zcxfl/DW7PTxMCyXxI2F6OVa+CDkYBoXYqbghZppZFXAu42JrkO2
         ia14mWkYcgCMEZxKC+IKfecWoZdtxXGdkWVGXZUi2t/zWnyJ0nGNSXccyhmtATiIoM7U
         yxDXTc9CK/rt9o90ROHrOWVpJv4w8v2xtB/F1AjffuBXbjBOQWyS9CcgO82nawzomUus
         odTw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788299119; x=1788903919; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+cgiBuN8pwAqtwrYzI+JS4k8m7KC3ziuw/j4zEg8Z38=;
        b=kpoyDK4oaHt1Muz95Cvn85bWiYVkW9j93tqTFJggZMaAUmB2rgFtywCfgdyBQhNV5Q
         fN3FyAtMxGU77/cJRBpHOfiwwbszBppZ46U6k47dyf9chJse6BAkTs5lvS8MGQSXtpbC
         nWxPaopwPt3gYIvtNYTzG10Ok/47qHWKhLAFoAJSmLiirRZoTGZHK4eT6VV4JbH1plRE
         5YxcWuHMFC3u7k6xo2n181uKLxqnfTBFWqBo8dO1yDD0wpp+6rcrxKCESipU+KN7xLS0
         e2m+OEQphYSxWvA5zouJp6aE3paJ8ZRn53Zv08ZQ51jBUBhkge1ShaEt3m9VSGCzJTK5
         xuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299119; x=1788903919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cgiBuN8pwAqtwrYzI+JS4k8m7KC3ziuw/j4zEg8Z38=;
        b=Ch5qPTN9qchVEZ4tEml8algK7WiJJk4NslcH0oTauMQNOoMNOs5ggYa3KOXk1Puz36
         ycULhCMU5GXzOrXwFnf4PsYhTu8LoDEyuaOGsxWfnTwMI9qp7mqf3tl4b60kq6h72LqK
         jp1T9Ndub+Zw8tExljdTIb0l1lETBF14xQ8j8vFabOe08BL7LFn0aYI6bXWfEZ1MW3ek
         EQqgEJXJWrVJmDmIuakNy8qgRUwbSJyJ/gE7gY1SSumVKm0BdwYdwPskQscYpNCW7a+s
         fyPwTOoKlxU8kKBmZ2rtGAfTnIvZka86rnKh4CeO13ogkZvGcMJJQNjWBbKsgPZLButG
         Q9Ig==
X-Forwarded-Encrypted: i=1; AHgh+RpryhdShk3Zki1a0OMxzc6DWPwW9wlcw4/szIVL255Hv6TvU1h8j3Z282nR9hEc6ik8wzIonU3zqQ==@lists.infradead.org
X-Gm-Message-State: AFuF++kaII3yUDG68LH2CVSVM/bVv+kgdGrhp5FP8gVAR+alqKhoqOCd
	whX8KLPn/Dz/gCOTQXwbxSItgFzWWlJuqDtBoQluGUFk0xJP9YWjGKRE4pWR4NEj66QKvcEozwY
	H+w+ySNgYvAqpPJ+PtXK6ARGO4TlErW56Co/CeNc7
X-Gm-Gg: AR+sD13BIOUF4UyjgkJETwk4UP2nyGMFqJsdfrlydmHH2j/Vq3G2W8uHWAeerabfL/t
	cUVpHw0oUKOEf2Aa8/jeQeUQN8DE226S9cDg2Wc60OaPkgWRrAAgBsJB+x196SNEd8apdvDNH5i
	v0cd0tufs7ScJcKwcb5I+/dfd3HVsOWV06s3NkWGEGohz+wsjtFAle8T+Rsyhmt3oswbQ3x/CG5
	DqRaPTXdy5gSKqcNtxTeTrZS0MRmkhVmfNBEPUwteWuXYf4jElpIiShAOxGtWVJopkNa3h28Ouz
	pauXnf3hX2vTbdx1DkSPhr7g5T/KIFdqoSVvfLbkFg4nJjPurbdJzMD28dWOzS8y+ArJ097MmZB
	O+mOerqdrIuXI+DigdxVPPk3U+8DWMYagZX6hl7D/fqf0igS6K1b7aW4=
X-Received: by 2002:a05:600c:474a:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49ce55ecebemr7900675e9.2.1788299117930; Tue, 01 Sep 2026
 14:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
In-Reply-To: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 1 Sep 2026 14:45:06 -0700
X-Gm-Features: AcwNN1WJANZf5K-B56FXnnbRv_nEZ-c1YRWO7ycGekrQC4yKcYcwf7zg-0bzQpg
Message-ID: <CAKwvOdkCGEYWnyJtWT=jArXkA47X==G0PU4UNV=s8htpA3Dg6g@mail.gmail.com>
Subject: Re: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
To: Oleg Nesterov <oleg@redhat.com>, Elliott Hughes <enh@google.com>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_144520_666754_48287FA7 
X-CRM114-Status: GOOD (  23.67  )
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

On Fri, Aug 21, 2026 at 3:46=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The register offset macros in <asm/ptrace-abi.h> are guarded by
> `defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)` for 64-bit, but
> were left unguarded for 32-bit. This causes havoc for userspace that
> happens to use identifiers colliding with these short macro names
> (e.g., EBX, ECX, EAX, DS, ES, FS, GS, CS, SS). Without this guard,
> userspace is forced to be super extra careful with include ordering to
> minimize the chance of collision.
>
> Wrap both the 32-bit and 64-bit register definitions under
> `#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)`, and ensure
> User-Mode Linux (UML) defines `__FRAME_OFFSETS` for 32-bit as well.
>
> Assisted-by: Gemini
> Link: https://github.com/llvm/llvm-project/issues/217413
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

+ enh (who pulled this into android for testing)

Oleg, can I get an ack/nack here? Or someone who knows better the
history of UAPI headers?

(I think the Assisted-by tags need `LLM` now IIUC? Assisted-by: LLM Gemini)

We've worked around this now in lldb-server, but figured it might be
nice to clean this up for the rest of userspace, too.

> ---
>  arch/x86/include/uapi/asm/ptrace-abi.h | 4 ++--
>  arch/x86/um/asm/ptrace.h               | 4 +---
>  arch/x86/um/ptrace_32.c                | 1 +
>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/uapi/asm/ptrace-abi.h b/arch/x86/include/ua=
pi/asm/ptrace-abi.h
> index 5823584dea13..3656955c6faa 100644
> --- a/arch/x86/include/uapi/asm/ptrace-abi.h
> +++ b/arch/x86/include/uapi/asm/ptrace-abi.h
> @@ -2,6 +2,7 @@
>  #ifndef _ASM_X86_PTRACE_ABI_H
>  #define _ASM_X86_PTRACE_ABI_H
>
> +#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)
>  #ifdef __i386__
>
>  #define EBX 0
> @@ -25,7 +26,6 @@
>
>  #else /* __i386__ */
>
> -#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)
>  /*
>   * C ABI says these regs are callee-preserved. They aren't saved on kern=
el entry
>   * unless syscall needs a complete, fully filled "struct pt_regs".
> @@ -57,12 +57,12 @@
>  #define EFLAGS 144
>  #define RSP 152
>  #define SS 160
> -#endif /* __ASSEMBLER__ */
>
>  /* top of stack page */
>  #define FRAME_SIZE 168
>
>  #endif /* !__i386__ */
> +#endif /* defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS) */
>
>  /* Arbitrarily choose the same ptrace numbers as used by the Sparc code.=
 */
>  #define PTRACE_GETREGS            12
> diff --git a/arch/x86/um/asm/ptrace.h b/arch/x86/um/asm/ptrace.h
> index 2641d28d115c..439c4151f6b7 100644
> --- a/arch/x86/um/asm/ptrace.h
> +++ b/arch/x86/um/asm/ptrace.h
> @@ -13,9 +13,7 @@ enum {
>  };
>
>  #include <linux/compiler.h>
> -#ifndef CONFIG_X86_32
> -#define __FRAME_OFFSETS /* Needed to get the R* macros */
> -#endif
> +#define __FRAME_OFFSETS /* Needed to get the register macros */
>  #include <asm/ptrace-generic.h>
>
>  #define user_mode(r) UPT_IS_USER(&(r)->regs)
> diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
> index 3af3cb821524..9e9155b0e918 100644
> --- a/arch/x86/um/ptrace_32.c
> +++ b/arch/x86/um/ptrace_32.c
> @@ -7,6 +7,7 @@
>  #include <linux/sched.h>
>  #include <linux/uaccess.h>
>  #include <linux/regset.h>
> +#define __FRAME_OFFSETS
>  #include <asm/ptrace-abi.h>
>  #include <registers.h>
>  #include <skas.h>
>
> ---
> base-commit: 26260251022fbc2f248a3d747a9b2b961b18d2d8
> change-id: 20260821-ptrace_uapi-462350036cbd
>
> Best regards,
> --
> Nick Desaulniers <ndesaulniers@google.com>
>


--=20
Thanks,
~Nick Desaulniers

