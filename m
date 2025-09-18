Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22990CAC597
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKlVdGR3DDGWOcc4/nfzMKG19h1bO7GYSLtWMup+EQg=; b=Px3dM2aUvAXCg/19u2PGvzQoZ2
	4/bxs6HCntVrC5QViysPruem0sR0EApO9byAYQSa4E9GmxvC0RDwV++7FIZriHVTSmF3kJLzN5jpx
	Vqifqn49eVWGb13w5nJV4Zmvn46YqVuCp2pixXnuLgMXNuJqPcfDIyDwTJi9iQXEioSX0nKfTmVZv
	SmF0l4t0nqIghUdsZzKuL4ixNKrPJI3QqF1N13cZId+ysEGWuVuFPjGWcFCW2GAMHuROdHPMHdHdf
	Xrw6mk1btbYjNM/oSWx43l1AD6noAUqV2u16k3P1J3SvBTZWN1avqaICVvK88XwSpescDJ9ZJgWaS
	Qs9W+23g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70d-0000000GIEQ-1v0x;
	Thu, 18 Sep 2025 05:16:45 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70Y-0000000GIAD-0E4C
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:40 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-b5500891f00so237264a12.0
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172597; x=1758777397; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKlVdGR3DDGWOcc4/nfzMKG19h1bO7GYSLtWMup+EQg=;
        b=WdVZ39n06nFSh9a2k3UoOUXQXE3Uvwsi/fkUIQjx6/rorPGVQKHtEvsCy6Pl+RqzMP
         6BvaR3CB1lfVMLoKz0MeVvkfiXRKx8YoLchw6h1EvnPCKpR6IY7mNCZTmbUci2OazoS0
         9pg0aJnK5PA4IyxesNwu+idE0tftNfpLqjezYLvjUJRYAf4G0wsGCBjnhzSQWh+KF10z
         ENjASQBy4UrADN9gP985aQ/aJj0yhLhT+0C+4+KKlKgxXHlt2xZsj57YmcWpXLgbBxTR
         U9HDTBhBfNQR3xWQRRo/XDYIzV/sDDz7De3Vr09Y9uyY7uJ/gEZNT09jq3jfyCGMfmlt
         cGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172597; x=1758777397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKlVdGR3DDGWOcc4/nfzMKG19h1bO7GYSLtWMup+EQg=;
        b=mJP5f5mZdXrJP4mVErwdxjxUZSRt5Fsp32Mx8/xBUcoYxTn2w8gRY7LYhCnxJlVjdm
         jOa/IdRGkjUHK07BiM4mbS65e5QMWKMRe8B6FR2j2hNcA8V0tdVUk+ALFvGTVWF0lB3d
         snC9VSqI9tLtemuRlC9tWwoD45Q9J9iG4t0Q7QPPzLrM//NL1q1I5EE5y9gxWAJGYpO/
         7EKxj/16cAPWNpvMmBI+SHC/DcSbdJKXyzwQLB0rlIv/3+B3DazxRdn69QpCHwssTtVz
         gd1HMySXqGSOeuKTJKmAITog3oMbVtSwIUMaRFE+ypgUdJszYTBm7xnkR6CNvdrKjVbF
         TEEg==
X-Gm-Message-State: AOJu0YzuFmnOA8WmSiZ2noZYkhWu06gR9rY4tkHM35SJpocwTQdr8xCJ
	G3x3tj1+p7WNsdCOS/gWlxWx+6cZIjmtN/KYD2ou/jiZka2p1DFfoMZd
X-Gm-Gg: ASbGncvui2w0gbpTDJjchgBEqYNqWuTwZUzQkeAqAq36/LiWU5PJhjx9Bpnq3xRjG9o
	83bMaGu9B+U62WY3MHLioMi/cLf6Jx3T1z5Y7+ZPYCBcaf2YR3nMnZZrwR0OPHGVQeSBNl67pX4
	Sg2hPG1W5Rk+ir+7qzH0pq9n9M3kacvnbpVEDeizC68850FKAPx8mO3PjUW+0C6wCpRBW07zoJT
	mFIdfTBHakgDuXRvIdSAg/ES7XdX+pqNu2YIj6C9OPx9jynyOiimaRXJs7VPV7GeXAJoozVh7no
	YVO4KFLCMxduOVIVe62eHqCGJ+qTYkNfqvDpIxLI8fvv1IK6xS+5g4nxxakc0/7UAwNW+614iqc
	BqhCurHV+JgOKAIaDhJV430axt+YwUKAU712oFLAB/xTlL62adD3KmSZTNKyU5F1AhHWUXneacn
	amyN1Y02JGAP4=
X-Google-Smtp-Source: AGHT+IGCbT607NrmgHz5Q3KgCNRtitF2Ip3ekkLRwWL5RuIU+yeUgrW6R7+caKPoVbPB2OrdzbDjGQ==
X-Received: by 2002:a17:902:d2c5:b0:269:9a71:dc71 with SMTP id d9443c01a7336-2699a71ded8mr3010715ad.16.1758172597074;
        Wed, 17 Sep 2025 22:16:37 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016d9d5sm12830035ad.53.2025.09.17.22.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:36 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 734B71061EEC; Thu, 18 Sep 2025 14:16:34 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 06/14] fixup seccomp
Date: Thu, 18 Sep 2025 14:15:59 +0900
Message-ID: <6adb6305c2c84d715d37642ee9cd4f5a28719979.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221638_425896_80D4DF0B 
X-CRM114-Status: UNSURE (   8.16  )
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

---
 arch/um/nommu/os-Linux/Makefile        | 2 +-
 arch/um/{ => nommu}/os-Linux/seccomp.c | 0
 arch/um/os-Linux/Makefile              | 5 -----
 3 files changed, 1 insertion(+), 6 deletions(-)
 rename arch/um/{ => nommu}/os-Linux/seccomp.c (100%)

diff --git a/arch/um/nommu/os-Linux/Makefile b/arch/um/nommu/os-Linux/Makefile
index 68833c576437..805e26ccf63b 100644
--- a/arch/um/nommu/os-Linux/Makefile
+++ b/arch/um/nommu/os-Linux/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := signal.o
+obj-y := seccomp.o signal.o
 USER_OBJS := $(obj-y)
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/seccomp.c b/arch/um/nommu/os-Linux/seccomp.c
similarity index 100%
rename from arch/um/os-Linux/seccomp.c
rename to arch/um/nommu/os-Linux/seccomp.c
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 432476a4239a..c048fc838068 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -21,9 +21,4 @@ USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
 	tty.o umid.o util.o
 
-ifneq ($(CONFIG_MMU),y)
-obj-y += seccomp.o
-USER_OBJS += seccomp.o
-endif
-
 include $(srctree)/arch/um/scripts/Makefile.rules
-- 
2.43.0


