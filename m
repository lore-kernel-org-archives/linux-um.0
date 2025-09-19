Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B345CAC5AC
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I1cm2is+Xgw+x+T3m8uuoGo4E722CtwyukEZGpVjsa4=; b=UN0+tTP4IcH+09owMOov1BBc2N
	R43AhUh1u/0fmmMnOyopk+euqFPJOnhmlgr1f5WN9FFIyvi29unJmQXw3ldw2QVjuS1irFN9gFLOo
	gr7jubZReJya9oWvFXsl6SMRFDHRgeGX/Hi3IsxCoiBvok1Wteqt4V1M2Vt6SPBnLciJjmFR/lOPa
	q43N18pbiXs/DtQwtcw9icJOjUso8a31U7VUmTm8ga9ZANlLe0iMh4tESnfI8ljxQzEJhFPWFt8Tb
	HU4/DM9oLG5IZNI+9vYRJK2sllqxZAxcZI2VzCsbmvuDf9WQf/r7+voWTHEbqIAtptq5RAYSao1E0
	hI7+R2Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9e-00000003MFc-3y0x;
	Fri, 19 Sep 2025 15:36:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9b-00000003MCH-48PH
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I1cm2is+Xgw+x+T3m8uuoGo4E722CtwyukEZGpVjsa4=;
	t=1758296167; x=1759505767; b=TJ65o6dbsp4D9czSBh4D2YKGyEsXcmRjoiCy0CN3MejLGWx
	v8gnRi13fBztYIhpyk7FmdW/glsHx+DHMfq0p3owTcpJ6ssltv8V7sBf9+DEBBDUXb5cC4CbjrUSt
	SnwjHr5MpM9R7coXW7mAoO05bGnUzTQG1+SYzpHUArbk1Inn45k0u+lzBqO0nHe275wcjqYI3iIPQ
	XfR7AVFs+gcrwKkIJ+1cFx9/hmmNW8q/ZXdUXhXV1+4wFSlhkek4osUj3zL967VHhDXrIMh9EdeDb
	qzn7ECKACaYw3bDrTTI/U9KO7BiMDvxjiVJhKIjIAq5XMcI+0F94i8A9BCzKIx3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9Z-0000000G6O6-2S7E;
	Fri, 19 Sep 2025 17:36:05 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 05/11] tools/nolibc: use __fallthrough__ rather than fallthrough
Date: Fri, 19 Sep 2025 17:34:14 +0200
Message-ID: <20250919153420.727385-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_083608_022899_C16BA555 
X-CRM114-Status: GOOD (  10.46  )
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

Use the version of the attribute with underscores to avoid issues if
fallthrough has been defined by another header file already.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 369cfb5a0e78..87090bbc53e0 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -41,8 +41,8 @@
 #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
 #endif /* __nolibc_has_attribute(no_stack_protector) */
 
-#if __nolibc_has_attribute(fallthrough)
-#  define __nolibc_fallthrough do { } while (0); __attribute__((fallthrough))
+#if __nolibc_has_attribute(__fallthrough__)
+#  define __nolibc_fallthrough do { } while (0); __attribute__((__fallthrough__))
 #else
 #  define __nolibc_fallthrough do { } while (0)
 #endif /* __nolibc_has_attribute(fallthrough) */
-- 
2.51.0


