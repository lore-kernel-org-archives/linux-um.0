Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA67DFA3758
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7jQ0LY8LlG1DaAIuyx516sPNv95cBD2bJzlx/Tt1cdo=; b=b6Fupb8HzOYyW537v21H5xnVtO
	mUsokXSuxxQ4nQuai6HFIg58SSNUyn373H/BpqPfdlKYEnrMmnisZ1v+LINTM+wxcI0gUf/noXUbb
	OqtkLoQJP/Gz8YJ2e23LTaS1f7oUkIMYeFBpHUfqG1knCCAi9xa5908fQfzH2CAJRmKkdwevn5rYr
	CSoU2bCR1Vny3um4mz+w+PXTFewtk/EkGm2FQyQw5Wpk8Rw1OHiY8Ayp2xsH1eJm9tGErby8c5Fhz
	/fL4bw36VNZz4F2zNLWEbnlgUGXbCHRuxfuETr3CFuplZO/z/x7qExyQ4UUJ8vXGTaOCSQ4xhhAkm
	3sYUdkYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bz-0000000G4kD-0td0;
	Fri, 13 Sep 2024 13:45:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bw-0000000G4hg-3epR
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:45:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7jQ0LY8LlG1DaAIuyx516sPNv95cBD2bJzlx/Tt1cdo=;
	t=1726235120; x=1727444720; b=Dg8NDAPHaZmtPktA0HKAYcuJ627Za6R9wf7Kg/XkQX7S7T+
	FNMeHXognSzRfNJfRmKH3T1Y0LjYVLq2XPyhu2D6wH8qRh0hJNnDwFDHB+nMxRKSpNsNND34ncA+U
	vB/h2/mDqLmf2BjdA8PY8ak/ATGKvb76Tb2PhnqrA7pv9XV7QIwOjiq2wy/amNhssw9PPGQjxZQi7
	2h22+7JMFK5yFS8EBOkLEtX/yXSRz5oA1Y5ocCLEMW4PRJ7rBnRzqw6Mtb1MldbYNU2ThZDTJ4vUj
	M07SdAw+N/6ZChyqnUbbvuv9lTVAOfD+2iNat1+WofEWFBhhdexaejyIalBL13dQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6bu-0000000GZ3W-0kzN;
	Fri, 13 Sep 2024 15:45:18 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 1/5] um: Remove unused os_process_pc
Date: Fri, 13 Sep 2024 15:44:38 +0200
Message-ID: <20240913134442.967599-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913134442.967599-1-benjamin@sipsolutions.net>
References: <20240913134442.967599-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064520_945085_CB2860E3 
X-CRM114-Status: UNSURE (   9.09  )
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

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
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


