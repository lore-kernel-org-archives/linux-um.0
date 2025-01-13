Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34C4C02184
	for <linux-um@archiver.kernel.org>; Mon, 13 Jan 2025 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fj+aXkWMZW3QH/dX6l64hmhfkptpcfLcjdl9WWJzH2A=; b=HJ9mbLDx8xQ3lovRWDeqUgCjQ0
	2wtonH2928EQb798Psk7qZf78oz/t96kGdwyXG79Gg2pKrUdFOE0bg03KdOcjSu8AD0j8WUox0e0u
	JK/thbI31Zoc13uVUXJ5R8lFbI7mPV7JZxen4EKYGoM94XB4yQbzQKNyA75g0rr7osWgR+7UUSx7X
	0ZM/1Bk9cB5ynx2T9Duu8OenGRYakIEW/Y0rwWQkYpq7rJLCNDTmMhtBFst4ojWcgNpq4bQbkx5Qv
	ZPVoxp81TEVqDkF7XPA6PFzupbW357TS7pGb9AELJkoavkRDwrB4Lj7ah1glnN5z6Sw+GxbrQGWH9
	25ZxO8nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMwJ-00000005mUY-4BgB;
	Mon, 13 Jan 2025 16:05:20 +0000
Received: from out0-215.mail.aliyun.com ([140.205.0.215])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMQh-00000005enB-0RmY
	for linux-um@lists.infradead.org;
	Mon, 13 Jan 2025 15:32:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1736782353; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fj+aXkWMZW3QH/dX6l64hmhfkptpcfLcjdl9WWJzH2A=;
	b=vbnhd09C8USgx5HD1X4SQZqXiIxVXRLjRcCOZu35ggZpuvV1brk+B/OEAFoaxP1ZktUPAGLJaSt8TLLEFZmi1AYk4UiDtpV/f4qI+NEd3RhT4EOU6kQcqYZtyLELN37d9/fPMxmxpmmTASKzxuKfyqOvW/eZd+3LyJJ29of3yOk=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.b1pVbjt_1736782350 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 13 Jan 2025 23:32:30 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/2] um: Remove unused asm/archparam.h header
Date: Mon, 13 Jan 2025 23:32:18 +0800
Message-Id: <20250113153218.3331321-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113153218.3331321-1-tiwei.btw@antgroup.com>
References: <20250113153218.3331321-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_073239_687394_41B91439 
X-CRM114-Status: UNSURE (   5.46  )
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

This header is no longer used after the removal of fixmap support
in commit 5bfc4a3a0af3 ("um: Remove obsolete fixmap support").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/asm/archparam.h | 20 --------------------
 1 file changed, 20 deletions(-)
 delete mode 100644 arch/x86/um/asm/archparam.h

diff --git a/arch/x86/um/asm/archparam.h b/arch/x86/um/asm/archparam.h
deleted file mode 100644
index c17cf68dda0f..000000000000
--- a/arch/x86/um/asm/archparam.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* 
- * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
- * Copyright 2003 PathScale, Inc.
- * Licensed under the GPL
- */
-
-#ifndef __UM_ARCHPARAM_H
-#define __UM_ARCHPARAM_H
-
-#ifdef CONFIG_X86_32
-
-#ifdef CONFIG_X86_PAE
-#define LAST_PKMAP 512
-#else
-#define LAST_PKMAP 1024
-#endif
-
-#endif
-
-#endif
-- 
2.34.1


