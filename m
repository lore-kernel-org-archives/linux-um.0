Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589A9C4345F
	for <linux-um@archiver.kernel.org>; Mon, 29 Apr 2024 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wKIv9ZTEQJHowCmh5eLbzPs57ClB41hs/bkkn+RVMsE=; b=o+XAFr+9xCByaSbINHcM4hCF8E
	WKtcJsfjx3YUmjK/OdPLVQ9jBL9JRZvY+jjjNmvu/5A+/l1Kgx/Txem6bpLOfKUMsJErKuYUPTWn2
	NeYSXSpgMNFoVD9n0S9ebESh1UiQ+zOpNAZ/CwKFozCCVnagbNiwHGTmcjpa7oQMJcolBFX2ZZDgO
	gvgp4zlstoQ0VfvASMJkYc9hl7bGC/0yAns20Uc5qGxp2ZKa4+1melawIQl/DFjnFWprgzCxJActV
	JIDpoC1SRBD244cgYPmzOXpndE8C/OHYgpQI79EpdrBHeE4fNoCrvrvwS0TpeeeYV9hiH0j3Jm0uI
	kGq8Scmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1RN7-0000000308Y-014C;
	Mon, 29 Apr 2024 13:48:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1RMu-00000002zvy-0oCZ
	for linux-um@lists.infradead.org;
	Mon, 29 Apr 2024 13:48:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wKIv9ZTEQJHowCmh5eLbzPs57ClB41hs/bkkn+RVMsE=;
	t=1714398511; x=1715608111; b=Wc4Lo1gyT2tsle+ygrND34RzNe4eOhLgo//C03wI4c5/9Mr
	gdy9P3dQmimcG7QzB7QxRgVfmkMYHqMRbYxouqGZpcBoSzchUDw0Y7fQeKL8SPIq6mbt2l2LY8zHp
	cV80ElSj7SHikYcZiJS84x3CxRPLvFtz1hHpp7ee9aNLTNbAc1xNWiVPkJqCHccmdOgnzgoVnghWK
	neOKi+PHSsqf4gvsIh/CujBAMzc6BtqXJkBUhkrDI6ZCfooKA7GBHo5+VyXVlKGweBMJf5PkWjK/w
	J7G8CA8evRq62V5JD73WZeabVoQHVeyZjsI2K2QoEmZLStoFbwBbMAhPl5nd91yA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1s1RMq-0000000CW0d-3zAZ;
	Mon, 29 Apr 2024 15:48:29 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 09/12] um: Do not flush MM in flush_thread
Date: Mon, 29 Apr 2024 15:47:56 +0200
Message-ID: <20240429134759.244517-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429134759.244517-1-benjamin@sipsolutions.net>
References: <20240429134759.244517-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_064832_658332_143AC437 
X-CRM114-Status: GOOD (  10.37  )
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

There should be no need to flush the memory in flush_thread. Doing this
likely worked around some issue where memory was still incorrectly
mapped when creating or cloning an MM.

With the removal of the special clone path, that isn't relevant anymore.
However, add the flush into MM initialization so that any new userspace
MM is guaranteed to be clean.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/exec.c     | 5 -----
 arch/um/kernel/skas/mmu.c | 3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 5c8836b012e9..2c15bb2c104c 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -24,11 +24,6 @@ void flush_thread(void)
 {
 	arch_flush_thread(&current->thread.arch);
 
-	unmap(&current->mm->context.id, 0, TASK_SIZE);
-	if (syscall_stub_flush(&current->mm->context.id) < 0) {
-		printk(KERN_ERR "%s - clearing address space failed", __func__);
-		force_sig(SIGKILL);
-	}
 	get_safe_registers(current_pt_regs()->regs.gp,
 			   current_pt_regs()->regs.fp);
 
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 76c0c7d600a8..9bfefcd33f36 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -39,6 +39,9 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out_free;
 	}
 
+	/* Ensure the new MM is clean and nothing unwanted is mapped */
+	unmap(new_id, 0, TASK_SIZE);
+
 	return 0;
 
  out_free:
-- 
2.44.0


