Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA6606A320
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uyTFUL3C;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=hJbkXpvM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bTlvD9Zk3dvsYXeljHYOtZmw+TfRjjfdFXOWZ+4HdQc=; b=uyTFUL3CWbBXMm
	c860bZVcjcgCvRmBslGYu68l58Tw2wiU/ox1XScL/VHuFcAfHI1wPylfvoGzwj33w4OK/bZ4WtdXc
	j262yX61PQPxSHB+sgPtqYRAtgLR6YjkHIZhpBG6mjOdtjhJE4mDfNgHYEaPyQDrReICkyFi/A9Ei
	6oSc30/cnkEpIN3l4CbaozkO0uGKpVYSZLewWcEmzzIzp2CKjeSnrv/9LxCo0vku/+ulxaeAQdp9Q
	kOcbtx9rm2iwX0rDGb56QbAJXPPnIr7T5mlaLL3BAiAp7JSd1qkS4yVhe0HnIj/a6eHHPr14iKaDZ
	8sttmugORNowXjRyHfiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29P-0000000C1h4-0H4S;
	Thu, 19 Nov 2026 13:26:07 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29M-0000000C1cx-17nJ
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:26:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bTlvD9Zk3dvsYXeljHYOtZmw+TfRjjfdFXOWZ+4HdQc=;
	t=1795094764; x=1796304364; b=hJbkXpvM4Oh+4HrY4vtPas5cyb9kqomrbu2UiSf+cSmTUOj
	0Hd/8A2m8ijj8F9w3fZs5ayzMSnaUwj/N7/aKUtL/+PtaYQ4Ex+pFeyGKjkm67W90ggdn+h/2f9da
	WhWidNuWdWxeCuf5eCzWG/Xewix3eGENrsKPs+qf9gZ/KaRv0ZXngOmSdWAarWeT1iNJxQwuyi8qr
	HxfA57rdyMtpfFLvq3amFgfySzy6IEDWTQT2LBwad4B/X9rS5wi/7acTohIYyq4RL9gI/FlClELH/
	XvZ8AWMO+A3x8oGWcWqvv28u/NFukpI0B/XOXMetvJdRuQiLp0kWsJ+/763Lst4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU29I-00000004LQj-1Bdr;
	Thu, 19 Nov 2026 14:26:00 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 2/5] hostfs: make dentry sorting stable allocation wise
Date: Thu, 19 Nov 2026 14:24:39 +0100
Message-ID: <20261119142555.a24ee3cb2cdc.Iec7ff04ca24cdca398b9732d88674c2b521d8f7a@changeid>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119132555.228479-7-johannes@sipsolutions.net>
References: <20261119132555.228479-7-johannes@sipsolutions.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052604_308902_38714B17 
X-CRM114-Status: GOOD (  18.24  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Benjamin Berg <benjamin.berg@intel.com>

The order and size of kmalloc/kfree will affect memory management in the
long run. Hide the any differences of the undefined dentry ordering by
the host not by sorting the list but by swapping the included
information. This makes it seem to the UML kernel as if the allocations
happened in our dentry sort order.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/hostfs/hostfs_kern.c | 53 ++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index e8419b96b869..224683fd74cb 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -34,7 +34,7 @@ struct hostfs_dentry_list {
 	unsigned int type;
 
 	int name_len;
-	char name[];
+	char name[NAME_MAX + 1];
 };
 
 struct hostfs_inode_info {
@@ -296,18 +296,6 @@ static const struct super_operations hostfs_sbops = {
 	.show_options	= hostfs_show_options,
 };
 
-static int hostfs_dentry_sort(void *priv,
-			      const struct list_head *a,
-			      const struct list_head *b)
-{
-	struct hostfs_dentry_list *hdl_a =
-		list_entry(a, struct hostfs_dentry_list, list);
-	struct hostfs_dentry_list *hdl_b =
-		list_entry(b, struct hostfs_dentry_list, list);
-
-	return strcmp(hdl_a->name, hdl_b->name);
-}
-
 static loff_t hostfs_seekdir(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
@@ -352,24 +340,51 @@ static int hostfs_readdir(struct file *file, struct dir_context *ctx)
 			goto discard_cache;
 
 		while ((name = read_dir(dir, &next, &ino, &len, &type))) {
-			hdl = kzalloc(struct_size(hdl, name, len + 1),
-				      GFP_KERNEL);
+			hdl = kzalloc(sizeof(*hdl), GFP_KERNEL);
 			if (!hdl) {
 				error = ENOMEM;
 				goto discard_cache;
 			}
 
+			INIT_LIST_HEAD(&hdl->list);
+			list_add_tail(&hdl->list, dentry_list);
+
+			/*
+			 * This is a bit evil. We created a new entry, but we
+			 * don't simply use it. We bubble the empty list item
+			 * up by copying the contained data for all items that
+			 * should be sorted later. Then we use this empty item
+			 * to store the new dentry.
+			 * By doing this the order that the dentries were
+			 * returned by the host is completely hidden from the
+			 * UML kernel. If that was not the case then the order
+			 * of kmalloc/kfree could vary between runs.
+			 */
+			while (!list_is_first(&hdl->list, dentry_list)) {
+				struct hostfs_dentry_list *prev =
+					list_entry(hdl->list.prev,
+						   struct hostfs_dentry_list,
+						   list);
+
+				if (strcmp(name, prev->name) >= 0)
+					break;
+
+				hdl->ino = prev->ino;
+				hdl->type = prev->type;
+				hdl->name_len = prev->name_len;
+				memcpy(hdl->name, prev->name,
+				       prev->name_len + 1);
+
+				hdl = prev;
+			}
+
 			hdl->name_len = len;
 			hdl->ino = ino;
 			hdl->type = type;
 			memcpy(hdl->name, name, len + 1);
-			INIT_LIST_HEAD(&hdl->list);
-			list_add_tail(&hdl->list, dentry_list);
 		}
 
 		close_dir(dir);
-
-		list_sort(NULL, dentry_list, hostfs_dentry_sort);
 	}
 
 	pos = -1;
-- 
2.56.1


