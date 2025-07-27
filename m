Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83AEC87FCC
	for <linux-um@archiver.kernel.org>; Sun, 27 Jul 2025 06:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HzWwg9ZbXSlmytRYMunN72zPUt5bTULnlx+bcn9REqY=; b=Btb+iisyvZwnohwAbl5qcy499h
	4N7J65yDc7FvU+83hu5C8NiUoaWU5kAR6omK7JVeAd+LZKBZ9NkhBJS4jrShci/fKnV2ADYfHm12R
	e/p83QWTdl75CurMAntbGgs8qLNw+CQh2r3fJwEofbZOyzcJyMHKG7/LMsTADNOvQGWWTZhlMtvPe
	14SORKSiuSOaKQTySxcp2A0KGMoBzGiuFd5n8NbOzQt1yiD10zy7UgmXAyeo9+XOvKyxDVVSCwNtA
	f1dJgInjvL+7vYyUTSGVyalckPc/PRea+mmFErXmUuGimYDDnyRBqCacV3c9Ki5qoBQR2GbS9Xa5P
	BqM5k3aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufuu1-0000000CO05-28hJ;
	Sun, 27 Jul 2025 06:30:33 +0000
Received: from out-185.mta0.migadu.com ([91.218.175.185])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufutz-0000000CNyM-0J0U
	for linux-um@lists.infradead.org;
	Sun, 27 Jul 2025 06:30:32 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753597829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzWwg9ZbXSlmytRYMunN72zPUt5bTULnlx+bcn9REqY=;
	b=D2HzWRTL2nHhNMKNll1++v8FDqshtqYwjcHoRAtUEgMwsD6LzfhUGk6zHjTzEbU4z23Yi2
	UK6/6NGh0aE8Me30pqchZuAm/redgW/8Qb9fz+pmsKUngB8DHS4y7TR4JO9lsKNfK+Bjjl
	8KYcHw1/dLs3/wHwjxCPYJNFNJ8bkEs=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 8/9] um: Support directing IO signals to calling thread
Date: Sun, 27 Jul 2025 14:29:36 +0800
Message-Id: <20250727062937.1369050-9-tiwei.bie@linux.dev>
In-Reply-To: <20250727062937.1369050-1-tiwei.bie@linux.dev>
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_233031_265540_965F66A8 
X-CRM114-Status: GOOD (  12.62  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

Extend os_set_fd_async() to allow the calling thread to direct
I/O availability signals to itself. After this change, existing
users will explicitly direct these signals to the CPU0 thread,
which was achieved by ignoring SIGIO in helper threads. This is
a preparation for adding SMP support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/os.h |  2 +-
 arch/um/kernel/irq.c        |  4 ++--
 arch/um/os-Linux/file.c     | 10 +++++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 0ca6e4548671..ca377421181d 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -155,7 +155,7 @@ extern int os_pread_file(int fd, void *buf, int len, unsigned long long offset);
 extern int os_pwrite_file(int fd, const void *buf, int count, unsigned long long offset);
 extern int os_file_modtime(const char *file, long long *modtime);
 extern int os_pipe(int *fd, int stream, int close_on_exec);
-extern int os_set_fd_async(int fd);
+extern int os_set_fd_async(int fd, int self);
 extern int os_clear_fd_async(int fd);
 extern int os_set_fd_block(int fd, int blocking);
 extern int os_accept_connection(int fd);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 5ed8014e43e4..193b6374d890 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -302,7 +302,7 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 	int err, events = os_event_mask(type);
 	unsigned long flags;
 
-	err = os_set_fd_async(fd);
+	err = os_set_fd_async(fd, 0);
 	if (err < 0)
 		goto out;
 
@@ -607,7 +607,7 @@ void um_irqs_resume(void)
 	raw_spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		if (entry->suspended) {
-			int err = os_set_fd_async(entry->fd);
+			int err = os_set_fd_async(entry->fd, 0);
 
 			WARN(err < 0, "os_set_fd_async returned %d\n", err);
 			entry->suspended = false;
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 617886d1fb1e..2544a0fc9fbb 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -391,8 +391,12 @@ int os_pipe(int *fds, int stream, int close_on_exec)
 	return err;
 }
 
-int os_set_fd_async(int fd)
+int os_set_fd_async(int fd, int self)
 {
+	struct f_owner_ex owner = {
+		.type = F_OWNER_TID,
+		.pid = self ? gettid() : os_getpid(),
+	};
 	int err, flags;
 
 	flags = fcntl(fd, F_GETFL);
@@ -408,9 +412,9 @@ int os_set_fd_async(int fd)
 	}
 
 	if ((fcntl(fd, F_SETSIG, SIGIO) < 0) ||
-	    (fcntl(fd, F_SETOWN, os_getpid()) < 0)) {
+	    (fcntl(fd, F_SETOWN_EX, &owner) < 0)) {
 		err = -errno;
-		printk(UM_KERN_ERR "os_set_fd_async : Failed to fcntl F_SETOWN "
+		printk(UM_KERN_ERR "os_set_fd_async : Failed to fcntl F_SETOWN_EX "
 		       "(or F_SETSIG) fd %d, errno = %d\n", fd, errno);
 		return err;
 	}
-- 
2.34.1


