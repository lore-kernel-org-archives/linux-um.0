Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E31C369A1
	for <linux-um@archiver.kernel.org>; Mon,  7 Apr 2025 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Odf4Ddk1ak3Z8BBw/cVBJ2e/0hHw2GU4Sp3rBfDN88A=; b=A0ICKwCHtvrJzXIkr5fmoV1FXd
	kVfbtepfNW2kumPyec5u1Kl9AW8qcxB73minWAzd+FZBADucCnykusFh9ubXjmzpKty3Qb8dnesJM
	JSLpXWxa6sb1OuL++gM3W2EMsHhGx58qsz9vF/9cHHRREWlkIW+UUpkhZijBaGSu20zG8iRTlSX/O
	JSQHzzU159BMy7gtc6GNb7tSey3SHOajJvQJFl4H/iz3xGuoAmK4gn9tJasdmBrni4Rhwtc3DEcPA
	37n9XXGtIPM/O2f/N6/+9lFBRoFNo1u0pt5T/ho/1aA43DuhU9gXBrpikEShnfX0ZgOII97N8c90x
	sjV5biDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1uIm-0000000241h-1t5R;
	Mon, 07 Apr 2025 21:46:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1qyB-00000001UON-0fNn
	for linux-um@lists.infradead.org;
	Mon, 07 Apr 2025 18:13:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 20FDF61164;
	Mon,  7 Apr 2025 18:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA71C4CEDD;
	Mon,  7 Apr 2025 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049594;
	bh=gU6hkKGDdvk7K7dSuye72CQjJX8W0AKAn4D7NbahrSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6qZ/5Ld/fDycCih2uw2tHkJ1sss8iltjm2MRdOqRlzA2mF/jkAr7S3O/S4uPNy4J
	 nCgvjZueOI3lv7oPWgqAUc9z58hK0aplvfJqg3iUMRbliNqzpzi9NpvPz4g3E6S5Io
	 cOGj2fm/r5lk91rE+vcnco0nnreVwwCf2p8CC7rupPtMCaBBhwCBJnvk71eag9T2k0
	 DO92sC2Rqd+ju052U/WvVbpKXCoway7/XI/Q+lZAJEtb8ematgl1U+hEx+R+8bv+2b
	 GGGOv7i7RpA860rzL/V3r5NyvC/6pkQmbFiYuhyTyz98g05GGtRyHZ8hp9LUVeaCmD
	 MyvnxnBJuswrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 22/28] um: Switch to the pthread-based helper in sigio workaround
Date: Mon,  7 Apr 2025 14:12:12 -0400
Message-Id: <20250407181224.3180941-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
Content-Transfer-Encoding: 8bit
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

[ Upstream commit d295beeed2552a987796d627ba7d0985b1e2d72f ]

The write_sigio thread and UML kernel thread share the same errno,
which can lead to conflicts when both call syscalls concurrently.
Switch to the pthread-based helper to address this issue.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250319135523.97050-4-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/sigio.c | 44 +++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9aac8def4d635..61b348a2ea974 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -21,8 +21,7 @@
  * Protected by sigio_lock(), also used by sigio_cleanup, which is an
  * exitcall.
  */
-static int write_sigio_pid = -1;
-static unsigned long write_sigio_stack;
+static struct os_helper_thread *write_sigio_td;
 
 /*
  * These arrays are initialized before the sigio thread is started, and
@@ -48,15 +47,15 @@ static struct pollfds current_poll;
 static struct pollfds next_poll;
 static struct pollfds all_sigio_fds;
 
-static int write_sigio_thread(void *unused)
+static void *write_sigio_thread(void *unused)
 {
 	struct pollfds *fds, tmp;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
 
-	os_set_pdeathsig();
-	os_fix_helper_signals();
+	os_fix_helper_thread_signals();
+
 	fds = &current_poll;
 	while (1) {
 		n = poll(fds->poll, fds->used, -1);
@@ -98,7 +97,7 @@ static int write_sigio_thread(void *unused)
 		}
 	}
 
-	return 0;
+	return NULL;
 }
 
 static int need_poll(struct pollfds *polls, int n)
@@ -152,11 +151,10 @@ static void update_thread(void)
 	return;
  fail:
 	/* Critical section start */
-	if (write_sigio_pid != -1) {
-		os_kill_process(write_sigio_pid, 1);
-		free_stack(write_sigio_stack, 0);
+	if (write_sigio_td) {
+		os_kill_helper_thread(write_sigio_td);
+		write_sigio_td = NULL;
 	}
-	write_sigio_pid = -1;
 	close(sigio_private[0]);
 	close(sigio_private[1]);
 	close(write_sigio_fds[0]);
@@ -220,7 +218,7 @@ int __ignore_sigio_fd(int fd)
 	 * sigio_cleanup has already run, then update_thread will hang
 	 * or fail because the thread is no longer running.
 	 */
-	if (write_sigio_pid == -1)
+	if (!write_sigio_td)
 		return -EIO;
 
 	for (i = 0; i < current_poll.used; i++) {
@@ -279,14 +277,14 @@ static void write_sigio_workaround(void)
 	int err;
 	int l_write_sigio_fds[2];
 	int l_sigio_private[2];
-	int l_write_sigio_pid;
+	struct os_helper_thread *l_write_sigio_td;
 
 	/* We call this *tons* of times - and most ones we must just fail. */
 	sigio_lock();
-	l_write_sigio_pid = write_sigio_pid;
+	l_write_sigio_td = write_sigio_td;
 	sigio_unlock();
 
-	if (l_write_sigio_pid != -1)
+	if (l_write_sigio_td)
 		return;
 
 	err = os_pipe(l_write_sigio_fds, 1, 1);
@@ -312,7 +310,7 @@ static void write_sigio_workaround(void)
 	 * Did we race? Don't try to optimize this, please, it's not so likely
 	 * to happen, and no more than once at the boot.
 	 */
-	if (write_sigio_pid != -1)
+	if (write_sigio_td)
 		goto out_free;
 
 	current_poll = ((struct pollfds) { .poll 	= p,
@@ -325,18 +323,15 @@ static void write_sigio_workaround(void)
 	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
 	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
 
-	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
-					    CLONE_FILES | CLONE_VM,
-					    &write_sigio_stack);
-
-	if (write_sigio_pid < 0)
+	err = os_run_helper_thread(&write_sigio_td, write_sigio_thread, NULL);
+	if (err < 0)
 		goto out_clear;
 
 	sigio_unlock();
 	return;
 
 out_clear:
-	write_sigio_pid = -1;
+	write_sigio_td = NULL;
 	write_sigio_fds[0] = -1;
 	write_sigio_fds[1] = -1;
 	sigio_private[0] = -1;
@@ -394,12 +389,11 @@ void maybe_sigio_broken(int fd)
 
 static void sigio_cleanup(void)
 {
-	if (write_sigio_pid == -1)
+	if (!write_sigio_td)
 		return;
 
-	os_kill_process(write_sigio_pid, 1);
-	free_stack(write_sigio_stack, 0);
-	write_sigio_pid = -1;
+	os_kill_helper_thread(write_sigio_td);
+	write_sigio_td = NULL;
 }
 
 __uml_exitcall(sigio_cleanup);
-- 
2.39.5


