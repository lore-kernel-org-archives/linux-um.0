Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9878AC44512
	for <linux-um@archiver.kernel.org>; Sun, 19 Jul 2026 11:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=; b=cd5TaBLZpBDeYoa8wbGxszcyFV
	ON10q4pHdGqNveJHoHUGdN1BIH1d6D9graZlxCf3B15nZ4oc2lTe9TFOZemKELawEMzFEIYR9pa7f
	MxJPu84Vuv0vcPI7DBqEq/Rg9YnqGTTjGyFo/aydkymi11EWXDTqGT1gKdZUTMuD8urlMawjdpxzf
	GHsr8EBAuOaGQwx0wx+L+Z4KO7AXm44R96YFgdax+79cFe78mDODG8Xt0XacFczZCbcBw3ICrZWyh
	ixTIyI4/q0NrpZS/f/Sn5JpRV6W2c8Xtc6EgPbkM3uvAwtPGpJ4J7J0Y4mGbvAHlXarkKMmZyzr6d
	x2It5IOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlPeY-00000004xKM-0ulS;
	Sun, 19 Jul 2026 11:25:50 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlPeV-00000004xIo-1XEH
	for linux-um@lists.infradead.org;
	Sun, 19 Jul 2026 11:25:48 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-69e2266b07fso6395865a12.2
        for <linux-um@lists.infradead.org>; Sun, 19 Jul 2026 04:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784460345; cv=none;
        d=google.com; s=arc-20260327;
        b=hoPYHku7eZzTyGr5EDXmXRQ6rwzqgh5IlC9uSqJF+JVB3l6/j+4/9P4rOTe46nc05H
         CJj4q4kUw4ejtH3qC2gFkTDZm2UhEHNSLi/9lf3ucmrS/4SYzFxCrrH4avhEvL65H6yO
         6DiZ+aZDelLjH0Gpvhq3InWei3WXzbMOwBtnU3yxTk6qlkobgmBLr8aRQ/Y5dyrUfZ/2
         AAC15d1Ljv8alTHbYkxKJ9DtP6aQWE2lCr1JB63JWLRkA29DtjPt5erAgECu8cA+OXlT
         v213MYiMfPDXOKTkpvIKugTsa+S++UlIsf3I4i2qsteR4VlGjplpDFvglhFzbgUOqI8D
         390Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
        fh=mHmw19RYcW/xN6f86r5DoLCTsag/+hNPDZtiONM6xV4=;
        b=QVu67gyY5nhpKUlgfUifBClzGcuJ21Hl4VcDA/tn0SjgbRnn3rmIg4Ywua20TVGGd9
         xM5/AiTonLD+tyP1hjWdOleIWIpnMq0bLPAQfwGisztSoHPH17hsO+1i2E1sLLKz0a3e
         i3gL4C/XOT4MVFCAW0zeFtBV68w1oDVNDpFOogAgTxAILRs4RUFA9vYzp6Mqvuay7Xz0
         jd5MpFSWWuAcm6gRpZwW5/ARU6DJT5aABjlTDboNUVWikPXtSl42OI+hytsulesLEQ1H
         zhzO3GGpNIignujXRcG4JV34MLpwsav0OW+jesw1nravNDHuxbVgFVNGMeE40y2tUaFx
         aT+Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784460345; x=1785065145; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
        b=PBt9MSGSK916HxWJhXMyTkOZqSVNztN8RET4AsIXYZGvR3WP7I9LanL17F7aSqb2ze
         NSmXPpUMG20q8s52MEG4UaqDANI9Xjmdr9ILCBZbbkkzEAuvuaEFUvkCbMFNsfliMREG
         TW116ZjA6o4L1PwFZa8/eNKM4PCEkqxRciepw0HcSpqtnsEtr0S/KbG4eGrkVy1Xtao7
         oW4ln8LqgQStZS0ZlZer7voUcYN2BqPVS9Nw9DGZZskrNeH2eyB3o2Fi8ilQtJdrexKA
         hCdajVencdSlduC7CadfrZXTu5jpnSSLdCFSFG00TCPj+LFYTxU5NWvMYjiFo5gzlH7B
         YirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784460345; x=1785065145;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
        b=NufJHfPqBEA9+tib7zKWphSdLQbMNTyz3ekqARsWZO9vpnBAa5ZCbOdvnXidJ0owj9
         CQRZAHo9ll+xzjTCYYXKc/7P5Mr1urx3vWff5Us3/tlh4nQLqO8hIciaF4LRPqXlAksQ
         c32NH2ZLRG0GLcEQEipwYgcB0h9HUgz7fiYaswinp9pwZL0TZ1yxyZYitoX3OWra9BO4
         RMAdpHXJakuRSVgzdBHnf3+KPUD1uLMFRqXEN0dCxwi6RWJ67PU4/stsgHMbEQVfopxh
         uAZBC6/I6/qosathcCh9sKOMZc3FiRaEW41/Czntq1Ov4rTa0iaifYvH7qGlrBfzt293
         xs+A==
X-Forwarded-Encrypted: i=1; AHgh+RpZiTTnqUpg7DwR6acrUyKjr36vtUifDIh2/ef6E0TCHPAIZquI1NCggxMTVZFg7sjBPUyAY+16jg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyKhQlEaed97g45FjvZA4g43N8tgT5VIQdqSdE9X2Uwi9sq7egn
	FbzYcrg1jUu6gX7i03Jq9JQ0I0DOTLqNFC30Y2QyAMv32FeXG6zbDZBLZrn1u+tAolC+ZWgysGS
	IE9zpKjimbbG9JcxEYPdF4jTNY9NsB98=
X-Gm-Gg: AfdE7clrGZKbTPinSiD4yW2Y5pS9wQSdhcHofyrzre1aqLWiVzZ9BUKQrkhillNFko4
	HTfbIZOXSLV0y/ZBq7Tmh6K0MgdRVOI65c2PhtPU61shjILnupZJ1avsfoR2jl4X60ybZZIystO
	CSKGs+/k3JQFIKHY1cWfDTvfP9bZQWnDD/FyCaYL2dpgzV7T4K8vIJt5yL5Rwd42a+Z6eiyo3xQ
	Em6CnM27YlwtlRcSNOmmzDlQT1tGRBL4wZ+/S+xXziMD5w1vnwm990gbplACQyWimwf/zeB8jaY
	l0YoXygsaxSP3dvQjU51l1EiQ2eJVa71szTkjzvnqQ==
X-Received: by 2002:a05:6402:34d5:b0:698:3b7b:e48a with SMTP id
 4fb4d7f45d1cf-69e652f908dmr3652615a12.32.1784460344585; Sun, 19 Jul 2026
 04:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 19 Jul 2026 13:25:32 +0200
X-Gm-Features: AUfX_mzTzrHRlu_CZJHA0P1GUw_Z2tfq0CbfsG-DFTqsEJDFIQx7LWbdfB3YWqk
Message-ID: <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_042547_422695_87AB5F29 
X-CRM114-Status: GOOD (  21.58  )
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

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>

Hi Thomas,

I did another round of testing of this series on Alpha, this time with my
Alpha GENERIC_ENTRY conversion rebased on top of this series.

For this test I also manually applied the seccomp fixup discussed earlier in
this thread, i.e. fixing the recheck-after-trace logic in
__seccomp_filter() along the lines suggested by Jinjie/Oleg.

With that in place, the kernel boots on Alpha and I do not see any
regressions in the seccomp_bpf kernel selftest or in the strace testsuite.

One note: the seccomp_bpf selftest run on Alpha uses this not-yet-upstream
Alpha selftest enablement patch:

https://lore.kernel.org/linux-alpha/20260203063357.14320-1-linmag7@gmail.com/

One Alpha-specific wrinkle I hit while rebasing the GENERIC_ENTRY patch is
that Alpha cannot unconditionally pre-seed the normal -ENOSYS return state
before calling into the generic entry code: syscall_set_return_value() also
updates r19/a3, which is still syscall argument 4 on the normal entry path.
Doing that too early broke early userspace mmap() during boot.

The Alpha conversion therefore handles this on the no-dispatch path instead:
after the generic entry helper returns, if the syscall is not to be invoked
or the resulting syscall number is invalid, Alpha skips the call, preserves
any ptrace/seccomp/BPF-provided return value, and only synthesizes -ENOSYS if
the return state was otherwise unchanged. That was needed for the
TRACE_syscall.ptrace.syscall_faked and syscall_errno seccomp_bpf cases to
pass.

So from the Alpha side, with the seccomp fixup applied:

Tested-by: Magnus Lindholm linmag7@gmail.com

Are you planning to send a v2 with the seccomp recheck fix and any other
review fixups folded in? Is the intention to route this upstream
during the next merge window?

Thanks,
Magnus

