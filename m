Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D3DFA3755
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=shGvXrNXhXQHJc0vnILvzX3YOtoEo/CWWLDuo9UHZFk=; b=4pVUuxJ6PjVnTvQArr/ggGpCgB
	acfVoHAU7Rk/Nti7qEfeQISfLcl43ziDOANZ3kDMCAhnvw6jbr84I9EzY2Tlg9+QTXiTl9vG/l0S0
	CS4P0NFYU8yGSzcQbUK3fyGm/S+SvcmlFFwRQpSJPWww/rhZ2tmE58Gngth5kfpjxv6opBxjgPeUS
	xapwqYYD9pt8KxfWZ69mqks0X7GF7DkDOM7073ENew+hpq0dvjxYQ42+pb59kYD8jmfrUmx0ufkmo
	1z9B9iMWHIZiUXvhUmUCYlY7JWirorwA45WSveNonOUb50WLM6Cc5+ypNja99WDjfgKADp4MS7oQX
	k9gozzYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6Tc-0000000G3BH-3gz3;
	Fri, 13 Sep 2024 13:36:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6TB-0000000G37P-0GZi
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=shGvXrNXhXQHJc0vnILvzX3YOtoEo/CWWLDuo9UHZFk=;
	t=1726234576; x=1727444176; b=xZ1HmJkXK/pKvbKzXSnltY7NvjAgXDIiKxcTq6bh/Kr2aCg
	+86zEel84qeGrVPDJ+DU+Y28Kfs+aSMkXlpsCXa9VhbMEnpvzvZpZabSDaYvPggRjkNULxOC5w/b8
	wKI4tI7r48rt8VZHIW9mKyjJ6znKVRP/2RtQ4meAtubM+DmqKfyvS2arWt5blnk57hzvqNo5q2uhH
	43ATzy6sd+pb3o0yqDANwkZB/luR/68gfNSKK1OK+FqRCLbDTf+K3Tc8OnxNec3ZU1CndJqoIxmtd
	HbRK0q3EF+4EebSYpZ98AfI8NM/CvKox0UkOEOLAzQ4WiB9033mWjdGv5zFtKQaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6T8-0000000GXf6-0lGX;
	Fri, 13 Sep 2024 15:36:14 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/5] um: Remove unused os_process_pc
Date: Fri, 13 Sep 2024 15:35:58 +0200
Message-ID: <20240913133602.963167-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913133602.963167-1-benjamin@sipsolutions.net>
References: <20240913133602.963167-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_063617_128086_A3C6071C 
X-CRM114-Status: UNSURE (   8.79  )
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

The function is not used anywhere in the codebase.
---
 arch/um/include/shared/os.h |  1 -
 arch/um/os-Linux/process.c  | 33 ---------------------------------
 2 files changed, 34 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 9a039d6f1f74..c8c1a93c8d2c 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -199,7 +199,6 @@ extern int create_mem_file(unsigned long long len);
 extern void report_enomem(void);
 
 /* process.c */
-extern unsigned long os_process_pc(int pid);
 extern int os_process_parent(int pid);
 extern void os_alarm_process(int pid);
 extern void os_stop_process(int pid);
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index e52dd37ddadc..6b74a8d91e06 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -18,44 +18,11 @@
 #include <longjmp.h>
 #include <os.h>
 
-#define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
 
 #define STAT_PATH_LEN sizeof("/proc/#######/stat\0")
 #define COMM_SCANF "%*[^)])"
 
-unsigned long os_process_pc(int pid)
-{
-	char proc_stat[STAT_PATH_LEN], buf[256];
-	unsigned long pc = ARBITRARY_ADDR;
-	int fd, err;
-
-	sprintf(proc_stat, "/proc/%d/stat", pid);
-	fd = open(proc_stat, O_RDONLY, 0);
-	if (fd < 0) {
-		printk(UM_KERN_ERR "os_process_pc - couldn't open '%s', "
-		       "errno = %d\n", proc_stat, errno);
-		goto out;
-	}
-	CATCH_EINTR(err = read(fd, buf, sizeof(buf)));
-	if (err < 0) {
-		printk(UM_KERN_ERR "os_process_pc - couldn't read '%s', "
-		       "err = %d\n", proc_stat, errno);
-		goto out_close;
-	}
-	os_close_file(fd);
-	pc = ARBITRARY_ADDR;
-	if (sscanf(buf, "%*d " COMM_SCANF " %*c %*d %*d %*d %*d %*d %*d %*d "
-		   "%*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d "
-		   "%*d %*d %*d %*d %*d %lu", &pc) != 1)
-		printk(UM_KERN_ERR "os_process_pc - couldn't find pc in '%s'\n",
-		       buf);
- out_close:
-	close(fd);
- out:
-	return pc;
-}
-
 int os_process_parent(int pid)
 {
 	char stat[STAT_PATH_LEN];
-- 
2.46.0


