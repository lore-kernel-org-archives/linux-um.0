Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3056C27C77
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hp5LFPHgnfrVTq7ygejxjdx9Ejal9WIM/AzR6eF8wRE=; b=h54TBJqAaA4JNGFFXCLj2t/uQ3
	EVF937yjX801aESK1+GunstdAk3RJO6jc/HduMSy+MTg8AQb2FavuuYLlBZQDF3tZanul2Z/W93gi
	EIwHUJ66aBMuhSzJDFCWrZDKwLX+re4RCKqoMdu6V/2f/4VXeiNKTNPlxuPobIUB+2baeDyEsO48h
	sT2w01J0UeJugxk9gghrHmQRaBOdxvfaO7sxiDsiYFx+q/ADtdXXC5pzofv9Ih+H5x2Op9GpJZP3j
	lOiavoh/tkUFvQNW7YJfTdvI23DrdEP1d4rfXUAtJHaGa8qV4eOF98KPfYyxOu/xAaA0+aUcl9fhp
	BIGJuToQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOLB-0000000CnZS-0V4e;
	Wed, 12 Jun 2024 13:48:41 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOL7-0000000CnW4-04xo
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 13:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Hp5LFPHgnfrVTq7ygejxjdx9Ejal9WIM/AzR6eF8wRE=;
	t=1718200116; x=1719409716; b=miTadJFXl6BoWrrr62hzo+0UWxUZjwLvBNaNM/gXJh/wJkr
	Hc+dAdBGf5KQwXkn3w5HivAWl28JvWb748VCp5Yb120bKXI2EaquHm3AZc+05V1l9x47N5GImLdD8
	95AEYq6v50i0tnho+8paUWJRlhDe+HCDfsnhX0MwEyBmuc2dVhJRZ3r41HD44RS+IsRNld8JqT25M
	y2iKKUorlyDOkJSncKJfMU63CI5/olJfUg32ppumXlRbTzV9DN+xV2piubUd8g6GG/HZJQMBLuBOS
	Iq8bJXcFx1mEgwqlwKPYwY13Fwrhr2liWSyFyES30X0ijANJyvpUrWqzCY50Zlwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sHOL4-0000000ALhN-3pL9;
	Wed, 12 Jun 2024 15:48:35 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 3/5] um: Do a double clone to disable rseq
Date: Wed, 12 Jun 2024 15:48:02 +0200
Message-ID: <20240612134804.1626427-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612134804.1626427-1-benjamin@sipsolutions.net>
References: <20240612134804.1626427-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_064837_173726_A0592E93 
X-CRM114-Status: GOOD (  17.58  )
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

Newer glibc versions are enabling rseq support by default. This remains
enabled in the cloned child process, potentially causing the host kernel
to write/read memory in the child.

It appears that this was purely not an issue because the used memory
area happened to be above TASK_SIZE and remains mapped.

Note that a better approach would be to exec a small static binary that
does not link with other libraries. Using a memfd and execveat the
binary could be embedded into UML itself and it would result in an
entirely clean execution environment for userspace.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v2: Improved clone logic using CLONE_VFORK
---
 arch/um/os-Linux/skas/process.c | 55 ++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 41a288dcfc34..11bc6f4ce5b3 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -255,6 +255,32 @@ static int userspace_tramp(void *stack)
 int userspace_pid[NR_CPUS];
 int kill_userspace_mm[NR_CPUS];
 
+struct tramp_data {
+	int pid;
+	void *clone_sp;
+	void *stack;
+};
+
+static int userspace_tramp_clone_vm(void *data)
+{
+	struct tramp_data *tramp_data = data;
+
+	/*
+	 * At this point we are still in the same VM as the parent, but rseq
+	 * has been disabled for this process.
+	 * Continue with the clone into the new userspace process, the kernel
+	 * continues as soon as this process quits (CLONE_VFORK).
+	 */
+
+	tramp_data->pid = clone(userspace_tramp, tramp_data->clone_sp,
+				CLONE_PARENT | CLONE_FILES | SIGCHLD,
+				tramp_data->stack);
+	if (tramp_data->pid < 0)
+		tramp_data->pid = -errno;
+
+	exit(0);
+}
+
 /**
  * start_userspace() - prepare a new userspace process
  * @stub_stack:	pointer to the stub stack.
@@ -268,9 +294,10 @@ int kill_userspace_mm[NR_CPUS];
  */
 int start_userspace(unsigned long stub_stack)
 {
+	struct tramp_data tramp_data;
 	void *stack;
 	unsigned long sp;
-	int pid, status, n, flags, err;
+	int pid, status, n, err;
 
 	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
@@ -286,10 +313,13 @@ int start_userspace(unsigned long stub_stack)
 	/* set stack pointer to the end of the stack page, so it can grow downwards */
 	sp = (unsigned long)stack + UM_KERN_PAGE_SIZE;
 
-	flags = CLONE_FILES | SIGCHLD;
+	tramp_data.stack = (void *) stub_stack;
+	tramp_data.clone_sp = (void *) sp;
+	tramp_data.pid = -EINVAL;
 
-	/* clone into new userspace process */
-	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
+	/* first stage CLONE_VM clone using VFORK and no signal notification */
+	pid = clone(userspace_tramp_clone_vm, (void *) sp,
+		    CLONE_VM | CLONE_FILES | CLONE_VFORK, &tramp_data);
 	if (pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
@@ -297,6 +327,21 @@ int start_userspace(unsigned long stub_stack)
 		return err;
 	}
 
+	n = waitpid(pid, &status, WUNTRACED | WNOHANG | __WCLONE);
+	if (n < 0 || !WIFEXITED(status) || WEXITSTATUS(status)) {
+		err = -errno;
+		printk(UM_KERN_ERR "%s : wait failed, errno = %d, status = %d\n",
+		       __func__, n < 0 ? errno : 0, status);
+		goto out_kill;
+	}
+
+	pid = tramp_data.pid;
+	if (pid < 0) {
+		printk(UM_KERN_ERR "%s : second clone failed, errno = %d\n",
+		       __func__, -pid);
+		return pid;
+	}
+
 	do {
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (n < 0) {
@@ -305,7 +350,7 @@ int start_userspace(unsigned long stub_stack)
 			       __func__, errno);
 			goto out_kill;
 		}
-	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
+	} while (WIFEXITED(status) && (WSTOPSIG(status) == SIGALRM));
 
 	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
 		err = -EINVAL;
-- 
2.45.1


