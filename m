Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DACBCAC592
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UVHwzh9sHs6Xo02VEWpZXjxZy4cbskfDXgmFGFBhsbs=; b=B02XDn71tBZ6HOycUtrk8wZske
	u1ejZ5oHRZ/7GRBHSm9I1EXLyW0K3L0nUcIxG7FYco9YEQ2HLwqPid0nx7Klvr9qbVdmbyc/PwBIz
	lAb+6ZlSqujm0+pmmZCxNoljDVhAVVtXrbcRKJokzSb/4M8jlHshOttJmuvQ3SjW5fPb43PyI2asU
	CdqFnG3/tsMg6fqP+b1hoixi9yhBu0ulz5IkxhaCugVxhAG4HhWLEy5duP/K6nxUe/E1i6qGQIWJx
	ZtXvwIz19sYXQOsNAAWm2lnozspuOwYsVuSFRk4YL9d4Sa2oDlbLbZKaUUBY94WeWNeJfe/6e/Jjm
	Be6Sehhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9i-00000003MKf-0bik;
	Fri, 19 Sep 2025 15:36:14 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9f-00000003MEm-1o0m
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UVHwzh9sHs6Xo02VEWpZXjxZy4cbskfDXgmFGFBhsbs=;
	t=1758296171; x=1759505771; b=vilE9zfU1jdF3lF6j6GGgafO7ZDDdd/PEy/idCwGWqh3LSX
	69p/e/Pm/ljKEsp5I8EvILR5fwM/DnAdfRz33d9lHVcbHmilro7SSTD/Vfz+sYl/RFI/RdrSiVQ9b
	Tmzf8bV92euNChApbOue/t2mDAlreGsW2QJMrtouiwAgkq0CT5p8s32PC3DyI7r2+qYkox7Axr7oL
	hylsNV+MrMoeJ8WMLLSxo91cwQGaCbfbZwIPRurmwpD7fYRIoXUpH19KY8lSUJXnK5xryxD2Iuv2j
	gOhVwWmQiSeNntI+J19p0UOQVj5+lANRI8nP228ymPGesEo6iM2e7yZ+uA4i6rRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9c-0000000G6O6-0blB;
	Fri, 19 Sep 2025 17:36:08 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 08/11] um: use nolibc for the --showconfig implementation
Date: Fri, 19 Sep 2025 17:34:17 +0200
Message-ID: <20250919153420.727385-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_083611_485277_C793C684 
X-CRM114-Status: UNSURE (   9.87  )
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

This is one of the simplest files and it can be switched over to use
nolibc without any modifications.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index b8f4e9281599..4b206a40b611 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 
-USER_OBJS := config.o
+NOLIBC_OBJS := config.o
 
 include $(srctree)/arch/um/scripts/Makefile.rules
 
-- 
2.51.0


