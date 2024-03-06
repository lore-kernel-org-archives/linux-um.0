Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9CDC54E41
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 10:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kWilWoZVgn4lyROhgRRHHfX/plr+3pJHP+in0Q+peQM=; b=1Cst30/i4Lx67Y1CenMc1DOjNu
	rRhUxGnVw3sygsjJbCPvPIhOUHDZnVL+hRRdT70nEpBysph61iXnPIICaxmNeMit0fIKY2Ml/+cxs
	qrp9Nkkwgbn1hq9fmnfwiJpV8Y+3OOWl4uEJQ3TvbBDpp/55tYCjOtTs/eu3O1WJqbQRBtBZZVzU7
	eLwrQZ/4tCEiUZoAOvch7LoK2sRKbQWiKoBQhct7+FaHbd4C6ILfb+GDF7chU+JfR8LL+B9qtmRBi
	ytANeF1q4V/ACy4Fm2pu9igxXwkARz8jJDrNhrWnXFThE5FAtr2bErdsFpO5Ua3ZPAlF5syzey1dK
	tfRF73kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNR-0000000HNKb-3XOe;
	Wed, 06 Mar 2024 10:19:57 +0000
Received: from out0-219.mail.aliyun.com ([140.205.0.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNI-0000000HNA8-1MhK
	for linux-um@lists.infradead.org;
	Wed, 06 Mar 2024 10:19:49 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-K9_1709720384;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-K9_1709720384)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:44 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 9/9] um: Fix -Wmissing-prototypes warnings for __warp_* and foo
Date: Wed, 06 Mar 2024 18:19:25 +0800
Message-Id: <20240306101925.1088870-10-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_021948_617816_A40A12FB 
X-CRM114-Status: UNSURE (   8.46  )
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

These functions are not called explicitly. Let's just workaround
the -Wmissing-prototypes warnings by declaring them locally similar
to what was done in arch/x86/kernel/asm-offsets_32.c.

This will address below -Wmissing-prototypes warnings:

./arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for ‘foo’ [-Wmissing-prototypes]
arch/um/os-Linux/main.c:187:7: warning: no previous prototype for ‘__wrap_malloc’ [-Wmissing-prototypes]
arch/um/os-Linux/main.c:208:7: warning: no previous prototype for ‘__wrap_calloc’ [-Wmissing-prototypes]
arch/um/os-Linux/main.c:222:6: warning: no previous prototype for ‘__wrap_free’ [-Wmissing-prototypes]
arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for ‘foo’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c                    | 5 +++++
 arch/x86/um/shared/sysdep/kernel-offsets.h | 3 +++
 arch/x86/um/user-offsets.c                 | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index c8a42ecbd7a2..e82164f90288 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -184,6 +184,11 @@ int __init main(int argc, char **argv, char **envp)
 
 extern void *__real_malloc(int);
 
+/* workaround for -Wmissing-prototypes warnings */
+void *__wrap_malloc(int size);
+void *__wrap_calloc(int n, int size);
+void __wrap_free(void *ptr);
+
 void *__wrap_malloc(int size)
 {
 	void *ret;
diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
index a004bffb7b8d..48de3a71f845 100644
--- a/arch/x86/um/shared/sysdep/kernel-offsets.h
+++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
@@ -6,6 +6,9 @@
 #include <linux/kbuild.h>
 #include <asm/mman.h>
 
+/* workaround for a warning with -Wmissing-prototypes */
+void foo(void);
+
 void foo(void)
 {
 #include <common-offsets.h>
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index e54a9814ccf1..1c77d9946199 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -14,6 +14,9 @@
 	COMMENT(#val " / sizeof(unsigned long)");	\
 	DEFINE(sym, val / sizeof(unsigned long))
 
+/* workaround for a warning with -Wmissing-prototypes */
+void foo(void);
+
 void foo(void)
 {
 #ifdef __i386__
-- 
2.34.1


