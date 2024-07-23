Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB25FC3DA49
	for <linux-um@archiver.kernel.org>; Tue, 23 Jul 2024 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZHXHVzaNpxl1OocSPoSA/XRm01ActSf+3D5CweN1pRk=; b=SMPJZiR0PE5FIuy8lDpyK0C7wP
	5dPWDJFjbmpYUfcR/wYwreJRuEGJ8dMI5tBUfsVkwhLJZjuXtdrdl610uICa3FO3gEICGu8WyR+gf
	5KkOg5X7gNeSOoiM8c8WgiYnK12bdZ9oBQ7jpRBe247Ky32BmG9Lq9T/aCtvgXkZ1HKvrAQ/6ih35
	xZbObkd3+FwzhcV0ZaD4y4RiLsFW/heKmZ3S75waAexMR0QSHrSZ+AdQAtK8tsdjysKK/vp18c8Vy
	jR818y54Z2EWkaWOpXoONIYESw04R1lzqPEibrg5zJQ9a9s8VCyn0J3NwzFa0NJtFw3noLrykt1XR
	wc5zSAOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWEZl-0000000CNgK-3Sq1;
	Tue, 23 Jul 2024 12:25:05 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWEZj-0000000CNem-2eqx
	for linux-um@lists.infradead.org;
	Tue, 23 Jul 2024 12:25:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZHXHVzaNpxl1OocSPoSA/XRm01ActSf+3D5CweN1pRk=; t=1721737501; x=1722947101; 
	b=hP8Q0YINqqyOLdQtm5jkfkuIgk6ORWg+MAQYvoYpTq7iuewuYoQIY42rfEZjyfwbWS4Js9Hm68/
	/uOcvruWI6hC0FlJ1oCGqO7beH1CVBmyAHnUNRKJkIflm/2Mf8JnCiFnW/ioAuZBIAig8Si0QMX4Z
	UP26JDed8ytEl2OET8CmCR8dl6rUQbmNfoSYBm8eg7jBlUoow8lMr5jJa+OnyuKcaWODF75PYhIAL
	9Gg1xYQAtJ0womro4e/M7yYhmMgHvJ2v6s5pU6c4TsvR7ixFiJY1cxMHkwfQIselU11SH4eRQe+i4
	PSBNc7sVm/fgthpQXVlzIWLoZzZ8uk/ug1ww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWEZd-0000000BF6u-3FLt;
	Tue, 23 Jul 2024 14:24:58 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Lukas Bulwahn <lbulwahn@redhat.com>
Subject: [PATCH] um: remove ARCH_NO_PREEMPT_DYNAMIC
Date: Tue, 23 Jul 2024 14:24:56 +0200
Message-ID: <20240723142455.819a44806b99.I25812fb37eb4b531092a791747bb291903dbd260@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_052503_700786_99B8E4F8 
X-CRM114-Status: UNSURE (   7.68  )
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

From: Johannes Berg <johannes.berg@intel.com>

There's no such symbol and we currently don't have any of the
mechanisms to make boot-time selection cheap enough, so we can't
have HAVE_PREEMPT_DYNAMIC_CALL or HAVE_PREEMPT_DYNAMIC_KEY.

Remove the select statement.

Reported-by: Lukas Bulwahn <lbulwahn@redhat.com>
Fixes: cd01672d64a3 ("um: Enable preemption in UML")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index dca84fd6d00a..c89575d05021 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,7 +11,6 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_NO_PREEMPT_DYNAMIC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KASAN if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
-- 
2.45.2


