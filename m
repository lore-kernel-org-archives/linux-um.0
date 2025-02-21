Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4F4C021AA
	for <linux-um@archiver.kernel.org>; Fri, 21 Feb 2025 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hbPH9YmXF2sSugcYogcprtVveICkEHIEi2QKojte4fw=; b=cSMq9o2XY0XFtaA3/XogJlFS5D
	li8VReUkHnPsEFor9CTI0Ba1MLlWHu884QDYgy/WFghbFHvq03PCfDOCuHA9oUeLwWtdyR1JVjsmI
	0CnsxSqPifbD+0RTzkjhD1YT8/SbZ/RPC2f08GilBKw9kspFgeGnclOjDgVtIOxDTV5o9a7eNlXi6
	EhmGbhtddyhOFqh7Wgg98/jD0KVGUt0a9FVNPfaBqdMTFPcD9P9TV/ShAbg8DSM8m9OPHU03WACuq
	yCopURz3yCwx4w/7j941Rz5ktBR01gr7jm9/vCtjbYI+HuA3JV/9HhZ/o9uL2KuEK50TUNUvPHOTb
	U18EK4iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOan-00000004kY5-2Ncm;
	Fri, 21 Feb 2025 08:41:05 +0000
Received: from out0-203.mail.aliyun.com ([140.205.0.203])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOak-00000004kUs-1f0g
	for linux-um@lists.infradead.org;
	Fri, 21 Feb 2025 08:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1740127259; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hbPH9YmXF2sSugcYogcprtVveICkEHIEi2QKojte4fw=;
	b=W+dI4NeCKrXZNAqPEONqMr7dUXBztANnuH0+wrMV0BoamIcBSwjBiDoKPmHEeoqDeh5nn3OksgZXSA6iyC850tuX1AKjjF0y/6g6kWeM4cXWiXMBh6xswyC57EqThSdZ2fugAnA2wo56VnTrmSEI5u/MqARoegMrz2JeDNAfbLQ=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bYJdX67_1740127257 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 16:40:58 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/4] um: Add the pthread-based helper support
Date: Fri, 21 Feb 2025 16:40:46 +0800
Message-Id: <20250221084049.1332318-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221084049.1332318-1-tiwei.btw@antgroup.com>
References: <20250221084049.1332318-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_004102_953938_5A6C4410 
X-CRM114-Status: GOOD (  10.41  )
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

Introduce a new set of utility functions that can be used to create
pthread-based helpers. Helper threads created in this way will ensure
thread safety for errno while sharing memory address space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/os.h |  3 ++
 arch/um/os-Linux/helper.c   | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 5babad8c5f75..1f62e793bce3 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -225,6 +225,9 @@ extern int run_helper_thread(int (*proc)(void *), void *arg,
 			     unsigned int flags, unsigned long *stack_out);
 extern int helper_wait(int pid);
 
+int os_run_helper_thread(void *(*routine)(void *), void *arg, void **handle_out);
+void os_kill_helper_thread(void *);
+void os_fix_helper_thread_signals(void);
 
 /* umid.c */
 extern int umid_file_name(char *name, char *buf, int len);
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 3cb8ac63be6e..c6a0ef8beb29 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sched.h>
+#include <pthread.h>
 #include <linux/limits.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
@@ -167,3 +168,62 @@ int helper_wait(int pid)
 	} else
 		return 0;
 }
+
+int os_run_helper_thread(void *(*routine)(void *), void *arg, void **handle_out)
+{
+	pthread_t *td;
+	sigset_t sigset, oset;
+	int err, flags;
+
+	flags = __uml_cant_sleep() ? UM_GFP_ATOMIC : UM_GFP_KERNEL;
+	td = uml_kmalloc(sizeof(*td), flags);
+	if (!td)
+		return -ENOMEM;
+
+	sigfillset(&sigset);
+	if (sigprocmask(SIG_SETMASK, &sigset, &oset) < 0) {
+		err = -errno;
+		kfree(td);
+		return err;
+	}
+
+	err = pthread_create(td, NULL, routine, arg);
+
+	if (sigprocmask(SIG_SETMASK, &oset, NULL) < 0)
+		panic("Failed to restore the signal mask: %d", errno);
+
+	if (err != 0)
+		kfree(td);
+	else
+		*handle_out = td;
+
+	return -err;
+}
+
+void os_kill_helper_thread(void *handle)
+{
+	pthread_t *td = handle;
+
+	pthread_kill(*td, SIGKILL);
+	CATCH_EINTR(pthread_join(*td, NULL));
+	kfree(td);
+}
+
+void os_fix_helper_thread_signals(void)
+{
+	sigset_t sigset;
+
+	sigemptyset(&sigset);
+
+	sigaddset(&sigset, SIGWINCH);
+	sigaddset(&sigset, SIGPIPE);
+	sigaddset(&sigset, SIGPROF);
+	sigaddset(&sigset, SIGINT);
+	sigaddset(&sigset, SIGTERM);
+	sigaddset(&sigset, SIGCHLD);
+	sigaddset(&sigset, SIGALRM);
+	sigaddset(&sigset, SIGIO);
+	sigaddset(&sigset, SIGUSR1);
+
+	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
+}
-- 
2.34.1


