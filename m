Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0004DFF5125
	for <linux-um@archiver.kernel.org>; Tue,  7 Apr 2026 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gSINc38Cy5uCy/SOLZjP/5z73q6WQERusZs5SUoSVOk=; b=FBHPN9LLVFD/neOplPJErTXTf3
	FMOLsN5u31w5Jm/G4ux49pP0tuD5TC8ivI9JA9Ubrvl7gKa6LssIElJEh+ygS6lWy0mCaqHQ2Cgmg
	9CH+E2b728MAF2K1QT0l4Hnw0fncSbMnutL49Mn+5QdWzNuXv8E73Nkc2hmyhzlGZNTIujNWz76wi
	yBlQzCWK4oWnrOkqRp9gb1rB0PoIladM3WW6nlTs/otvx9+9B7zeVa0nkJfihW+7P/qAJ5fbP/9Nc
	Lxg2u97EhbPQxq0LT5IVfPlwebmGGy9JH07nQcPNB2819/Cu7KL9KWBmL5NUP1KnkdWg8Dr7xL0nb
	UwFenzDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9Y8-00000006oQm-2FDw;
	Tue, 07 Apr 2026 16:45:12 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9Y6-00000006oQ0-2FTJ
	for linux-um@lists.infradead.org;
	Tue, 07 Apr 2026 16:45:11 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-8a049a767c3so609476d6.1
        for <linux-um@lists.infradead.org>; Tue, 07 Apr 2026 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775580309; x=1776185109; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSINc38Cy5uCy/SOLZjP/5z73q6WQERusZs5SUoSVOk=;
        b=VKg3PgcRtWn7eG/dlK/Ak7EGmqUj6T5QTNkilZ2Z3oFHqVOXdE5hM2V81FKL0WjVlC
         fnaHGwLV7U5O2jGiTOPFbf/pDsP6PbqfN1fYHf6dJU0aBjHlt6u4H11VbxdcKqZhKhiO
         CX08WUjVbNvYOMGsc+J5nie9dMYQkbdSy8w37/CfOmVMjknqXs/3oIzN96a6nqMmjPnU
         q3k3gLVRh8m/9vRimzCVzMtFK2sTiIjeHHbEBdMw0+ZV/YKvmDJuRlsO1kHszRJIQn3N
         nS5nBphrKgL8JTWNx3GJ3yeGiW7wLnWNA2Fq2dZdr9bBTYyIwFpNYUHLWn4n/OagboJa
         0GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580309; x=1776185109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSINc38Cy5uCy/SOLZjP/5z73q6WQERusZs5SUoSVOk=;
        b=mb5or+p79kqLLmRcIbGTlulvipEFW1MvxqKeGsLAQLWwoEupe09PzJC+epEIgQg//c
         8HBDMGNC2nH7dGaUQRayGW3sH6hMnQolwvdBkeNgGn2SlF13gVp4vR9f5XHE9WU669ro
         Ni3sJGD+RzL+37Vj1iM43mjcYFwhXEKU3FTA9kZZaSo1ID50FE+8xauApGCHu1+PlmJD
         kgJPf83CTXEWCS9AzqKyNrqhiRomDiBA1SXklTKNWUOe2g48dbhQIAaDtWVNTtTN60yN
         WrhOrXbyY1ved1xC8V9cSs4AgvGm2yP7ZjG7mxT91pEsDzX8+peu8GGuRNEqd8tfRCs/
         IZ2w==
X-Gm-Message-State: AOJu0YxyW4uyyfSdPAyAFuVBpfXjrB2ttVJ4foybTVyhNaRZy8OBzmtd
	WpPiZYV2+2CtMAE+cFq/IyFpZVxHT/Gh3lbYMEqezVgujoaKcZp6lZDr
X-Gm-Gg: AeBDiev1P7nA8V1bZr+Sdzjki+wiw6halgoTt0Yfn95MhYIQT+0pkiwE/TuYSKqD5Uk
	OFfXxc41TjCbFCNfpIi/pOGl2db5WysODviPWqMhkTgGh2yqeIeyfY91rXoh4exZnTwJk4687/1
	xuKGKyyT/Cv8Rqhussq5mXTLKCXhqHsHovpX15tTqvoHObef3RELifVWLh+Rq5Ve81Wj1wRD1R/
	IP2uIvKiSiXKyGgvAa/NQhScdnzx/cM9wUunzhiRZdb3SvQC+tCaFSf7ibrKq1ybzCzQ1veG3zd
	gpDyW0uk+EO8YbjbsXhLb7zi0sdkw0HCmgjVt7IYh40dD55f6/3reBbee/FFXTuRDvi0O5ZQdeo
	ybr/uOgTxldu5PtMSJ0UsZSpDOsHPrB2gvhOMf6hTZ/R4To6JMJmZ+RLmJBVK3L3OIIuFSZ6IXY
	s5yvBLWfPfovJKgK32kjJjo/NH/lZT3SpX5zr3zNuGXG0aLGLyEEH62K7WP7TCK+lFOlQWmqmJ5
	ue+IKtbOgbdXbcDfYjSfWnUUeE=
X-Received: by 2002:a05:6214:4883:b0:89f:65be:998a with SMTP id 6a1803df08f44-8a5e6ccdf6emr330429436d6.0.1775580308286;
        Tue, 07 Apr 2026 09:45:08 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aa70136e87sm62044156d6.22.2026.04.07.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:45:07 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 0/1] um: drivers: use libc strrchr() in cow_user.o
Date: Tue,  7 Apr 2026 12:44:34 -0400
Message-ID: <20260407164435.726012-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_094510_594784_271DF884 
X-CRM114-Status: GOOD (  22.88  )
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

Building ARCH=um on hosts with glibc 2.43 fails due to an interaction
between UML's global -Dstrrchr=kernel_strrchr remap and glibc's new
C23 const-preserving macro for strrchr().

The failure is in arch/um/drivers/cow_user.c, a host-side helper that
calls libc strrchr().  The object is built whenever CONFIG_BLK_DEV_UBD=y,
which is the standard UML block device driver, so this affects most
non-trivial UML builds on Ubuntu/Debian today.

I caught this while testing on the release candidate for Ubuntu 26.04
LTS, whose libc is glibc 2.43.  With 26.04 LTS shipping in the next
few weeks and carrying five years of support, the affected user base
will grow quickly, which is the main rationale for the Cc: stable
trailer in the patch.

The root cause is that glibc 2.43 added (glibc commit cd748a63ab1a):

  #define strrchr(S,C) __glibc_const_generic(S, const char *, strrchr(S, C))

as part of C23 qualifier-generic support.  This function-like macro
replaces UML's -D object-like macro, and the recursive-expansion
protection in the C preprocessor causes the inner strrchr to resolve as
the bare symbol -- which was never declared under that name, because
the header declaration was already rewritten to kernel_strrchr by the
-D.

The remap itself (commit 2c51a4bc0233) is still needed for kernel-side
objects to prevent linker clashes.  This was re-affirmed very recently
in commit a74b6c0e53a6 ("um: Don't rename vmap to kernel_vmap"),
which removed the now-obsolete vmap remap and updated the comment in
arch/um/Makefile to explicitly call out -Dstrrchr=kernel_strrchr as
one of the remaps that still prevents libc symbol clashes.  This patch
only exempts the one host-side object that is proven to break:
cow_user.o.

A standalone reproducer (fails on glibc >= 2.43, succeeds on older):

  printf '#include <string.h>\nvoid f(void) { char *p = strrchr("foo", 47); }\n' \
    | gcc -c -Dstrrchr=kernel_strrchr -x c - -o /dev/null

Tested on Ubuntu with glibc 2.43-2ubuntu1 and gcc 15.2.0 against
v7.0-rc6 (3aae9383f42f).  v7.0-rc7 dropped on 2026-04-05 and neither
arch/um/drivers/Makefile nor arch/um/drivers/cow_user.c changed
between rc6 and rc7, so this patch applies and behaves identically on
both.  The patched kernel builds cleanly, boots a Debian bookworm
rootfs to multi-user, and boots with a COW overlay that exercises the
absolutize() -> strrchr() code path in cow_user.c.

cow_user.c is the only file under arch/um/ that calls strrchr(), so
this patch is complete for the current tree.  A broader discussion
about whether the global strrchr remap should be narrowed further
(given that glibc's C23 macros are here to stay for strchr, memchr,
strstr, etc.) may be warranted as a follow-up.

Compatibility and impact
========================

The patch only changes CFLAGS for one translation unit, cow_user.o.
By configuration:

  - glibc >= 2.43: build is fixed (the point).
  - glibc <  2.43: no observable change.  cow_user.o now calls libc
    strrchr() instead of being silently redirected to kernel_strrchr()
    by the global -D; both are functionally identical for the
    NUL-terminated path strings absolutize() uses.
  - CONFIG_STATIC_LINK=y + CONFIG_UML_NET_VDE=y (the original 2011
    case): unaffected.  The global remap is preserved for every
    other translation unit, so the linker clash that 2c51a4bc0233
    fixed cannot recur.
  - CONFIG_BLK_DEV_UBD=n: cow_user.o is not built; the new
    per-object CFLAGS line is inert.

Verified locally with nm: after the patch, cow_user.o references
libc strrchr (not kernel_strrchr), and the final UML binary cleanly
resolves both kernel_strrchr (kernel side, EXPORT_SYMBOL'd) and
strrchr@GLIBC_2.2.5 (libc) with no multiple-definition errors.

A small personal note
=====================

The last and only patch I sent to LKML was in December 2006 [1], a
two-line fix in the IEEE 802.11 softmac association code during the
dark days of laptop hardware support.  I have done my best to follow
the guidance, especially the recent AI assistance protocols in
Documentation/process/coding-assistants.rst and generated-content.rst,
but apologize in advance for anything I have done wrong regardless!

PS: see the note below about checkpatch.pl and Assisted-by: behavior.
I'd be happy to submit a patch for that as well, but suspect an
experienced maintainer might prefer to handle it.

[1] https://marc.info/?l=linux-kernel&m=116607116605310&w=2

Disclosure of tool assistance
=============================

Per Documentation/process/coding-assistants.rst and
generated-content.rst:

Tools used: Claude Code with Claude Opus 4.6 (Anthropic); Codex with
GPT-5.4 (OpenAI).

What the tools did: helped reason through the -D macro / glibc C23
macro interaction; helped narrow the failure to cow_user.o; suggested
-Ustrrchr as the minimal override; helped construct the standalone
gcc reproducer and the build/boot/COW test matrix; helped interpret
build and boot logs; drafted the changelog and this cover letter;
cross-checked against the glibc 2.43 release notes and the referenced
kernel/glibc commits; located recent precedent (a74b6c0e53a6) and the
Documentation/process/ disclosure guidance; ran checkpatch.pl and
get_maintainer.pl interactively.

What only the author did: manually reviewed every line of patch,
changelog, and cover letter; executed every build and boot test on
the host (ARCH=um build, bare kernel boot, Debian bookworm rootfs
boot, COW overlay boot exercising cow_user.c::absolutize());
inspected the resulting kernel binary, boot logs, and exercised code
path by hand; made all final scope, framing, recipient,
and Cc: stable decisions.

The author has read every line of this submission, understands it,
and takes full responsibility under the Developer Certificate of
Origin.

A note on the Assisted-by: trailers
-----------------------------------

The trailers in the patch use the format from
Documentation/process/coding-assistants.rst:

  Assisted-by: AGENT_NAME:MODEL_VERSION

scripts/checkpatch.pl in v7.0-rc6 does not yet recognize Assisted-by:
as a standard signature, so it emits a "Non-standard signature" warning
and (because the value is not a Name <email> pair) an "Unrecognized
email address" error for each trailer.  These are intentional: the
trailer format follows the in-tree documentation, and checkpatch has
not yet been updated to match.  Happy to reformat if maintainers
prefer a different convention.

Thanks,
Michael Bommarito

Michael Bommarito (1):
  um: drivers: use libc strrchr() in cow_user.o

 arch/um/drivers/Makefile | 3 +++
 1 file changed, 3 insertions(+)

--
2.49.0

