Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC29FA3757
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8ZJpxf1cnrFLp5Q6l3tX3r2LO1khsjGOScBVr/2Hyo8=; b=SqE6myhieXy7+piLXeXMxSseJV
	JZRWzz0gXk6PHF3FVpYOnS2+u+BCvGPK5IQyymPlFBJK/8ypLa8d+UbVS/kGgyLeeTfvgyHLLeTvX
	/0HG/99NRSJMGCrVWqWdRVr+b+RIS7Nhw20yxW+av+5epXEgoJUVx4KKYcjmo1PlY9Y5pkXme4RTI
	U3WZqvW9H6fycRigwiDsbg1CEWdbCx9aVXGdQBHS4Re8HwVJtmbdS1WxuD7DhxxARBT1urr9bIhJO
	WFr9B6qix3qIodPjsQxv0NOyyKHC/6Y/owszp7rmWIzeQbPA+GybeyY6BfNoD5L7p/p3pOnAW0qyJ
	MxdajFGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6by-0000000G4jm-2Kio;
	Fri, 13 Sep 2024 13:45:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bv-0000000G4gJ-1hFY
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8ZJpxf1cnrFLp5Q6l3tX3r2LO1khsjGOScBVr/2Hyo8=; t=1726235119; x=1727444719; 
	b=R3yclnN5AZizUCKscxrgOTMiTj1EQjtWJ0F0/9UJiv3KEMrEhFMUmjskN/c8wwk0RuIwRbudfCF
	GAGXj+rk/Tzm7M6Qr/Y2iWHITj1q62bb77UiF8T88fd6y+HssldUMVX1h/eTTl9PFKR1CBhlgBTRv
	JYk5uweq1GwmtLItC4hbWiW8yu72NZ1S6dlk8Gu1kyHqgTU9D8SSr/FvvFiGDiczhwybTickq/1hj
	yijd7L1kuwAxf5jdn2GE4oVHP0Dc6iS4zACKadCKaDGa4H6j9VeturaIOGAXNTZOMCLBYl5nOXnqq
	3PbaBrYPxHRebSzPqspmyTa0EvSqg4QvdBXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6bs-0000000GZ3W-1gIK;
	Fri, 13 Sep 2024 15:45:16 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 0/5] Minor cleanups for UML
Date: Fri, 13 Sep 2024 15:44:37 +0200
Message-ID: <20240913134442.967599-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064519_482319_A6AE249A 
X-CRM114-Status: UNSURE (   5.49  )
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

This removes a set of unused functions and also selects
HAVE_EFFICIENT_UNALIGNED_ACCESS on x86 to avoid UBSAN spewing warnings
by default.

v2: Add Signed-off-by to all patches

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


