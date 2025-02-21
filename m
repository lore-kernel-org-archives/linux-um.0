Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0E9C021AA
	for <linux-um@archiver.kernel.org>; Fri, 21 Feb 2025 04:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZETV4lSzdZNkUs4MFno0C0x8tXQr6IVguAvuH2XIrlw=; b=hjQx+M4I17+AHIPoabquXD08Ab
	cIeW3Dhe4kbZNR8b2e1Ltboc5p8Y65hQKv9wGoh5nE8HnpZ4wsJI7oe/tLveoQsC3Ib+6SrqClwth
	i9ExEiArGZwM6b7lfyGqHvgTTkvlPYBosuQnQNJRjoMmVRn1xPhvlkFDXEegS43U1KuDNzbjjcCrE
	NCovKiYl7kVe3KkHyGDX1YDk4eiN3Ixycc5WWEB3IyEvLe194wKh7tsqnlEHR82MSQLqdjpZMjPOx
	MIyA+155AM0kgGvfIoyKwnsFD20DLNWeXiH3B+ZIrdCSBmvTAJO8+WXE3BfGJmwoO9eHJQlQpDr/F
	QwMXZfFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlKVS-000000045GC-1vqh;
	Fri, 21 Feb 2025 04:19:18 +0000
Received: from out0-194.mail.aliyun.com ([140.205.0.194])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlKVO-000000045ER-2OKo
	for linux-um@lists.infradead.org;
	Fri, 21 Feb 2025 04:19:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1740111546; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZETV4lSzdZNkUs4MFno0C0x8tXQr6IVguAvuH2XIrlw=;
	b=UJq6MyEAUg1/EKaLtnXrIttVwH5FlzCFUcEUtI15Xpjn/O8IcU7A1ew+bints7GKWBxiTvn0wjCp2dKn38kVBcRjPkZxqv1WxEI7WoHtOs1LYR6Fs/6Y+c3TAeK62sMhMvwr6PE6p1dV73h14q6YIzKES3kP04+CZD50/NcgckE=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bY3Iwso_1740111538 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 12:19:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Update min_low_pfn to match changes in uml_reserved
Date: Fri, 21 Feb 2025 12:18:55 +0800
Message-Id: <20250221041855.1156109-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_201915_119772_AD3630DA 
X-CRM114-Status: UNSURE (   5.56  )
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

When uml_reserved is updated, min_low_pfn must also be updated
accordingly. Otherwise, min_low_pfn will not accurately reflect
the lowest available PFN.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index befed230aac2..91b7710c0a5f 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -66,6 +66,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.34.1


