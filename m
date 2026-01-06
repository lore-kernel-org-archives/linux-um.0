Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E415CD0429
	for <linux-um@archiver.kernel.org>; Tue,  6 Jan 2026 00:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9tX6gpxi2EQmP4oevyiEdWqZx5mbwRJ2/QZKBfjWcOc=; b=1nWYcMKh6PA2iIlREE8pGS88Y2
	QuS61An8m9haCr1dgOw+NxISxjguS/QY/8mtkIQfpBF2+lyOgZOQs3YUs27tTdmDgKFSNQVqrT1hi
	45VLyeCdyTKz+TcMJcp8Zrrb/u6I5+xwugVx8RvI+tWlTfUNHDWrbKmLmqEalxfwoioVarkjj9wNu
	GKfdjTbewa2UTMwheaEzYZ5ey5uGHmEQbfOE8Zu5eF2kuX6wRJGK4+aVyWubCzBcHQt0sijGOdKQy
	5cK1z4LQfpP0AumY1/AE0q6wex0OSxGVzQ5frDUDUOaXjxuDKNsgz/EH379aGuiWCs6bADBzDiXDR
	kcOwn8bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcuhR-0000000CFny-2uF3;
	Tue, 06 Jan 2026 00:13:25 +0000
Received: from out28-170.mail.aliyun.com ([115.124.28.170])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcuhM-0000000CFmi-3D8E
	for linux-um@lists.infradead.org;
	Tue, 06 Jan 2026 00:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1767658392; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9tX6gpxi2EQmP4oevyiEdWqZx5mbwRJ2/QZKBfjWcOc=;
	b=b9+T/xF+9ncQ800UoU6TKKvq5AbpHRcXmfjDDzuDqurF3dz5lMTXVKL+XkRYEVnIRt9sMPXRvoSy5RxDOl2U1SFcPm/kd9wRi7M5un3OzDNeXDVcvbQyzpyrPmFkSLO6FsM+pU7pPXi83uh5Yj3ub1i7W/T8NmMz+WQ7xWv8E1o=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.g-qgwWU_1767658390 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 08:13:10 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [PATCH 1/2] um: Preserve errno within signal handler
Date: Tue,  6 Jan 2026 08:12:27 +0800
Message-Id: <20260106001228.1531146-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106001228.1531146-1-tiwei.btw@antgroup.com>
References: <20260106001228.1531146-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_161321_359279_349DC377 
X-CRM114-Status: UNSURE (   9.82  )
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

We rely on errno to determine whether a syscall has failed, so we
need to ensure that accessing errno is async-signal-safe. Currently,
we preserve the errno in sig_handler_common(), but it doesn't cover
every possible case. Let's do it in hard_handler() instead, which
is the signal handler we actually register.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 327fb3c52fc7..de372b936a80 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -36,7 +36,6 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) =
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	struct uml_pt_regs r;
-	int save_errno = errno;
 
 	r.is_user = 0;
 	if (sig == SIGSEGV) {
@@ -50,8 +49,6 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 		unblock_signals_trace();
 
 	(*sig_info[sig])(sig, si, &r, mc);
-
-	errno = save_errno;
 }
 
 /*
@@ -207,8 +204,11 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 {
 	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
+	int save_errno = errno;
 
 	(*handlers[sig])(sig, (struct siginfo *)si, mc);
+
+	errno = save_errno;
 }
 
 void set_handler(int sig)
-- 
2.34.1


