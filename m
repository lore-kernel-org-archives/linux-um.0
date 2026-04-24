Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89491FED3FC
	for <linux-um@archiver.kernel.org>; Fri, 24 Apr 2026 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:Message-Id:
	Subject:Content-Transfer-Encoding:Content-Type:From:To:Date:Cc:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CC9VmaJmuE4+l9TeEA+2T38jJ6gbwFgmDLEFdtmT0Bg=; b=xWCO4LdgGEOQNSScKY7oqQPNee
	4X4cMB6bXrb2twlg8PdpYCxINive925Am2jqBuzsVlpbiU4/56DzJAsWIe375uGD154If6YdtMGnz
	ZVBZLlbfpkvbNnIEEeUxanO0ak/0cG8lM8grLuA7mSW63rBDftzRCl4hwsFkDp6PsAyS2Skd4US+I
	hD/V5VIOUiEtht0uvQzccvrrmccSuC5xR/iPD6gRsOzWAduFWCLoggJt6TIs+ukcun0/5lG3NNyQy
	+GQNmFKYojw88uRthkC4wpTukqGaWMp1O6f/4p2rPKsUWvFQSja7u7gLNdB/088sk5iOYHNG35JKj
	xGHZZ39Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGN9u-0000000DjfC-25t5;
	Fri, 24 Apr 2026 20:29:54 +0000
Received: from va-2-35.ptr.blmpb.com ([209.127.231.35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGN9r-0000000Djep-2XTM
	for linux-um@lists.infradead.org;
	Fri, 24 Apr 2026 20:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1777062585; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=CC9VmaJmuE4+l9TeEA+2T38jJ6gbwFgmDLEFdtmT0Bg=;
 b=uoG+TyWgk36+y0vIGDNcDy6vzceg5aiPPuyVQCI5j8pV46I1lPshDIU8JPNlvJnjNZg0o9
 QF3beZ27f5g2O5xA7CbdmyxGbpwuLhW1NVwvpBkrEbSGirb9AVUcJ+VmCpvcQiRQEdbqRc
 TXS5J0S4nT0qrZYFzjMReH27Mn3P/BFY6ik2ovFEGIxQ3kJaIE9nmiab1VQ7pN3yM1i9Ca
 +PqFR/TUBK9K1KL4DaZiOD5uyL14Ygj/cWJ3bPf0yFDRwWuUJfq0Br5DkEqUMIYmUQlhfq
 8ArPt1oKlCJOhzTYTIOfiJqIIbp0L4X7iGWYRDLHa89CYaMZZtADkBHMJmX8sw==
Received: from pve.cherr ([111.42.148.201]) by smtp.feishu.cn with ESMTPS; Sat, 25 Apr 2026 04:29:42 +0800
Cc: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Date: Sat, 25 Apr 2026 04:29:24 +0800
X-Change-Id: 20260425-mconsole-oob-read-leak-a4b8696ac97b
X-Original-From: Shengzhuo Wei <me@cherr.cc>
To: "Richard Weinberger" <richard@nod.at>, 
	"Anton Ivanov" <anton.ivanov@cambridgegreys.com>, 
	"Johannes Berg" <johannes@sipsolutions.net>
From: "Shengzhuo Wei" <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+269ebd2b7+c2655d+lists.infradead.org+me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIAKPS62kC/x3MQQqEMAxA0atI1ga0aNW5iswirVGD2gwtDIJ4d 4vLt/j/gsRROMGnuCDyX5JoyKjLAvxKYWGUKRtMZWzVmBYPryHpzqjqMDJNuDNtSI3r7WDJD52 DHP8iz3K+4/F73w9dsTqnaAAAAA==
Subject: [PATCH] um: mconsole: Fix out-of-bounds read in mconsole_log()
Message-Id: <20260425-mconsole-oob-read-leak-v1-1-7d46e5892c5c@cherr.cc>
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_132951_725738_15B78168 
X-CRM114-Status: UNSURE (   8.05  )
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

mconsole_parse() matches the 3-byte prefix "log", but mconsole_log()
skips strlen("log ") = 4 bytes, advancing ptr past the NUL terminator
when a client sends "log" without a trailing space.

The length then comes from req->len, the raw recvfrom() count, instead
of req->request.len, so printk() reads up to req->len - 4 bytes of
stale data from a previous request left in the static mc_request
buffer, leaking it to the kernel log.

Use req->cmd->command for the actual command length, add skip_spaces(),
use req->request.len, and guard against non-positive length.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 arch/um/drivers/mconsole_kern.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index e2a9e8879f584734cf2e94d47e403d03f8aa2131..0dd5aab1544648a7f7942c2eb47a5792e7dd702b 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -117,10 +117,12 @@ void mconsole_log(struct mc_request *req)
 	int len;
 	char *ptr = req->request.data;
 
-	ptr += strlen("log ");
+	ptr += strlen(req->cmd->command);
+	ptr = skip_spaces(ptr);
 
-	len = req->len - (ptr - req->request.data);
-	printk(KERN_WARNING "%.*s", len, ptr);
+	len = req->request.len - (ptr - req->request.data);
+	if (len > 0)
+		printk(KERN_WARNING "%.*s", len, ptr);
 	mconsole_reply(req, "", 0, 0);
 }
 

---
base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
change-id: 20260425-mconsole-oob-read-leak-a4b8696ac97b

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>

