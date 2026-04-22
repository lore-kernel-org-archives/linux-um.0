Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0026DFA1FDB
	for <linux-um@archiver.kernel.org>; Wed, 22 Apr 2026 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:Cc
	:Message-Id:From:Subject:Content-Type:Date:To:Mime-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qs9GUd9BD+oZzLK/vsuOICM6KBilsRgKUVepBg7QJJ4=; b=BWkXwhplSxzhEFq+rhoOFASXYm
	EjmE7/yyZ+2uA92femd2CPcRqyDzNzIsnf0CFuNDHvalFUVnJz0AJic3h6kVhrH2YANIO8Hko0ZC9
	hdXVWiQG6hSDyoX9HB+y/pbnbrvT9sLl10hmuIQu/eUFq6gmF1KnBX1KFks7KXcGgwgYPHizct9V/
	cka84v3cjc6KiLsyp7y/MoUw3G/9LmiZphJPJLhcMA8BY+3/tgh3whxyg0GXmiW6FzrAPYr3cojqp
	QzBsukfssh7Qhdte6mspNh8OtDSioFHHtCNDGX+Ao6NKNe2tCQzJb4DIZhyHqIkZ/LsOXAFC1tdvq
	YIKMmDwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFbYE-0000000AaEH-00ro;
	Wed, 22 Apr 2026 17:39:50 +0000
Received: from va-2-20.ptr.blmpb.com ([209.127.231.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFbYB-0000000AaDu-1R8Z
	for linux-um@lists.infradead.org;
	Wed, 22 Apr 2026 17:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1776879578; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qs9GUd9BD+oZzLK/vsuOICM6KBilsRgKUVepBg7QJJ4=;
 b=VjNHg5eN6T0G/5JprjMthUuKi6Uyguf47P3dOu7gMc0GL5B3dzqKUNRmsT6ouj6DLhtwSR
 chUfZKWJ/IGtbBCHYuESa69k98+Kn8Sxy6L9VvfSZh3zcVPhWKSjh4WhycxSXOxrrdn3x+
 NkciWOyQtzvOtQR0VF+8m0sI59dNnH+kd65LJkRocsaxAyxyvSqyZhYjUTissFE9I6/cCb
 w51spGerxQsO3Y8SPdIBxWMXStI7yT7D+6EmbomH4fxSTw/6HvRVdWGlyL9EMu2j0lQnSa
 mEqXHPStFnpC4NzSLnktt0WuZ9CsFCWiXHpaPPrIh/Y246NngI2HYVlWLLyiaA==
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMwH6WkC/x2MQQqAIBQFrxJ/naAWUl0lIsJe9TcaGiGId09aD sNMpojAiDQ1mQJejuxdBdU2ZK/NnRC8VyYttZG97sTBaUXix/odYpSDNAoWRvdUkzug+n83L6V 8yBJH+F4AAAA=
X-Mailer: b4 0.14.2
Received: from pve.cherr ([111.42.148.201]) by smtp.feishu.cn with ESMTPS; Thu, 23 Apr 2026 01:39:35 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>
To: "Richard Weinberger" <richard@nod.at>, 
	"Anton Ivanov" <anton.ivanov@cambridgegreys.com>, 
	"Johannes Berg" <johannes@sipsolutions.net>, 
	"Dan Carpenter" <error27@gmail.com>, 
	"Andrew Morton" <akpm@linux-foundation.org>, 
	"Jeff Dike" <jdike@addtoit.com>
Date: Thu, 23 Apr 2026 01:39:25 +0800
X-Change-Id: 20260423-fix_exitcode-908061ece624
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] um: proc/exitcode: fix simple_strtol() out-of-bounds read
X-Lms-Return-Path: <lba+269e907d8+6a09fa+lists.infradead.org+me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260423-fix_exitcode-v1-1-7e4508913d68@cherr.cc>
Cc: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_103947_466727_CA3B0926 
X-CRM114-Status: GOOD (  10.25  )
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

The stack buffer 'buf' is declared as char[sizeof("nnnnn\0")] (7 bytes)
and the copy size is min(count, sizeof(buf)).  When a user writes 7 or
more bytes, copy_from_user fills all 7 bytes without a NUL terminator.
The subsequent call to simple_strtol() expects a NUL-terminated string
and will read past the end of buf on the stack.

write(2) should report the number of bytes consumed. Returning the original
count would claim success even when the input was truncated, so userspace
cannot detect it.

Clamp the copy length to sizeof(buf)-1, add a terminator, and return the
consumed length.

Fixes: 201f99f170df ("uml: check length in exitcode_proc_write()")
Fixes: e16f5350d4cf ("uml: get declaration of simple_strtoul")
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 arch/um/kernel/exitcode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
index 43edc2aa57e4fbd4a3d24f96878c76f9f8fd4eaa..8de404ff21a213918c5351bc20a6e047bf1b93f5 100644
--- a/arch/um/kernel/exitcode.c
+++ b/arch/um/kernel/exitcode.c
@@ -43,16 +43,17 @@ static ssize_t exitcode_proc_write(struct file *file,
 	size_t size;
 	int tmp;
 
-	size = min(count, sizeof(buf));
+	size = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, buffer, size))
 		return -EFAULT;
+	buf[size] = '\0';
 
 	tmp = simple_strtol(buf, &end, 0);
 	if ((*end != '\0') && !isspace(*end))
 		return -EINVAL;
 
 	uml_exitcode = tmp;
-	return count;
+	return size;
 }
 
 static const struct proc_ops exitcode_proc_ops = {

---
base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
change-id: 20260423-fix_exitcode-908061ece624

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>

