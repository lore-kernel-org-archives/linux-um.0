Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB40E7717F
	for <linux-um@archiver.kernel.org>; Tue, 17 Dec 2024 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2AjmcsgTzx3TIo/NiPZF3pU4weuGY3iYJ3AIwf8Kn/s=; b=RT0qbIuoFIKYCTZN4xZKu+6edQ
	kYuzwWFs87XZGNpd8oahpKXMZjHkmu36Nro+oqmdGE2MFcsk4HhQlbLvdjU4Q8XAteDrmO7jNEcR3
	FUHIzu1MQvmcy/AOclfLLU3s1uYPhslq9W5gSY/f0xb00ux43DwAS2XfIQKYllqk5toy6xQxpwXOF
	pYFoN3NGeThYHZknBLB68taS9ejc+/xkj+xekDquqqwDbP8bujvKjzBhGwUSyHjcDRI7lIB93IdU8
	vQH16GbBZ18Uc6AoNyk1bugTzsUhQfL9jpT/E/EKah7ybXIlW0CkiPk1lHBlY/PO7CS89xTzZx85a
	Pem48rkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeCp-0000000EkjH-2iYS;
	Tue, 17 Dec 2024 20:30:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeCn-0000000Ekh5-0BFU
	for linux-um@lists.infradead.org;
	Tue, 17 Dec 2024 20:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2AjmcsgTzx3TIo/NiPZF3pU4weuGY3iYJ3AIwf8Kn/s=;
	t=1734467408; x=1735677008; b=A6tL8XjRbRqqYbnrHl+PLNbGPZYJ+7KUQRxUaPShu1vMhgx
	MiVyP60yoCzaNYL1t3SM4faTJdGlnyvI7ltwLhhiIUI88uPziiAAuDLpYo0ptX6Tjznrd+6LHWyiV
	9rY/s+w/YZV+i0TEX7k1MmIFT3bU5bRg0fL3IirgsOni0NWvGjpuv3Dnd/8M963zVoViKs5JZxCus
	rUQXJVCRrOmcKyE3OF+7aJrhWh4jhW+cTeAlzIr0IeEWG4eHC9a2tJ0k1gpD8jsYEc9cZVgoAQNvZ
	wRrDxclZACnYlQM1GnlXPH1z8WFCy3pOYg/edCTmvRoX5/4aTGonBintDd0BpcVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tNeCk-00000002NwX-3MTY;
	Tue, 17 Dec 2024 21:30:07 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-arch@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	briannorris@chromium.org
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/3] x86: avoid copying dynamic FP state from init_task
Date: Tue, 17 Dec 2024 21:27:45 +0100
Message-ID: <20241217202745.1402932-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217202745.1402932-1-benjamin@sipsolutions.net>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_123009_085133_25408748 
X-CRM114-Status: GOOD (  10.49  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The init_task instance of struct task_struct is statically allocated and
may not contain the full FP state for userspace. As such, limit the copy
to the valid area of init_task and fill the rest with zero.

Note that the FP state is only needed for userspace, and as such it is
entirely reasonable for init_task to not contain parts of it.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Fixes: 5aaeb5c01c5b ("x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT and use it on x86")
---
 arch/x86/kernel/process.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd00a91..1be45fe70cad 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -92,7 +92,15 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	memcpy(dst, src, arch_task_struct_size);
+	/* init_task is not dynamically sized (incomplete FPU state) */
+	if (unlikely(src == &init_task)) {
+		memcpy(dst, src, sizeof(init_task));
+		memset((void *)dst + sizeof(init_task), 0,
+		       arch_task_struct_size - sizeof(init_task));
+	} else {
+		memcpy(dst, src, arch_task_struct_size);
+	}
+
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-- 
2.47.1


