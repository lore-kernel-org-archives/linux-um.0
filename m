Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF414C10F15
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lumfKnRDCzxzbmj8wJ/Hznk5zzPAE/pxByFtYHy06AQ=; b=oPjtAqUwevDt9fxpGm0A49imc1
	S8H7yPSGkXV8E5sMRTTTr8I0pxQgrqcjLjmvpENwOj2G2L12eQIRfmNyPVR0DaqZqTdt3QMMQ2nnw
	qZEch55ugS2D3kVU3aemmAJ9L97Lv8ddCqeRaBBP0Aq0OYBTaFP0wotuz0+5JVDkr7mkzGSDZfmQq
	m3ol8AvtooaJ/Fy887p+N+MQqQucKAqFKvmXdfgcnwF1Y/nR1Ge4VHMhsQ99i5mHInQIL0KOEceHy
	UIH6tFhiZE0VgnqiDtZgBQPEyb/BxwAKEevl4FM7Z1k8zt11WVxZd5mXWbYjbCgWBR/XkF7ZLzcB3
	2kNFnIHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFk2-0000000HXzS-09SJ;
	Tue, 23 Apr 2024 12:59:22 +0000
Received: from out0-202.mail.aliyun.com ([140.205.0.202])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFjt-0000000HXv6-0JVH
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 12:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877149; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=lumfKnRDCzxzbmj8wJ/Hznk5zzPAE/pxByFtYHy06AQ=;
	b=n0HVDqsy9gqwPYdqOSn/UILDsSEH+3yxlEjWow3mT8gKzmrJX5uRX3i6D/jErMEZBzLCxOZXPe7RItbXgIQ7h75CG8iX73vowU6csFKXqbrug/drQ6jiebmIGQuAIZ79HGFYpVARI+ANq1X/pjvDSiCF8173iu9rHGOH5g1oQdE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjT6_1713877148;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjT6_1713877148)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:08 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 7/7] um: Remove unused do_get_thread_area function
Date: Tue, 23 Apr 2024 20:58:58 +0800
Message-Id: <20240423125858.137709-8-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423125858.137709-1-tiwei.btw@antgroup.com>
References: <20240423125858.137709-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_055914_770045_EA277981 
X-CRM114-Status: UNSURE (   7.22  )
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

It's not used since it was introduced by commit aa6758d4867c ("[PATCH]
uml: implement {get,set}_thread_area for i386"). Now, it's causing a
-Wmissing-prototypes warning:

arch/x86/um/tls_32.c:39:5: warning: no previous prototype for ‘do_get_thread_area’ [-Wmissing-prototypes]
   39 | int do_get_thread_area(struct user_desc *info)
      |     ^~~~~~~~~~~~~~~~~~

The original author also had doubts about whether it should be used.
Considering that 18 years have passed, let's just remove it.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/tls_32.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index ba40b1b8e179..d301deee041f 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -36,22 +36,6 @@ static int do_set_thread_area(struct user_desc *info)
 	return ret;
 }
 
-int do_get_thread_area(struct user_desc *info)
-{
-	int ret;
-	u32 cpu;
-
-	cpu = get_cpu();
-	ret = os_get_thread_area(info, userspace_pid[cpu]);
-	put_cpu();
-
-	if (ret)
-		printk(KERN_ERR "PTRACE_GET_THREAD_AREA failed, err = %d, "
-		       "index = %d\n", ret, info->entry_number);
-
-	return ret;
-}
-
 /*
  * sys_get_thread_area: get a yet unused TLS descriptor index.
  * XXX: Consider leaving one free slot for glibc usage at first place. This must
@@ -231,7 +215,6 @@ int arch_set_tls(struct task_struct *new, unsigned long tls)
 	return ret;
 }
 
-/* XXX: use do_get_thread_area to read the host value? I'm not at all sure! */
 static int get_tls_entry(struct task_struct *task, struct user_desc *info,
 			 int idx)
 {
-- 
2.34.1


