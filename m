Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF6BC3271F
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MqoYyPkn54zZEbKYwHZZnsaEUbejZWauLm9p2TPzPmA=; b=sYdbbUXYimzCApI+t9ul3/hJwl
	SZOnMSmp626XUqbf7wRPnOcr5ii3qkXY2J4ydmEOEhtRlM78bvwj1Kti+3zHx0PeQikhvOSixXoFg
	g4u1F2pcAJ5/v/tB/SWcqZRACzi4V+tacjvxKzOlXFV5s+vHS7v4csjwPfYyERBg/QMWate7HC/dN
	9N3cZfhjYGXvm+KI9EMrGKEUlfiJaN2mKONB9ehOxcQz+MSrj1t+qBF8uCohpvxwE4RjZlM/LABIW
	YxpcIsqmJhCDYwlDq0cuTTRu6Dtc4NZEoK6K4Q3+fJgqH32XQWy49r6aIMcNUlnEjficaYy1E62cS
	GUsmajHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRll-0000000EEJf-0cQm;
	Thu, 04 Jul 2024 19:05:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRlh-0000000EEFw-46YB
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 19:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MqoYyPkn54zZEbKYwHZZnsaEUbejZWauLm9p2TPzPmA=;
	t=1720119921; x=1721329521; b=c56gizg2UAB+5Q5L9DWnBHQk2LujEn2qGtCwZ250a70fkV3
	u+7RGymUebE/FJvC0MEFRzsbku+e6qlJS6wsH38BDuSugn8XUScVxeg4SpDJjWsePH3GfaJP2XhAe
	eYZ5foDxB73Xsh9MwJJeQdNrjAvGd5vDz6duBAPELqzJuXQNTsM5K6oZv/X8TZsyM7NAc8KE4fG3h
	DnitIHBCZel5heyOPVbXt83SwN7Aa6eRvBFFKxZ7bGSyfoK0jfpP4OPSAqdXIgunq8fQWpyPvSt9t
	16Ndugv63AHHwYvmrREkEeWsN1djA1F+YhXceatp8uBb40lC3/Vynw2s8n3S2g3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPRlf-0000000DrZs-3vHZ;
	Thu, 04 Jul 2024 21:05:20 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v8 6/7] um: clear all memory in new userspace processes
Date: Thu,  4 Jul 2024 21:05:05 +0200
Message-ID: <20240704190506.1438493-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704190506.1438493-1-benjamin@sipsolutions.net>
References: <20240704190506.1438493-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_120522_042276_2659D10F 
X-CRM114-Status: GOOD (  16.23  )
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

With the change to use execve() we can now safely clear the memory up to
STUB_START as rseq will not be trying to use memory in that region. Also,
on 64 bit the previous changes should mean that there is no usable
memory range above the stub.

Make the change and remove the comment as it is not needed anymore.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/skas/mmu.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 47f98d87ea3c..bf64702d9e04 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -40,29 +40,8 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out_free;
 	}
 
-	/*
-	 * Ensure the new MM is clean and nothing unwanted is mapped.
-	 *
-	 * TODO: We should clear the memory up to STUB_START to ensure there is
-	 * nothing mapped there, i.e. we (currently) have:
-	 *
-	 * |- user memory -|- unused        -|- stub        -|- unused    -|
-	 *                 ^ TASK_SIZE      ^ STUB_START
-	 *
-	 * Meaning we have two unused areas where we may still have valid
-	 * mappings from our internal clone(). That isn't really a problem as
-	 * userspace is not going to access them, but it is definitely not
-	 * correct.
-	 *
-	 * However, we are "lucky" and if rseq is configured, then on 32 bit
-	 * it will fall into the first empty range while on 64 bit it is going
-	 * to use an anonymous mapping in the second range. As such, things
-	 * continue to work for now as long as we don't start unmapping these
-	 * areas.
-	 *
-	 * Change this to STUB_START once we have a clean userspace.
-	 */
-	unmap(new_id, 0, TASK_SIZE);
+	/* Ensure the new MM is clean and nothing unwanted is mapped */
+	unmap(new_id, 0, STUB_START);
 
 	return 0;
 
-- 
2.45.2


