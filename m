Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971A6C4345F
	for <linux-um@archiver.kernel.org>; Thu, 18 Apr 2024 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wKIv9ZTEQJHowCmh5eLbzPs57ClB41hs/bkkn+RVMsE=; b=U/vfYS/XCrj6NR5D1ClokozJGa
	uIDRG1Mg98lCm9umY1wEFZ+9/FSJFFy5YKyE+Oo/lHeyvIdOcOqySEhfQVoEU8Ke6X5ec1zccsJuC
	U1NQkhCIdh0TjknARzYAYuG0zLwQiwMvkiu3Ngk67UTieWjMEaGNd4a2AGqScMzewHI60ot8lN3UI
	qeG418G9Dvr89eNIVu2r10CWwHoJ2xngSTDCAWLxJZa22cxmCpbKAR2HWRugWc3UeBne3+M3uLJBU
	CmBTcrqKWmKStJjPDhncr1kx8Eont55pvgFs4lc87h/6sKIZF7GCJQogfjGd9LodTp1v8pBa6BgZ0
	8ej5SZNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO11-00000001bUB-41a1;
	Thu, 18 Apr 2024 09:25:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0r-00000001bJ2-11yr
	for linux-um@lists.infradead.org;
	Thu, 18 Apr 2024 09:25:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wKIv9ZTEQJHowCmh5eLbzPs57ClB41hs/bkkn+RVMsE=;
	t=1713432301; x=1714641901; b=bi/FevcdTBpHTU6Ep+QI386v+zxRmFYi4o8SmN3GNbU0EKo
	Sl3qJU3dXiZhB9k+iH08SYC/KYM/rdy1E88FJTOSbGe6oi2LWhkoI8VxErIe1T9K36gxQ7Fob+keO
	XNqe98nXou1FS0yqY35a2MJuhOQQAiqSzeXi3fZ1DWB5ExOqWpKD6paNMJ02lqninlbCYPnHJ9XGV
	LodSfc7WJfunlRsGtO3yLeK8YrUfQ95DedbnCqtqXRLUx4U29CCELip1L85JFPPwiCeP/o3ErM3GX
	wAdJN3KYq3/eLhdziQCZkiGMZcu5Y98+HV1W8v1QgvAcqQxDbwJdJ+IAYC6AY29g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rxO0o-0000000CKXH-0nSX;
	Thu, 18 Apr 2024 11:24:58 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 09/12] um: Do not flush MM in flush_thread
Date: Thu, 18 Apr 2024 11:23:24 +0200
Message-ID: <20240418092327.860135-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418092327.860135-1-benjamin@sipsolutions.net>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_022501_590224_82E2BD58 
X-CRM114-Status: UNSURE (   9.89  )
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


