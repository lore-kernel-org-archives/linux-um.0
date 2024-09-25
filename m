Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DADCCCF9EE
	for <linux-um@archiver.kernel.org>; Wed, 25 Sep 2024 20:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=798Pe4y9UugDN+QU72wAGbH3wNvKyUq///x3VuY4CI4=; b=bJnRBLTKYRl98i/m+vMLjYVnwa
	/hEX90uwVaXrIj3P+BvlmElni0pve/oJhWHy1TzsCF9Vyd3fy5D16stVI5VDJwdJXJBOE9xmLgzot
	rm876vlIID7nru0CmRDA0OZn1F02RK4HqECh5C9j/sSpN5JIhRdRN9FwkPkZzbd6uts5rhu99mWJE
	611HTLBOF2nfoMKO31EZP9Ce5BqN2r1XXgvnGoX/EFi3F0QIyt6Npi0Ju/4gfjt+7K5DxDRbgaoQu
	54bMydc1RjedCU4ynpmhBBtbkLHrdAupPLrdBw+Na0lqZZZ6L7G4lz/AmT2e6/vd4uzKZMQVyKvD6
	NN7zhFtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stYgy-00000006V0o-0QN7;
	Wed, 25 Sep 2024 20:32:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stYgw-00000006Uzv-0V6d
	for linux-um@lists.infradead.org;
	Wed, 25 Sep 2024 20:32:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=798Pe4y9UugDN+QU72wAGbH3wNvKyUq///x3VuY4CI4=;
	t=1727296373; x=1728505973; b=Q4eNAjnpMxsjWwdijqo3waXWGsNjGvGv2iYkIa6RvKV7VVU
	o+bkLn1BV1UhVTJfCvpoOaS6S07OEyiEZo6Lu6fHhCTW5jbpLuSS+JpHZ11AjNpmbZTJ1DRcmPo4Y
	f6HRojsP1wm8wXYScXG/3U5tUlbGW559OqEiXp7BlYzOHOFWo05RNx+LRx+p2KgQnY84vTLYq5EW2
	XnWp/t+3rdRpRTDho9d9MkRcXKnhRYd6w6Jc2K0AC99NIG5TnW3BDwMQh/eIWNyv/jmce8VVnad1I
	lVk2fUFNRDt6C/boO+yTOAyI65yItJzKgKNDnCkL+uqTAsVdEpCKaRMp7S8J+lyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1stYgr-00000001A19-1gtv;
	Wed, 25 Sep 2024 22:32:49 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 3/9] um: Add UML_SECCOMP configuration option
Date: Wed, 25 Sep 2024 22:32:26 +0200
Message-ID: <20240925203232.565086-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925203232.565086-1-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_133254_180704_6CA2827E 
X-CRM114-Status: GOOD (  10.56  )
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
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 48db1c99bd46..4698e4c8ef29 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -240,6 +240,26 @@ config KASAN_SHADOW_OFFSET
 	  set to a large value. On low-memory systems, try 0x7fff8000, as it fits
 	  into the immediate of most instructions, improving performance.
 
+config UML_SECCOMP
+	bool "SECCOMP based userspace"
+	default n
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
2.46.1


