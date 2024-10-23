Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17493CF5390
	for <linux-um@archiver.kernel.org>; Wed, 23 Oct 2024 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vubM6DJPWQDpiFuI+UVsMpSx6yTb88l0CA17X1Tud18=; b=yo2ObRTZIM99zBrrWT9LrmzCNw
	HVKOV6weIdC6Bs+cZmpmSwztv8KKatNQ8xbWCPiEqIpXgpP+D/aNbFa3KoTgPrTJYxTyQ2Ai2Q73H
	NjafLoEoYctwsnjZXi1AI5tMGHilC74cKQU62DwZ2okPCfVIIRKfGbOWL1VyGua+UOypa8GnYD7tk
	IivLf1r7WhUcHu/X3LMMVKwn4Bv3FkLH06jP5dOKBzNsPZwiCLK1D1jPhecJNPLhgymllAkoDiuvm
	UUOZxaQcvrvbu69vhh48fEUD0y31fHUVF5ixvxnBVMwZyXYxOfD88A8mhIw6YuEQsvQXeoLw/5vRC
	cSZK3gFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3c38-0000000EeIt-3NoL;
	Wed, 23 Oct 2024 14:09:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3c35-0000000EeHB-12wm
	for linux-um@lists.infradead.org;
	Wed, 23 Oct 2024 14:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vubM6DJPWQDpiFuI+UVsMpSx6yTb88l0CA17X1Tud18=;
	t=1729692559; x=1730902159; b=wHMLpvRqTuf1So/rRSoNqUz6w7Er4IRq7teh230fu9NJgtl
	akJb9IofIBc7qsZPLuOwKEL+gurbm/uYr4Y2sZfFSuQifBtHeGihQtNte7xMtO0ciA/Rs3/GxSvgd
	H2J05WNbaW1919azRxlvtId97bqlgQ93aUMr8ldkhgXu51r83H9ujZWreCjOYWGFtajDtM1pwqosF
	jJ9tFNv80TiNSh2iB/IQ7mnhRwzlrwnOLvCe9DxtSzTRhG6dVVoew/mUAhGznAZste/Jq/0FM2g98
	Yko2yRNiyRt9naIYDWleRuyuamXhw7MstPKGLM/moDozgGknBtHwW3cn2jnG/VCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t3c32-00000002hDF-1Mnu;
	Wed, 23 Oct 2024 16:09:16 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [RFC PATCH v2 3/9] um: Add UML_SECCOMP configuration option
Date: Wed, 23 Oct 2024 16:08:21 +0200
Message-ID: <20241023140827.136550-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023140827.136550-1-benjamin@sipsolutions.net>
References: <20241023140827.136550-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_070919_308888_490D387C 
X-CRM114-Status: GOOD (  10.15  )
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

Add the UML_SECCOMP configuration options. The next commits will add the
support itself in smaller chunks.

Only x86_64 will be supported for now.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>

---

RFCv2:
- Remove "default n"
---
 arch/um/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index a9876bdb5bf9..7ec0e98493fa 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -257,6 +257,25 @@ config KASAN_SHADOW_OFFSET
 	  set to a large value. On low-memory systems, try 0x7fff8000, as it fits
 	  into the immediate of most instructions, improving performance.
 
+config UML_SECCOMP
+	bool "SECCOMP based userspace"
+	help
+	  With SECCOMP userspace processes work collaboratively with the kernel
+	  instead of being traced using ptrace. All syscalls from the application
+	  are caught and redirected using a signal. This signal handler in turn
+	  is permitted to do the selected set of syscalls to communicate with
+	  the UML kernel and do the required memory management.
+
+	  This method is overall faster than the ptrace based userspace,
+	  primarily because it reduces the number of context switches for
+	  (minor) page faults.
+	  However, the SECCOMP filter is not (yet) restrictive enough to prevent
+	  userspace from reading and writing all physical memory. Userspace
+	  processes could also trick the stub into disabling SIGALRM which
+	  prevents it from being interrupted for scheduling purposes.
+
+	  If in doubt say N, as the feature has security implications.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
-- 
2.47.0


