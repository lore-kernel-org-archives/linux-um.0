Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343B5C83F20
	for <linux-um@archiver.kernel.org>; Fri, 11 Jul 2025 05:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oi52C+K5nKGVg+oe9kg80ZglB1v8tNSsZr3qMLFJGEI=; b=O594qlf+aCCaEhCbJeeJLTMrL9
	hGTPsKGIE1yBmWjUbdu7SGNdUoz88TY8VQBTg+3I3/DAjVbrUI1ujzev4NLZwHcndrrTFqVLQkfc4
	PvA6jhl0B0+uVHcK8eB9JcfHN0FEAMoZ8vhayc2htTiLEO0wG1iAL+8DXZzd730R2ulp2AmIRwu3v
	DEib+G3hW1z2R5qRTdHHl7MsRCnyf39aKbxRtzZKxTkQ/DuLZvdTS4Ea9FoF6LmR1jHXDBa9SRDMc
	/Tr+KB0Jj4AWeIEiUyt0IbCy1XuW+vvFBLRwORHTaLyl+q/f2HphOz8bLHaDj8CDRPZUi+IS3m523
	cctVPO5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua6S6-0000000Dlb0-1ozj;
	Fri, 11 Jul 2025 05:37:42 +0000
Received: from out-180.mta1.migadu.com ([2001:41d0:203:375::b4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua6Iu-0000000DkjU-3buB
	for linux-um@lists.infradead.org;
	Fri, 11 Jul 2025 05:28:14 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752211689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oi52C+K5nKGVg+oe9kg80ZglB1v8tNSsZr3qMLFJGEI=;
	b=RodbHBU2fW+FOrwomjVitIy9cfQFRpYyiqQe0aissCtXRaeSbKZ66p+wwZwbqEU0yBl0is
	a2My6vudKAajeOY9WUYq/Tdjo/5EPaGxY8IzPXl+zHsjJ6EUL/hqBo20l77F8MbpSOxJlK
	Is4tS1+K01ZfuNAS43xs75C41sIY1DE=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 1/3] um: Use err consistently in userspace()
Date: Fri, 11 Jul 2025 13:27:46 +0800
Message-Id: <20250711052748.2434424-2-tiwei.bie@linux.dev>
In-Reply-To: <20250711052748.2434424-1-tiwei.bie@linux.dev>
References: <20250711052748.2434424-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_222813_330002_B29D8684 
X-CRM114-Status: UNSURE (   8.52  )
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

Avoid declaring a new variable 'ret' inside the 'if (using_seccomp)'
block, as the existing 'err' variable declared at the top of the
function already serves the same purpose.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/skas/process.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index e42ffac23e3c..2de7fbc6eb23 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -592,12 +592,11 @@ void userspace(struct uml_pt_regs *regs)
 		if (using_seccomp) {
 			struct mm_id *mm_id = current_mm_id();
 			struct stub_data *proc_data = (void *) mm_id->stack;
-			int ret;
 
-			ret = set_stub_state(regs, proc_data, singlestepping());
-			if (ret) {
+			err = set_stub_state(regs, proc_data, singlestepping());
+			if (err) {
 				printk(UM_KERN_ERR "%s - failed to set regs: %d",
-				       __func__, ret);
+				       __func__, err);
 				fatal_sigsegv();
 			}
 
@@ -623,10 +622,10 @@ void userspace(struct uml_pt_regs *regs)
 			mm_id->syscall_data_len = 0;
 			mm_id->syscall_fd_num = 0;
 
-			ret = get_stub_state(regs, proc_data, NULL);
-			if (ret) {
+			err = get_stub_state(regs, proc_data, NULL);
+			if (err) {
 				printk(UM_KERN_ERR "%s - failed to get regs: %d",
-				       __func__, ret);
+				       __func__, err);
 				fatal_sigsegv();
 			}
 
-- 
2.34.1


