Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD62BC3ABAC
	for <linux-um@archiver.kernel.org>; Fri,  2 May 2025 08:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LVObwhONwacsr8J8k6E8Dl7C1TWEljNKaUOAbPgxTow=; b=R0BhvtOm4oW7g9uKnXxRHFH/ZQ
	dbunvUeqWPqQlyT3a7O1PKvt5YCjERIRTiqkperRJz8ck1GfpQ1BbjrWSfj3kM9fLa5MuFpEpu3/i
	FBBAEghQaBXHrzRgARjD3RjXKMsEonHBVb4jv0RjwsPzRL+rpqX1vXeIVb7G+z/DmmgTobXit3NoV
	FICSCM5eF/UfcxMZJM6RqGYnteudO4RRGRJobbLgqOuNA7lQ+aA6oywbFrLiiGp7s2yVn5ujD6vGL
	MQ2M61mrgfAT3QlQwnijoSVt3tngF8XbvYsEgZIJf6mYG7fXKW/+8P8Y1s+FDq6DwtOuvaE0TmeOG
	VjD+DLHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAlok-00000001CZ8-2NCw;
	Fri, 02 May 2025 08:32:22 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAloh-00000001CYA-0nyT
	for linux-um@lists.infradead.org;
	Fri, 02 May 2025 08:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746174733; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LVObwhONwacsr8J8k6E8Dl7C1TWEljNKaUOAbPgxTow=;
	b=DTzyOv8YRAN6inhCsoRUPpyjndT4Kreo88bWkpcukQCfVGxO0Ve+IZhEhpgJrMEXb96p7N2OiR1qz7COfjZLGvSVsmjRnYb0QJGNpG85ckIFaC5jPam/jucNCnZvWAjnzkR4xZ6xeD/TqZq3V1oDF+uS5GLF7MeGk/nOVN2NY3g=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cd4hJwg_1746174720 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 02 May 2025 16:32:08 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Merge os-Linux/drivers/ into drivers/
Date: Fri, 02 May 2025 16:31:52 +0800
Message-Id: <20250502083152.3791637-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_013219_729489_D3A56E5A 
X-CRM114-Status: UNSURE (   8.15  )
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

Most of the drivers are stored in drivers/, with only two drivers
kept in os-Linux/drivers/. Merge os-Linux/drivers/ into drivers/
to simplify and unify the code organization.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/Makefile                       |  4 ++++
 arch/um/{os-Linux => }/drivers/etap.h          |  0
 arch/um/{os-Linux => }/drivers/ethertap_kern.c |  0
 arch/um/{os-Linux => }/drivers/ethertap_user.c |  0
 arch/um/{os-Linux => }/drivers/tuntap.h        |  0
 arch/um/{os-Linux => }/drivers/tuntap_kern.c   |  0
 arch/um/{os-Linux => }/drivers/tuntap_user.c   |  0
 arch/um/os-Linux/Makefile                      |  2 +-
 arch/um/os-Linux/drivers/Makefile              | 13 -------------
 9 files changed, 5 insertions(+), 14 deletions(-)
 rename arch/um/{os-Linux => }/drivers/etap.h (100%)
 rename arch/um/{os-Linux => }/drivers/ethertap_kern.c (100%)
 rename arch/um/{os-Linux => }/drivers/ethertap_user.c (100%)
 rename arch/um/{os-Linux => }/drivers/tuntap.h (100%)
 rename arch/um/{os-Linux => }/drivers/tuntap_kern.c (100%)
 rename arch/um/{os-Linux => }/drivers/tuntap_user.c (100%)
 delete mode 100644 arch/um/os-Linux/drivers/Makefile

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 0a5820343ad3..4180a59df929 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -6,6 +6,8 @@
 # pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
 # in to pcap.o
 
+ethertap-objs := ethertap_kern.o ethertap_user.o
+tuntap-objs := tuntap_kern.o tuntap_user.o
 slip-objs := slip_kern.o slip_user.o
 slirp-objs := slirp_kern.o slirp_user.o
 daemon-objs := daemon_kern.o daemon_user.o
@@ -38,6 +40,8 @@ obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
+obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
+obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
 obj-$(CONFIG_UML_NET_SLIP) += slip.o slip_common.o
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
diff --git a/arch/um/os-Linux/drivers/etap.h b/arch/um/drivers/etap.h
similarity index 100%
rename from arch/um/os-Linux/drivers/etap.h
rename to arch/um/drivers/etap.h
diff --git a/arch/um/os-Linux/drivers/ethertap_kern.c b/arch/um/drivers/ethertap_kern.c
similarity index 100%
rename from arch/um/os-Linux/drivers/ethertap_kern.c
rename to arch/um/drivers/ethertap_kern.c
diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/drivers/ethertap_user.c
similarity index 100%
rename from arch/um/os-Linux/drivers/ethertap_user.c
rename to arch/um/drivers/ethertap_user.c
diff --git a/arch/um/os-Linux/drivers/tuntap.h b/arch/um/drivers/tuntap.h
similarity index 100%
rename from arch/um/os-Linux/drivers/tuntap.h
rename to arch/um/drivers/tuntap.h
diff --git a/arch/um/os-Linux/drivers/tuntap_kern.c b/arch/um/drivers/tuntap_kern.c
similarity index 100%
rename from arch/um/os-Linux/drivers/tuntap_kern.c
rename to arch/um/drivers/tuntap_kern.c
diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/drivers/tuntap_user.c
similarity index 100%
rename from arch/um/os-Linux/drivers/tuntap_user.c
rename to arch/um/drivers/tuntap_user.c
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 049dfa5bc9c6..fae836713487 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -8,7 +8,7 @@ KCOV_INSTRUMENT                := n
 
 obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o drivers/ skas/
+	umid.o user_syms.o util.o skas/
 
 CFLAGS_signal.o += -Wframe-larger-than=4096
 
diff --git a/arch/um/os-Linux/drivers/Makefile b/arch/um/os-Linux/drivers/Makefile
deleted file mode 100644
index cf2d75bb1884..000000000000
--- a/arch/um/os-Linux/drivers/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# 
-# Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
-#
-
-ethertap-objs := ethertap_kern.o ethertap_user.o
-tuntap-objs := tuntap_kern.o tuntap_user.o
-
-obj-y = 
-obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
-obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
-
-include $(srctree)/arch/um/scripts/Makefile.rules
-- 
2.34.1


