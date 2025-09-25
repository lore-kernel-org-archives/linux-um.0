Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79685CAC5A5
	for <linux-um@archiver.kernel.org>; Thu, 25 Sep 2025 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V4NmZHUoJps7Yrk11w5SBou2tcMbfSFRbEHR6+6/r24=; b=cAd+0AgxQx8OZSDEgLYV6z8zNq
	8nNAeue+u1eITAZ1S7gd0dg3ljRhBl7wyHYFSDyS74nzeBBH55DTM3XS/Tbv6QWWSS7CO2eVgDKjL
	Fthum4O9p7Q2M2P94+KWXpt1hGyGWyIm3skRgg7LY8Ua8mh7DA5J8F+8RomaTlheIVOE0GaBAbcfX
	5ZdoquowrrD9BizlyaCezNZilACarJixKwk+OzYlSDSOuVtoan1wiEQe/t/gv9MWd0ETg1VJKTann
	r6MB28E8oAzZh2qD7oDI+m49A5BqquwAvDNAiKVGYLByXmanYWFnO8ms8Qj/+KiVVxJAej7YKZutF
	U9bsErVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1gXF-00000006m05-1aGP;
	Thu, 25 Sep 2025 07:37:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1gXE-00000006lyp-0BI8
	for linux-um@bombadil.infradead.org;
	Thu, 25 Sep 2025 07:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=V4NmZHUoJps7Yrk11w5SBou2tcMbfSFRbEHR6+6/r24=; b=LwBPfXPFOTgR90iEielrpICfUt
	+Y+YeOa+wZww6aVyKxmVnPwn2REKIOSbOn3BfHsV+/lvRzdqvcdCh4NkyglD1QMeFzI/C6FLyKijK
	NM5bP+rNtPCIHampXZTIqVTRj0gbqaeuZirOCmKOgEwQacErxZsdDtRaa1337sCqjgiCXDfu9Q/Nq
	yQ7Wqx+jyAJNlfxb50YIITWLhQ4cxM1/TrJpwa90eZHSam27xx5O2y50IgV8RFHJfSNZkc4FaY8YG
	Ijf8PBIJUB/4acjeedDoo5jmdla7LywriQ+QoNVwhQ5sQ08rgRQ0fFsZMgGIBqA2NzvyRaeEx+HiB
	+OJkdEtg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1gX9-00000008vqC-3pID
	for linux-um@lists.infradead.org;
	Thu, 25 Sep 2025 07:36:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758785804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V4NmZHUoJps7Yrk11w5SBou2tcMbfSFRbEHR6+6/r24=;
	b=fNNibu59hKyN9ltYQlO5X1S9wUg+NpsymoT/6OaNNQoT9ZH+P7teYp2f0AkztRL+vQvcmJ
	BZhL48iLNPLf7/WDuqzdgJ7v9+HlEU46j1F5LWVgcxGJEJSeQ6LAfcpitm20dM3Sm8YSQZ
	Vq+WMQM9+4iZU2eCiLoLGjo7XSv93Cg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758785812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V4NmZHUoJps7Yrk11w5SBou2tcMbfSFRbEHR6+6/r24=;
	b=K9Q666qFi1WC8sh1qMAnweS//nUxq6skNdIq/06iX/sz5cvL6AyTzBWWHpysppYEngSipP
	dYjw5gMkZYp2IO8kEkdNBJynEjn2Tbd0KjTk1ZAScIDA0onkHJqWChcWwQb3/ZS1QEHb9X
	tUNqohJhsZy9uLStERZWgRkp9chZaBU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-epi8fczuM4muPm_IB-vEBA-1; Thu, 25 Sep 2025 03:36:43 -0400
X-MC-Unique: epi8fczuM4muPm_IB-vEBA-1
X-Mimecast-MFC-AGG-ID: epi8fczuM4muPm_IB-vEBA_1758785802
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46cde0b2226so1455245e9.2
        for <linux-um@lists.infradead.org>; Thu, 25 Sep 2025 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758785802; x=1759390602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4NmZHUoJps7Yrk11w5SBou2tcMbfSFRbEHR6+6/r24=;
        b=D6rUvmKkbQismqyrMWLbKYmEfITNSt7lpoglv+RbllgBWZAN9+9bvA8tGPpHzMCE30
         TyV8Mbx6MrflCik0wwriXpd2/kjs0hT1dwarXWvxidmdWaBnG0Q2YX/7xly34CbUX+VH
         Tggs6NGrFWF2OYczBLroRqcCxxXvYbDO6La7f8wj1cpcDU5t4BfqEDZzKowY3Oqu9em5
         Uu0B+4oA13UNuAoLl/0o7ilOpwaeN6cB2FSe6JY4B3obdk9EEQ1Lq5zGfpv0ekOvFanD
         mGRePlvbL2zkUAiJDTtixYuiP5hytkQhYNgYIm9bT0Ve0eXQ4woEBUwAcoe/giPcEr6L
         bI/A==
X-Forwarded-Encrypted: i=1; AJvYcCWp77teNNsFMOwrIcjZl+zB9L7lOVOEztrhvQW/4f9jxfYbiN/oEQ3THm4lRA9BSz15LVwspAXHLQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzPhUjJ9DIR8N32jJZtk4N1nyec7FUXTihT6YPauwnC1aEDgg5P
	iBxrbbEPpHAOUdvyWTChh6wj9k+P/wzSw40koL4C8eVuUvqtULGP7Ck+M+fPI56pLNrvGGitIXi
	yXjlzXaPLYvGse2P+N2RATegTq/Aij+hVdhQ+8i8nHiYvo+AeCseB/Lc+4fRh7aI9/g==
X-Gm-Gg: ASbGncuyDFIKvknDNp59VIVQ2ymAkx5442wfxjc+vLFxcIlWeYIRAXPN6Rkt6v8mi74
	glrvCTfahuZ6exXgNp1XhiHSI2mGIKMLwFf/Ow+wkkpqmhNBFkowYuBxNaJ9nyTSw6GS0YMz621
	GA4lSMu/qSpvldwZJA6F7EApQjt6ext+X42lMAHByxiZh76XcokfklmDgAFN8lrGJbs7P1+ABjb
	7AAyk70KgXpNF7fvnJxls9Csf/rYJSdcMRt2QQzzHzWbd4NlWKidBGEHIQ9H/GCI8TLLX1fOcH/
	mSj42hkkVwwvjRI8CaHRv1lanSHbQ8hj9r8A97GqPihepo2Lx8dnTJxgDlakRURgavSaJ6bAygw
	EEhwTvnQvke13Mg==
X-Received: by 2002:a05:600c:8010:b0:45c:b5eb:b0c6 with SMTP id 5b1f17b1804b1-46e329a805amr24229625e9.5.1758785801748;
        Thu, 25 Sep 2025 00:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHigtd7Rlw0EkwZsZ6TnPLHr+fIfHQKJS55XMc7sCab7310hvvOcbsSwYh9WPs1s1S/Xj6xjA==
X-Received: by 2002:a05:600c:8010:b0:45c:b5eb:b0c6 with SMTP id 5b1f17b1804b1-46e329a805amr24229265e9.5.1758785801231;
        Thu, 25 Sep 2025 00:36:41 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc560338csm1755120f8f.41.2025.09.25.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:36:40 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-um@lists.infradead.org,
	linux-openrisc@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] Documentation/features: Update feature lists for 6.17-rc7
Date: Thu, 25 Sep 2025 09:36:34 +0200
Message-ID: <20250925073634.112142-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ie8k4-TpXSziF7DMLZvfTTZnESNAmiPgDtNVrDHjMnY_1758785802
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_083656_427524_17A2910F 
X-CRM114-Status: GOOD (  14.94  )
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

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

It seems that ./Documentation/features/scripts/features-refresh.sh was most
recently used in December 2022, with the latest kernel release v6.1-rc7 at
that time (see commit 7f2e60ff51ca ("Documentation/features: Update feature
lists for 6.1") to update the feature lists in this subdirectory. All
further changes to Documentation/features/ since then have probably been
done manually, without checking for changes in other architectures and
features, that missed to update this part of the documentation.

Running ./Documentation/features/scripts/features-refresh.sh now showed
seven changes of supported features in various architectures (one in arc,
two in parisc, one in riscv, one in openrisc, and two in um), which were
not reflected yet in the current documentation.

To confirm the sanity of this script's suggested changes, I checked if the
commit messages confirm that the features have in fact been added in the
following commits:

  - commit f122668ddcce ("ARC: Add eBPF JIT support")
  - commit 4800a6215e33 ("parisc: Wire up eBPF JIT compiler")
  - commit a869b8c29f86 ("riscv: enable mseal sysmap for RV64")
  - commit 2f681ba4b352 ("um: move thread info into task")
  - commit 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
  - commit 7ce8716e2769 ("openrisc: Add HAVE_REGS_AND_STACK_ACCESS_API support")
  - commit b5ff52be8913 ("parisc: Convert to generic clockevents")

So, update all documents to the current state with features-refresh.sh.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 Documentation/features/core/eBPF-JIT/arch-support.txt         | 4 ++--
 .../features/core/mseal_sys_mappings/arch-support.txt         | 2 +-
 .../features/core/thread-info-in-task/arch-support.txt        | 2 +-
 Documentation/features/core/tracehook/arch-support.txt        | 2 +-
 Documentation/features/perf/kprobes-event/arch-support.txt    | 2 +-
 Documentation/features/time/clockevents/arch-support.txt      | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index 7434b43c2ff8..83f77f55fc87 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -7,7 +7,7 @@
     |         arch |status|
     -----------------------
     |       alpha: | TODO |
-    |         arc: | TODO |
+    |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |        csky: | TODO |
@@ -18,7 +18,7 @@
     |        mips: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
index a3c24233eb9b..fa85381acc43 100644
--- a/Documentation/features/core/mseal_sys_mappings/arch-support.txt
+++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
@@ -20,7 +20,7 @@
     |    openrisc: |  N/A |
     |      parisc: | TODO |
     |     powerpc: | TODO |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  N/A |
     |       sparc: | TODO |
diff --git a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
index 2afeb6bf6e64..f3d744c76061 100644
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -24,7 +24,7 @@
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |          um: | TODO |
+    |          um: |  ok  |
     |         x86: |  ok  |
     |      xtensa: | TODO |
     -----------------------
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index a72330e25542..4f36fcbfb6d5 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -24,7 +24,7 @@
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |          um: | TODO |
+    |          um: |  ok  |
     |         x86: |  ok  |
     |      xtensa: |  ok  |
     -----------------------
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 713a69fcd697..75c05d348c01 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -17,7 +17,7 @@
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |       nios2: | TODO |
-    |    openrisc: | TODO |
+    |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 4d4bfac52970..d6100b226de5 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -18,7 +18,7 @@
     |        mips: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
-- 
2.51.0


