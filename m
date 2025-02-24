Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3771FC19F2E
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYewY3rxu4BGkKIObNxRv2IUCm6u0EHYyXC3shucqCE=; b=LcLtNqK5k08XDGt5gB+ZeiOIVr
	DXQPfIVDoxsOwRHvwbCm2B+QlI1lOco3q06xknkW1OHfjwEfmUng5vZC7ExisXNPytNHzOspeLCsd
	RgSZzlq+MW6o38sh0Tsvas+9UDNE8zJ3eiMthT9eN/IXxUCubSR49fw10yiJsueb0KCwp75FnzW4o
	RGEfNOsnIxz4iidtwfgbSVd0bYiuRbxk4LqhQ/k07Szm74a3g0TRQjeZN0IDpH1K+zQsHy3mEK3kV
	wMTTy3dIAhVXy+2199xKUdFcLVxO0eA5VCyLOSq/hGDRbdgKeFX5KqTxMZIpH9dZn5OLizJAURyWL
	+rf2Bf4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd8S-0000000EnP8-3teZ;
	Mon, 24 Feb 2025 18:24:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd31-0000000EmCg-2cm4
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 18:19:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HYewY3rxu4BGkKIObNxRv2IUCm6u0EHYyXC3shucqCE=;
	t=1740421159; x=1741630759; b=p7G3GZi/P4fYBjR8c9jZNLmS9bdgwDMxaSLMYgjlTohgFd/
	D5bOrn0COTeB6c43mZVyLj13YPddQc2RZqaLxiIAoQXfuPmSlI5tsLb00a/3mjpV3/weHHnMK5zTH
	zAd5KqQ/BnHTJk8dgXHJumEb/PROuQVILMKJu+rbWxGFnFqYo1iZx7d4pC3Ehxz7HFdZqPTta6FT3
	NXNWKUZvU27Ame3DYWtYl1dVHMo2hMCNeQT59DHqqNAk8RIYs69azQJ3XF8+6MszwQOVHQo1ZNxF2
	Y55GyepTAneCCd06ASUQDAm3ZbGPHf0LimtQujxPVd1hyv0tZ0MO3qaKsy5b5p5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tmd2w-00000008tWp-1HKq;
	Mon, 24 Feb 2025 19:19:14 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 9/9] um: Add UML_SECCOMP configuration option
Date: Mon, 24 Feb 2025 19:18:27 +0100
Message-ID: <20250224181827.647129-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224181827.647129-1-benjamin@sipsolutions.net>
References: <20250224181827.647129-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_101919_669457_2F00A29E 
X-CRM114-Status: GOOD (  10.03  )
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

Add the UML_SECCOMP configuration options.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>

---
v1:
- Move to the end

RFCv2:
- Remove "default n"
---
 arch/um/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 18051b1cfce0..11ed4422593c 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -258,6 +258,25 @@ config KASAN_SHADOW_OFFSET
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
2.48.1


