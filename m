Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8081606A335
	for <linux-um@archiver.kernel.org>; Fri, 20 Nov 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HrnO7YdR;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=csSR+LuY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=MumwmMlz/ycOY2rwiIV/TfXn6r1Kli3xnRKcL14uXZw=; b=HrnO7YdRUE2b8ABVvyJzaYHyeb
	uWOUAE/9iRRhgMtt05NK9oTym2r/9XiR5Nuv5RTdtAx6x0iNpv8dwz5U7qY9IXnDpUT1dwKLfXc9Z
	YtsLxlee2c8tKS1he8cOP9XakbcMUGVjKZqOH/J+TEb+czo3vD24FLrJYyj+u0wl2OQ3ELzhuIrgk
	2j/fDJXuzzrZ4kFQVSUJSloWG5RMosqVPYhaBZdpTF6geyFa4/SQmJd9draBckREl3bfp2yzCWrsC
	gDWvwq8h5DJ1H/22yTspdK8gFRXWk8Ejt5ilGIpmhccFRNYgT6JqSP+p1If69QRZPMzwDgGGOtYBn
	Qq24xdlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSrc-0000000FpmB-0co7;
	Fri, 20 Nov 2026 17:57:32 +0000
Received: from mout-p-101.mailbox.org ([2001:67c:2050:0:465::101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSqW-0000000FpMh-13KZ
	for linux-um@lists.infradead.org;
	Fri, 20 Nov 2026 17:56:37 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jWNLQ6gSCz8vRp;
	Fri, 20 Nov 2026 18:56:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795197374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MumwmMlz/ycOY2rwiIV/TfXn6r1Kli3xnRKcL14uXZw=;
	b=csSR+LuYSK5l1G5b9hx8zrzBFhbqYELUpyuZRFDEYRfu69tadAP917oKWnPe66odFOl9Vg
	YrN8f3cz7g5XD092IbZ9FJvOV/PhZOfjBTIdiMCNSvuVt7SnSAjtH5XZekLavEhfFtXgyd
	m8DA5VqkvyIHf7lm0itS1WA/MHkuIbiIQ6C/3IJKnMBPXD/TBzZGkESiKTRnWCSLDEsSyO
	/51MvPlFF3nvOIM3CN1jmTzRfqyBUReZEzBABllwFZg1YkOBZ4tDbZvvzGR7GHWYeZfQLy
	5qDa+IZjKskDKszUNeF4Juxc7VfT2uv8lBiOeo3y8/yXz/ooWIKIK2m/t0nvSA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	linux-um@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: UML: user_mode_linux_howto_v2: Fix bracket
Date: Fri, 20 Nov 2026 18:55:09 +0100
Message-ID: <20261120175509.1369714-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ea02f5196a9d0790d6d
X-MBO-RS-META: 594ua1nrxhfo8sfmwnxhfdtgipnfdeam
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_095624_582826_AF7F1899 
X-CRM114-Status: UNSURE (   9.39  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add missing ')'.

CC: Renzo Davoli <renzo@cs.unibo.it>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
[v2]
 Correct position of closing bracket (Randy Dunlap)

[v1]
 https://lore.kernel.org/all/20260909140051.1365758-2-manuelebnerli@mailbox.org/
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 9224bea5ee..e4b1cb1092 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -581,7 +581,7 @@ https://github.com/virtualsquare/sshlirp
 
 connect to a local area cloud (all the UML nodes using the same
 multicast address running on hosts in the same multicast domain (LAN)
-will be automagically connected together to a virtual LAN.
+will be automagically connected together to a virtual LAN.)
 
 ***********
 Running UML
-- 
2.56.0


