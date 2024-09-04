Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E81CD3431
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YEl6UcNWySWixJDtk3OBM+nYtD0bKQYmS/w9a5H5Rf8=; b=NlXmiFwsQA9P07QkJ5hvLBocpA
	CxPfMn+XqrljIKPQGwG5JxuQNTWIgvKGdTJTWVVkHBEqlmkiM/YhkV8iJ7fUh/stgl6lu1i0Lh7SS
	Qu+7CZiKHPqegEDl4AuJBO8vxLgeQvYVySzCbM8LCkXqaiai9k61QNYqIDZzw80N/NYzdkG5KXG1Q
	3GL+j3WqWnB9uYkqWOzyuSfsWgKYrH9HQYvzi2J1d13QPQC24d8QSaDk3OdbxLEUsNP7ljQy4i6p7
	+9S+fpLWh15gxDnsFmNLs5KPnpcFlaNLVn0f9xOJMMhTkybZeUbAiVfrkR0TkB7MeWqwPBgRH/id1
	+yNMA6dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slqQz-00000004dZH-0Gn4;
	Wed, 04 Sep 2024 13:52:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slqQv-00000004dYs-13ww
	for linux-um@lists.infradead.org;
	Wed, 04 Sep 2024 13:52:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725457947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YEl6UcNWySWixJDtk3OBM+nYtD0bKQYmS/w9a5H5Rf8=;
	b=XPfefdYHl1U98mDn7ERCrYafqG+AH2K2hTEn3YsmZjZeWXl1u+2DB3hjCvHBpO8b2dQyKO
	OSDRDDUHvFSI147JvvMsAenwaKwTJJ2cbHdRnyuxicWd8fboWkylJ/0/cFmOoutd/z5bM5
	Lh78XbAnvfFKWuxvgHqy1a/opbS+7uo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-e_9B40lyMieiF8Az2Ti6rw-1; Wed,
 04 Sep 2024 09:50:45 -0400
X-MC-Unique: e_9B40lyMieiF8Az2Ti6rw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E44A1953945;
	Wed,  4 Sep 2024 13:50:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.194.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A77E300019A;
	Wed,  4 Sep 2024 13:50:37 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] um: kunit: resolve missing prototypes warning
Date: Wed,  4 Sep 2024 15:50:19 +0200
Message-ID: <20240904135019.200756-1-gmonaco@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_065229_608906_181C0866 
X-CRM114-Status: GOOD (  12.01  )
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

While building for KUnit with default settings, the build is generating
the following compilation warnings.

```
$ make ARCH=um O=.kunit --jobs=16
../lib/iomap.c:156:5: warning: no previous prototype for
‘ioread64_lo_hi’ [-Wmissing-prototypes]
  156 | u64 ioread64_lo_hi(const void __iomem *addr)
      |     ^~~~~~~~~~~~~~
[...]
```

The warning happens because the prototypes are defined in
`asm-generic/iomap.h` only when `readq` and `writeq` are defined.
For UM, those function get some default definitions but are currently
defined _after_ the prototypes for `ioread64*`/`iowrite64*` functions.
Moving the inclusion of `asm-generic/iomap.h` fixes it.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/asm-generic/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..0b02c8e38f20 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -13,10 +13,6 @@
 #include <linux/types.h>
 #include <linux/instruction_pointer.h>
 
-#ifdef CONFIG_GENERIC_IOMAP
-#include <asm-generic/iomap.h>
-#endif
-
 #include <asm/mmiowb.h>
 #include <asm-generic/pci_iomap.h>
 
@@ -295,6 +291,10 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 #endif
 #endif /* CONFIG_64BIT */
 
+#ifdef CONFIG_GENERIC_IOMAP
+#include <asm-generic/iomap.h>
+#endif
+
 /*
  * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
  * are not guaranteed to provide ordering against spinlocks or memory

base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
-- 
2.46.0


