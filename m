Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E4606A32C
	for <linux-um@archiver.kernel.org>; Sun, 22 Nov 2026 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zzhByqC8;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qzz3DxJS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=E19SZfpkDiocYs9XnZbWGHZ66N7bbdKVZ4Xp3vsd+Pg=; b=zzhByqC8aonHMA0JPTOPhiSwy3
	2Yz3nD2BWAz7MSKaZJ9MgBQqv9gdhlsBomD3BUxSEEJQI3lWPFro4mcCEd9mfY67H0u88i8YnhewI
	yU4+AjkEewLBPgGuZnbXmVFYlm+nYk7ystNIPkz4mPxwsNZgip1kEvGzmlW4zlwlGXYF/nY8WosDP
	2hF1XVqbNUW0lQlQp4rid3hOlc7TDKw71tcJRTQY1ieA2HVqUP7MKGpcLL5KHYWhxqj+zU3tvCu4F
	kDlPoMp6gY9A0NLfvxlB9GkOarNG/+fXwCsCIl444X8ztg0jI2VVN+oAZ6IxWYpiHzvalN4Lzxw06
	jj2CCHUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7pE-000000019Pi-0vUd;
	Sun, 22 Nov 2026 13:41:48 +0000
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7pB-000000019PK-1hrR
	for linux-um@lists.infradead.org;
	Sun, 22 Nov 2026 13:41:47 +0000
Received: by mail-yx1-xb136.google.com with SMTP id 956f58d0204a3-67da69e7c31so2403244d50.3
        for <linux-um@lists.infradead.org>; Sun, 22 Nov 2026 05:41:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795354903; cv=none;
        d=google.com; s=arc-20260327;
        b=AOWZ+X7AExhPw/eH5lwjYxCqgtwkohSSVV63ZGeqhwKN9DDIf0lAaodVLZ8zhb9OwX
         i+4Lyws1YWS5xXA5wfxce570UTPbEYMOaVojceLc4qEaWFiHwSHbp3bkxadsKbbctViy
         USvPyRO1raByXyLDh0NP0Cvgky9j6tvPuHxbnN8X0t21jp32IKg8oMc+EyVzoFfqpRCU
         pmzsIc5KBAXzeMcBnV8L1bfINpNzoazOfRmT3l9HFPozohDqfmLqDwZ71qCYh9rlz8tE
         uTVrP+AdnhEKo/ZcqjJBQSJ4jGbA+3B4OIpHj0dH6lVWS+M9PTlI7RvAcnWZCF16yuub
         ZbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=E19SZfpkDiocYs9XnZbWGHZ66N7bbdKVZ4Xp3vsd+Pg=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=T8q2s9PbOjEau2X+6bjZi7eswyiWP7YIu0FN5ni1rzKFLrQnsCj1SD48bdTJ+gRUTP
         imHL2iSTNULdGRe1PaEinvAEFwsMI4zHb+n5GoYkZaAxpWh+JHNaZ9y/WtajW0mxeZV1
         nJU9fjeb37T8+aQIEU/k9LPmZGUccxUfh4oojbEfAmJwA03FN6+rX/v5HPmxMXXWYdsz
         Bx9e/FWlakL8F+Ii6G+DaGVfrhvthzFxg9owRMpunDskMHfdcwQHW1lI5RagW5ToKyCI
         sjD3p65iRnAWv/izeg3IgHJ0CtzZP2+rYyvFcQ0YQrYMZ73kDYLZd8LSEOoIOFeSehHn
         eNvw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795354903; x=1795959703; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E19SZfpkDiocYs9XnZbWGHZ66N7bbdKVZ4Xp3vsd+Pg=;
        b=qzz3DxJSABrYVIFxosmQ7B2wFOXInQQibOVseuS3QJs1T+JoVvlzQtqp4S0/NvOXiC
         8sdkbvsZsUmJI8Q4U0RMYGMSXuBWMcJOGmQdFVpTkCy5rBndGGgUu8en09SxLPuhpO4Q
         v19LUuGqnebyiuQQALuQN7F+uzhjywF1+UDLgGjNgmOK3+mYDLthUm9ifVOg+ZUAdWaX
         J7/bvdgYh/Fa5QnlpvDpaitI8PZyua2ghi0Hbed5iVyp4u7cVROtwZ6KjDcY2SJzYu0B
         xUBvoCvbM53e7VJwB9TU6aM6269mHj6lywjSoBFZEQn7mjF0qPnuHw1Ees7M4c6BqK9L
         npaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795354903; x=1795959703;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E19SZfpkDiocYs9XnZbWGHZ66N7bbdKVZ4Xp3vsd+Pg=;
        b=URpaTKcu+xQWIfgoerZ2zEgM434dJPLKo0OEJoDVb7RdWIVAQCv8WJEHrqKilB+h/8
         NsZW9joiN+LFPFFdx2rTxWolUfL47o//QDehi2/dbJSdhJL6eZKdmA8lNoolLP48dyyx
         zuVJueMnp9wG/iOTnGg18L7WID+SnDmJDuaEM2c8QMjWFiaC93f7M24y+9SXbLoA8gD7
         TZA+ChK4jehhNBY5Iu1G5Dy0GHSDUmXGXXjJMPP+IgfAWrBNYoArV8KXA7gFxc51o6bG
         ukNx1UA9UuecVMN8JTHAW4UFXQjlm7F0fhCySp8p3Yp3T7wbLMQaLHcswxRPVfHTVECJ
         Uj2w==
X-Gm-Message-State: APuU4Z8HKTu5e+v138YzpmxnZlFrMDGeXiVMUM/NwVcYD++fvZjCHODS
	j4CcntuclYmr/Vkf8czMnJDTFUNSWDJQhdAU/+UnnVnhz6b4JO1pWBeGnjp1bOMCj1wr0uWFn9J
	h/PQCcKsV0b9C2/nIyD7dELaP3Qdq/BZTv13GaUE=
X-Gm-Gg: AZFdTZdZPXNZdjCqYGrSEN/Abdo8AGewXHKipF/UO1wvBuIXXj5jBjcOv8ppFsV0iD+
	jk2MuRAvA9AatzSJjR+DvkkgrrlPvMsKSURDYD4idUd3HXxPLsuTTkWPP+7u3vZtIAgq6XTb30j
	RvFLQzWsEO/sQQ/nlcAfU62yRdiMb0/D2wFWwvOAWyCf/eHUIqgxrCopwG7RXO2aOnVzK5Yo3Hf
	z2qeWUCU+Ll6ZjJole29hoPFNrdRIIiPGFk9z1VDdFkptvwJBkDEihE4kbZfMWp3Pf7YfBCmhj6
	O9x69QwzPwnd525Jixqmb893JpqiqG2mmm616kqWTV87JxCMjuB0ZwwOo1NHyHsNfkTgfSi2Ih6
	bYibGBMuYa31+IMRYQwe9IbfzHcnPX5ZLTl8=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:690e:1287:b0:67d:b5fe:1ce1 with SMTP id
 956f58d0204a3-67df44101bfmr3527022d50.20.1795354903250; Sun, 22 Nov 2026
 05:41:43 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Nov 2026 07:41:43 -0600
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
Date: Sun, 22 Nov 2026 07:41:42 -0600
X-Gm-Features: Aa3M54om3IqOhvlaFMMnrPPkhsIA35eOVqgBmU5x5UIKas2_YQR0hsR_R6MSvyY
Message-ID: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
Subject: [PATCH 0/5] um: Use the generic vDSO for UML/x86
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_054145_492606_E72B7067 
X-CRM114-Status: GOOD (  10.31  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series replaces UML's hand-written x86_64 vDSO with the generic
vDSO framework (lib/vdso).

Since 2011 UML/x86_64 has shipped a vDSO that turns every __vdso_*
call into a syscall so that UML can trap it (Richard Weinberger,
"um: implement a x86_64 vDSO").  That was the right call when UML had
no way to give userspace a trustworthy clock, but it means every
clock_gettime() still pays a full syscall round trip: about 36 us
in our guest measurements.

The guest can read the host TSC with RDTSC without a trap,
so there is no need to bounce to the kernel for time at all.  This
series calibrates the host TSC at boot, switches the timekeeper
clocksource to it, and lets the generic vDSO interpolate the time
in userspace from the TSC and the vvar, following the same pattern
as arch/x86/entry/vdso.  Measured in the guest:

  clock_gettime(CLOCK_REALTIME): median 70 ns, against
  36,535 ns via the raw syscall. In the boot where the
  syscall baseline was measured the vDSO median was 80 ns,
  so the same-boot speedup is 457x; at the typical 70 ns
  median it is about 520x. Monotonicity, drift and reboot
  gates pass, 6 boots on 7.4-rc3, 0 segfaults.

The patches:

  1. um: vdso: add shadow headers for the vDSO build
  2. um: Kconfig: select generic vDSO options for UML (MMU only)
  3. um: time: use the host TSC as clocksource for the vDSO
  4. um: vdso: add the generic vDSO alongside the syscall-shim vDSO
  5. um: vdso: wire up the vvar mapping, layout and build (MMU only)

Three things I want to be upfront about.  First, patch 1 adds shadow
copies of four asm/vdso headers because the x86 ones cannot be
reused verbatim in the UML vDSO build (rdtsc_ordered() needs plain
"lfence; rdtsc" as the ALTERNATIVE patching machinery is not
available there; cpu_relax is already defined by UML with its own
time-travel handling).  These are workarounds for UML build
limitations, and I am open to a cleaner fix if reviewers prefer
one.  Second, the generic vDSO is MMU-only: patch 2 selects the
generic-vDSO Kconfig options only "if MMU" (following the
arch/riscv precedent), because the pulled-in generic code calls
MMU-only functions and would break the NOMMU build.  NOMMU UML
keeps the existing syscall-shim vDSO, and the NOMMU build and
link are verified.  Third, getcpu and getrandom are deliberately
not exported: there is no guest CPU number in userspace (an x86
RDPID read would return the host CPU), and the RNG vvar page is
out of scope; libc falls back to the syscall for both.

This series is based on vanilla Linux 7.4-rc3.  It was developed and
tested in a UML guest (4 vCPUs, 256 MB, seccomp mode).  The 32-bit
(i386) build passes, but UML builds a vDSO only for x86_64 upstream
(arch/x86/um/Makefile includes vdso/ only in the 64-bit branch), so
the vDSO speedup here is x86_64-only and i386 is unaffected.  It has
not yet been tested outside that setup, and I would appreciate review
and test reports.

The commit messages and this cover letter were drafted with the
help of an AI assistant; the code itself is my own work, tested
and measured in the UML guest.

Signed-off-by: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>

