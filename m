Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F34DF483D6
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XLEIQBkYnCURFZUO1QdNkFw7ZulAflHOOKcW3h6P+i4=; b=48JVOSetd/l2tv3gR7gA3jImKq
	oQuoCaujzuZcx9jw3eTWX15MJd+yxLh0xnIKf2fg+U7weDHe3MmX99EP9nXjjo7NOlLa5ENvFAw27
	+4s50VGsJ35ngKXqoGZv+up5WvBYPtvORdc/TRL/MC4vqKDgZ9evwrr3g1dxZJh18dvdtwTN/mXeZ
	yk7eQuBr6CsrMOxkPPxVf36PiDcCBwrZtnrZKGbJOnbsjN3WuPydm6t0PYQHSAskUYOLZMzMCuRtV
	DJyqet8vFIBaw8U+dGvB49rxoRtILKQCCWaEQELfFejLyu/Mr1KDlWkgxNC1Dv1mKdNispb/AXsr+
	xpbqpfTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ity-0000000HDBQ-3yyy;
	Mon, 23 Mar 2026 17:17:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4itx-0000000HDBK-045b
	for linux-um@lists.infradead.org;
	Mon, 23 Mar 2026 17:17:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 25E27600C4;
	Mon, 23 Mar 2026 17:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28BCC4CEF7;
	Mon, 23 Mar 2026 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774286235;
	bh=/eQUgT1KQXGq96zk0iCPYppr6SLqEvcqyZ2k7p/CtOg=;
	h=From:To:Cc:Subject:Date:From;
	b=g4DDdkC6w1WJFMCU/T4Xpy8/sePdXBZACqBz8WwS3gsJTlSp1ECyYaieX0vf6ycrm
	 ITHyzD3QBPbMiJnH0f7EmT2FNv+/EvqWNi46e7NI80OPg9bDUba73ndT5rJ2gK37tv
	 Zy8bS2OAO/GPVlXa9E0wkLnlKcK8lemlHzkv8ZpjN2oNyWfb0zVzsCziDalB8JiDvK
	 kf87j9bXA6c2ZZYCYg1v/lCmgSJtRvJ5enAiZXqt84+Qx6NI5h4H/66HqO/J4+ruUX
	 7eg45LooGu6Jg5jeDZzU0XuYH+5+mTT4+OFkAnMA6sM3100NeQNixUDCZD2yHZT4V3
	 Hhfj4fY5KfInA==
From: Kees Cook <kees@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Kees Cook <kees@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] um: Replace strncpy() with strnlen()+memcpy_and_pad() in strncpy_chunk_from_user()
Date: Mon, 23 Mar 2026 10:17:14 -0700
Message-Id: <20260323171713.work.839-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; i=kees@kernel.org; h=from:subject:message-id; bh=/eQUgT1KQXGq96zk0iCPYppr6SLqEvcqyZ2k7p/CtOg=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkHS2cubda4P9PlpD7/5/thd8udtuZ3rheWfnLuS9+TK bkLblxY2VHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCR55IM/3Qn7/t6+5LcPn2b mIbfP87d6fOZKh9xa/X6e5tZviTMNohj+M2m+nO1gGPZ8y08MfcKRCvedtQfyuucntd1vuOz3su Z8nwA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
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

Replace the deprecated[1] strncpy() with strnlen() on the source
followed by memcpy_and_pad().

This function is a chunk callback for UML's strncpy_from_user()
implementation, called by buffer_op() to process userspace memory one
page at a time. The source is a kernel-mapped userspace address that
is not guaranteed to be NUL-terminated; "len" bounds how many bytes
to read from it.

By measuring the source string length first with strnlen(), we avoid
reading past the NUL terminator in the source. memcpy_and_pad() then
copies the string content and zero-fills the remainder of the chunk,
preserving the original strncpy() behavior exactly: copy up to the
first NUL, then pad with zeros to the full length.

strtomem_pad() would be the idiomatic helper for this strnlen() +
memcpy_and_pad() pattern, but it requires a compile-time-determinable
destination size (via ARRAY_SIZE()). Here the destination is a char *
into a caller-provided buffer and the chunk length is a runtime value,
so the explicit two-step is necessary.

No behavioral change: the same bytes are written to the destination
(string content followed by zero padding), the pointer advances by
the same amount, and the NUL-found return condition is unchanged.

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/um/kernel/skas/uaccess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 198269e384c4..caef1deef795 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -170,8 +170,8 @@ static int strncpy_chunk_from_user(unsigned long from, int len, void *arg)
 	char **to_ptr = arg, *to = *to_ptr;
 	int n;
 
-	strncpy(to, (void *) from, len);
-	n = strnlen(to, len);
+	n = strnlen((void *) from, len);
+	memcpy_and_pad(to, len, (void *) from, n, 0);
 	*to_ptr += n;
 
 	if (n < len)
-- 
2.34.1


