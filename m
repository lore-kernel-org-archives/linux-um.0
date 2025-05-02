Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA59C3DA4A
	for <linux-um@archiver.kernel.org>; Fri,  2 May 2025 22:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jIBtEyAokjAEkZnBAUAX5LDb5f/8nH7cHbyE0gJC8u8=; b=OoZu7w8Tiy348xGcEDb+V6Ddzy
	4Oa/yXoRGjFeUZG6upbCVgro2ZSPa1NsSWYxzZjNVEHPjvsA46a6gVbrlXIdgAJGLA3H9zM9H9x6B
	MngcUbKz7dsBoohttehox16ABzyXodpJFCWJ/WchOdN3R+fFzdvArtLJIwaUgwxah9ZL1tcayHu/V
	6no03jdmbM9NsrkrMduT/T48OMdvZDqeuE2BNRINUl5ht90prKWllEZ319jrW1c0AU4gzBqSx5t70
	rqPE5ECSLJj1sgxkqUeYTkCqp+jFk7ChbR6dXn0ZQDcs1I8QQzjz+HuQRmuzMhxwuHwMCHuqdoIUZ
	uVg6OrrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAzGx-00000003C8i-0EbR;
	Fri, 02 May 2025 22:54:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAzGu-00000003C7I-3KHJ
	for linux-um@lists.infradead.org;
	Fri, 02 May 2025 22:54:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 97E534A88A;
	Fri,  2 May 2025 22:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EC5C4AF0C;
	Fri,  2 May 2025 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746226459;
	bh=p3LCBG41fA+N9OOg7h+A3NTLbRHrJjxplvYJ9i2fjRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssm7w/5OZHMhxTzwMP4B4UgKSyqDS49B4LzQoeqpM6gq8fFj67ZCjSc9HH7u9EGhG
	 D5p6tcYMU1FvQqDasRC4ueS8g3cJQLabkV4DBDMSf01s2i9Hqb+fvrMZz/vhZiCjbl
	 q59u9hK4c9qNtDCDZ/PpSnmg/qgPvpx/tJl0NjdeXCX7d1aZedvHwOSQpBvN8Ot1RM
	 MZhVSvW4V7VSJzDtAz9K89UvV2KYeqFIRjRnRE7Wm5dT3nPJxX49BpoHcA+33YS0tT
	 zEUc00UOuVESsiTC5v26JvoMPHZwyD+mRB4CfW5ctFR+Wkhez7Dx3Pynf+GjMni1S1
	 fSpRGPEgXylIg==
From: Kees Cook <kees@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Justin Stitt <justinstitt@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-um@lists.infradead.org
Subject: [PATCH v2 1/3] gcc-plugins: Force full rebuild when plugins change
Date: Fri,  2 May 2025 15:54:13 -0700
Message-Id: <20250502225416.708936-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502224512.it.706-kees@kernel.org>
References: <20250502224512.it.706-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3599; i=kees@kernel.org; h=from:subject; bh=p3LCBG41fA+N9OOg7h+A3NTLbRHrJjxplvYJ9i2fjRY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmivmJ2fLZvdZtuL3ln0FN9zyeba4Wj2k17D3nRxQXrd vdMr2PqKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEjGNEaG31vtb+Y+u61978cH qSv9Qt/MA2r2XlX+dImj81RrVk9POMP/KOPbz/fsmLXErj3kugvzgqC892Eblgc1Mnx9/1GLbac cJwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_155420_879827_49CA461C 
X-CRM114-Status: GOOD (  16.39  )
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

There was no dependency between the plugins changing and the rest of the
kernel being built. Enforce this by including a synthetic header file
when using plugins, that is regenerated any time the plugins are built.

This cannot be included via '-include ...' because Makefiles use the
"filter-out" string function, which removes individual words. Removing
all instances of "-include" from the CFLAGS will cause a lot of
problems. :)

Instead, use -I to include the gcc-plugins directory, and depend on the
new -DGCC_PLUGINS_ENABLED flag to include the generated header file via
include/linux/compiler-version.h, which is already being used to control
full rebuilds. The UM build requires that the -I be explicitly added.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>
Cc: <linux-hardening@vger.kernel.org>
Cc: <linux-kbuild@vger.kernel.org>
---
 arch/um/Makefile                 | 1 +
 include/linux/compiler-version.h | 4 ++++
 scripts/Makefile.gcc-plugins     | 2 +-
 scripts/gcc-plugins/Makefile     | 8 ++++++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1d36a613aad8..8cc0f22ebefa 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -72,6 +72,7 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
 		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__ \
+		-I$(objtree)/scripts/gcc-plugins \
 		-include $(srctree)/include/linux/compiler-version.h \
 		-include $(srctree)/include/linux/kconfig.h
 
diff --git a/include/linux/compiler-version.h b/include/linux/compiler-version.h
index 573fa85b6c0c..08943df04ebb 100644
--- a/include/linux/compiler-version.h
+++ b/include/linux/compiler-version.h
@@ -12,3 +12,7 @@
  * and add dependency on include/config/CC_VERSION_TEXT, which is touched
  * by Kconfig when the version string from the compiler changes.
  */
+
+#ifdef GCC_PLUGINS_ENABLED
+#include "gcc-plugins-deps.h"
+#endif
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 5b8a8378ca8a..468bb8faa9d1 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -38,7 +38,7 @@ export DISABLE_STACKLEAK_PLUGIN
 
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
-GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
+GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y)) -I$(objtree)/scripts/gcc-plugins -DGCC_PLUGINS_ENABLED
 export GCC_PLUGINS_CFLAGS
 
 # Add the flags to the build!
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 320afd3cf8e8..24671d39ec90 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -66,3 +66,11 @@ quiet_cmd_plugin_cxx_o_c = HOSTCXX $@
 
 $(plugin-objs): $(obj)/%.o: $(src)/%.c FORCE
 	$(call if_changed_dep,plugin_cxx_o_c)
+
+quiet_cmd_gcc_plugins_updated = UPDATE  $@
+      cmd_gcc_plugins_updated = echo '/* $^ */' > $(obj)/gcc-plugins-deps.h
+
+$(obj)/gcc-plugins-deps.h: $(plugin-single) $(plugin-multi) FORCE
+	$(call if_changed,gcc_plugins_updated)
+
+always-y += gcc-plugins-deps.h
-- 
2.34.1


