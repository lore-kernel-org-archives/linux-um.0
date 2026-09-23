Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F1FC9830B
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fW91gkdPX1bLvaxQ13B5AcZidLh03BBudaCJeNOWB0A=; b=2qxiaxdKrcQabb8n9FNL4dv0Q/
	92zLEOl5DrGgk4FOd5pFWx1q5i9Cs8WKNo4EsoblVCKIFOwlrKZGhiXrBm0v+xmlbvxDTJ2imGLAR
	DsXBNCtJCdKAclTZV6zo1E0noFoOAFkNmbWEnSW1geJsGRxxb3ZglEfI5eiGcZ9Er4U243eT3/bOv
	LYR7afjRc1pHdxtMoq9s0McWjXi25Lx6y1MECtUK5vRG5A9uvOiGd3AjVz6waUwCUtCNYa7c7fP3O
	Ib4TSZ2WiR73yQzhirBVniV0IIf/pOaS8JpMNc15WiL8UTXSuqEbFcHUbLfhPW9UxkA8sI6vnGEV5
	ofbFTodQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9P0T-00000008krb-1IK0;
	Wed, 23 Sep 2026 15:35:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9P0P-00000008kpA-1P2q
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 15:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fW91gkdPX1bLvaxQ13B5AcZidLh03BBudaCJeNOWB0A=;
	t=1790177733; x=1791387333; b=srlMKdxQX+CweqDHHSAiLhOjWK3vhExy5W70PU9VxyoUE3b
	c/gP0FHVpiCQm65hpvpTzEXViiGsGnB2gyTa4Sr0ePnljeYYJ3XJlQ5qrT+JdTp6rV38O54yyT2Mj
	TR6X+a2C7D19L7T0czsYTYZWiTXOGA8PkoArQd9hV981S7tW8lSooo4c8q1Z7ZfqEGs1xIPTrdElS
	M6xQjnqf3gHxvWmBzQJwZgClpZcymtUhX+/e/xdwqsBfSKyxF547xOHxSLo03DrZY4vYcpoIRiS4c
	2Di8hFfs3m8QjtEkG/cDJpF3f9r0JJVF605Rtom8eiGnGPhOiBoJzgoIA2G1eZLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9P0K-000000083zz-36CT;
	Wed, 23 Sep 2026 17:35:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] um: make stub compilation more robust
Date: Wed, 23 Sep 2026 17:34:31 +0200
Message-ID: <20260923173523.9cb03214335b.Ie1487657bc0f464f4911e95f532ab010b32864b8@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923153523.987904-5-johannes@sipsolutions.net>
References: <20260923153523.987904-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_083533_374776_382FA482 
X-CRM114-Status: GOOD (  10.73  )
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

With clang, stub compilation could result in getting stack
frames where none are allowed, or ways of making it be not
relocatable. Set -ftrivial-auto-var-init=uninitialized for
more code, and -fomit-frame-pointer as well to avoid these
issues.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/Makefile | 10 ++++++++--
 arch/x86/um/Makefile         |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 3384be42691f..0df1e49300f6 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -40,8 +40,14 @@ targets += stub_exe.dbg stub_exe $(stub_exe_objs-y)
 CFLAGS_stub.o := $(CFLAGS_NO_HARDENING)
 CFLAGS_stub_exe.o := $(CFLAGS_NO_HARDENING)
 
-# Clang will call memset() from __builtin_alloca() when stack variable
-# initialization is enabled, which is used in stub_exe.c.
+# stub_signal_restorer() must not touch stack pointer, clang doesn't
+# always omit the frame pointer automatically
+CFLAGS_stub.o += -fomit-frame-pointer
+CFLAGS_stub_exe.o += -fomit-frame-pointer
+
+# Clang's stack var initialisation can use memset() or similar and that
+# cannot be done for this code since we embed/move the stub
+CFLAGS_stub.o += $(call cc-option, -ftrivial-auto-var-init=uninitialized)
 CFLAGS_stub_exe.o += $(call cc-option, -ftrivial-auto-var-init=uninitialized)
 
 UNPROFILE_OBJS := stub.o stub_exe.o
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index f9ea75bf43ac..100b68f601f9 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -47,4 +47,7 @@ include/generated/user_constants.h: $(obj)/user-offsets.s FORCE
 UNPROFILE_OBJS := stub_segv.o
 CFLAGS_stub_segv.o := $(CFLAGS_NO_HARDENING)
 
+# see arch/um/kernel/skas/Makefile - this goes into the stub
+CFLAGS_stub_segv.o += $(call cc-option, -ftrivial-auto-var-init=uninitialized)
+
 include $(srctree)/arch/um/scripts/Makefile.rules
-- 
2.55.0


