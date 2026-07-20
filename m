Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABB6C4452E
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMfeXbks+4YVUkh+LmfFBfcgy80kjfTQ53UwwKnisYU=; b=tCsmU8mJeJsF+56cTevykHj72f
	IDh/waE1cYZDOj+myi/oLWrV4IklvCEvjui/AwxDXoo6CVUioe3jz5LPRD6iMaLilrxLQF86FetwJ
	iu9ucruw2mDFzdbGDXQE0Qu3HXXc6XgziOh2x54b8GFeKz2o2pzmtAi1at33l3re4uIpKhg0a5Bpq
	w3V4FSZjWL9IWi9FZAnO/F0Awm0JuNBmxqPA0zPw0iBiXiJcQzG1PsFARULsPq8ZfoexDWFBDAE2e
	RFltEknCrhSvJdzGtir5oqut5GZBCFe/nel21CJq4N2dJ+S4f9RAxq7+5TxJDY/DuVpDhM9vlg9HB
	XryeSZ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt5E-00000007h4x-36Q2;
	Mon, 20 Jul 2026 18:51:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt59-00000007h10-2nq5
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 18:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JMfeXbks+4YVUkh+LmfFBfcgy80kjfTQ53UwwKnisYU=;
	t=1784573475; x=1785783075; b=jbEKAr/inxBbRe/RrZzJLdVx+MSc7CaNfPI9A9ZhJcjioFK
	gZI7d9wloD2IzGu911K2vfh6ciy1nQd9WwGOKVeiv1ta0cZuEimic+qwWdr/AkvpJ4Dgch5D+Qd4D
	J2n46O4Yzfyzk6UeiVUtOrejfuNOFXYNl5/34oCQtF7xLzUbvKljxZqzVLujBWoV21mZjQbyBxHMd
	cGW7mZrjHAAZv9Ah9tblFa9BAhdHMO4+M0UA48Ly4WqvNMJtHRGg3hZMyLvaYIeVZE1lYmyCwawyB
	RY17Ji9xQzEGts906Dm56OrNPC4jEx/O9TfWsnOMhyIwEb2boGzyFdoFnCZot8nA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wlt54-0000000GsPP-2YSL;
	Mon, 20 Jul 2026 20:51:10 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 4/9] um: change machine name for uname output
Date: Mon, 20 Jul 2026 20:26:54 +0200
Message-ID: <20260720185103.530603-15-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720185103.530603-11-johannes@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_115116_001672_BE04038D 
X-CRM114-Status: GOOD (  10.10  )
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

From: Hajime Tazaki <thehajime@gmail.com>

This commit tries to display MMU/!MMU mode from the output of uname(2)
so that users can distinguish which mode of UML is running right now.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Link: https://patch.msgid.link/62314a61fd98febda7aafaa746f00eb0b16d1180.1770170302.git.thehajime@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Makefile        | 6 ++++++
 arch/um/os-Linux/util.c | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 937639edc295..1f85b73d4abb 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -148,6 +148,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 CLEAN_FILES += linux x.i gmon.out
 MRPROPER_FILES += $(HOST_DIR)/include/generated
 
+ifeq ($(CONFIG_MMU),y)
+UTS_MACHINE := "um"
+else
+UTS_MACHINE := "um\(nommu\)"
+endif
+
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index e3ad71a0d13c..5fb26f5dfcb6 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -64,7 +64,8 @@ void setup_machinename(char *machine_out)
 	}
 # endif
 #endif
-	strcpy(machine_out, host.machine);
+	strcat(machine_out, "/");
+	strcat(machine_out, host.machine);
 }
 
 void setup_hostinfo(char *buf, int len)
-- 
2.53.0


