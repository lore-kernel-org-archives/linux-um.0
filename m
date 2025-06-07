Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B72C5B543
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SNzK7t/kTDrEu3ZAe2BVUdBYjisR+xcRUFsS6jLDuk0=; b=N87bzI8wIz9+g5dUC8eC4FoaHf
	aRNCRwWj18ymtyVXOIwx5XG/ZZ54NZl3lAq7ZlJEfFltUyg97+TWx8WqhB8CL8scRUZjKJqIhM7vO
	IcP9NSHeOiPuuOtIC+wY6Z46otErLYmlMJIZDdKi/8gkXjqcLQR3exD0mcTC8hoFAFZ9QRE3m6u0q
	+x0wdkqfsRyvqbiKT8lp6ThZ0g5Q4ZlqRTKSJlknXmv8GBqW9CYWguI8/ySvwNQJY3oVUuQWt2t9b
	tdugiB7m3UDN/5svyZacpeSoKxMwaBj5oM4MaHEasEAs7Q3+Zla9GHXa2NSaKNRa+Xd4YgTPVnhfD
	F1sMEJng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uO18K-000000028WF-1ROA;
	Sat, 07 Jun 2025 21:31:20 +0000
Received: from mout-p-101.mailbox.org ([2001:67c:2050:0:465::101])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uO17V-000000028Tx-2sen
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 21:30:31 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bFBDV2t9Vz9smv;
	Sat,  7 Jun 2025 23:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1749331818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SNzK7t/kTDrEu3ZAe2BVUdBYjisR+xcRUFsS6jLDuk0=;
	b=1hrfMvYFFhtvWdGADpcQy0aN+Dw/WPd67jBGx6Orn3GyPbkKgoCKPwHYnovEs+b7+gzbqw
	jcp4GrOGKYyLQ3Dz3+2Ut+CHbJLt5E05xcM78flowv5jh3tp3HZRhDoeeQqK4gMRT3oNxy
	2iKL3BVQd3YUwhHhXF4HBQLW4qXS+g21ZhVlePf8eEyNvK0kiTUKVpiudpSsBCTcDZIfvh
	afFvVX7ujKPgqKZagXc3it2TVqes7xZlid0RipJ6+otyYVLA64lZSU/VOWBwtQYutL5zta
	arvBZ+sifzYWjxCTXmYde9GbpMBNzBX1/cAJks9Js3RO2tj9/m1NeNAXLyeDMw==
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	justinstitt@google.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [RFC PATCH] um: replace deprecated strncpy with strscpy
Date: Sun,  8 Jun 2025 03:00:06 +0530
Message-ID: <20250607213006.7858-1-listout@listout.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250607_143029_918464_6864CA6F 
X-CRM114-Status: GOOD (  10.38  )
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

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

This modification is mainly due to the concerns on
https://github.com/KSPP/linux/issues/336, where it was mentioned that
strncpy_from_user is confusingly named as it does not NUL-pad the
destination, but it does NOT guarantee NUL-termination.
With this approach/patch we can always ensure that the dst buffer is NUL
terminated.

My initial guess was to create a separate function, something like
strscpy_from_user that would use strscpy_chunk_from_user which would
inturn use strscpy instead of the strncpy (like in this patch). But I'm
new quite unsure about adding new functions to kernel code. I'm open to
other ideas and/or approach as well, since I'm quit sure there might be
a better way to handle this.

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 arch/um/kernel/skas/uaccess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 198269e384c4..c00ef385591c 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -170,7 +170,7 @@ static int strncpy_chunk_from_user(unsigned long from, int len, void *arg)
 	char **to_ptr = arg, *to = *to_ptr;
 	int n;
 
-	strncpy(to, (void *) from, len);
+	strscpy(to, (void *) from, len);
 	n = strnlen(to, len);
 	*to_ptr += n;
 
-- 
2.49.0


