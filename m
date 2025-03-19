Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF578C35FFA
	for <linux-um@archiver.kernel.org>; Wed, 19 Mar 2025 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6dp817P02CEgbm+ak2ponlxXzfEwYBQTmCWdq5Cu3dk=; b=4S7w2wiZtlJ1Js3+6XHQCnjbUB
	Y5Z0s+abc/Iv6TyCBsOBLPb/R5YVqO/HotuvqldS7kNaIHykcd2VraedD2I6wZFOY/f/XXeGCY8JY
	M1Q4n3m93PciTuUmiXpM9Xqr2UiA9rgjlJGbwmNxq0ZE3vg3tWIDvSGq4b4akNdy/+q89cKoTBddM
	2UZbKRcVMlJNCVSlcsu7htRyD1V/A6Wvd20kFyesa3kvsVAVBf8MuNPhqO9Yq3irDg37+xsbYuEoV
	XRRuksLooSjx8+nfjQdVprnt4PS87groSF/O0xb46L3ohOKHBDX8GwA0BF/pF6cBcPoLUj7P2p7Jg
	u6aN1wMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuttX-000000098VM-3yqV;
	Wed, 19 Mar 2025 13:55:43 +0000
Received: from out0-218.mail.aliyun.com ([140.205.0.218])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuttT-000000098St-1SS9
	for linux-um@lists.infradead.org;
	Wed, 19 Mar 2025 13:55:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742392534; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6dp817P02CEgbm+ak2ponlxXzfEwYBQTmCWdq5Cu3dk=;
	b=ev3kkl5IYxna05UKIY4+a3b+zdUfHvekaGANVpkd2ipkjhKlng7epMY5KKr8EdJ+uh5HC9T9INzzu2W9pjXbJXMX1XggLiMmzIuY49xNNHcgJLRh1uhq0uJUZ1pzO7mr6kLl6ti0Dk96FeNzEaWGpaaQwr8o6GscDjSTAoCfvCY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.byXmrjr_1742392533 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 21:55:33 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 1/4] um: Add pthread-based helper support
Date: Wed, 19 Mar 2025 21:55:20 +0800
Message-Id: <20250319135523.97050-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319135523.97050-1-tiwei.btw@antgroup.com>
References: <20250319135523.97050-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_065539_904703_20FF9556 
X-CRM114-Status: GOOD (  11.48  )
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
thread safety for errno while sharing the same memory space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/os.h |  5 +++
 arch/um/os-Linux/helper.c   | 63 +++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index bc02767f0639..d0ae42911cb5 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -224,6 +224,11 @@ extern int run_helper_thread(int (*proc)(void *), void *arg,
 			     unsigned int flags, unsigned long *stack_out);
 extern int helper_wait(int pid);
 
+struct os_helper_thread;
+int os_run_helper_thread(struct os_helper_thread **td_out,
+			 void *(*routine)(void *), void *arg);
+void os_kill_helper_thread(struct os_helper_thread *td);
+void os_fix_helper_thread_signals(void);
 
 /* umid.c */
 extern int umid_file_name(char *name, char *buf, int len);
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 3cb8ac63be6e..df22cba24d82 100644
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
@@ -167,3 +168,65 @@ int helper_wait(int pid)
 	} else
 		return 0;
 }
+
+struct os_helper_thread {
+	pthread_t handle;
+};
+
+int os_run_helper_thread(struct os_helper_thread **td_out,
+			 void *(*routine)(void *), void *arg)
+{
+	struct os_helper_thread *td;
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
+	err = pthread_create(&td->handle, NULL, routine, arg);
+
+	if (sigprocmask(SIG_SETMASK, &oset, NULL) < 0)
+		panic("Failed to restore the signal mask: %d", errno);
+
+	if (err != 0)
+		kfree(td);
+	else
+		*td_out = td;
+
+	return -err;
+}
+
+void os_kill_helper_thread(struct os_helper_thread *td)
+{
+	pthread_cancel(td->handle);
+	pthread_join(td->handle, NULL);
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


