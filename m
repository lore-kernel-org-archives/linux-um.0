Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33866D767D6
	for <linux-um@archiver.kernel.org>; Thu, 31 Oct 2024 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wrghW4A0H+TlJlKgvbZVK8/cu/epk3c78bmQlCjgwW0=; b=YLBCE9db5r5r8FnEhZs+bw3dVZ
	7laGM4KYm+1vfboc41Iso3YCULKFLMFGQvPsnBLYJz3twiP+JPpa8shjHmUaG5WxT8+iVcjG1xjnB
	PeYkvhrXO9vFq/TN2EOj7fqT9VrT9KhABeCwqxP7c70nl1edWZgInBknMxIr8GROPaTUZqT/z/fT+
	73m51+0Ka6po2CEFSXBDahYdJvLLSVE8nyycAcRkqgzyWiqWI5HBtF0IQ4XJlhIhD1mi1uMmsUxcU
	9MvBP7gVhGHwGkn8XYBYiNK9S0FB7GaNLEvMnA5wcmuf5a0EsOqr0K05LQYQeKMcuxJ+GlOY+C63Y
	Snu4vesg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6W3W-00000003n5s-1gpe;
	Thu, 31 Oct 2024 14:21:46 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6W3E-00000003n3a-1WnV
	for linux-um@lists.infradead.org;
	Thu, 31 Oct 2024 14:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wrghW4A0H+TlJlKgvbZVK8/cu/epk3c78bmQlCjgwW0=; t=1730384486; x=1731594086; 
	b=XZO5aIpB/qFsTdczxNqwFkFgCvpV2Z3Nt/Wd3sY09I7fNL+A6jQ8jUsehZtLxCE8MPBhFrE/jjA
	enpWX27lq0NoBb2VFg2/eosyCY+UcoXIOOrCIj7d6a9mbqJtRRtxD5sPz36nGn8c40PX2KD6kfqDZ
	A8KgjBIbXg/n4UT9wuUc3T+1/VvNXRBn3pSSDGGxAhM6dGfWXrKOzTBdtDNV9rBKr9sFJRKASoRMR
	AM7S0CxeKMRgnhCvKQAZQRlkdyJiBaahoCtU3mESjktHWScy+ArSBQrYjTcP8SB6bZFbJSW4BlAts
	PEaZdvwU6VMYWVQZu3Y/ueu/la05kNzLLkyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t6W38-0000000AUMx-2D0P;
	Thu, 31 Oct 2024 15:21:23 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] um: fix sparse warnings from regset refactor
Date: Thu, 31 Oct 2024 15:20:16 +0100
Message-ID: <20241031142017.430420-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_072128_428620_9CB9CCDC 
X-CRM114-Status: GOOD (  11.63  )
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

Some variables were not tagged with __user and another was not marked as
static even though it should be.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410280655.gOlEFwdG-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202410281821.WSPsAwq7-lkp@intel.com/
Fixes: 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/ptrace.c |  2 +-
 arch/x86/um/signal.c | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/um/ptrace.c b/arch/x86/um/ptrace.c
index 54d924bc45ce..57c504fd5626 100644
--- a/arch/x86/um/ptrace.c
+++ b/arch/x86/um/ptrace.c
@@ -242,7 +242,7 @@ static struct user_regset uml_regsets[] __ro_after_init = {
 	/* TODO: Add TLS regset for 32bit */
 };
 
-const struct user_regset_view user_uml_view = {
+static const struct user_regset_view user_uml_view = {
 #ifdef CONFIG_X86_32
 	.name = "i386", .e_machine = EM_386,
 #else
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 94b2b2bbae31..797c4e4e57f3 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -82,9 +82,10 @@ static int copy_sc_from_user(struct pt_regs *regs,
 #undef GETREG
 
 #ifdef CONFIG_X86_32
-	from_fp64 = ((void *)sc.fpstate) + offsetof(struct _fpstate_32, _fxsr_env);
+	from_fp64 = ((void __user *)sc.fpstate) +
+		    offsetof(struct _fpstate_32, _fxsr_env);
 #else
-	from_fp64 = (void *)sc.fpstate;
+	from_fp64 = (void __user *)sc.fpstate;
 #endif
 
 	err = copy_from_user(regs->regs.fp, from_fp64, host_fp_size);
@@ -97,7 +98,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 				    task_user_regset_view(current),
 				    REGSET_FP_LEGACY, 0,
 				    sizeof(struct user_i387_struct),
-				    (void *)sc.fpstate);
+				    (void __user *)sc.fpstate);
 	if (err < 0)
 		return err;
 #endif
@@ -173,7 +174,8 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	BUILD_BUG_ON(offsetof(struct _xstate, xstate_hdr) !=
 		     offsetof(struct _xstate_64, xstate_hdr) +
 			offsetof(struct _fpstate_32, _fxsr_env));
-	to_fp64 = (void *)to_fp + offsetof(struct _fpstate_32, _fxsr_env);
+	to_fp64 = (void __user *)to_fp +
+		  offsetof(struct _fpstate_32, _fxsr_env);
 #else
 	to_fp64 = to_fp;
 #endif /* CONFIG_X86_32 */
@@ -198,7 +200,8 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	__put_user(host_fp_size, &to_fp64->fpstate.sw_reserved.xstate_size);
 
 	__put_user(FP_XSTATE_MAGIC1, &to_fp64->fpstate.sw_reserved.magic1);
-	__put_user(FP_XSTATE_MAGIC2, (int *)((void *)to_fp64 + host_fp_size));
+	__put_user(FP_XSTATE_MAGIC2,
+		   (int __user *)((void __user *)to_fp64 + host_fp_size));
 
 	return 0;
 }
-- 
2.47.0


