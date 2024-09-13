Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1B3FA3756
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y70Yni1fwwVIWsx+ueQpN8lK6mJqanJelHzX7HJ9wrQ=; b=EKlKACo7Fx6nRlTlap58uHN5KJ
	IEj8aM0vXOQiMx6jBBdwmFF70YuEYsRm6g4NByevEXF4Wzq5vgsm1F5eiLqcao2nvv0Gu5tmBXU4j
	CApOStu1Wm604st9oPb1zS9WEt59cQLHAfr/cDK1EhonsOuur9rNCQ3vNVz4552p8g4T3/1/o//aO
	6AOSYPOSKrr2ECKRtljvvWWlcNYdM9u2YN3e1QTUnPsdzZDJpJggSrxgeSpRJmRr6Qajad4C+o5Ky
	ZsEnttiOZrS64c+FWL62WNzso1G+cvzzRN50mHvJu5BaaQ1in48D8rADJ/Bm0E9EJo9xQ4trqzKYO
	ab3u0MIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6Td-0000000G3BW-0t8S;
	Fri, 13 Sep 2024 13:36:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6TB-0000000G37i-48Ek
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:36:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=y70Yni1fwwVIWsx+ueQpN8lK6mJqanJelHzX7HJ9wrQ=;
	t=1726234577; x=1727444177; b=rTSVidL8oRTT72PXEFkLzr65brPkasgu7sRwybqZA4gdKz9
	3DlgkKvJhWivjx8Uy11eaS4ExZRREKNwQa9Ne2KckDTVOgRkXeHIAiyiZhClhdutXxhCVGefBvN3h
	7moJMdO7wDtG+BYHnQ1q3FSU7IY6ezqG297DSxQaMquSHJXjrexdts2Hc89UDitQr/dwL3I+NkluN
	8+FweDLwLNHxKqKgcpdP/87tqfZMfSI5puo8ATvotfpie8UUaGS64vgxhGf+IquT0+zJwIIdNs8/p
	YjrRMTTEHY4eJjf9t++bPAsWv3sxBVz/HvLkZaIx6d/ayPK/kE8nqxHOmNUBPKqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6T9-0000000GXf6-3mXu;
	Fri, 13 Sep 2024 15:36:16 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/5] um: Remove unused os_process_parent
Date: Fri, 13 Sep 2024 15:35:59 +0200
Message-ID: <20240913133602.963167-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913133602.963167-1-benjamin@sipsolutions.net>
References: <20240913133602.963167-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_063618_045891_87660220 
X-CRM114-Status: UNSURE (   8.74  )
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


