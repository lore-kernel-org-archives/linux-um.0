Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60024CD042A
	for <linux-um@archiver.kernel.org>; Tue,  6 Jan 2026 00:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+GItRf63O7TxYIMQbbd/DGIxtORDZBq83Z22ibe5R18=; b=TzAlZVh/+pvDcPZgYS+0vgwCLS
	1sN3yEPF8MgfOI4R/Ckv8k6AlfHfqm/I0C4vy5Drh1dCXh9M03J+8/OpzEcnny6KHwwrjH+64vGIT
	9FMP8XFl0kZ8GMFHZhXdLDfBbhktHR3UYZTen352xzoo/90vmp9rQlEtaL7WMs1c4CTMsJoZjeAad
	97J76fQrDJaS+jk5ukv9q0lYEQUBwaXlBKTgcoNXha9Sr2xfcz4nO4mQWH6ea+CsIwR/s44REntYT
	CY9QYJPan/BOscxbBjadlPkc7fmgXJuIV4DNMnLXeeEfuxHlRfIKaEtQHWH61zNjI8F1sFqRQlCzL
	cHm827wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcuhR-0000000CFnq-1sdV;
	Tue, 06 Jan 2026 00:13:25 +0000
Received: from out28-99.mail.aliyun.com ([115.124.28.99])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcuhM-0000000CFmk-2rxW
	for linux-um@lists.infradead.org;
	Tue, 06 Jan 2026 00:13:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1767658393; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+GItRf63O7TxYIMQbbd/DGIxtORDZBq83Z22ibe5R18=;
	b=taCq8Spmt8wTLMx+JqSk/7iQtu4+xFn+YeZl1bSP35BGy+JLvTSMjzb5SJ6cd7oHTC2Wzl528MtUUAEo7QUv80WZSMIqR00njsMxF68DV29933gOpk/zDuWD9U+XTmntA9MOnE1lB07kVz6msXF8I6Yni44vPP1p3mJ8+jJIT1w=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.g-qgw-l_1767658363 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 08:13:10 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [PATCH 0/2] um: Minor signal cleanups
Date: Tue,  6 Jan 2026 08:12:26 +0800
Message-Id: <20260106001228.1531146-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_161321_360736_1A65449B 
X-CRM114-Status: UNSURE (   3.45  )
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

Tiwei Bie (2):
  um: Preserve errno within signal handler
  um: Handle SIGCHLD in seccomp mode like other IRQ signals

 arch/um/os-Linux/signal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


