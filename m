Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5297CC19F4E
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+epOjrcnscwevX+BkIMhVfG4/FidOuIEx8jyTdVre0=; b=tnKAmpR1kfVcZUrU/UWyC4texA
	SQy7VtJXa+ec1HkDGwHjahkCkMSAZavPkN46wjldRTXNVwpuuqgxjKtDzP2zZWciJ/sHojr6LT8uv
	b9RJemlA4uG4tK3iACpk3MEd40Kj1eRLZZ/cvdsXjv79CPyJHJvJUFkYlMXDGb8TWP6TcW+cPRb5W
	sUwiR9VqKm46QOX+fbaXtS9OHxGlhOjiyyp6mbEFKlndLSptRtAPj4w86MtuYvuQzOaNAPsOXhMKE
	8CS/gIwWbAco87Tqsne5FHHjOG2dt/wOO1u8PbaHenNpyq1kcGKtBHh4c6ewiYg4gY7tg6RljHR0l
	26vF27bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEHI-0000000H5NZ-3aEp;
	Tue, 23 Apr 2024 11:25:36 +0000
Received: from out0-197.mail.aliyun.com ([140.205.0.197])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEH1-0000000H5Ba-22lb
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 11:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713871514; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=N+epOjrcnscwevX+BkIMhVfG4/FidOuIEx8jyTdVre0=;
	b=L06IJxjN3ZBzDpwfjqOUTjbf7BaI/j0VXBCUQvSzGsMoz4dEzc6so6swWdCw6c993j4ORUxAQ2sFqJXdEsdU+kgGFJB9s5ZYkVR3BKm/ye8TUIz42iTHtOUZqBBLIOAoQW4ZcsJH++HNAynV+ESsDyQNlWqbOYum3qxVZ89vpD0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYhx_1713871513;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYhx_1713871513)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:13 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/7] um: Fix the declaration of kasan_map_memory
Date: Tue, 23 Apr 2024 19:24:54 +0800
Message-Id: <20240423112457.2409319-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_042520_355260_99A95745 
X-CRM114-Status: GOOD (  10.66  )
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

Make it match its definition (size_t vs unsigned long). And declare
it in a shared header to fix the -Wmissing-prototypes warning, as it
is defined in the user code and called in the kernel code.

Fixes: 5b301409e8bc ("UML: add support for KASAN under x86_64")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/kasan.h        | 1 -
 arch/um/include/shared/kern_util.h | 2 ++
 arch/um/os-Linux/mem.c             | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index 0d6547f4ec85..f97bb1f7b851 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,7 +24,6 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-void kasan_map_memory(void *start, unsigned long len);
 extern int kasan_um_is_ready;
 
 #ifdef CONFIG_STATIC_LINK
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 81bc38a2e3fc..1fa03499e1dc 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -37,6 +37,8 @@ extern void initial_thread_cb(void (*proc)(void *), void *arg);
 
 extern void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 
+extern void kasan_map_memory(void *start, size_t len);
+
 extern void uml_pm_wake(void);
 
 extern int start_uml(void);
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 8530b2e08604..c6c9495b1432 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -15,6 +15,7 @@
 #include <sys/vfs.h>
 #include <linux/magic.h>
 #include <init.h>
+#include <kern_util.h>
 #include <os.h>
 
 /*
-- 
2.34.1


