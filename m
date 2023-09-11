Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7486BC71153
	for <linux-um@archiver.kernel.org>; Mon, 11 Sep 2023 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=UB51yaWENML5W16bcJq6Rj1q2d62uBKfQ1VldWLJpRQ=; b=w8O
	M2KAkOiD+VWJYOxWzueSYLG/F8wgOxvD2CahRFoSHKX5L0eP9vHZvv35aq0eCpo3fNv3IckEQ7g6m
	kKqdh78rpetGMNbovw5kRqxiTFUSxnDzUOLjHiOVrctSg9FpH2Bh9Zg7aSqQ56AKoAUBaxpBIsbpc
	ov+UOp12U2dGd4Knycd32+SaoYhXqPjbOEl2T9avar7W1ETqsaZFM0Ls95lzJY6A86QWrAg8mMcXQ
	DQtn+cesG4jhrjvXYCz6qgNX6kEVAfi+zVGZHpC6hSC5oHws2ctZ0c5OTPwk1Xj/MPoJO/yMv4OMx
	Gi8quaruB9P2Dg6xUDtOGDCxvVt1qOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfl5p-0015iZ-0c;
	Mon, 11 Sep 2023 17:53:01 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfl5m-0015iF-1V
	for linux-um@lists.infradead.org;
	Mon, 11 Sep 2023 17:52:59 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b56dab74bso34289167b3.2
        for <linux-um@lists.infradead.org>; Mon, 11 Sep 2023 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694454776; x=1695059576; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FfX6RSRA/tErdP/6b3BPnVn+Cseh6Qa8GqkXP+/ygfU=;
        b=BYMK0nBZAQ1A7cbPWJ0kGwQFOuocgHzKfSPWP58btrSA8kb/gRi8vbdAw14sP9nQMp
         U98a6YFu3LiWT+v1UEEla24CeQ2jx2/FvAt3fAwCYcRWd1YwY3HzG8dSZdgSKUw/D/k4
         MkJfmaauvwKMrn7NZWN5r9IPsfWYk43Yy+VTGotDqJd57Sl9WNOi0ibdjUp9kjnaGbp6
         aIh8yFnQwSe0Y2lF8T3FBVIzk9639Ou7EtRw/sxk+fTnmcU7bDVj2UyX2kmsk7fyxKJO
         WnNd88Zgpt0T0YoEoqA1Mzmaubu0CdLHy1zxRmcrk6GjO21MIkon2JUtEN5Yh8kew+f+
         u1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694454776; x=1695059576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfX6RSRA/tErdP/6b3BPnVn+Cseh6Qa8GqkXP+/ygfU=;
        b=gQGpZH4PcYDIhAgYK33TWGium8ZzqqCpA9h7gQrXIpQaMzxnlr4CWOmbmHUi7x8oUc
         VtOjebjJhYHUcovJY+EZoZ3TBLAUjDohWfQ3Yyd6quQMkZ5fdiuidlrYC2vTXQtzXY08
         xvUTZqrJiTGn8xWmkZM1MUHUhDu9pjgXbSHXlmUjOtX8i+6kX4gs6mUKyAiEezqpk2rg
         FdzwNtAy7XyYoCvIYGZIMKtaNuJWlHVOySiLYBTctasF9Z6oL03ab0FbKZ+D5Zgw2hM0
         GsVOs+aH3Ub1FvQm11M33+fdXN5XOXzJTwmza3SwLYj3m7cs2wAOO/iubSJgv9g2StVR
         MfbQ==
X-Gm-Message-State: AOJu0Yyt+ALXJoWg4DoLQniXy8vjZ6AX8GB2somR491TCyyYZOfIG0gt
	T9ybPldRsqtFhhW3DWj89gG7mHbXXkmv3g2gRg==
X-Google-Smtp-Source: AGHT+IEA/Fl4erMnmYdtrmI9xarwhf9E5DXlxyKwU8nOP9w68+WoAh6IzaJY9FBWx8oyGyINbpWCxI9Xum07nwJFww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b706:0:b0:58c:74ec:3397 with SMTP
 id v6-20020a81b706000000b0058c74ec3397mr248983ywh.1.1694454776558; Mon, 11
 Sep 2023 10:52:56 -0700 (PDT)
Date: Mon, 11 Sep 2023 17:52:44 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOtT/2QC/x3NQQqDMBBA0avIrDuQKJamVylFJBmbgTaGmUQs4
 t0buvyb9w9QEiaFe3eA0MbKa2phLx34OKcXIYfW0Jt+MM5a1CLJ5y/O4iPWD66Kb051xyC8kSh SiSRlzlNtNHq8jc5eTbDDMjpobBZaeP8vH8/z/AG03h9UggAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694454775; l=1822;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Wgwz6kVMUOE/MdaR7dFrpNbwIMGBA/OsTf12jDBzZgQ=; b=msb87huM5Q1fxVqPK+dd7EGT/+zyiEGIFJ8brAYfbNJVy1XYEB3ede05shCahtgbcub2GG4VL
 XXvEL7We+4lCTj6XZm5nuJguI+xwBOM+eD8TJpQ3x7NELmT7z7rybnE
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
Subject: [PATCH] um,ethertap: refactor deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_105258_506538_96244BED 
X-CRM114-Status: GOOD (  11.07  )
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

`gate_buf` should always be NUL-terminated and does not require
NUL-padding. It is used as a string arg inside an argv array given to
`run_helper()`. Due to this, let's use `strscpy` as it guarantees
NUL-terminated on the destination buffer preventing potential buffer
overreads [2].

This exact invocation was changed from `strcpy` to `strncpy` in commit
7879b1d94badb ("um,ethertap: use strncpy") back in 2015. Let's continue
hardening our `str*cpy` apis and use the newer and safer `strscpy`!

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/um/os-Linux/drivers/ethertap_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
index 9483021d86dd..3363851a4ae8 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -105,7 +105,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
 	sprintf(data_fd_buf, "%d", data_remote);
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 	if (gate != NULL) {
-		strncpy(gate_buf, gate, 15);
+		strscpy(gate_buf, gate, sizeof(gate_buf));
 		args = setup_args;
 	}
 	else args = nosetup_args;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-859160d13f59

Best regards,
--
Justin Stitt <justinstitt@google.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
