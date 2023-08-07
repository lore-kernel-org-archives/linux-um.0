Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9AAC001B0
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 18:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=eddDJgcWv+xAq3mLuSulDZJICxCZqxEHEYUNUmtdC7s=; b=N5a
	bZhUT92b1sMhlmtFI19ERTJlzLiEQHhywPDJN8H7M04PlS4/EMypQwd3rrCb8sXnSI601DXrItrwf
	+G0AIW1sDKlylbc6V+f9TKb2WVcvHSmIT3t8KMPyhK5jTRJWUXGabaI7pObr1KQ8i1gkaeZA1AXH3
	Nhg7chYAifV3QBRFT/LjYEDdVVCexGRv0sJiWxjbw8wfRevIDUuIdVToxim0eR1jUbi/AfPwCwR3V
	1QTpYMcpkxzcunOxiLXLxBxr3/4JyKwJdWkkR1b94T7twA5SEUGS8RO90El/ufIbjFbXph44BUOXv
	F1seml/9r79ziGioC3ZkVDVfpLF7Q1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT4sM-000Ovt-26;
	Mon, 07 Aug 2023 18:22:42 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT4sI-000Ov5-1p
	for linux-um@lists.infradead.org;
	Mon, 07 Aug 2023 18:22:40 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d27ac992539so5049182276.3
        for <linux-um@lists.infradead.org>; Mon, 07 Aug 2023 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691432555; x=1692037355;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7jgUB0WpU0M7afNXyKboaaIvZf92Ty700IWf8lOD30o=;
        b=i8J/Xe7MJ9rD7NzJZFsQtFMkGeXqS2bJrxxhlpaKBuExNEjWUEFdkeosztI64kxSPx
         JF/4yQsv6CuDK9TeNysNuDl1pWk3Jx0dVBOx20Puce26jnhznarZ9FVuQbeHT+hc8uXe
         tto4hAfhiuqVDUbQD3Ws1uohuYH9VueQp1VY1fEeGfb2u5P8Xfvy8nchwO6vIVLW1pF8
         xL4RHZvhfwT4h4gl8ZO9cL9lwd/ulYYkVns29wq9LO2G8VEskQ+zZFfHSBMxJmOAyCCa
         4oo+vmDEYtCEGBluOi6X4e3MVj8kue3KR3SOyDDwB6epZiLljw6W6stVuH8djTbLZBww
         XBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691432555; x=1692037355;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jgUB0WpU0M7afNXyKboaaIvZf92Ty700IWf8lOD30o=;
        b=bk4tzEJ1rIHLIY12Z8Ar1d4Zw/3EQt82v7LvQnoW+pSH5s9dW235FYGhsrIRvwFdnX
         fGynJ+IwZ0oErGqLNTWdzJK8lc2WOEd3oRiX9y3MyD7Y+RA5FOdvyEcg145aDlGOLuRW
         dvo38s7+1gzqkOG9bjVTcDfzl57kIRktngq3mpO6vCSFL/I6p/v6riGLcXq7uPfnfYef
         VghVzSwSpYJoJtYEteWyHMRKz9i/zyI5Un7UbwF+NFSaMwNUwVAMTZxnD73G9nqOTZyQ
         hcRgkVy0PwGboxCdddTPSs0YDvqasHj9aVotfcPgEAIqDrGK6GP0cQw483mp8PscJWwX
         jh8Q==
X-Gm-Message-State: AOJu0YzWmV5D5IiG46z7BOz3im2FZ/eIefMmU8xdMOu4byPLK//Pc6Un
	GX69+Ke6EsHX+BwcJ9Qsl6gXW/0wg2pGBeKqZw==
X-Google-Smtp-Source: AGHT+IE3EsW86Yh8dtPgXOL32nHWwf9iJWr3DyWFMH7EYJdokxnbYqC4oE8Kpzq82cS9iBtHL5aEgmyQTD1Dn3nOAA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3446:0:b0:d47:f09c:cc8e with SMTP
 id b67-20020a253446000000b00d47f09ccc8emr49064yba.10.1691432555654; Mon, 07
 Aug 2023 11:22:35 -0700 (PDT)
Date: Mon, 07 Aug 2023 18:22:30 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGU20WQC/x3MPQqAMAxA4auUzAaitli8ijgUGzWDP6RYBPHuF
 sdveO+BxCqcoDcPKGdJcuwFdWVgWsO+MEoshoaaljx1GHRa8dowqmTWhCFaS468d5GgVKfyLPd /HMb3/QB6UkMCYQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691432554; l=2334;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2oYTjCvV17po6xXOpfrY+INCIA0i2CXq/pTmWjU9YB4=; b=exkU3+X8smSe8ECTT7ic4ouZhlLEph4CCWwgj+Qr8gJ7jaZ+O6d3w5WFRk4LnzhbsR+9W5UPI
 rWdniopikbWBVCbiSSFM+aTHyahPN1VBvuH0AKGOn4ZvnvUjjusU85N
X-Mailer: b4 0.12.3
Message-ID: <20230807-arch-um-drivers-v1-1-10d602c5577a@google.com>
Subject: [PATCH] um: vector: refactor deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_112238_624548_F0F19E2A 
X-CRM114-Status: GOOD (  14.31  )
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

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

In this case, we are able to drop the now superfluous `... - 1`
instances because `strscpy` will automatically truncate the last byte by
setting it to a NUL byte if the source size exceeds the destination size
or if the source string is not NUL-terminated.

I've also opted to remove the seemingly useless char* casts. I'm not
sure why they're present at all since (after expanding the `ifr_name`
macro) `ifr.ifr_ifrn.ifrn_name` is a char* already.

All in all, `strscpy` is a more robust and less ambiguous interface
while also letting us remove some `... -1`'s which cleans things up a
bit.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/um/drivers/vector_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index c650e428432b..c719e1ec4645 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -141,7 +141,7 @@ static int create_tap_fd(char *iface)
 	}
 	memset(&ifr, 0, sizeof(ifr));
 	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
-	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+	strscpy(ifr.ifr_name, iface, sizeof(ifr.ifr_name));
 
 	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
 	if (err != 0) {
@@ -171,7 +171,7 @@ static int create_raw_fd(char *iface, int flags, int proto)
 		goto raw_fd_cleanup;
 	}
 	memset(&ifr, 0, sizeof(ifr));
-	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+	strscpy(ifr.ifr_name, iface, sizeof(ifr.ifr_name));
 	if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
 		err = -errno;
 		goto raw_fd_cleanup;

---
base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
change-id: 20230807-arch-um-drivers-ad44050885d0

Best regards,
--
Justin Stitt <justinstitt@google.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
