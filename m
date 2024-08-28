Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E612C54FB3
	for <linux-um@archiver.kernel.org>; Wed, 28 Aug 2024 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9u5p5kx6uh3e0Bb5YhuSL84dXaiVoWyd0IYSs5o/yK4=; b=womsfgP3yauNxIbg8buJFSUghW
	IqeL03qt+uWiN7otZEU1NoTNuZeR3IXceRcKImgbw7nesBFL3Jm4ZvWul6PtgDzQYfDTN2adHFdPs
	Dpu69NSbUwv8STYsTqMG9fliV9LdNhu9FWk35JERA06xnNX/+T9YnnP8VYz8CttgbC/L/87wt6um7
	nwu9+PsAKzW3YQTJyuVP9owfBftxl5JV5RBERMjbXd+jOHranej030oZ8jU9QMUK3ZB0z7kbm4XaZ
	oED4JTSSWh6Y7aSW6K9cE0shZfr+LXEEO50X051WUCBx+I8mobqM/Wgs2+oPdwgv0MvU5imvBXy3e
	s2NBHtZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjJ5d-0000000Fb7Y-0sgM;
	Wed, 28 Aug 2024 13:52:01 +0000
Received: from out0-222.mail.aliyun.com ([140.205.0.222])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjJ5Z-0000000Fb6J-09wp
	for linux-um@lists.infradead.org;
	Wed, 28 Aug 2024 13:51:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724853110; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9u5p5kx6uh3e0Bb5YhuSL84dXaiVoWyd0IYSs5o/yK4=;
	b=1035wzZBM/t2DrFqh4kT/O2bt09rG6AJr376FILQwf1Wr/DIxbWVmOf1dzbu6NQ7mXY5MXmuJr7sExuRur+dTX3fvT2IjeBGJfPVMjAqu+/mh4ZGqGVCvbI3abrMWRs20iDBXAJ7jItrqk90457/BQgt7HFStpJf2KSssQsLxp4=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z4l3S4N_1724853101)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 21:51:45 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs
Date: Wed, 28 Aug 2024 21:51:40 +0800
Message-Id: <20240828135140.1015940-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_065157_554589_AF87F053 
X-CRM114-Status: UNSURE (   6.89  )
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
 arch/um/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index be2856af6d4c..3cc2b663aa78 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -291,7 +291,8 @@ unsigned long __get_wchan(struct task_struct *p)
 int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	int cpu = current_thread_info()->cpu;
+	int pid = userspace_pid[cpu];
 
-	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
+	return save_i387_registers(pid, (unsigned long *) fpu) == 0;
 }
 
-- 
2.34.1


