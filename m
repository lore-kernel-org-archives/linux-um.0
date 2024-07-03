Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1475C3DA44
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IYrj7H/308QDw4RgZwRH56ruUN6iV896ShDluxSlwoQ=; b=ZUfVDESQBWyGGo9WnJDcwG9NoO
	65p9nbQ5KVdVofowo1eFBSrRmvrEJHPHPz/TKZ4YXyftyc5AiCu0ZI+c/OZAIJLK7KKH+Q7AEp7du
	Q41b/jpeFntSnJAhXQ5zTVXipXsxB8OUCpEscMav+WFRSjskyUcaLxJeWlCbfFDi+gmOmjkDxKDQG
	RQ6xsGZj0vkkojnVWX6PUTfk9mYcqpS2x26ao0Uc4hZM9NdDzhWH6xU3kW0RZR8CBGvHTh86+4beN
	xB0omzRRIZwBNJmnmZU3QrZl9zzXbI09whvAVTvfdYKcGMaVVstI1h9mi8/BJn9V/LQy25DudSfh7
	XCDUBkZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1TY-0000000AafQ-0iZf;
	Wed, 03 Jul 2024 15:00:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0Jh-0000000ALMG-0lNW
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 13:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IYrj7H/308QDw4RgZwRH56ruUN6iV896ShDluxSlwoQ=; b=oyh+ePxjDWCXiFeHhGYdkzWtpv
	QZT2T6TPd99Q8gqyxG5++MrQHNm8dHfTQST5hMhRqJ01UvYwwzoqQxlWPRhz9lVwPI5EKC+qqXVjW
	OnW1cNE4d50418jKW26k9IxPeI4fgq0tjwXhydLPMg0/9AIkX7JA8PN0j8ks6MXHWH2RrYa/YVR6C
	JkD7sbbfuoG+sa08HTRIcoeA7yNE7QQ1Y2Qw9th6Au8JBptuk5UELJ9JpoM2EWUh1Pk9jeLVsD5v7
	o7ln1KH6r5hUZhO4JvnmDgQour2e5LE9WOHOIJvS5hLbe+hi6kFEt26jNeZWPg3BMJjEyQ/gYlT18
	q3HlfwjQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JX-0000000A1J7-3bwR
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IYrj7H/308QDw4RgZwRH56ruUN6iV896ShDluxSlwoQ=;
	t=1720014387; x=1721223987; b=tB6wmF8Vbpiz8l7YvPXX7b9lQ7HwL6+WYDod7g+flo7XcKy
	R4Z+OQrDBSooqkdo+yLRqfKTCr/iAGOkWiSyxU8dl19+dXXPfY0hNi0F2QQ1f8sG9Vm6AEF6s6PYV
	XA4za9/wwJ5JmriE8y+nd1FtRadKD9o36jJHtiFF5UimtW4dANBh/hto2WfUV7ssKVlluLPU++YKe
	trWAK0/u3Hbcre/3dpiEwyjnwVybhzIpGv1mjtt/NyJKrcffkXdLetco9hKyVXCC3tNJ7/itFujfX
	hT9h1N8xagwmnz0mRr3BP8ga8hYJwiJx3HCYncanr9tyWiGJC3u8TlBFBVa8ywdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0JV-000000094nb-49Um;
	Wed, 03 Jul 2024 15:46:26 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 09/12] um: Do not flush MM in flush_thread
Date: Wed,  3 Jul 2024 15:45:33 +0200
Message-ID: <20240703134536.1161108-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703134536.1161108-1-benjamin@sipsolutions.net>
References: <20240703134536.1161108-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_144628_241444_AB9D99DB 
X-CRM114-Status: GOOD (  14.39  )
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

There should be no need to flush the memory in flush_thread. Doing this
likely worked around some issue where memory was still incorrectly
mapped when creating or cloning an MM.

With the removal of the special clone path, that isn't relevant anymore.
However, add the flush into MM initialization so that any new userspace
MM is guaranteed to be clean.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v4: Only clear memory up to TASK_SIZE
---
 arch/um/kernel/exec.c     |  5 -----
 arch/um/kernel/skas/mmu.c | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 5c8836b012e9..2c15bb2c104c 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -24,11 +24,6 @@ void flush_thread(void)
 {
 	arch_flush_thread(&current->thread.arch);
 
-	unmap(&current->mm->context.id, 0, TASK_SIZE);
-	if (syscall_stub_flush(&current->mm->context.id) < 0) {
-		printk(KERN_ERR "%s - clearing address space failed", __func__);
-		force_sig(SIGKILL);
-	}
 	get_safe_registers(current_pt_regs()->regs.gp,
 			   current_pt_regs()->regs.fp);
 
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 697dad49c36b..47f98d87ea3c 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -40,6 +40,30 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out_free;
 	}
 
+	/*
+	 * Ensure the new MM is clean and nothing unwanted is mapped.
+	 *
+	 * TODO: We should clear the memory up to STUB_START to ensure there is
+	 * nothing mapped there, i.e. we (currently) have:
+	 *
+	 * |- user memory -|- unused        -|- stub        -|- unused    -|
+	 *                 ^ TASK_SIZE      ^ STUB_START
+	 *
+	 * Meaning we have two unused areas where we may still have valid
+	 * mappings from our internal clone(). That isn't really a problem as
+	 * userspace is not going to access them, but it is definitely not
+	 * correct.
+	 *
+	 * However, we are "lucky" and if rseq is configured, then on 32 bit
+	 * it will fall into the first empty range while on 64 bit it is going
+	 * to use an anonymous mapping in the second range. As such, things
+	 * continue to work for now as long as we don't start unmapping these
+	 * areas.
+	 *
+	 * Change this to STUB_START once we have a clean userspace.
+	 */
+	unmap(new_id, 0, TASK_SIZE);
+
 	return 0;
 
  out_free:
-- 
2.45.2


