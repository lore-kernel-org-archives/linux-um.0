Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D9FA3757
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QgZYeiaoeis6yeSuPfQWqkHVf9veTG+LxONX7qCYazo=; b=tWg5RYu0Kr7JhFnUAE0AmzQe7d
	Ng5PcDjtu/D1nCC5VYfl5/NR8S0ZnRZMkp+f5dKib416SPSRgyDYnuZQQW4j0FP5Gtn86l8xMVd7/
	xO77Lb9uvqqFZl3CrxMjoFB+sqg4KH3kHfFHlT1NKZdzWt0m/hQ9hlZ8FXBYqtn6j0Yi0i55pQVF8
	Ucev0uIUKVa6h1JKUB2qdrvB1GQfdjfRAjUenIVcpSaCvxOBFKZB4Y9AH++yfbEAOeB3QWJM0Cqcz
	brUHvvA16IVhyobfwUulV7MMf5Bjb/AXtddOzHJ+SBlipfMMb6ns0qPG8/+cuGA7M647962gNJMEt
	SlHe0gxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6Tc-0000000G3BB-2MIP;
	Fri, 13 Sep 2024 13:36:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6T9-0000000G37A-1VlZ
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QgZYeiaoeis6yeSuPfQWqkHVf9veTG+LxONX7qCYazo=; t=1726234575; x=1727444175; 
	b=C5DszLuE1wRjsC/Vk3cwrE5miS/dS7q9focbISimTmRG0LHCS2VQZfbxOCL4IuVohtfqZ6H6vrX
	RGQQgtIDgwa3ggvnMvLOVmQMmrwvhRhdR5UxbgS/Dhe4XP8oQd85S7gecZwx7KQ/iSlNILMqRLOL0
	n4xEE51QJO13b/zes7yKTRqgDIDH9kpxN69JfLrVeP7CjN7Nw7LKglfQX9JJy5ad0RqKEJx3V77E8
	VOfFnZdupr8oMJt7R6VXsY6QXXb4uWzI2tw2AlYJbBMmPV5iTfCXP7fyJ+AfKg9i3Gf/4LPbtivuf
	Sitrwj8gBo1SJZTBloboTxy4M3ko6WGzrp9Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6T6-0000000GXf6-1VXT;
	Fri, 13 Sep 2024 15:36:12 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/5] Minor cleanups for UML
Date: Fri, 13 Sep 2024 15:35:57 +0200
Message-ID: <20240913133602.963167-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_063615_424699_8E24D172 
X-CRM114-Status: UNSURE (   5.40  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

This removes a set of unused functions and also select
HAVE_EFFICIENT_UNALIGNED_ACCESS on x86 to avoid UBSAN spewing warnings
by default.

Benjamin Berg (5):
  um: Remove unused os_process_pc
  um: Remove unused os_process_parent
  um: Remove unused os_stop_process
  um: Remove unused os_getpgrp function
  um: Set HAVE_EFFICIENT_UNALIGNED_ACCESS for x86

 arch/um/include/shared/os.h |  4 --
 arch/um/os-Linux/process.c  | 82 -------------------------------------
 arch/x86/um/Kconfig         |  1 +
 3 files changed, 1 insertion(+), 86 deletions(-)

-- 
2.46.0


