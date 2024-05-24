Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C46FC25B7D
	for <linux-um@archiver.kernel.org>; Fri, 24 May 2024 21:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTL8dyd5UpXCaQ2QExNZoh1Z9fNceonR8BV5bwEdyeE=; b=o5T+Lv59DPV4zACYK3wciG2rR/
	wP3UTQVbms19TJIfCvSLlkpdWgi/xE3DB57XIZ24IvzMNjZxnLuIdW6sccV0dJ874UHux2UoklMk/
	V+giicIXmITGLeDzxa8Zvghoo4ePNnbVd78xG4RvqFD+cq6LigbTR6GLO6TRNbECRGQ4dkr6ki7d6
	9zq0Rh0n26sgSoQTde9t9aIRoIhR7Tnaf/wQEvr1KM/qsKkF1ygQJXOiWZo5NITbFAzC9ShY+BW55
	IKzj9H5MvSVADAQoFTJx3saVHARqITpk0HP9q3782BCz2qEiSoTZGZstUbl1+fPiqLODUM83486qJ
	ELy20+3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcfD-00000009wj7-3lV1;
	Fri, 24 May 2024 21:41:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcfA-00000009wgQ-1yOx
	for linux-um@lists.infradead.org;
	Fri, 24 May 2024 21:41:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qTL8dyd5UpXCaQ2QExNZoh1Z9fNceonR8BV5bwEdyeE=;
	t=1716586880; x=1717796480; b=L1u97PXOyERknf3Uh5Ub8A6br2pfx77QMWFW1/1p7WFKvff
	+w0764q/xqrR/Yl/S7z6Ubow7VRSPugNmEE0z1rMjNSjqfTPyWKd5b3DeiW1C4SfKjbaUHI1qyJRC
	BqimC00cuH1PTiaAEgwGDaoYojP7FStZ4WrbsoqFi1adPACS8nxNd45Y+5C/cnwYRGdhDxK2cqTxh
	bJb8890AZwZzZl9RUXkZ5/WQSeZrb1mRN8A3ajZPZvYK9UvntHGtjSnfVksdk1pUCzFP+YZPaN6YR
	p7BS/pXbnyAb4oXKuzZX3p9syp/VmYrzS68CNnRDk4Jmfx8EvGrmX+4XS9N1jA/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sAcf6-00000008ke7-2klU;
	Fri, 24 May 2024 23:41:18 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 09/12] um: Do not flush MM in flush_thread
Date: Fri, 24 May 2024 23:37:15 +0200
Message-ID: <20240524213718.1757703-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524213718.1757703-1-benjamin@sipsolutions.net>
References: <20240524213718.1757703-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_144120_624974_A7D541F8 
X-CRM114-Status: GOOD (  10.19  )
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

v3: Flush until STUB_START as that might be higher than TASK_SIZE
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
index 76c0c7d600a8..d417ecff078d 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -39,6 +39,9 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out_free;
 	}
 
+	/* Ensure the new MM is clean and nothing unwanted is mapped */
+	unmap(new_id, 0, STUB_START);
+
 	return 0;
 
  out_free:
-- 
2.45.1


