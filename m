Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF90CE8E86
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DW2X6x5nYJj0dxAEofhIKyQStzlJYeyPAOconukYPcI=; b=swDSi8uRdWZj5YSARDr+sszuN2
	o6AfxuML6w9mzG8TDnpS9uU6bwSuqvICoBLxPFCsS+/ruktYF7bPrVh8fWwsOB7XGKCvOLlFkezRj
	crEFvh4OMa5avvYf/cBjWAaZP3a/xFdu8/1pqxCkpcUMs15MFCI4FbCcWWj5CdlBfNUq26nseLfjH
	om4C8Wip5aXyzjht+Ox13lqwifrb+r71AN5VLbYQrT4yJDm0KxLT10Sp85+/+dJ33vuA1j9f9/b+t
	UEt5OpuEVtFKsh+jP2sjzAU0J5KnupvNQjXpfY4FczZUpS3Fy3UO8vnd6Zn0nEI6C7MtXX7IKKxbd
	Gi9L0cdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3z19-00000000mJl-3TG4;
	Thu, 24 Oct 2024 14:40:51 +0000
Received: from out0-198.mail.aliyun.com ([140.205.0.198])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ypO-00000000jVQ-3c3X
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 14:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780117; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DW2X6x5nYJj0dxAEofhIKyQStzlJYeyPAOconukYPcI=;
	b=xFifBZFGfevXW1X/9XqfwjvzJirpgISM/W0cLGJUbiPKp88cLb8H1JbXbPqUORtEq4U6ZtU/XjKM7YLP2fYoJRXizHJXVmSPXfbZV2v64qo8wbwHmLMGeOH1MZOQKUjTwVnPybXJvHVDxoKwR0Ug3jV2p1cIY+wVsuMHJcffXXE=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBt-9_1729780116 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:36 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/4] um: Set parent-death signal for ubd io thread/process
Date: Thu, 24 Oct 2024 22:28:26 +0800
Message-Id: <20241024142828.2612828-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
References: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_072843_387614_04BBB754 
X-CRM114-Status: UNSURE (   6.25  )
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

The ubd io thread is not really a traditional thread. Set the
parent-death signal for it to ensure that it will be killed if
the UML kernel dies unexpectedly without proper cleanup.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ubd_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 7f28ec1929dc..2b8d04e67600 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1499,6 +1499,7 @@ int io_thread(void *arg)
 {
 	int n, count, written, res;
 
+	os_set_pdeathsig();
 	os_fix_helper_signals();
 
 	while(1){
-- 
2.34.1


