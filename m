Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E02FC001DE
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=MdLbN9iHirNgl9c6Cx6qhPtkBp/QpU09wLxpfJGY18s=; b=4Kd
	v+CId+L3iyszg7FUaFH3/Y8k9Phu8hsN8phge+rp1LFMKJP5Ff7kmMoi7BJ8XfEGeIqnrPyAkNz2Q
	aufGD4TasjlJZjqH2eKHPCKpiwbGOoNz9+US0C4WchVKowzDyUhPQ4CSdRGz895tb+QeyWwMvO9AJ
	Tecw5puhJm1OVFCKHKKlxDdlmW+uoZEydbAx1hOVp92mlHOBZCnZDVP+vwzQFa7lxIJr3LcwQWRp7
	t+Q5IKzoAQObN1QUlR32Dgpx/GZiuvgP4DnFUvdz84R6XU9Bs9Ji3JHLQwk7d6DW5MprPQz3rnoVx
	UgeJUGZ9vk9rI1jm+KAUq5HEvPGxufw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT7cA-000kTY-0q;
	Mon, 07 Aug 2023 21:18:10 +0000
Received: from mail-ot1-x34a.google.com ([2607:f8b0:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT7c7-000kSn-2a
	for linux-um@lists.infradead.org;
	Mon, 07 Aug 2023 21:18:09 +0000
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6bc9bb5019dso9686491a34.1
        for <linux-um@lists.infradead.org>; Mon, 07 Aug 2023 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691443085; x=1692047885;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2mfCIyPm2aO7x0iXfdEGub/+bSKhcssAHTeROw2F55I=;
        b=iXvXoonIYBdhMFviyOkoygmsJIyTGeBeq4/AOnBxytLBvQQhjalGqFzg7pCH7KQxfF
         eKRi5WxgelqBpHePErOT2Bt5zN88BKI9miy34Avnyz48BfPkNp3qp1t/NvRGeLfMSMBu
         ZKa+3pwQi71GXW9fVgOgw5fIB079W+CRsJHTp+GUGaJsCoY+4M1QuK58KCYVKIgKNQhZ
         MDzIdOWmfwnJvoSd7P4iHZp6p3yo4EwP6d7k43C+57isSu04UsZzVLz9k1QVhs9iHeMp
         JDzFnnEmAS8cBGV9g1gv2aE9flzX+CV9jCKD2QZUmxpSkE8tujbKDIBT7w8/Lgv1ixP2
         1iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443085; x=1692047885;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mfCIyPm2aO7x0iXfdEGub/+bSKhcssAHTeROw2F55I=;
        b=ItnSBQ9yFLesKNAlI8CGNEdOaVCX8+34kKA7iFxdwYyE/ZRaH8ZUD3PbGLKy6BlEPM
         bot8RyNtlUycE0E2QML0FIN/yHtuvtnqXdg1bTGP4zZ2e/IVCQkcTR/eW2Oqc5olFsJz
         s9HevI0Q105Dq0+I/LhwGPXIGyTaj7PDslGDFz6uQSG3dHbuRNeFT8o/G+t3mkCTTip7
         l28AsqChg2j1ovGoLLRLcbGvgCtM72hSml/+ORySYRKkah/eBmClvEQYF19xlnyrjGUt
         5V9mFqx/PLe1uczxtoclGOeKc+ZTinO8zw0XmBy15xTbAmrLKJZuswGoOhstgGb77E7X
         CZqg==
X-Gm-Message-State: AOJu0YwPg03oOPWK/4xxdi29dJkPaQVByPCYLxxSM5dF8zs8WdUhfB5R
	D1Jj/H9oOVKNoSFfNHqd5i0q4U1VE9Is8aeUmA==
X-Google-Smtp-Source: AGHT+IGr5rwXC6cUJHtMMxiCQlU0uuF7YpzxMjNzb/DWy220WGAU/2ZgbGEhlaruYZWPZNrBVnzaPnyS5y+0Klm1ew==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:3a0f:b0:1bf:d7b9:9960 with
 SMTP id du15-20020a0568703a0f00b001bfd7b99960mr7527734oab.2.1691443085255;
 Mon, 07 Aug 2023 14:18:05 -0700 (PDT)
Date: Mon, 07 Aug 2023 21:17:56 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAINf0WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNz3cSi5Azd0lxd49Q0IxMTQ2MTI/NUJaDqgqLUtMwKsEnRsbW1AHb 5zV9ZAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691443084; l=1886;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=29NvDKooXX0ph89b44s4wsreDRVLQpWCZn8WSLtPy8Y=; b=E9ZtbxM3R6Zqci4MF+SDmmhn3TxUgdCPU66xW4h3e6fKqBfhSZq9iL/ienwg97ORyGw56fXX+
 9sD/afEHAV+BT4wvqLe0apqEsuO1EjSbbcyG+J/cbR93lW9E0n3XX51
X-Mailer: b4 0.12.3
Message-ID: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
Subject: [PATCH] um: refactor deprecated strncpy to strtomem
From: Justin Stitt <justinstitt@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-hardening@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_141807_856739_C37259FA 
X-CRM114-Status: GOOD (  10.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Use `strtomem` here since `console_buf` is not expected to be
NUL-terminated. We should probably also just use `MCONSOLE_MAX_DATA`
instead of using `ARRAY_SIZE()` for every iteration of the loop.

Also mark char buffer as `__nonstring` as per Kees' suggestion here [1]

Finally, follow checkpatch's recommendation of using `min_t` over `min`

Link: https://github.com/KSPP/linux/issues/90 [1]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Notes:
I only build tested this patch.
---
 arch/um/drivers/mconsole_kern.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 5026e7b9adfe..fd4c024202ae 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2001 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include "linux/compiler_attributes.h"
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
@@ -554,7 +555,7 @@ struct mconsole_output {
 
 static DEFINE_SPINLOCK(client_lock);
 static LIST_HEAD(clients);
-static char console_buf[MCONSOLE_MAX_DATA];
+static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
 
 static void console_write(struct console *console, const char *string,
 			  unsigned int len)
@@ -566,8 +567,8 @@ static void console_write(struct console *console, const char *string,
 		return;
 
 	while (len > 0) {
-		n = min((size_t) len, ARRAY_SIZE(console_buf));
-		strncpy(console_buf, string, n);
+		n = min_t(size_t, len, MCONSOLE_MAX_DATA);
+		strtomem(console_buf, string);
 		string += n;
 		len -= n;
 

---
base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
change-id: 20230807-arch-um-3ef24413427e

Best regards,
--
Justin Stitt <justinstitt@google.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
