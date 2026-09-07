Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEB3C79F9E
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 06:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NIbvHaaScRJefKeUY/awHTyPuZNGAgS8A74dfXyR1QI=; b=k5K3AeAJRl55DcTETOuggUDmXu
	/vh9H8jtZafa87oCRrUE15mlMK0QP6VnBqyWv8VM0B/Bk+9GCvym0sc2nSuPn0JmCWbdn5FDQDie5
	l4eQ8Lxk6Fm9MluHHvkOEyRYlkQBEnyJm7ZfO/tE9lUJ1Kh/+l4wvmscx1WsWrOgm6Dr+daXMTrzr
	N+yvq4X9p480TL64obPXZG4POII+Ws7LIvH2bLDCbrg3II5+NYBcS7550oKqzFDENsLk22sP6TLLy
	zYBPJJL/rjXAbL8mYZNqB185ZRExg7oj8sIh2tr03MBxqHSwpOyqkYbAVlnfyyPjpqBN7MQLonzxB
	S5KWuohw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Spi-0000000612B-3Dso;
	Mon, 07 Sep 2026 06:27:58 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Spf-0000000611F-2TGV
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 06:27:56 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1664474a12.0
        for <linux-um@lists.infradead.org>; Sun, 06 Sep 2026 23:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788762474; x=1789367274; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NIbvHaaScRJefKeUY/awHTyPuZNGAgS8A74dfXyR1QI=;
        b=W/waIf0FSX6CZ5NNpIkX3EVSXsO8f7Uq1rBooVGBwx8mbKoi19F4EuesF+YdcyD5sv
         MYS4WCmCFfx/NKl+Q/QXueku2d4AJ3oqrPAveEiNGSiF9gVx+EijneBDUpLBMt7fe5fk
         7Q2C3jfoPTQ+12v0xK44x2d13amJzc0mTYLQzSrzx6HkLQ58RchY302B8UwuB88ay4PR
         EG2wjeS2guG+9I5wv9okJVrNuEYHhEt1RWGlG7BbuQwJhl5S7vKr+0pUCf6HCd1Toob1
         KtKBITETwrMaB+/9gf1gCk5gVRVBambjkZ4yOO3m+Ds/jHAQNDhZFQNOASLzrOaCVxYX
         TBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762474; x=1789367274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NIbvHaaScRJefKeUY/awHTyPuZNGAgS8A74dfXyR1QI=;
        b=fIUTzmrW/DFHjO8phr8Ts4iPewf7vu6p+JakP8ftrn5pX4rVA6E4LembsZ6YR4Tse6
         eHems5z7OElOSrg1pqenycnfRUTWKXB9Ffa8FXhDlSHUHpsgccZ+XysZ3/3p0w5LPf0Q
         LATY2R3OjTp9J+RtO/dzZZojAFNEsvBHb0ls6YuGgR7kfkEemCroqnsLFrBNuLHdz3Z3
         MEIdwNYQvSQMh+ckTPcQmiwFopRsUoM8IA8bw07xEzaZMuZTM03TvQ37PpBLBWTJKTPS
         O4dGy594rCeo8uh8BGXYcWvHJLwxCbjhaGab/MGiideCKVGTUiQy1wp44BmkbF/a2LLE
         pmHw==
X-Gm-Message-State: AFuF++nwdDvpmsuP8jgPKuFFcsdJ7UOT0auKJQZEg0fCGBPIbTqmT8jC
	FOkZZgJ/sAvfujtD8ZOKsQLiPQpFmzb3TP6SdjIT+wvXzPsMkh1F+hkP
X-Gm-Gg: AYBFou0QH/PJ1r1ieWG4wMXgKnl4SipOmYz4HmHm6K93lrVVbLDoByXwpJsEXAfMJPN
	lQBRPxIteXzQU4aIe8UX6wuWUg5ceJgm5Yt40sgSX1IGYQVnDrn/z223spWuFcWpx8af3xu2meo
	D9EJQ6uBh5cMBwc98WjR9A9IsK7+Ru/yE+6edHsVaPCEZFfwUgxdBN1rBYcpk8iK4uNZhD35EfR
	VfSpWwxnzepeSmp1r2jQryRwQfOMxWNV0+9QxLKkfYSI5RuUyRebsH0OOQogSqpgQzbCyoM+U4g
	o4vXkJQ7+bJB+fqg40GeVS1hRrOTNoXDgxG15MDFkG8xjhL+yJPNlyIgcbZJQ2LEd7TTCyMiVWR
	viV/00/RHHlbuyXbKw2Qf7cQryH/Vv7d2FYwUklySZW9hqM+g0b9dy3unRq+ex6+0Vsn0DYhko3
	kbGdnnat4lbnu4HB0DvSkcU4hUtcuG9I/iBbY8BdnvvSsq7iyZSpr7uRPWvsHpPFHd/dCGmm/bu
	5Z4eBaAVtwwYA==
X-Received: by 2002:a17:90b:5346:b0:395:f0e8:9e13 with SMTP id 98e67ed59e1d1-39b26190fd9mr32789988a91.7.1788762474538;
        Sun, 06 Sep 2026 23:27:54 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm28507059c88.5.2026.09.06.23.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:27:54 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: fix typo "hander" in comment
Date: Mon,  7 Sep 2026 11:57:49 +0530
Message-ID: <20260907062749.16397-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260906_232755_628550_34D45700 
X-CRM114-Status: GOOD (  11.20  )
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

Correct "hander" to "handler", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/um/os-Linux/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 6c993bc8c78e..57f0a5e46afb 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -453,7 +453,7 @@ void unblock_signals_hard(void)
 	 * call _within_ e.g. vu_req_read_message(), where we observed this
 	 * issue, which loops. Thus, if the inner call handles the recorded
 	 * pending signals, we can get out of the inner call with the real
-	 * signal hander no longer blocked, and still have a race. Thus don't
+	 * signal handler no longer blocked, and still have a race. Thus don't
 	 * handle unblocking in the inner call, if it happens, but only in
 	 * the outermost call - 'unblocking' serves as an ownership for the
 	 * signals_blocked_pending decrement.
-- 
2.48.1


