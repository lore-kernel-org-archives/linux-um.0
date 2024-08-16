Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99A5C531DF
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 10:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xaPbnHCYbWmnOQhAEH3tFBvJcl0Mc7zmh0X86Vcw7mg=; b=C9ibSJ1CCDF4c/8T0FCpg97zbl
	gmv19sBDealCeCFYm/3l6XDN7y6J40+Pr/ZqGIOJgI7LS5M/Hh6tVv1+HNV8ViwEDoPoI2KZK2jL8
	MscqMWUFlsr4k5bbT/vRSfz244SLJBj7daHqyZzG2pLNXl37gveWGVEMKbyeRap9NBt7Js+Z7zklW
	yGxqLoWGe9RBWxOF7SD6FKh9fUj1C46XBmloM34PyQVSIyhjar3Luvptj5eNZAL9XjBBUjOCEfmkx
	D1ZoPffKoecwAMBbuHxNiBaptEPa4LgY7NhcbmcYaxPjORdh3ewiEXTL1qXR7pwNkHOjQoXXzfcC/
	M3u1MRmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setkk-0000000CWNq-2JP4;
	Fri, 16 Aug 2024 10:00:14 +0000
Received: from out0-215.mail.aliyun.com ([140.205.0.215])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setke-0000000CWKG-0mPD
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 10:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802405; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xaPbnHCYbWmnOQhAEH3tFBvJcl0Mc7zmh0X86Vcw7mg=;
	b=LZz4lA0Sa+rqCiyhu+pwRlH+JjFnjML8aYphyxQjZQpuN5pvPdY8VW6a3JU7Qtw77KGBJYSG+ks9FYZ2BT6IfwIx+iLUqxfU/3dtku2xwoVkkbIR7clBYLPKP4M0lcFv2P7a+1jbCxJDUeIJmKVcxPhvN/1c+L5Mjh1TnV7KH3Q=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE9B_1723802404)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 5/6] um: Remove the call to SUBARCH_EXECVE1 macro
Date: Fri, 16 Aug 2024 17:59:52 +0800
Message-Id: <20240816095953.638401-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816095953.638401-1-tiwei.btw@antgroup.com>
References: <20240816095953.638401-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_030008_740734_60472CE1 
X-CRM114-Status: UNSURE (   5.07  )
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

This macro isn't defined by any supported sub-architectures in tree
since it was introduced by commit 1d3468a6643a ("[PATCH uml: move
_kern.c files").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/exec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 2c15bb2c104c..cb8b5cd9285c 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -35,8 +35,5 @@ void start_thread(struct pt_regs *regs, unsigned long eip, unsigned long esp)
 	PT_REGS_IP(regs) = eip;
 	PT_REGS_SP(regs) = esp;
 	clear_thread_flag(TIF_SINGLESTEP);
-#ifdef SUBARCH_EXECVE1
-	SUBARCH_EXECVE1(regs->regs);
-#endif
 }
 EXPORT_SYMBOL(start_thread);
-- 
2.34.1


