Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD71C001DB
	for <linux-um@archiver.kernel.org>; Tue,  8 Aug 2023 21:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=NKD5zbhAyvoyCUkvml76SIs6XngP8kLPBtANDY547lg=; b=dfI
	xnwF3n//1EKVoLxiAuImlugks0R32iw5hvOrllEGZ8dTRUL0fwshB34G2BzJurHsbXhiu3AU/6rQQ
	DJLiVR00GKIIO2SFBr51D1YZkXTTFnqmDaqeE4QmM3vGYoYGMQoqTfldXwHlQWziN10O2oL7p/sMV
	BRnI3Prgq+dWCUQVAekpHP9OzFZNkJGotIQHfZlFV4nW2d2Q9haiiLHMG9TNZOJTA509glBU9yEvP
	tXkZNqjX3vsUkCeXEgXJh4IOGuxJqdquySMBYMOaPfGL2MJvFaS7TThjNLoodcdzvg2loU0klrjR6
	QwTbzkBTgvqVFFHGlt9iMRtynAoUxQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTU5K-003Uv9-0X;
	Tue, 08 Aug 2023 21:17:46 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTU5H-003UuH-0K
	for linux-um@lists.infradead.org;
	Tue, 08 Aug 2023 21:17:44 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d437624b9c1so5142550276.0
        for <linux-um@lists.infradead.org>; Tue, 08 Aug 2023 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691529458; x=1692134258;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3FDxtd5TTI0yB6OcEaflPtTwnfjpX0FPpXrLyaUzpnI=;
        b=ym9wbg9V5cG40hCkLxqz65tC4ED2P5AeQdHne3t/UygEjzZr8/a5m8SwO/AKizXomx
         u8fEjD+U7gQowx2Dzh3O8+5wk3+PNe7gLkjAJevXZ83D5L8qAAo1cTMY/xAm2FCva8Uo
         lbE0sLMOv4JtHE0YJU0tm49XmoGTvbj9P5GejXYtzRdmdWTFMl8J4dkbFKPaogpQoiER
         4M7ck4LYlq5wCT989oZGduI+9Gx1DkTpCRIQQwzp5P3YARB34JJpq8lPHe9TEaOgr2F/
         xvcUIK3cM/5fqej6ththcBfzqr0IbuQZnZCPkRH12fbhzkri0s6VksUok8wtQMbszUG9
         vFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691529458; x=1692134258;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FDxtd5TTI0yB6OcEaflPtTwnfjpX0FPpXrLyaUzpnI=;
        b=jam2SeTv35ZJTTL6+RJ+U1UstIrIvoFIAurm0mBJf6f13DI47fF2kAyLBqGmzfWaDH
         Ccq4EkGaa+PBNOTs/ne//vLHIPDVVP2Wzf3/NphKa/8OiyifJa8O4Ai0foRE/1K8f7Yq
         oMrYi+Q7+t+Qtd3ZKPhsCMwgug17RPwA0RPDo4oAudig5oiPciX6WW3uoQeZ3yuErfd5
         KrzPOKSkB/1h+oPxwNA0P/DthGzdDk3uvAZW9Re/UjnYpYQfw/SMvB1DaC465Hd5oTbG
         Hn0LUmFS+vS92twO5p5WXm35RStHcAyuiSuLXZsmM9+6fFEKPTSERSoiuZx8WHtOjN9t
         KwWg==
X-Gm-Message-State: AOJu0YzKooD8PL2GVRC7WREfhRQlhMx2o1A/j4WtA5sP4NABYsD5UHoW
	ubwiSYSKKjr5JcYwNbbnHlJD91sYQX6fxuFlLg==
X-Google-Smtp-Source: AGHT+IHRpFBahWyCsqDq2Jymqy4KmoaI/LjbwJfXSlsnxSeNP0O276Z+TuKwYj/2pYJWPJENuDtYuJ/tH9GWqqAQXw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:e78e:0:b0:d0a:86fc:536c with SMTP
 id e136-20020a25e78e000000b00d0a86fc536cmr15189ybh.2.1691529457883; Tue, 08
 Aug 2023 14:17:37 -0700 (PDT)
Date: Tue, 08 Aug 2023 21:17:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO6w0mQC/2XMSw7CIBSF4a00dyyGl9I6ch+mg0Ivj8QWA0o0D
 XsXO3X4n5x8G2RMATNcug0SlpBDXFvwQwfGT6tDEubWwCkXtKeKTMl48lqIQMulZEJyhdDej4Q 2vHfpNrb2IT9j+uxwYb/13yiMMNKfZ62tPg2KDlcXo7vj0cQFxlrrFxsjY9GfAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691529456; l=1882;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tgWFws4763lrVU2WbDNesL8iVYR+q5vLBUC0Li+5Ak0=; b=vgzwPI9m0aHfamLtzCxThUgHXsLWmmm/NJ8qfrQFiLO/W00KK2zwHm+9PrMop2SNbVKZcF4s5
 FZtwZaG/Ic9CA3qj/qsfoXSdwko4/YOOl7N7PSyX01aDoDWnVNxCuru
X-Mailer: b4 0.12.3
Message-ID: <20230808-arch-um-v2-1-5fbe76eaf853@google.com>
Subject: [PATCH v2] um: refactor deprecated strncpy to strtomem
From: Justin Stitt <justinstitt@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-hardening@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_141743_146089_06DB1C77 
X-CRM114-Status: GOOD (  11.63  )
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

Favor a more robust and less ambiguous interface over `strncpy`.

Use `strtomem` here since `console_buf` is not expected to be
NUL-terminated.

Also mark char buffer as `__nonstring` as per Kees' suggestion here [1]

Link: https://github.com/KSPP/linux/issues/90 [1]
Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Keep usage of ARRAY_SIZE (thanks Bill)
- Remove unnecessary import (thanks Kees and Bill)
- Link to v1: https://lore.kernel.org/r/20230807-arch-um-v1-1-86dbbfb59709@google.com
---
Notes:
I only build tested this patch.

I am also making an assumption that `console_buf` need not be
NUL-terminated. Am I right in believing this?
---
 arch/um/drivers/mconsole_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 5026e7b9adfe..d5fa9c8dcd18 100644
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
