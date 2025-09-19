Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88E7CAC5A8
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w0zvkyHycNf62ji7JboPNe59KMTBMZPeiYVTw++Mcio=; b=OmTlFa0Dh3G0vxCU0tzi8KirOF
	LL4+4TlHN1CXLSfUyd4XdwojETNzL5efw6H0CYlSQVIuYp+gkCpp/pcx/Yto2u4Wf8yExUgFVUqCV
	8y2y7Thu+WiTIhlGMqed2JZREy2hgFpZHeDM0XhEdAjq2Pl9Tz6L9ylUV+zPufxiSwsUW21nhddnx
	1f9ZlIimON8vQnoVqnBS+gXvpMiCLKrYTae+wsfn4S3QPOGX2ayb2H3Znqu/kzlu0CYDtQ1hs+or2
	2uAqggsO8TpDWSJeHv3/n59AFGgSYRY15y6dMiaiqO4rjHDbcNIZ0fhrE5sRxT7YDUrjnP9wG/Cwn
	9pyN7jjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9e-00000003MEo-1iqg;
	Fri, 19 Sep 2025 15:36:10 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9a-00000003MAt-0OGw
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w0zvkyHycNf62ji7JboPNe59KMTBMZPeiYVTw++Mcio=;
	t=1758296165; x=1759505765; b=U45vhkUOS9KFhvRfbZQFvclhSoTwFEOEN534bCbKGj79ECz
	ytdlcbe6ul0yjvD9eu9cvGqTkW/fy7MbtNCRGmzBIBXVPGPO2YgXaVjSroiPuZT4vN+cvfXLShF2j
	8ipvYMdfmbyhie481AnXE1f4Pf2a+udRjOYs3XdRFYewW9iSgJhF8N7kOvzccbxqPCr0RZfTEFfeU
	VwmjqTK2PUt4FrxdHbJNS+tmf7e3xWtNFwL+NX3VaGXICwFlh4u27iNMeT0iszLS2ZhbnGVR0ViCf
	50Tj9vgC9MbTY7Lg9ubZrDqiuKkiomLjaGIyFyZdOCs1MQO1eN5N/znffFna1Qpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9T-0000000G6O6-2i20;
	Fri, 19 Sep 2025 17:35:59 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 01/11] tools compiler.h: fix __used definition
Date: Fri, 19 Sep 2025 17:34:10 +0200
Message-ID: <20250919153420.727385-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_083606_129865_B60733D1 
X-CRM114-Status: UNSURE (   9.78  )
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

The define mapped to __attribute__((__unused__)) instead of using
__used__. Having the wrong definition here may result in the linker
incorrectly removing the symbol. Also, this now matches the definition
in include/linux/compiler_attributes.h.

Fixes: e58e871becec ("tools/lib/lockdep: Remove private kernel headers")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 33411ca0cc90..b2c40621d441 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -127,7 +127,7 @@
 #endif
 
 #ifndef __used
-# define __used		__attribute__((__unused__))
+# define __used		__attribute__((__used__))
 #endif
 
 #ifndef __packed
-- 
2.51.0


