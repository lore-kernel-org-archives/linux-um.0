Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F2BC83F1A
	for <linux-um@archiver.kernel.org>; Fri, 11 Jul 2025 06:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aOHJhxmb6QsVW9p2ZnXwrDUu+N5HCqfaaoto5OwNDOk=; b=Nx4PA+LRhroZJaB8C3W6HFfrLu
	DFf6rOQ20z7AP3m+mu1r5g5q1FS2HP1gODaLFyKgnQ51Zwn9o8C2kf4ojML0wXGKU855iw1chgN6f
	jG4l/U9ujxkC6SX2TGXaHa90xUEpgEGDrI+xcumTKGN/BvJG0TTDJ7Q7OczvjhGXYiom6upEK7CF5
	18JnbzHX3qp/aQ81IceQVH+fzQb+t5fv+WgmegqWwBNMREe2u1H3DTBj4JcDW39zOl8lvq3qLeQIB
	fxLCl6/k9r4Zy5b15o91q9o9u+PMxW0ESqHJYIHqgJcleOGuAg4RFlcfIwm6a1+Arxhf0xC396HDk
	DFRTc8Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua7az-0000000Dtb6-3Wdx;
	Fri, 11 Jul 2025 06:50:57 +0000
Received: from out-172.mta1.migadu.com ([2001:41d0:203:375::ac])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua7aw-0000000DtYU-3YK8
	for linux-um@lists.infradead.org;
	Fri, 11 Jul 2025 06:50:56 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752216652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOHJhxmb6QsVW9p2ZnXwrDUu+N5HCqfaaoto5OwNDOk=;
	b=iQgatEOzRPeHQJms9MhjfYWbkue9LQnIJOM8UaFyVQjOLe1DlV9YR601Ms0KnpuB/wUUnA
	zZuDmoIC3o8iHlTIeyDU2L+JVNN2cerfhmlKWZGWnYfnu25QwnNeByY43rQWfiG5THOX76
	T+1+maRY0W+8SFoYUnEOze0KQY5Gm7s=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 2/3] um: Remove the pid parameter of handle_trap()
Date: Fri, 11 Jul 2025 14:50:20 +0800
Message-Id: <20250711065021.2535362-3-tiwei.bie@linux.dev>
In-Reply-To: <20250711065021.2535362-1-tiwei.bie@linux.dev>
References: <20250711065021.2535362-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_235055_019953_9C43F771 
X-CRM114-Status: UNSURE (   8.48  )
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

It's no longer used. Remove it.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/skas/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 2de7fbc6eb23..e90a0658bba8 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -267,7 +267,7 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 	memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
 }
 
-static void handle_trap(int pid, struct uml_pt_regs *regs)
+static void handle_trap(struct uml_pt_regs *regs)
 {
 	if ((UPT_IP(regs) >= STUB_START) && (UPT_IP(regs) < STUB_END))
 		fatal_sigsegv();
@@ -755,7 +755,7 @@ void userspace(struct uml_pt_regs *regs)
 				handle_syscall(regs);
 				break;
 			case SIGTRAP + 0x80:
-				handle_trap(pid, regs);
+				handle_trap(regs);
 				break;
 			case SIGTRAP:
 				relay_signal(SIGTRAP, (struct siginfo *)si, regs, NULL);
-- 
2.34.1


