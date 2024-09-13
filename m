Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35059EEE27A
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 02:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sk78RPR/D1ucvqQzMBD4yW9ti1WrTuAHH9RwDLsSwP4=; b=P5Bf2vVT8Y2Fp9JyAEuZHVOHzR
	pN74YBE4qOU2acPPW23P4AoJq3QAylLL3uJtKjePFTMMLXXFHBzxuRRIoA3n/7/5GQlwpl55J+Lqk
	FrMWgALBCdhJSa/UQuKpQkPkpcwH97o9k5e0SefeJNnYmf2Qjt4fqHWnBTnlwkbkbuluR0UlKHetN
	H+GhaGQxiMwf1pYJXa5+OOyscvjhTJy1SON0hP5F/6So0612SuP2zdOgKZNIDU8JIvyLwOPn8d4GQ
	4jIQGv/EuavIKJn+PAS2ZgB/l7gdL91eNrih5jAiGuFNb6j02zKwccgKX2tdnpb0VnVpGDKaIF+yg
	DLTJJ6MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sow7e-0000000Ek2L-1Fse;
	Fri, 13 Sep 2024 02:33:22 +0000
Received: from out0-205.mail.aliyun.com ([140.205.0.205])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sow7b-0000000Ek21-183R
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 02:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726194796; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sk78RPR/D1ucvqQzMBD4yW9ti1WrTuAHH9RwDLsSwP4=;
	b=j2Aq6SFHVKntQGYCfguj3macKtrKEBDheLwpOwIVO3SXPHSM8nvVX3dCOWMxiQWgkDKEJiGRgWhjvgyqQQhA2lniNThjN+PeXQyucoQeRiSG3RzOeFmAy+95MpO+1ZfBxfAjTiIrMyYRdftbUnUIcu23FPORYbyCQ8pqgy5N0uY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZHtFxUj_1726194790)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 10:33:15 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2] um: Fix the return value of elf_core_copy_task_fpregs
Date: Fri, 13 Sep 2024 10:33:02 +0800
Message-Id: <20240913023302.130300-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_193319_791759_8D91803F 
X-CRM114-Status: UNSURE (   7.80  )
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

This function is expected to return a boolean value, which should be
true on success and false on failure.

Fixes: d1254b12c93e ("uml: fix x86_64 core dump crash")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
v2:
- Drop the unnecessary new variable (suggested by Richard Weinberger);

 arch/um/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index be2856af6d4c..9c6cf03ed02b 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -292,6 +292,6 @@ int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	int cpu = current_thread_info()->cpu;
 
-	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
+	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu) == 0;
 }
 
-- 
2.34.1


