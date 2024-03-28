Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570CDC54E67
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IPVeZRXnqJidyGpr4HO2lELicvr7jyE2bmMpBvU7AgI=; b=jB4DcEDfkDu12bTyxvaTVUeQ6C
	CoZyVbQvrOyj9zy3EApWlWokohEooOKa40IIhDZapRFLShAQjdRID0yS6oxd+4oJaf7md0KABEFgQ
	fkFRfAb+ZobmQQzkBGueycIhcG2HojFEd26BBiVeNKDcQqsdUd2LtQM2dw8yUL6inszGADKz+cGpb
	Z817zEcLcUd5XPCpkOCtqgZPdfghJnDOo9777Bj6vKhFwbVkyMlbP++VcHmpyG176YgWJv+S3gZ43
	0wrmovMWsnBU2eHX1i0qXQ+C0JnVWi0bhh3YeUTHp+KPx7n3fCnOhMo9KZKSBv9f6yMERhkAubJcM
	PtgYgkEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnV-0000000DFWC-1fi9;
	Thu, 28 Mar 2024 09:11:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnR-0000000DFUK-3gDm
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 09:11:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=IPVeZRXnqJidyGpr4HO2lELicvr7jyE2bmMpBvU7AgI=; t=1711617101; x=1712826701; 
	b=QP0jzS4ivhKo7fm5cf4E7h7kul3veeuj/uwnnVzpjVkm58/gX8vjzpKhYbcqqSDP+8XPCiWns7S
	l7B66CkALsMBWYBVpufoQ/CmY1aDwTTvSCB8idU0KsClZmiUYupqJzKbqtzSbkqv2TpqWlCuOF3UM
	DMSyCf+WSPOHF+sSgCKfir9R6cu1vpICWeslvceUosBk7UCJO/AF+2tDi6cSElJp8SlQJAe4LRiwc
	hunrKp+tHXCbkPX8Twt/LR91LGR2Lo8Wm/vGD9SSwsj3g3SIyhoRQ+mAtx2MTE0p50lgLSbxxUwOs
	1A3le7LZLdxorbpjseTXnkKlc1M3NmVSjphQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplnP-00000000oe8-04nh;
	Thu, 28 Mar 2024 10:11:39 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/5] um: signal: move pid variable where needed
Date: Thu, 28 Mar 2024 10:06:34 +0100
Message-ID: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_021142_245110_903E2BDA 
X-CRM114-Status: GOOD (  11.47  )
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

From: Johannes Berg <johannes.berg@intel.com>

We have W=1 warnings on 64-bit because the pid is only
used in branches on 32-bit; move it inside to get rid of
the warnings.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/x86/um/signal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 263e1d08f216..16ff097e790d 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -155,7 +155,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 			     struct sigcontext __user *from)
 {
 	struct sigcontext sc;
-	int err, pid;
+	int err;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -201,10 +201,10 @@ static int copy_sc_from_user(struct pt_regs *regs,
 
 #undef GETREG
 
-	pid = userspace_pid[current_thread_info()->cpu];
 #ifdef CONFIG_X86_32
 	if (have_fpx_regs) {
 		struct user_fxsr_struct fpx;
+		int pid = userspace_pid[current_thread_info()->cpu];
 
 		err = copy_from_user(&fpx,
 			&((struct _fpstate __user *)sc.fpstate)->_fxsr_env[0],
@@ -240,7 +240,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 {
 	struct sigcontext sc;
 	struct faultinfo * fi = &current->thread.arch.faultinfo;
-	int err, pid;
+	int err;
 	memset(&sc, 0, sizeof(struct sigcontext));
 
 #define PUTREG(regno, regname) sc.regname = regs->regs.gp[HOST_##regno]
@@ -288,10 +288,9 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	if (err)
 		return 1;
 
-	pid = userspace_pid[current_thread_info()->cpu];
-
 #ifdef CONFIG_X86_32
 	if (have_fpx_regs) {
+		int pid = userspace_pid[current_thread_info()->cpu];
 		struct user_fxsr_struct fpx;
 
 		err = save_fpx_registers(pid, (unsigned long *) &fpx);
-- 
2.44.0


