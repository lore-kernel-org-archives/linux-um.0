Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27AFC8303C
	for <linux-um@archiver.kernel.org>; Fri, 11 Jul 2025 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oi52C+K5nKGVg+oe9kg80ZglB1v8tNSsZr3qMLFJGEI=; b=rYpjKcXeiq2zBnGW0pO52BuchU
	8xD3hmyjPXY2Hl41UsFJXH2aSoIhZf2z0BDYSRGnSt+8FJdB528TweBALXChJzrFIDgBNrMLKMeAU
	aviADaIPCUe6a4Zp0FyQNx2rGwZR7vk8eSgG6q0SkV700xUjLO3dFLV0nNH87gW44k0agvRqaPGoq
	QGnYOfHNpM+vEPjMOPc6gUaPURD4cPsGU47XmS9v/DaE5b+AIZTbr6U2wi87mcaYXSdS1tiuIrDdu
	gVhxHzB6ORSUa88ye5034uYGxlrurs61ju290vQFRvwaifYpsgjd/EysituX9287U/HtCG/2g3WY5
	OfjHylGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua7aw-0000000DtYw-2HxH;
	Fri, 11 Jul 2025 06:50:54 +0000
Received: from out-171.mta1.migadu.com ([2001:41d0:203:375::ab])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua7au-0000000DtXt-1Sux
	for linux-um@lists.infradead.org;
	Fri, 11 Jul 2025 06:50:53 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752216650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oi52C+K5nKGVg+oe9kg80ZglB1v8tNSsZr3qMLFJGEI=;
	b=aNY9imHBh9C0QXqbiZSh1OC3gOhlwJaViINPQ1Vk+RjL7u4gT9m91DADM7hL7ZLpkCc+Nq
	dLzcwDoWJlJliWzJbtZPwA5yPPogXe3Tav6CoUt15Setwcw9bk1QlM60t0HyS4Awkn8R/Y
	QdYquJ5rOtilnpvYYlF0/oDTlwRc94E=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 1/3] um: Use err consistently in userspace()
Date: Fri, 11 Jul 2025 14:50:19 +0800
Message-Id: <20250711065021.2535362-2-tiwei.bie@linux.dev>
In-Reply-To: <20250711065021.2535362-1-tiwei.bie@linux.dev>
References: <20250711065021.2535362-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_235052_522605_705425A1 
X-CRM114-Status: UNSURE (   8.65  )
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


