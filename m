Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0A1EB64DD
	for <linux-um@archiver.kernel.org>; Fri, 21 Jul 2023 17:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/mGyaJG8jHceMAgoSGnsSh2j/G6UBNUfvO258FifLIc=; b=pQt2+GhvAKUMwD
	9/QVKU2zO2/xkG7HY+YNAX8iUyTawgL6Dd/bR+ZNTgCvYCYZyvtf98rHor9P+2tPqw6OtQm7uvZCP
	GXD+gjqgYoWWXMTVVw1j3kyFoLFsHUK/Tg7skh8IW0IRlGIqg0GmzdjRoarKz3WM2a/mKOFmFH23q
	XiBT8DmIpe1MjmJNF6GJqaDRYsnUl0SRemsvYzrtEz73F0QHeapDGq2kj36tfTZLTvjrExKqFUe3r
	wkPe+MaDMjvKKjlkqK0rkXniNM82HuMEK8BJp6BPCRGVM+3ta+b6ozhk8UfH8JO6+gV+hT7TybAVa
	4uX8VXYmmNl7qmtNwuyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMtmc-00EjxW-2L;
	Fri, 21 Jul 2023 17:19:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMtmZ-00Ejw7-1l
	for linux-um@lists.infradead.org;
	Fri, 21 Jul 2023 17:19:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BC7DF61D42;
	Fri, 21 Jul 2023 17:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B330EC433C7;
	Fri, 21 Jul 2023 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689959950;
	bh=rqQYBDs0vqpTTedyTMN83jkJBaQ/Y93Hskjay6OnuvE=;
	h=From:To:Cc:Subject:Date:From;
	b=jdVEybrP7L1EQAa1kFGVahsP7XbxLWeBbHkEQ8/2j3bE72eeqexXMm8SP1NcSl60D
	 wCbHBQ4JNk34vVBUDsYjcrSinMflpatKaF7oI14TremTy6vjygaNlZwiOP7LMkNaDY
	 S1dzMsVWwOFWQTi5dLnPoTlnDeDK33O7snbWY0yA+WFnXXO+7rFdLmuaBj8JX6vCYN
	 Wcuuq9ZkJmfsLkTW2osqaPnpdAd/igwkBvR1ebIneqFLnytg7xKQEHHg2ngaRDyCpF
	 5IBxefKbLbdw2ZA1TJs7uChNcy6mKCkW5l0/580I6SoZuyJz9WBt5ymX108ThKN+R5
	 qvEaZWlOrYn0w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v2 1/2] UML: hard-code the result of 'uname -s'
Date: Sat, 22 Jul 2023 02:18:56 +0900
Message-Id: <20230721171857.3612639-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_101911_643293_AABCE234 
X-CRM114-Status: GOOD (  10.27  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

We rely on 'uname -s' returning 'Linux' because there are os-Linux/
directories, but no other os-*/.

Supporting a non-Linux host is unlikely to happen.

Let's hard-code 'Linux'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 arch/um/Makefile     | 7 +++----
 arch/x86/um/Makefile | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index da4d5256af2f..1735a562453d 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -18,14 +18,13 @@ else
 endif
 
 ARCH_DIR := arch/um
-OS := $(shell uname -s)
 # We require bash because the vmlinux link and loader script cpp use bash
 # features.
 SHELL := /bin/bash
 
 core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/drivers/		\
-			   $(ARCH_DIR)/os-$(OS)/
+			   $(ARCH_DIR)/os-Linux/
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 
@@ -78,7 +77,7 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
 
 #This will adjust *FLAGS accordingly to the platform.
-include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
+include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
 
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/include \
 		   -I$(srctree)/$(HOST_DIR)/include/uapi \
@@ -155,4 +154,4 @@ archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 
-export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
+export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index ee89f6bb9242..e207e6748aa2 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -13,7 +13,7 @@ obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_$(BITS).o stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
-	mem_$(BITS).o subarch.o os-$(OS)/
+	mem_$(BITS).o subarch.o os-Linux/
 
 ifeq ($(CONFIG_X86_32),y)
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
