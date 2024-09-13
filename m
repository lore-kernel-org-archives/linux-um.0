Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858A3FA3757
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gUrSAQP6ItGLxIKpBinbaBgwPMSnam/qyeaCMOabpRI=; b=Jt0tJ/Pj9LALlX4csGMFRiBlC1
	wkL561s+fG2R51qjezVkQ49+3vD/tYuL3O5vCtiP0YbVaJAk3TF09OuAvkUMwtMRnzksVVljQcABl
	kQ8q8Bd5b3P4sVMkcM9PGFudMwCunpr7eP6geC83LSNyoDs9cVLl18KrHi8/d/cnzn9HZPsvGaKD2
	CHabBZ/RGn8O6jN6ruNH4zpUogWpC8PGKez+6hL3dIK3Om65PYULgUiPFUCaxQ0aTXRJlX1ZwDu6D
	HAnCYLtZvXtNj7w7/yKfqoYg6TD+R1B8FL5afxOajgPOEIns8pE6NkcjACbDvQm6Z+ue5M/+jWG+m
	gjAhvFoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6c1-0000000G4m6-08kc;
	Fri, 13 Sep 2024 13:45:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6by-0000000G4it-0VGW
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:45:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gUrSAQP6ItGLxIKpBinbaBgwPMSnam/qyeaCMOabpRI=;
	t=1726235122; x=1727444722; b=l7DklIpzol9ic6st0R5QT4j9uJsg5YmtWVYgOQgm14CkCRJ
	CSqw8CgpIg+pZ9ggFzZVViya1gOhefcE+kf6MdYSZyJUepFXPblVkJY2P9M6jV7ArFPVYFnm3LExq
	hLoER23w7jmyN9/cJR9ih0hVT1y5InetTAPxFIrtiZxY6ANRJIYXJLmyjORHxtzjzosqDeCCWY4cv
	lkGwAm+ZavzlJp6wggXEQHE+nurtKz0QvbOJ1y5GT5POavWfQ3appKPnHidDBBnvQN+I2a2tC0zko
	aokIcnSmlGQWzItGFQstUQjTWxijIvZMwcUUpJIUlDSSCsmQqoFlCLHtTpdz8cJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6bv-0000000GZ3W-3WpY;
	Fri, 13 Sep 2024 15:45:20 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 2/5] um: Remove unused os_process_parent
Date: Fri, 13 Sep 2024 15:44:39 +0200
Message-ID: <20240913134442.967599-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913134442.967599-1-benjamin@sipsolutions.net>
References: <20240913134442.967599-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064522_294324_0BF8767A 
X-CRM114-Status: UNSURE (   8.96  )
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

The function is not used anywhere.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/os.h |  1 -
 arch/um/os-Linux/process.c  | 39 -------------------------------------
 2 files changed, 40 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index c8c1a93c8d2c..4bdd4fb5dd80 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -199,7 +199,6 @@ extern int create_mem_file(unsigned long long len);
 extern void report_enomem(void);
 
 /* process.c */
-extern int os_process_parent(int pid);
 extern void os_alarm_process(int pid);
 extern void os_stop_process(int pid);
 extern void os_kill_process(int pid, int reap_child);
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 6b74a8d91e06..b25c226c5491 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -18,45 +18,6 @@
 #include <longjmp.h>
 #include <os.h>
 
-#define FAILURE_PID    -1
-
-#define STAT_PATH_LEN sizeof("/proc/#######/stat\0")
-#define COMM_SCANF "%*[^)])"
-
-int os_process_parent(int pid)
-{
-	char stat[STAT_PATH_LEN];
-	char data[256];
-	int parent = FAILURE_PID, n, fd;
-
-	if (pid == -1)
-		return parent;
-
-	snprintf(stat, sizeof(stat), "/proc/%d/stat", pid);
-	fd = open(stat, O_RDONLY, 0);
-	if (fd < 0) {
-		printk(UM_KERN_ERR "Couldn't open '%s', errno = %d\n", stat,
-		       errno);
-		return parent;
-	}
-
-	CATCH_EINTR(n = read(fd, data, sizeof(data)));
-	close(fd);
-
-	if (n < 0) {
-		printk(UM_KERN_ERR "Couldn't read '%s', errno = %d\n", stat,
-		       errno);
-		return parent;
-	}
-
-	parent = FAILURE_PID;
-	n = sscanf(data, "%*d " COMM_SCANF " %*c %d", &parent);
-	if (n != 1)
-		printk(UM_KERN_ERR "Failed to scan '%s'\n", data);
-
-	return parent;
-}
-
 void os_alarm_process(int pid)
 {
 	kill(pid, SIGALRM);
-- 
2.46.0


