Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89098CCF9F1
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=noNlmxCJE3KO/lPWg5rcvAC/N6+hMXNKqLIKFsG5DTo=; b=eNtJna5LduilTy
	Sl2b8xTkUORlc2Jfd8YQBziR6AIprZqKNeXQdS0hUKHUBJrpvD3dHztBzNb3gVEieKv2xMSA7hpS8
	DhE/JhD8UYYPrt0fZzQ0fUagZTsjLaPLZuBmfAFifE6QrdIJQOvg9svBOORf/DNIZp0NydCkKeKDe
	Ia4amNPwJ2PEo1eoWAXAG5/G+txOtucEUYucNYV0QfeqzttGSnSdLvUd/jm+YhtneLvKqeGSPWhCh
	IcybTGAyAVp3AJXKOH/bTEICOSr2BnOT4nFcIT62Gik2CxPCllBP8Q+WmdQBGGnitJXXej6vWJFYm
	r2V5fgS8+Q1TCmcbHCNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpY-0000000Fd3k-0urD;
	Tue, 28 Oct 2025 09:17:28 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpR-0000000Fcz4-3usM
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643037;
	bh=xB7h3ce2gbt35UPG3jOGIq2cIVnYk+vgnnNmKPQ3hUc=;
	h=From:Subject:Date:To:Cc:From;
	b=n3Cna5cwrHoFXFZwXsYyr7xr8U1JWDVfqk8mrpEf4PO2s+yHzfo9ae9GaHIoF8OAT
	 pZxv9lkhfM75w4QdyKXmE+mYxFbn4uRlRg22lrILG3xbdF/DL60Hb0d1d53sXXv02R
	 62OfOdhoO6A1fBQUiI+iFw7EzH6AhO4EqQgAt/tg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 00/10] um: remove vDSO passthrough on 32bit x86
Date: Tue, 28 Oct 2025 10:15:35 +0100
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALeJAGkC/x3MQQ6CMBAF0KuQWTtJHQHRqxAWYL8wiVDSgcaEc
 Hcbl2/zDjJEhdGzOCgiqWlYMq6Xgl5Tv4xg9dkkTir3kIr3+cMRc0jgmwy68WrYfeDkLXAzOLl
 LiaaWmnKxRrz1++/b7jx/CUHeqW4AAAA=
X-Change-ID: 20250925-uml-remove-32bit-pseudo-vdso-8b02724e8626
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1974;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xB7h3ce2gbt35UPG3jOGIq2cIVnYk+vgnnNmKPQ3hUc=;
 b=fy3Gznoqa4idS4vD+Qw7c736OSjfulXJWRQdumuwvFU5YCVJrhuicwaakAQoBCgYhdehVlJzU
 ntwkq3FfWbvCXZdNvbbkRNDKA4+YT8j8iaJXv5Yyc1gTYwqKH/G2rWl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_021722_130988_6FF75D5F 
X-CRM114-Status: UNSURE (   6.43  )
X-CRM114-Notice: Please train this message.
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

Inheriting the vDSO from the host is problematic. The values read
from the time functions will not be correct for the UML kernel.
Furthermore the start and end of the vDSO are not stable or
detectable by userspace. Specifically the vDSO datapages start
before AT_SYSINFO_EHDR and the vDSO itself is larger than a single page.

This codepath is only used on 32bit x86 UML. In my testing with both
32bit and 64bit hosts the passthrough functionality has always been
disabled anyways due to the checks against envp in scan_elf_aux().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (10):
      um: Split out default elf_aux_platform
      x86/um: Move ELF_PLATFORM fallback to x86-specific code
      um: Split out default elf_aux_hwcap
      x86/um: Do not inherit vDSO from host
      x86/um: Drop gate area handling
      um: Remove fixaddr_user_init()
      um: Remove redundant range check from __access_ok_vsyscall()
      um: Remove __access_ok_vsyscall()
      x86/um: Remove FIXADDR_USER_START and FIXADDR_USE_END
      um: Always set up AT_HWCAP and AT_PLATFORM

 arch/um/include/asm/page.h    |   4 --
 arch/um/include/asm/uaccess.h |   9 +---
 arch/um/kernel/mem.c          | 107 ------------------------------------------
 arch/um/os-Linux/Makefile     |   4 +-
 arch/um/os-Linux/elf_aux.c    |  37 +++------------
 arch/um/os-Linux/main.c       |   4 --
 arch/um/os-Linux/user_syms.c  |   6 ---
 arch/x86/um/Kconfig           |   4 --
 arch/x86/um/Makefile          |   5 +-
 arch/x86/um/asm/elf.h         |  39 ++-------------
 arch/x86/um/elfcore.c         |  78 ------------------------------
 arch/x86/um/mem_32.c          |  50 --------------------
 12 files changed, 15 insertions(+), 332 deletions(-)
---
base-commit: 83e4187d1b952c36ffc2d01a2e532ad8a9e80a76
change-id: 20250925-uml-remove-32bit-pseudo-vdso-8b02724e8626

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


