Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B73BC7EE37
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=32491UDGlmoN2WSEb+Dab2vFS8MiAey2fNW+meGAzqU=; b=VJnrLXFiXGNv7Y
	k6zig3dfxKUGjdLb22f0j5UoAg24SdqlTrNvVNBWb4edV+9YEzibFXPYMRcdVFrhWOwGNvnxK7NWR
	DiW/aSpKcYquUXXFHIQYRdAzqcFry/UObfKbs2xiyX00O/m7u1hnOD9DCMfAUVJ84rwCUfHKYTbyx
	XF/x3ZYncVoIhQotxBVGbfd2s7YlWx591gz7q46mtyzv0eKO47/xuT6iMg7iqwHN3R9qSp5ZYI9an
	MbdxvxmBaJBYOpFFGqYWYMpLvDY4cPoNvgc/1Pfw4nKfHIQK4BOQmGP+5XM/YYTWkZzgNsr8Y5VCf
	ZQXeNB+ogAvcwRPNvLoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZ7-009c95-1Q;
	Thu, 08 Jun 2023 14:24:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZ4-009c7h-0z
	for linux-um@lists.infradead.org;
	Thu, 08 Jun 2023 14:24:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD3464E17;
	Thu,  8 Jun 2023 14:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F10C433EF;
	Thu,  8 Jun 2023 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686234276;
	bh=k+Mn9weSydYIaCuWNuvDX6AoybHLToDi+9bw3+6L3mE=;
	h=From:To:Cc:Subject:Date:From;
	b=fRrTog57JAttHS7m0CTWO4G3XgAr0HVzUMfMz+Jmj5OZPG0N0DW2sGdctfa4CGO1e
	 L6rPljb+N0AK99eRTbYIESp6H+s+AtiYY6qRRcQyvCg86U2BQoRi1UYLk1lM0KmOfK
	 AGKQ8hO4xvAjeyBD60CJJKpJJRO6A8qTgK4mFNx5vPy/x0BpHI3Nwsw1NS6XT8iDnH
	 ArNDJGpgwarr95RA8NNW82gvmFyAwZbIsleYpLXawNwmtbBR5mblmfZ7XRceO182ys
	 PJFSuNqp+b4GeEsh2Nw6PKKVMWIogyCKTroUDzVa7XSYBCwQ233h2/xGDvfoqph3oV
	 i98Nwklk4pAiA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 00/11] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
Date: Thu,  8 Jun 2023 23:24:17 +0900
Message-Id: <20230608142428.256985-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_072438_438158_D45B9472 
X-CRM114-Status: GOOD (  12.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


This patch set refactors modpost first to make it easier to
add new code.

My goals:

 - Refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
   You can still put EXPORT_SYMBOL() in *.S file, very close to the definition,
   but you do not need to care about whether it is a function or a data.
   This removes EXPORT_DATA_SYMBOL().

 - Re-implement TRIM_UNUSED_KSYMS in one-pass.
   This makes the building faster.

 - Move the static EXPORT_SYMBOL check to modpost.
   This also makes the building faster.

This patch set is applicable to linux-next 20230608.

Previous version
v6: https://lore.kernel.org/linux-kbuild/CAK7LNARjzGnj+sYX=_5yQ+8qoOQ2KB5N-_Ye53Ru3=XicezTYw@mail.gmail.com/T/#t
v5: https://lore.kernel.org/linux-kbuild/CAK7LNARBiOywrMLbR=9N35sk19U0QM3xcPy7d1WqV-eyb4W23w@mail.gmail.com/T/#t
v4: https://lore.kernel.org/linux-kbuild/CAK7LNASDzy9RERN6+q6WgR4ROYZQue=SBqgbcoYuVePByHtk6Q@mail.gmail.com/T/#t
v3: https://lore.kernel.org/all/20220928063947.299333-1-masahiroy@kernel.org/



Masahiro Yamada (11):
  Revert "[PATCH] uml: export symbols added by GCC hardened"
  modpost: pass struct module pointer to check_section_mismatch()
  kbuild: generate KSYMTAB entries by modpost
  ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
  modpost: check static EXPORT_SYMBOL* by modpost again
  modpost: squash sym_update_namespace() into sym_add_exported()
  modpost: use null string instead of NULL pointer for default namespace
  kbuild: implement CONFIG_TRIM_UNUSED_KSYMS without recursion
  modpost: merge two similar section mismatch warnings
  modpost: show offset from symbol for section mismatch warnings
  linux/export.h: rename 'sec' argument to 'license'

 .gitignore                        |   2 -
 Makefile                          |  22 +--
 arch/ia64/include/asm/Kbuild      |   1 +
 arch/ia64/include/asm/export.h    |   3 -
 arch/ia64/kernel/head.S           |   2 +-
 arch/ia64/kernel/ivt.S            |   2 +-
 arch/um/os-Linux/user_syms.c      |   7 -
 include/asm-generic/export.h      |  83 +----------
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/export-internal.h   |  49 +++++++
 include/linux/export.h            | 127 ++++------------
 include/linux/pm.h                |  14 +-
 kernel/module/internal.h          |  12 ++
 scripts/Makefile.build            |  27 +---
 scripts/Makefile.modpost          |   7 +
 scripts/adjust_autoksyms.sh       |  73 ----------
 scripts/basic/fixdep.c            |   3 +-
 scripts/check-local-export        |  70 ---------
 scripts/gen_autoksyms.sh          |  62 --------
 scripts/gen_ksymdeps.sh           |  30 ----
 scripts/mod/modpost.c             | 233 +++++++++++++++++++-----------
 scripts/mod/modpost.h             |   1 +
 scripts/remove-stale-files        |   4 +
 23 files changed, 266 insertions(+), 569 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/check-local-export
 delete mode 100755 scripts/gen_autoksyms.sh
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
