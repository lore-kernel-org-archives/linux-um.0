Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439ABC83F22
	for <linux-um@archiver.kernel.org>; Fri, 11 Jul 2025 05:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aOHJhxmb6QsVW9p2ZnXwrDUu+N5HCqfaaoto5OwNDOk=; b=tGcomouqrJi5yobHk5HqQxKXpe
	UCQFeDaCNKnGoOPQYCnaNiSrOGr9aMlUlvvCEBUwU6qRVbomMSHs/BSwJV96hIQaLTfzBrm23/d2c
	pZhILrLVMZqBY+qaoOhePHs7Cp5JpR4z4Qbhe+YpEsdXOoMiDCMEICXtNbCaqMSGTvFsBuR+QzVq2
	YK1rED/MW/kUXv50A99NZqlijgrjScLUIlPEGRgTKqJ7RsZ3a0rh0gfFrFpAT/cAR65K30jgVb36u
	zsyFudzO+SblGLtCjehWyX+JJHLItkYpWqW32nBVYMSJHgdCQzg8SjI7OPmB8VaJU+EPjNv99XcWT
	jHtVOnIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua6S6-0000000DlbG-34mc;
	Fri, 11 Jul 2025 05:37:42 +0000
Received: from out-176.mta1.migadu.com ([95.215.58.176])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua6Iv-0000000Dkjw-1Byz
	for linux-um@lists.infradead.org;
	Fri, 11 Jul 2025 05:28:14 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752211691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOHJhxmb6QsVW9p2ZnXwrDUu+N5HCqfaaoto5OwNDOk=;
	b=CFQG+Ma1LUf8DpkKWSsdFTiUhy9XhzZiS1fnPsWsRDPk6Z2bAlZNDjjh1EgFVrzF99HG5x
	d0fi1s/g7OFbRmc7ciEWqhIexInezOv4xrYxXSe/v7ou3jUecfCGcBiOD4bGZSP843sTFG
	WetLcvb5Vw2MPmjemJYHJ0QNJ16oY9c=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 2/3] um: Remove the pid parameter of handle_trap()
Date: Fri, 11 Jul 2025 13:27:47 +0800
Message-Id: <20250711052748.2434424-3-tiwei.bie@linux.dev>
In-Reply-To: <20250711052748.2434424-1-tiwei.bie@linux.dev>
References: <20250711052748.2434424-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_222813_472485_B07229C3 
X-CRM114-Status: UNSURE (   8.50  )
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


