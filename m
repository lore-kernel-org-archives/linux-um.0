Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AEFC5B555
	for <linux-um@archiver.kernel.org>; Thu,  5 Jun 2025 05:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qz9bH2zvp1Drs1jYyhoCgWsUb5+94JET36R0XuSbZ+0=; b=NdHuGHscmpmSrgiIV6hGqXLoQ0
	Wi+t53Gt2HGgN5gwRESaJL0VH0joGPJDURC9bwnFMyGPx70iJx07ax+CAU6P0ECZuKAfdF0+P6D5j
	zEJGcrl+8LefAJC9kqyaBk6uHybnUW7p1O4NElWvY6NMxtTzqBPDIWWWmNWFDuJCpXn+Nil/4jZHN
	KJ0c6hGjNXMAFSgf2XJvxwDIXAIcPQLl6Mk4JYaZMziVmCGyp1Vh1fa/FP9jBeRjPEwmMjrC3x9/D
	PvGjx/QuOLL+XKeO/kLbQG4KbyKIlgVzLE0dQocXRRrNd7uSmlBJzMpwqMyVeyjlTpqH+F9EOgDzh
	HWVPR2fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN2lw-0000000Ejke-3D1M;
	Thu, 05 Jun 2025 05:04:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN2lu-0000000EjjS-1gpX
	for linux-um@lists.infradead.org;
	Thu, 05 Jun 2025 05:04:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Qz9bH2zvp1Drs1jYyhoCgWsUb5+94JET36R0XuSbZ+0=; t=1749099849; x=1750309449; 
	b=HPQmPtsdP2FQPFDXhixGB+L8d2tHyOo/c8rCe33VjZ8Xqyf8WL2JInQaEZAnkkHvH2XoPPq+0D+
	GsuDPpXiJ1gQWiqSQsrwodWT7ONIuN0GpdDUj4I97k3c72wpnmMnpmYcOz2atOhzcUbA4GqwROSoM
	V/bggiWAIKtfoelpzxGHopfxbKOYMKW5MiZHFl+1jK0fVFmphOcycLYNNmU/3fHVHqhn7YcGS8vh4
	LSP8sQmnOTbWE1Fc4rM7UIZxEhkEYwjoScGr51zRz0wV7j1E3h4izFptEhHrdSDn7DAkYGnI+iC/L
	Snn4TN1kmcZWifVSmulRclmDyzVrMcRamKWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uN2lr-00000000rYX-3aED;
	Thu, 05 Jun 2025 07:04:08 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] um: fix unused variable warning
Date: Thu,  5 Jun 2025 07:03:24 +0200
Message-ID: <20250605050325.1077208-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_220410_465839_7FA1535A 
X-CRM114-Status: UNSURE (   7.49  )
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

The code was updated to access the PID of the userspace stub process in
a different way, making the local cpu variable obsolete. Remove it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506050008.AwXLNxQX-lkp@intel.com/
Fixes: 406d17c6c370 ("um: Implement kernel side of SECCOMP based process handling")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/tls_32.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index 21cbb70cf771..cb3f17627d16 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -25,7 +25,6 @@ int host_gdt_entry_tls_min;
 static int do_set_thread_area(struct task_struct* task, struct user_desc *info)
 {
 	int ret;
-	u32 cpu;
 
 	if (info->entry_number < host_gdt_entry_tls_min ||
 	    info->entry_number >= host_gdt_entry_tls_min + GDT_ENTRY_TLS_ENTRIES)
@@ -41,9 +40,7 @@ static int do_set_thread_area(struct task_struct* task, struct user_desc *info)
 		return 0;
 	}
 
-	cpu = get_cpu();
 	ret = os_set_thread_area(info, task->mm->context.id.pid);
-	put_cpu();
 
 	if (ret)
 		printk(KERN_ERR "PTRACE_SET_THREAD_AREA failed, err = %d, "
-- 
2.49.0


