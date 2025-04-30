Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D284C3ABB7
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6E7x5VXLrqiNLDtPDv1wAnEEbwFv0sen/P7TnXEwTfw=; b=q6tHqL65rizf6n9ZKQvfJexifr
	WNG7kt104foS9jNUoArZbwcdwSUXR9ZFYYlzpoXKup1XO+i/PGl7PRedSVGzBQ2e1awWOQzLI7rn2
	yRMUkOSibFTw8HVqDaRw9DZixubxWzFD9whNTVrzReYbnCw11yHgg4IF0dS15cHU+PShgK3aH6N+P
	svMzWduBS5HUijPfIVbkLk84cvbRJwhA4KgFN7oD70UATAi4gzCgkVltRfyy0uWi81YZAIW5chADx
	udJ40H2RNVwfHIlrY4L39A4/FtKSFRYwGSEknw/ulk46pILMKLwwyN44iXp3wqwweeteLk51RvrZF
	MQnp+kWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9zW-0000000DO3S-3OcX;
	Wed, 30 Apr 2025 16:08:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9wx-0000000DNhh-2nIs
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 16:06:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6E7x5VXLrqiNLDtPDv1wAnEEbwFv0sen/P7TnXEwTfw=;
	t=1746029179; x=1747238779; b=owloo9ox8zlTakAvgBadVEQWiBIswlvY/EUoJYDj3CNkWiJ
	haMWfktjLXmqrMi4iPnavuXWv8QrEaEjy5HBncy49J72tiS+fEaJiYTWBuA4FOTWkU9OaSW7LhNV7
	j5pFbmqNg4l5hA5EmYpgEdVyhHv1pvLBgCpxLavS70XWQq6TrdgTmh8YJ5wS0UXHFAHFfDURmpu5Z
	hhJsWUtDOjW+M1Ly3/1fxXj4zS6Hq+gAToMQLjONE3VZ9unwVtWNot/1GHSCTfupxgk5vD5k+8ZlN
	nBG/o2tJM6ZlGNIjsFzUJq3AN1dSkPtedKH3PIDjR+d4hOsiyE86cXzuCIX3kdxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uA9wu-0000000DxyX-2rmm;
	Wed, 30 Apr 2025 18:06:16 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 8/8] um: Add UML_SECCOMP configuration option
Date: Wed, 30 Apr 2025 18:04:13 +0200
Message-ID: <20250430160413.3250227-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430160413.3250227-1-benjamin@sipsolutions.net>
References: <20250430160413.3250227-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_090619_712978_40060A9A 
X-CRM114-Status: GOOD (  10.26  )
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
index 79509c7f39de..f9ed39709a8a 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -259,6 +259,25 @@ config KASAN_SHADOW_OFFSET
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
2.49.0


