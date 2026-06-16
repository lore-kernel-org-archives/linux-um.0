Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EA7CD98D2
	for <linux-um@archiver.kernel.org>; Tue, 16 Jun 2026 03:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Content-Transfer-Encoding
	:Mime-Version:Cc:Message-Id:Date:From:Subject:Content-Type:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CC9VmaJmuE4+l9TeEA+2T38jJ6gbwFgmDLEFdtmT0Bg=; b=NycyHK6E8Ag2xXJA7l5m5QkXh0
	kQa8FDWfVGGzMDJmYMoHWYlZ9s5LFQiEqMq6CcLEapAAvfr6N5z6d6MAKXsI6JNga+0E5cnZSLw2C
	vtnYB975jqyrLVr8TBvgpqAqhMOAg9JmxvOM4ErunlRhWSGzKa8YIoicudFCNdWNNJrqERXQz6/QY
	Fu0Z+D+UpSzf66de6/1t6UDjzzlva2lnGTgwUJByOpcU0jPLWuCiyRHQTkgG6hJEOfkcwTGbloHlP
	B1+b3wxam63OVXPUNO7STDdTIc3OFG4VfrJX+IQsC8azyhyNp+Dmrg6YOHmsT/X9OgJV4NMT+tgfB
	fYbad7Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZKpt-0000000FACJ-3JOg;
	Tue, 16 Jun 2026 03:51:37 +0000
Received: from va-2-44.ptr.blmpb.com ([209.127.231.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZKpr-0000000FABY-0XG9
	for linux-um@lists.infradead.org;
	Tue, 16 Jun 2026 03:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1781581885; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=CC9VmaJmuE4+l9TeEA+2T38jJ6gbwFgmDLEFdtmT0Bg=;
 b=XxymL61XvZgVQF1YxGm3+R18cpPktpALxkVX5/i7fY/x7R8N/KXdA+dtp8cyLg7L+DEZOe
 9jFaSXrcawdMwoFdSrxEeWESV9aYFkwoo6hsmWOxFM/btGD+GuFYXFBky6TTCZ9PAq9aAD
 okr105nI9i2tf+XPeXxHKrwyOFKx6aaoToOoN1ZWp1hgmEkrYuke8K8q2IJcE89YzEpnlF
 D53Lqiq49zYY/n4ocaPCEJPQzDZMuLYFzW1B2TeYuw5a+jNLVtFOokkIeUyHYBmTGTJmzx
 Qw7JODaifVjlrP0+P7lYk+pNr7pb99AXv9fvhL/EerycWjeHlinvGlTjxPXmeg==
Content-Type: text/plain; charset=UTF-8
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a30c83b+23c956+lists.infradead.org+me@cherr.cc>
Received: from pve.cherr ([111.40.58.131]) by smtp.feishu.cn with ESMTPS; Tue, 16 Jun 2026 11:51:22 +0800
Subject: [PATCH RESEND] um: mconsole: Fix out-of-bounds read in mconsole_log()
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Tue, 16 Jun 2026 11:51:14 +0800
Message-Id: <20260616-mconsole-oob-read-leak-v1-1-528d711f63fb@cherr.cc>
X-Mailer: b4 0.14.2
Cc: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "Richard Weinberger" <richard@nod.at>, 
	"Anton Ivanov" <anton.ivanov@cambridgegreys.com>, 
	"Johannes Berg" <johannes@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_205135_253694_394BD9B1 
X-CRM114-Status: UNSURE (   8.17  )
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

