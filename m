Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EE1CE8E85
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vju3PSxIcD7VxO0E+oMlNC+TNtVp16e3ZGllvv3Wkog=; b=AXQ5SRYc5WPbzI91proyxMDzDs
	FufN9kVfq5MNlrSkHK08mjrZY3Q7/K5LdCMniCOHO70WEVBnQ07nciGHQiM6qNbF7CZty5FNvH7Zh
	zYtBB7T5KIsujoTBI0fT2NV0763tcf5YApDP1nTVpOEGE52A9APIyqYlODIw5Q0WTM8UC+kW8pUyo
	fM0x9pllC3V63gqiLymde18tDr6xaMOXnqH7UXMd68Xty5MB8HbEzKlKioo++KGyE1bUWojGlMZCr
	pIPntG4PrTbBLOun3XR8diL5kPxTAHVwMWgbHnK1S//AkgFzkBSBP4IyIT1YUCprxk0c8r8m8uGTt
	Q9erG6/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3z19-00000000mJD-21dP;
	Thu, 24 Oct 2024 14:40:51 +0000
Received: from out0-221.mail.aliyun.com ([140.205.0.221])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ypO-00000000jVu-3dFm
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 14:28:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780119; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Vju3PSxIcD7VxO0E+oMlNC+TNtVp16e3ZGllvv3Wkog=;
	b=Wt7ZIfQALSH0PXsZ292yjGcHGBRMaiqiDGwseh2cbH18q2f1nB62TxjiSrmMATDaYxNxTQInJba++DKOeoff78wVyjMgb7/OUFk/uIF5H8f3nHLM2N0yDoFLZCN4neP9N2sADlUNJoyw+cQi9xzsNIqNQ3sJFwzQIY9+wd4/HEc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBszp_1729780114 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:36 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/4] um: Add os_set_pdeathsig helper function
Date: Thu, 24 Oct 2024 22:28:25 +0800
Message-Id: <20241024142828.2612828-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
References: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_072843_406213_26BC5D60 
X-CRM114-Status: UNSURE (   7.51  )
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

This helper can be used to set the parent-death signal of the calling
process to SIGKILL to ensure that the process will be killed if the
UML kernel dies unexpectedly without proper cleanup. This helper will
be used in the follow-up patches.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/os.h | 2 ++
 arch/um/os-Linux/process.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 09f8201de5db..d709a24dc6fc 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -216,6 +216,8 @@ extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 extern int os_mincore(void *addr, unsigned long len);
 
+void os_set_pdeathsig(void);
+
 /* execvp.c */
 extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
 /* helper.c */
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index f20602e793d9..9f086f939420 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -12,6 +12,7 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
+#include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
 #include <init.h>
@@ -203,3 +204,8 @@ void init_new_thread_signals(void)
 	set_handler(SIGIO);
 	signal(SIGWINCH, SIG_IGN);
 }
+
+void os_set_pdeathsig(void)
+{
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+}
-- 
2.34.1


