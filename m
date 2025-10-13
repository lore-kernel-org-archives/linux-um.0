Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0829CCD185
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cn3osPYs4c1fpWopV4aZ+cLtK4IK6I5A4rd+bW/Oo8c=; b=kAa+j5mPkPglkrzUUE9RulK63o
	d8TzUi3INA2hk6BUYcVTzr2QRvvixN3w5wEEoLfSQVwurOclxb5EDWDv+SzMfhvg1iI+2bNDVjl/+
	OVPvfa1xE82PubNMi7dO8PbW8SwUdHWNswgeCarO/gDdtm7sc1lZ8PO7Qt0oKWE7tJipujbFdJMPH
	t0LS2jsijEB9u62eq/82zxqv+r0BH0oWB0lNHaWhzP4rSM+ZGiuaIm+9tw3BURbgKeDCqGD+xn1Su
	Q6Bn9Ycz3nNdSMXbF/A7YzN/r/2fzhnVz7byHlF8JgfKacn2MtBDDhSTUqIhIZAgaWEDapLJom5We
	12eajsRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fyh-0000000Cv6Q-11rV;
	Mon, 13 Oct 2025 10:40:31 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fyf-0000000Cv5A-0XKl
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 10:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352024;
	bh=1LVkRx8kRsF68/oifLyumQVqZEvOwQPq1xNG3PoVF1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J6mngZ5lrtIRvMVqQUBJixn0amS1NZH/0oIVAzVy8lRtWUVPuqh7z7s3OcWJ3FVTm
	 /NXElh7G6j6Hzijz7uaA7kKOXcT2GH4xTamjNhd0JQp3oyEJFyIj8ZbHb0XvOhQzPo
	 mSDPSaY/361xM+3FffvLTOMVnzgLNnznjVNnj2go=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 12:40:18 +0200
Subject: [PATCH 1/4] x86/um/vdso: Fix prototype of clock_gettime()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-uml-vdso-cleanup-v1-1-a079c7adcc69@weissschuh.net>
References: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
In-Reply-To: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=1689;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1LVkRx8kRsF68/oifLyumQVqZEvOwQPq1xNG3PoVF1A=;
 b=6UzajuXf5P86gem69w6a2djFM4jes8KR7Z+AzzHnTw4uM+roZNNIk2t1Jq+8CO6OVy0pS/y+F
 PC1ENOK3eoBBrpWRQyQSH5h8EA2YJElWI2s0v3x8dePl7ZxczNQsnBN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_034029_330153_5372B5EB 
X-CRM114-Status: GOOD (  10.87  )
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

The clock_gettime() system call takes a pointer to
'struct __kernel_timespec', not 'struct __kernel_old_timespec'.
Right now this is not an issue as the vDSO never works with the
actual struct but only passes it through to the kernel.

Fix the prototype for consistency with the system call.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/vdso/um_vdso.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124f..5cadcc04d422 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -14,12 +14,12 @@
 #include <asm/unistd.h>
 
 /* workaround for -Wmissing-prototypes warnings */
-int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
 long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
 
-int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
 	long ret;
 
@@ -30,7 +30,7 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 
 	return ret;
 }
-int clock_gettime(clockid_t, struct __kernel_old_timespec *)
+int clock_gettime(clockid_t, struct __kernel_timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)

-- 
2.51.0


