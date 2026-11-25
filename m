Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52E606A31E
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gmW1aF6i;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rG3MCIF+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=yvTWhALg+lt12R9VXApxogyKbQiK2UrYUpNz/RviIDs=; b=gmW1aF6ilOBocv23wO5QvOXgEv
	xZ+XdN0MkOq4CC6IA1oVhHMPOzyohBY7B7VGECXmlqTErKF7gCzHpSF1dI7ShX4nDH8jbcBXesK62
	bwvjbDfZnUCTXHEF8b1VzFyV9aZMoTMOhXnsgXlgWy2r7HreoA3Hl9J/+hWBQ5UXQDLa5fzZd2u2k
	zrnCToV9xxL7rKaDSXdz7Ri3OMRt/COh/IsW6EiMYr5NXP3I9cWvztK4XYctyudjSBnEdJlkiGTXK
	VQGHM5LMeLSy+EFG4z/iMZuvxwcopkItAPWGXQaPOtnlGpD5bJ03Ay6IL+eLXeiv0uaYQa14pUh18
	vrThd0+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9RQ-00000009KSk-1OW6;
	Wed, 25 Nov 2026 09:37:28 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9R6-00000009KFa-1f7j
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 09:37:09 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-5364d86f7f0so58292531cf.1
        for <linux-um@lists.infradead.org>; Wed, 25 Nov 2026 01:37:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795599426; cv=none;
        d=google.com; s=arc-20260327;
        b=Mc/cpx9XqsEqPZn1axSF203ZuwwxVkK7sM1ZyFPYAzT/xB9agrYbQN7iIqlYNJ6Bh7
         2kb/oMzFVGDnCdv3djN07Ns9kh8bMtl/+Hkc3lvqFYBbnt2AsEIxYGOsoePqS1LaKSFj
         W9rdN9FMUZGgU5RrqFFsQaXY/S3yoSFY+s/7FkoJ8sefDoX1muBm/DfsN7XTC2M7q2ME
         dqBpsBrShrWTYs84EjPE1BLznGmFcyXywxEVB69kGMgWEWAFx//P4/mBDi0vrmqRZiGJ
         O/flwcserf/tHgzX0yjJiZzk2L3rWNqoO/SMAakb+GY11fXhAbwlZCNJj7a76JqCRP4X
         AHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=yvTWhALg+lt12R9VXApxogyKbQiK2UrYUpNz/RviIDs=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=hJmgPSixpMZ5fgNT7AX9B4mbvj2gE1mZ0lqDajPfM7ZyUF6TcXGKOPKrhjyae2AAq2
         gJrzj5DYs40u7ZovGwksvOIJn1WXchiR94dp6wbqfIz4crQAetStZw2ZKAmt2qBM0FWU
         Q0ohvWu0MDEKh3mZ5suz1Zhg0/EJfflKMayrsyMbsslXeRLJOU9exa4HScz3CY6zNrdA
         PCMWsH6l5hxqpFZWdvax7zan6a++pnSyaUik48fVJ3yWwjP+CGUnuYjja6AOajA3s1Rf
         VE5sim77DT/ZuXe6foZ46qwRZXhzWr2luJhijOuf5++GScIDt9xJ6wpNzIxsJiZsu2Zk
         TVgA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599426; x=1796204226; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvTWhALg+lt12R9VXApxogyKbQiK2UrYUpNz/RviIDs=;
        b=rG3MCIF+tkj6mnTx4Ro7d1pp4d4aHzrSJLWPrZZoVpnggiWDzRP+opUWft74FIjJIz
         BtG5c/E/BJwk71iDTUpjNHD+HZ+B1EaFqiqR11+k4GsCDUkuQfUT6yfKwIOpCYVCrY4L
         9XgH9MVd4Ri4NJL9yMuxr3ALSXM1B+iHur0tH8xpNuw07IcLdIcxdd866GFRav3xa6xQ
         l4icY3IpmH5EizJSKJs74WNPWddRe0XNWIvcTBYWznJVE1IfD1xWsMW+nCLQG028F8fQ
         2LBe25mu/rK2QnvZB8Bs7aBNGI9Oatsn2PIVyGZC8g9XkeY4iafgAm0wdv06nk5xxCVG
         HM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599426; x=1796204226;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yvTWhALg+lt12R9VXApxogyKbQiK2UrYUpNz/RviIDs=;
        b=vcWcBqyzrEyb+ddHPKOwHE+uKAx0Or412h3QOQjXJbyYogK+edpgmK20BzBOpNCFM6
         weEUzM6SgVl9BLQgEztR4pMcWmzCPSoAOMNHDD2ZLJyspX3Kxsg8c8ssIMOi9W5fwRfv
         UcjxfkGWEDkaj9e8A50PcboBJCESvyODjsOKECCmrxkAW/2wi0HjGiqpZ6ZHKnfEkp2y
         P2Bu+zTtsPsjwLVj/cCS4ETDbn8bHzsmRCIk6hT2JRy9ehF32nE27HXrjm6pTwIexYq5
         r2f0XLBE/j3ySh8bKQjqQ0XoYI2z6fgHAiHDWP6hfYPccsClNPGmBqQtMi8xWs+ovH2w
         VP8g==
X-Gm-Message-State: APuU4Z/5VaultdFU8Iii2gE8uUaQWAfkw66h0GVo5CCJVusiEo0L6e2j
	Q79M5+dmiNRW24gQclMkEb6c9A2zdzaVkfaSoL9ky8UL2iZPMGf/EyAhGJ2K0f+3YKIMYG1/sFY
	Vk/tyO+Fc1P1gSjCLNLmG00sj6R7RZGOliTUH
X-Gm-Gg: AZFdTZeWicleXtK8XWKBIK0x1gXKX8uM1i+ANpI5Kpk7q77FOemzXtP5iHVc4qXwtgq
	TGJanNBVkJSZSCOxsZ/EtR9cjuqgmOwEfifywICFLhk/PCTH36qPeXBbS2rHs7gBi22zz81c6LU
	JTePSnjR/tZ6ElMhviscjl7TyycyJUMSYuC+s6C/CkzW9HCU8Jo0Kckb7/36S59cNTUfBORB4+M
	2KIBpuiZAZD6oT1nBWeHsp/lwqKD7ack6ijkH4eYiW4HRPrH8LShUfoFmHNML3fY7ReSNer1ja1
	D+T6Y7jTgfdW+PV9eJK4O30zNLtFTa+Ac1gB/MYo1qls7KBdtT8z6NhN9YSBYirjLBIQkcKIMYz
	m6kyF1G+RKi0+uiMoqY3ofqV14Adv4vhMXAk+4JYnYU4wWU0OLG2/
X-Received: by 2002:ac8:598f:0:b0:536:620e:90f7 with SMTP id
 d75a77b69052e-55d76a2027amr310450631cf.39.1795599426568; Wed, 25 Nov 2026
 01:37:06 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 03:37:06 -0600
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 03:37:06 -0600
X-Gm-Features: Aa3M54oB1FMq-8uSMBR0uJ9vo7jNCaBoI4Xzf8ut1F9QTW0M-e6p5Wu8M5l6RL0
Message-ID: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
Subject: [PATCH v2 0/5] um: Use the generic vDSO for UML/x86
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_013708_492371_F029784A 
X-CRM114-Status: GOOD (  12.76  )
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series replaces UML's hand-written x86_64 vDSO with the generic
vDSO framework (lib/vdso).

Changes in v2: patch 3 now skips TSC calibration explicitly when
time-travel is active (the guest clock is independent of the host
clock there, so the host TSC cannot be used), and the clocksource
registration in um_timer_init() is restructured so the original
call is kept verbatim instead of being removed, keeping the patch
free of long removed lines.  Patch 1 wraps one long function
signature in the shadow headers.  No other patch changes.

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

