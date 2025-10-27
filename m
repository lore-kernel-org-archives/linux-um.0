Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D212CCF9E5
	for <linux-um@archiver.kernel.org>; Mon, 27 Oct 2025 00:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QjFrwlF759x9QExSvPBA2TAaIUv0ml3JmoT2DaGEPdo=; b=Z4kRmoB5utisL+Pz09ycl/1s6o
	FekifqXeSHXE/P6ExRjW9flbjamu+4mqXVzWLcczIEJ7xRT/58lu2L8LdDG+TyY9i2g6g5XHxNWuy
	2qFkLS//AGwUBS12mBX4fz57lMfcLaY2K55nnmfNDPS8jyaoJOeVLGlCTvd7AAd/BWmns+hz9qs2m
	PNFGqf5RoUgTS3XO3sl7h9YKJS8gyMvEf+II3w3I6vWjDrIC6tnZ1VeEPS/9hxRFJzdzaAhvqY/vM
	NMVVynhjs0uwf4l1Lw27umT7YiWpR8+A6E1uekzmI693ViWihC9ttVtgtazA4CKr8o8BBJbO3A+ml
	y17m3Qlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAwa-0000000CtKu-0hkG;
	Mon, 27 Oct 2025 00:18:40 +0000
Received: from out-173.mta0.migadu.com ([91.218.175.173])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAwX-0000000CtK2-2FDK
	for linux-um@lists.infradead.org;
	Mon, 27 Oct 2025 00:18:38 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjFrwlF759x9QExSvPBA2TAaIUv0ml3JmoT2DaGEPdo=;
	b=d4RhZ0g+0hgDpoTkj5KARfRZ8GwC9ZHCDLUPcoTGJFnec/pe5+kdAyECOlFdqSV2NWE5hn
	bVBRqkXxkyGrHiCCXfO2nM5yqnLaLktAN8+avRk+O+9QeBEOh4UBndt259lQRt3lMfZscd
	4ozKS3wrPZAsspc0QNPyG32pcoyPd7I=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v4 1/8] um: Do not disable kmalloc in initial_thread_cb()
Date: Mon, 27 Oct 2025 08:18:08 +0800
Message-Id: <20251027001815.1666872-2-tiwei.bie@linux.dev>
In-Reply-To: <20251027001815.1666872-1-tiwei.bie@linux.dev>
References: <20251027001815.1666872-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_171837_719149_621FF80F 
X-CRM114-Status: UNSURE (   7.92  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

Currently, initial_thread_cb() temporarily disables kmalloc when
it invokes the callback, allowing the callback to bypass kmalloc.
This is unnecessary for the current users of initial_thread_cb(),
and we should avoid memory allocations that are not under the
control of the UML kernel. Therefore, let's stop temporarily
disabling kmalloc in initial_thread_cb().

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 9c9c66dc45f0..757e21185a0e 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -185,11 +185,7 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 
 void initial_thread_cb(void (*proc)(void *), void *arg)
 {
-	int save_kmalloc_ok = kmalloc_ok;
-
-	kmalloc_ok = 0;
 	initial_thread_cb_skas(proc, arg);
-	kmalloc_ok = save_kmalloc_ok;
 }
 
 int arch_dup_task_struct(struct task_struct *dst,
-- 
2.34.1


