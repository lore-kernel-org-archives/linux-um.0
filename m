Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B65CA0EFF
	for <linux-um@archiver.kernel.org>; Sun, 24 Aug 2025 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVPNkJpiAMCpzoNqNDnjxDyp0f81tgE5bxKkui3WVFY=; b=JJp4fwBrtT+irIO2F3aUD4S2nW
	BmLAtJIhAdGGtWD7cuWJZSVC+0tnm5FlbejXm7eijki3xw/wkHgf5qU5/WArW9G/eyXvK1JZV3X1t
	YWqCowCeZluJIwXNY0Gsz2KBdFu0+iu7ezG7WsaM8IfBe+/uPJnOWUMjIqLTykS1QsiQTsadc44IL
	B5V7UPYVPFkbn3suYw4zN1KYDUYqdDKyoDqQcbxPIGPC5Ma3Va0z1bY4/Bd7T7dNkFNA6yf3bE7/M
	SuPZmBADEfagLSgqJp9Ywjs0f7W+1L8ttvZvP7Jt4g4KjOmJajX/2P9bWj9nlfHo6ZFVW0+k/RKFG
	GGkeLVTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuC-00000006JFQ-26L6;
	Sun, 24 Aug 2025 15:45:16 +0000
Received: from out-178.mta1.migadu.com ([95.215.58.178])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCu9-00000006JEg-1Tg4
	for linux-um@lists.infradead.org;
	Sun, 24 Aug 2025 15:45:15 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756050311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVPNkJpiAMCpzoNqNDnjxDyp0f81tgE5bxKkui3WVFY=;
	b=Yq6qoRhBr+d8qdoHEgz2CuXFBdoOYvDTAHK5I4TWvWhzxkYecRyJEMXhypIbvLM8ZGGyk/
	QuS2ZO1XyvlHE2OWbbX/PHFRjFx0qTv3f6EVUgdNuw9tchMSpgFlkD2Yykk1nV5ESUQGXu
	cg6/y6DXwuifr/nyk6e1PQZQ7ZppAFA=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 5/7] um: Remove unused offset and child_err fields from stub_data
Date: Sun, 24 Aug 2025 23:44:23 +0800
Message-Id: <20250824154425.2243375-6-tiwei.bie@linux.dev>
In-Reply-To: <20250824154425.2243375-1-tiwei.bie@linux.dev>
References: <20250824154425.2243375-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_084513_781340_71E98231 
X-CRM114-Status: UNSURE (   7.20  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

They are no longer used. Remove them.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/skas/stub-data.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index c261a77a32f6..27db38e95df9 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -53,8 +53,7 @@ struct stub_syscall {
 };
 
 struct stub_data {
-	unsigned long offset;
-	long err, child_err;
+	long err;
 
 	int syscall_data_len;
 	/* 128 leaves enough room for additional fields in the struct */
-- 
2.34.1


