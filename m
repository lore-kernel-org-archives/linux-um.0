Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B381EE8B38B
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=St31LvF0IHppIozPj48TTmhG2uWfbbDiPNVwz27B6eo=; b=2yScky9wHyaKnlzQ5eXPu6CB7u
	DLfsoMZ4y8H9XvGGgt2RKlPO31cm7mweDi+NNrQJ91Bt1CmVGyzF03rjg1483amG5pYlfCBlF8+cz
	enpQDjKzrRdfGdTWQ/ICInjayg+s0aIdWPz3IhE/wxj4dkIjZJ8UZiylp8tG2S1P0v7VR04v2f0gS
	V4ZfZLjywolPyL0EZbsQ69Oomn9FONKKzdrzfupWwx+KYu/hDudeCA4IqYC2YVC1rGdotsHkYWdZt
	M93GAY87LsFiiCpJ5O2sdU8ZoUW5WYOPlexIFj5lLET+Hmj1yQDjZVrq9bgJS09RUpDAhvqVcoeL3
	JrxIYzpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSdH-00000007mKg-1Ufo;
	Wed, 04 Feb 2026 02:28:43 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSdC-00000007mHB-42pL
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:41 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-81f39438187so3706762b3a.2
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172118; x=1770776918; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=St31LvF0IHppIozPj48TTmhG2uWfbbDiPNVwz27B6eo=;
        b=KjY6z8pRmEHj338LvlacqLxVcT2WW/YFt0m+eocxxWrapBoOiF6L+a+XORbdqwk8gp
         IL+O+w9DUwmwY+cvZZwmJNczBCW8Fkr16g9fari99DUPt6H1MiOZFfCa69ggezqa9pve
         fVA5jKxWEmOCvo2QvtVbOgAgYckjbT+doeI1oikLddRAGc3lIanJTgjm3LZ+D3MZRb4w
         KThlHrYcxEanRDxnSLf7TpmMiVo/LowneNTgzhgh/KHAUEKxRg2KhTlEGMo+jjLDE/Gi
         5dWp9X0q3RrLtgWVwVyj/Zo/aNWnigVqRvAS+vE11QNZu+eq7XgGOQz9tKO1uEJwRSq9
         Wo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172118; x=1770776918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=St31LvF0IHppIozPj48TTmhG2uWfbbDiPNVwz27B6eo=;
        b=l3tFgwqC0lpWmpgQ/ZzaKrL0fyOMS4bxhjDAd186d8yhQXryWXUo2eKTWttmBkuYC7
         tPcWhvwOy5+9/85M5HjA7xUjn1XUJGo/Ax8uMnBechhIJ8bzSDYeTx0qUnRmhoMgRsTD
         Hg0F/XjcKWBmW7bpYIlHYQpzUt+aHYWOqjUpFu5dmfbqhhfOVaU5jzwKaD2bbJlw8+Ll
         c6vs0rzp9Za4no4rZLZ36ey4p+i5q2/fzNfGGIXYQsgpaVz3WMdKFXyoPT9UCsHEyx23
         oPzOLlg2P/vprWE/uP1/MdMwvshOwRFTlR0KhcN7trjd/aC/y0Gb2U94yvrHLV/mqIGd
         gVsA==
X-Gm-Message-State: AOJu0YxrE6KXwoCPM1RgB1ElOKE22TBuKLfBL4o5Wy591brNtpl9VRS8
	GvolpVLkwXo6rRkpiMe8f6zNnPJWnFiPcI9iTpZF4s9rBSX33SA6WIIt
X-Gm-Gg: AZuq6aJz3TaiftDT2qojcL5PQoE1ej75jn8klwrvVCtjAWHHf2o5INoAmiy6ahVe9BK
	b3E/srsBpmoSzLudaGx10ZnQrM6XH0ANw5XyzRsXHlGXeYYw0ePTJcRAe6fAQ0zFtxHLhMoNtzK
	+btfsrj7Nn73p35HDmwYH/xxB88WRVQbl/Qs+1t2ggXWRmtf3iIxkNj9fLollDUQnS3EXpX/rHG
	+4pNgrOrwErJnLhCgR1seFNntIK6O/hGxxxHKBEeXoh4+cGFLY5AH30xMykF84AGZU/8DhWH7je
	ItJ+fCtsQy4Xkg6uSpDLPlMfvX9nsSqTDaB8iaxQMtrk+pBOslMSiZDBADMLsdkiYGMngfNpL3b
	us7uVugldItD7w1B9xjUFj51W2t9mHh+H9H06pgumPxXPZuepqOMpJcen3KmCP+LXVw5EgSbunM
	2bURYBDq/CO+X1r9HdJnTb/6ECspNndMpLn0jB5Yni7/oxyyvJ6Jz4MVGOk27eXu/VoAE2AweSd
	Mzg7cc1IY4MRJLvpUgStt6nEoY=
X-Received: by 2002:a05:6a00:4b4a:b0:81f:3d13:e07b with SMTP id d2e1a72fcca58-8241c5efb68mr1330656b3a.43.1770172117824;
        Tue, 03 Feb 2026 18:28:37 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d478975sm628857b3a.52.2026.02.03.18.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:36 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 8BE061200C49; Wed,  4 Feb 2026 11:28:35 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 13/13] um: nommu: plug nommu code into build system
Date: Wed,  4 Feb 2026 11:28:11 +0900
Message-ID: <d6057e2fb8584671e259fbc2d94959e2b04117db.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182840_651069_6F5A17B4 
X-CRM114-Status: GOOD (  13.17  )
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

Add nommu kernel for um build.  defconfig is also provided.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/Kconfig                        | 14 ++++++-
 arch/um/configs/x86_64_nommu_defconfig | 54 ++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 8415d39b0d43..1c90e3efef2e 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -35,16 +35,19 @@ config UML
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
-	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ARCH_VMAP_STACK if MMU
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
 	select SPARSE_IRQ
+	select UACCESS_MEMCPY if !MMU
+	select GENERIC_STRNLEN_USER if !MMU
+	select GENERIC_STRNCPY_FROM_USER if !MMU
 
 config MMU
-	bool
+	bool "MMU-based Paged Memory Management Support" if 64BIT
 	default y
 
 config UML_DMA_EMULATION
@@ -226,8 +229,15 @@ config MAGIC_SYSRQ
 	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say Y
 	  unless you really know what this hack does.
 
+config ARCH_FORCE_MAX_ORDER
+	int "Order of maximal physically contiguous allocations" if EXPERT
+	default "10" if MMU
+	default "16" if !MMU
+
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
+	default 3 if !MMU
+	range 3 10 if !MMU
 	default 2 if 64BIT
 	range 2 10 if 64BIT
 	default 1 if !64BIT
diff --git a/arch/um/configs/x86_64_nommu_defconfig b/arch/um/configs/x86_64_nommu_defconfig
new file mode 100644
index 000000000000..02cb87091c9f
--- /dev/null
+++ b/arch/um/configs/x86_64_nommu_defconfig
@@ -0,0 +1,54 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+# CONFIG_PID_NS is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_MMU is not set
+CONFIG_HOSTFS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_SSL=y
+CONFIG_NULL_CHAN=y
+CONFIG_PORT_CHAN=y
+CONFIG_PTY_CHAN=y
+CONFIG_TTY_CHAN=y
+CONFIG_CON_CHAN="pts"
+CONFIG_SSL_CHAN="pts"
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_IOSCHED_BFQ=m
+CONFIG_BINFMT_MISC=m
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_UBD=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_NBD=m
+CONFIG_DUMMY=m
+CONFIG_TUN=m
+CONFIG_PPP=m
+CONFIG_SLIP=m
+CONFIG_LEGACY_PTY_COUNT=32
+CONFIG_UML_RANDOM=y
+CONFIG_EXT4_FS=y
+CONFIG_QUOTA=y
+CONFIG_AUTOFS_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_NLS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_FRAME_WARN=1024
+CONFIG_IPV6=y
-- 
2.43.0


