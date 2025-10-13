Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B869ACCD18E
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCjuI6KQlUnErooOxXkErybYUanb2mdgvyk1axj3d+o=; b=eSe0//pqotNbRmA2UoamD4d9g0
	uIfoIp0/j+qpUVXS8HniJOGLU+9f1kVj+GHNTqdNZzT4a3BPft+/BHP5xTVYngE453PZlkwo/0Gdn
	QlRWtUNrRUiIHEKqiDpLToWsKHqycWLhc0SsjQP8PBW8kXQC0y3wix0QqUrm+mLdATbQWDmebavSU
	Yrw0yo5i3O9ELHr3qRtaq/uaD0hw/2f/kSyWDfCSLFIjtys6ofknbzgz8iDnUf5QBCPPQBRtRTV2K
	wvk5+Fr5Z6tNi7L9ZxmpQFYTYTt7R5K0h8HSXVjCoxzhjclRh1xmcu0JsHH9y5S4n7hFzH4xiKbKy
	zY90iDyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fyi-0000000Cv6r-27wZ;
	Mon, 13 Oct 2025 10:40:32 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fyf-0000000Cv57-0xMN
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 10:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352024;
	bh=1LBGK3TkrPoW63QLWYmeLol3aNiWj2Xkcr6MKYmW53w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pTjoi4kk9KMK8YhfuDbvKy/w8317zuHva+xyx2B0jEZuCR9YB/UW+sL00F92mSFeD
	 GmVQdZ0h5YCxnD+1UZVrskky1mqiQSrmV74y897v86iSxwzGeAR19m6TwALBbLZpwx
	 fhCYQDk0m0uGc7WNeR0f3dL9HB3VVNZZsDJgMjvI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 12:40:19 +0200
Subject: [PATCH 2/4] x86/um/vdso: Use prototypes from generic vDSO headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-uml-vdso-cleanup-v1-2-a079c7adcc69@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=1093;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1LBGK3TkrPoW63QLWYmeLol3aNiWj2Xkcr6MKYmW53w=;
 b=MsrwrxDOXOU/dVReY9Htl3GJq1AC/ZpJPqTe1SC8mLKREvu7kOV34WL64CxKeKIs5+9fkTc2Y
 2nmIHBraG5fCGhikb0qvbXJ6rE8PCShGHBl+CbPbUqbiraEzJ8Z2iwu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_034029_416692_DBBF68F5 
X-CRM114-Status: UNSURE (   8.40  )
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

The generic vDSO library provides a convenient header for the vDSO
function prototypes, use it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/vdso/um_vdso.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index 5cadcc04d422..02d41fdb5655 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -9,14 +9,12 @@
 /* Disable profiling for userspace code */
 #define DISABLE_BRANCH_PROFILING
 
+#include <vdso/gettime.h>
 #include <linux/time.h>
 #include <linux/getcpu.h>
 #include <asm/unistd.h>
 
 /* workaround for -Wmissing-prototypes warnings */
-int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
-int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
-__kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
 long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)

-- 
2.51.0


