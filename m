Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CFE606A33B
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hCJjZ8WQ;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=C5lubwUk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dm2MSBUe0Lqirr4f3WaPmjkvm/rJxHWSyjN9mI+8azg=; b=hCJjZ8WQ6CtSIP
	JZUxfHqdqZHsxreSREaI7/Oj4x18JqazAvZwwX7M5sL9pE/P/FW6HXGLrH+qQcoJk4oU/fdAsOeTo
	rgOm9Fpa2dnqyFppjMFZ1FSszaB3DMthkgSsognpmZQ2LsCxL07AAaXvGqwxYKfs4OdE7N8jKN/qJ
	NW7fpMjjxr03e48kjjodbpc2KF9zb8rCPIicPH8ptQqRVF9PS/N7QZCb71RP97IRqntVwJwhiiiQo
	YCtlfpc4IhI3w6iEMBbMdP4/I7XAOSjCMfIRtiERcq7KPxZAI4HLFD4xOZDuBI+ZYOm2DhlpZx/hE
	4dcXyUT1UTsTCPXPcQ0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU27F-0000000C1MO-1hq1;
	Thu, 19 Nov 2026 13:23:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU27B-0000000C1Iw-2FsD
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dm2MSBUe0Lqirr4f3WaPmjkvm/rJxHWSyjN9mI+8azg=;
	t=1795094629; x=1796304229; b=C5lubwUkfqthGtrFReQDNz7lLE0tH+g7y5gNVUpxRUiO3CK
	8eYHTcuvipj1PdN+Bdzb131EpIPFeCjCg93NlSULleeoLOdYSeW3tVRLINAmL6Us74LipyiqiSE3T
	JJlE+McsrqixHSONWGu154IjoBdySlWOUqPw+zMZzTdGHeo82sXNNJpYhseUSCvMHe8Ko0o1xu/mx
	z9y38q+6O5jOsc+vbnaLqDgTgXTuod32Ex8FNKCMhMIajqO8JuFNXRg6F8ouHw1W0htD7UHRFnsnO
	JN8f679yjmqifZs2TKMaUJcFqIQ9zNprimoszycf2sahMxgCiGCMFzGs5S0PnzHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU277-00000004LIl-2NOP;
	Thu, 19 Nov 2026 14:23:45 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 2/3] random: do not include utsname in early random
Date: Thu, 19 Nov 2026 14:19:13 +0100
Message-ID: <20261119142340.e6bb6d0f1205.I61c6041598778a92b9afaccdca2ba4a3803f4e6b@changeid>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119132340.225696-5-johannes@sipsolutions.net>
References: <20261119132340.225696-5-johannes@sipsolutions.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052349_632959_83646520 
X-CRM114-Status: GOOD (  10.46  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Benjamin Berg <benjamin.berg@intel.com>

The uts name includes information about the compile time and such and
changes. Exclude it, so that different kernel compilations will see
the same random numbers.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b4da1fb976c1..64d0cfc99ac4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -877,7 +877,7 @@ void __init random_init_early(const char *command_line)
 		++i;
 	}
 
-	_mix_pool_bytes(init_utsname(), sizeof(*(init_utsname())));
+	/* _mix_pool_bytes(init_utsname(), sizeof(*(init_utsname()))); */
 	_mix_pool_bytes(command_line, strlen(command_line));
 
 	/* Reseed if already seeded by earlier phases. */
-- 
2.56.1


