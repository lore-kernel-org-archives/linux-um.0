Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762F4C001E0
	for <linux-um@archiver.kernel.org>; Wed,  9 Aug 2023 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qvN6crKNmqc/An+ebBO2+DDsHbSydjb3fNbQpUOxrIY=; b=33Y
	qb5sfwEHBlkzPbar1U1jCo9b6MBHWMlFGNpMwiRawPbAPq2hKEoYm3UrJUiFstNZhL3gQ9gCF4mZM
	wLHQGguJFx0nM8UuG/fe5pN9AeYLQHKYlQeDUiqdoz5xo10bcxGqYkO17gE0RLo1yzm8rS+jDnN+m
	YrqqNlUhAVI5VzgKH/OSRFbu7/+rNVrzMzRyhjZPQKw7TDfAyg/feEUVsrYDJeA4jDDz695Vo5p25
	9TDjSHbt0yDjSXoczbgqM7x5mDUqNDdQTm5LgoA/Fx9NabDULgn49xb56Ev62iAJBZSsNnEfslPFX
	SR8rMTbRBOoY/ODk+QhZJBM0IaZ37KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTnma-005bkv-3A;
	Wed, 09 Aug 2023 18:19:44 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTnmX-005bkI-2X
	for linux-um@lists.infradead.org;
	Wed, 09 Aug 2023 18:19:43 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840614b13cso1670467b3.0
        for <linux-um@lists.infradead.org>; Wed, 09 Aug 2023 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691605178; x=1692209978;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r9+IWZmGOXJH6TQW7TrBTS32AvWqt6FCCDY8aKxFBjc=;
        b=RH6NAR3HPdnAujcthLTNkfqMgMO/gZFXu3pAy247EtYZv7AEyeT6rW7a3dF7bt4t1K
         Ns5gMTpuaZ0NzSKHwUP9D7wle6yt6iTpcCM8L0rXvYhcYC5qEocjnXhwI5qb4Aj+iJWl
         j526OvzmzAb83YAkRWDy3Av3Fjt7vzl0O1W+Id2YO/7AUktjkzoS6ThAMaOvvFAFArSz
         xbQ+kkaEGA49j8RS/1N2dEIzJ9m1nBTYKNo+S0/WE5oIbaCSG3iSPyI/q/H38rPT0hjF
         l/iS9ZIzREp9evcoCEAAlfNbISIIW6lKjFv+SAEYcAEpNfWoZ6TMyo6HwgV/MKdhqR9z
         vjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691605178; x=1692209978;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9+IWZmGOXJH6TQW7TrBTS32AvWqt6FCCDY8aKxFBjc=;
        b=kS60wJp9imJIRKLo39wO11wv6wJroZmp6Fl93KLT/nB2UVzAT1ReNLWp6Ih00amQzw
         f8XX183v+LZj7+jdfj2wwZSTkmhuTcLfHWXxjrZ2dQN/xYhV5iM86C0UnneQPkr8jxZU
         nCaPDzVN4RTJgxvoowxc+Fd4phmDIGrPnNbcnDCH54bfxExm+lsYTz8HgasdSB8RyUCX
         VIWfTQ9Ud1tSz5sE36EfLCc24kqeWMgzKE79wewm+N+UcO6KAvI48PramQ1rotnG9oS9
         0gSh1tSfdDwW+mcJ6hWab3GKMlsQQ8nv0hJxHGpVg36K8bRKMKI4u1zqK3A3enXMigi7
         tsxg==
X-Gm-Message-State: AOJu0YxLP3BKmwDYWw6cK/imdm6H4h++5/A3BofUjJJ1CEx47Gdd9Z8L
	L/3fryeQLzcACwgZzbu8yN/T1It2Q3+PrkNDGw==
X-Google-Smtp-Source: AGHT+IHnpy+/J/C+D4Q4JPgAzwlXMTPI+h6CwminUuHwP+Cql0xghqh2RomkGyS/8mpup5ykvjSMYLYD4xsftvGlAw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:70a:b0:586:e2b5:f364 with
 SMTP id bs10-20020a05690c070a00b00586e2b5f364mr4614ywb.4.1691605178129; Wed,
 09 Aug 2023 11:19:38 -0700 (PDT)
Date: Wed, 09 Aug 2023 18:19:32 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALPY02QC/2WMyw6CMBQFf4XctTV9AC2u/A/jgpZbaCKUtNpoC
 P9uYaPG5ZycmQUiBocRTsUCAZOLzk8ZxKEAM7RTj8R1mYFTLqiikrTBDOQxEoGWlyUTJZcI+T0
 HtO65ly7XzIOLdx9eezixbf1vJEYYUXWntdVVI2lz7r3vb3g0foQtkvi3qD4iz2JlNcoaW6sq8 SOu6/oGENOyE9gAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691605177; l=2213;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=23IC5Bw+8KkKs09S0EaJWss3x1p4d4hD+7BkZ/ap4cg=; b=gfF6LynUr5OZNkVjBs6fVzSf9HY8BE2EsZGdMISI5wxTkkPFSBAPa8s8UwSGy9Awn7YZsIbB+
 XjEWts8XjrNAywzyWQ+e03kVuL94vwtZkqCoKKelbu2jA/dn9CwrB1e
X-Mailer: b4 0.12.3
Message-ID: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
Subject: [PATCH v3] um: refactor deprecated strncpy to memcpy
From: Justin Stitt <justinstitt@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-hardening@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_111941_824682_697C9B15 
X-CRM114-Status: GOOD (  12.24  )
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

Use `memcpy` since `console_buf` is not expected to be NUL-terminated
and it more accurately describes what is happening with the buffers
`console_buf` and `string` as per Kees' analysis [1].

Also mark char buffer as `__nonstring` as per Kees' suggestion [2].

This change now makes it more clear what this code does and that
`console_buf` is not expected to be NUL-terminated.

Link: https://lore.kernel.org/all/202308081708.D5ADC80F@keescook/ [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
Cc: linux-hardening@vger.kernel.org
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- Swap `strtomem` to `memcpy` (thanks Kees)
- Link to v2: https://lore.kernel.org/r/20230808-arch-um-v2-1-5fbe76eaf853@google.com

Changes in v2:
- Keep usage of ARRAY_SIZE (thanks Bill)
- Remove unnecessary import (thanks Kees and Bill)
- Link to v1: https://lore.kernel.org/r/20230807-arch-um-v1-1-86dbbfb59709@google.com
---
Notes:
I only build tested this patch.
---
 arch/um/drivers/mconsole_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 5026e7b9adfe..ff4bda95b9c7 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -554,7 +554,7 @@ struct mconsole_output {
 
 static DEFINE_SPINLOCK(client_lock);
 static LIST_HEAD(clients);
-static char console_buf[MCONSOLE_MAX_DATA];
+static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
 
 static void console_write(struct console *console, const char *string,
 			  unsigned int len)
@@ -567,7 +567,7 @@ static void console_write(struct console *console, const char *string,
 
 	while (len > 0) {
 		n = min((size_t) len, ARRAY_SIZE(console_buf));
-		strncpy(console_buf, string, n);
+		memcpy(console_buf, string, n);
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
