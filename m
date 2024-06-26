Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193AAC27C4F
	for <linux-um@archiver.kernel.org>; Wed, 26 Jun 2024 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wKszcfZnyJ3b41gidimRUVTrQ8M1RySn6kxZcpbVkFc=; b=GjJ45hyGtE9fv4KDWjSfm/V8go
	T6InTWhwL6NvKe/agZAMHTyIXRR+PJXIHbYJjsgaW3cQD6b9DQ8rkcaL8QLQRTmxqAhsOWGBxwt1k
	Ob3iPO6J00cmxbr86YHI4FjDisr4UpHveKKXuYJ8ovvcv73WJGM97nI5tXGRjoE8YI3Dd3yD12lLn
	A8gMV8kSA9aAS5f5FjyqQJ1MdkKVX6kXVQPU0c49z0nPQw5hmBfd3fsklKd5Sh16jj9OE6REf2LMq
	aIMtVrdqRTWvrlj1GOhJmYvtCNXuObQ3szhLEFoNg/Y02exHZIMjVg3hi1uYi2rp5Pa377HY88k1i
	5MOuR81A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT8B-000000074hp-2dCv;
	Wed, 26 Jun 2024 13:56:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT83-000000074dy-2OHC
	for linux-um@lists.infradead.org;
	Wed, 26 Jun 2024 13:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wKszcfZnyJ3b41gidimRUVTrQ8M1RySn6kxZcpbVkFc=;
	t=1719410167; x=1720619767; b=HOcfUxr08/LV5QGvlWvFcpAipk4XrQLWc4y9jX0tSCzTBcv
	P5OyoUQeMPbf++pQ7pp6YR6Z4a+6SaHTBL1dyGoPik27ksGj6MjpH0uy+azOrBY+WdVIakKoGlu3p
	pGnXmMAyaS0t4nSKsCByOyXYxJL/v+UWRKcvVxxgFhZOXqktQZr9kAX3zShnnWqhnjIhFe8gUvQCQ
	i7WTNGLcVwObT8HNFa2mCBqUotiJm7O38sLB8T/6MyqjW0tTqilpAPs6PqYwzXjZb+fWp5XyD+vOq
	xJ/TvkWMoGTfJ8ANLytHVCP3MmYKoo4D9tmEpEYPYv2CrcrfwpW26JCw0rS4mwqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sMT81-00000003rXd-0KXG;
	Wed, 26 Jun 2024 15:56:05 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v6 4/7] um: Fix stub_start address calculation
Date: Wed, 26 Jun 2024 15:53:47 +0200
Message-ID: <20240626135350.493110-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626135350.493110-1-benjamin@sipsolutions.net>
References: <20240626135350.493110-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_065607_631613_6215C83C 
X-CRM114-Status: UNSURE (   9.48  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The calculation was wrong as it only subtracted one and then rounded
down for alignment. However, this is incorrect if host_task_size is not
already aligned.

This probably worked fine because on 64 bit the host_task_size is bigger
than returned by os_get_top_address.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/um_arch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e95f805e5004..0d8b1a73cd5b 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -331,7 +331,8 @@ int __init linux_main(int argc, char **argv)
 	/* reserve a few pages for the stubs (taking care of data alignment) */
 	/* align the data portion */
 	BUILD_BUG_ON(!is_power_of_2(STUB_DATA_PAGES));
-	stub_start = (host_task_size - 1) & ~(STUB_DATA_PAGES * PAGE_SIZE - 1);
+	stub_start = (host_task_size - STUB_DATA_PAGES * PAGE_SIZE) &
+		     ~(STUB_DATA_PAGES * PAGE_SIZE - 1);
 	/* another page for the code portion */
 	stub_start -= PAGE_SIZE;
 	host_task_size = stub_start;
-- 
2.45.2


