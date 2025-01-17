Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E3BC02183
	for <linux-um@archiver.kernel.org>; Fri, 17 Jan 2025 23:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yIXkGQwnzX2BgXcnaBAeuJr3Wo+ssX64cIPy7lGG0mc=; b=KfuFwwcKG9yvP46BG0Z2xACcb+
	tr91toc/YYo1qRTr8apOFX2POSHdC6Ten5WLJ3KpVw+sLBFWUbv0IHur8bHCzdRm74go2UklBxrGA
	M6LxjBRISiErZJwGj1pz7M+npNQF7MH+qj/HEuhyTDW9NMLSli8JZ2SYIY5E8XSljPIPb8/RGIau1
	zMDltumuAVGNW8aKEk4JZCAdeKUOn4+Mu+B943+vJ7gk+Wvhyupj8Fs/0xsntOyysZN1BVY81+qnO
	bP99H1wr05AZuPCgYCufpmRSdNy0SQDJM1hIqvc+sY3xJKJt6UD1RKwfjEyHSSgkK77+bJiXTpDTI
	ITJs4uKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYvSr-00000001W3m-0YcM;
	Fri, 17 Jan 2025 23:09:21 +0000
Received: from [2a03:a000:7:0:5054:ff:fe1c:15ff] (helo=zeniv.linux.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYvSn-00000001W3K-18Im
	for linux-um@lists.infradead.org;
	Fri, 17 Jan 2025 23:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yIXkGQwnzX2BgXcnaBAeuJr3Wo+ssX64cIPy7lGG0mc=; b=iMjPw57ZPCfvaqvzLQExDjnVzG
	/CWi/Zu1ZkJJx/xwctbWIoDaD4xSFav+klKYGzwi1mp/rRzcT0Ib0JqxB3r8grxD96r0fKetgSE05
	YOfJwHSupgKjnvnokSBK7lIE3OZC/EKZf8m+GHEcT4/o0iUPpciuAcOV/O/uothYzcA0eVEv1utUl
	GvhZYCa5BDZg/GJCPrkPjWuoGscTFYZ4qRzet0ll/SYjvtJ1cDbwe6hYDHwR9SWVU6OVMPe3GdYKd
	bsVtPpP5YGYBUsu+XHH102neqE8bYSMWEYMMUuz0TnSdwz3M9RS0cICRnVp4mKQXY38g9G4LRnWRI
	3BiTEmww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYvSj-00000003egY-1fGT;
	Fri, 17 Jan 2025 23:09:13 +0000
Date: Fri, 17 Jan 2025 23:09:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] hostfs: fix string handling in __dentry_name()
Message-ID: <20250117230913.GS1977892@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_150917_310286_FE470B08 
X-CRM114-Status: GOOD (  10.72  )
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

[in viro/vfs.git#fixes, going to Linus unless anyone objects]

strcpy() should not be used with destination potentially overlapping
the source; what's more, strscpy() in there is pointless - we already
know the amount we want to copy; might as well use memcpy().

Fixes: c278e81b8a02 "hostfs: Remove open coded strcpy()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 7e51d2cec64b..bd6503b73142 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -95,32 +95,17 @@ __uml_setup("hostfs=", hostfs_args,
 static char *__dentry_name(struct dentry *dentry, char *name)
 {
 	char *p = dentry_path_raw(dentry, name, PATH_MAX);
-	char *root;
-	size_t len;
-	struct hostfs_fs_info *fsi;
-
-	fsi = dentry->d_sb->s_fs_info;
-	root = fsi->host_root_path;
-	len = strlen(root);
-	if (IS_ERR(p)) {
-		__putname(name);
-		return NULL;
-	}
-
-	/*
-	 * This function relies on the fact that dentry_path_raw() will place
-	 * the path name at the end of the provided buffer.
-	 */
-	BUG_ON(p + strlen(p) + 1 != name + PATH_MAX);
+	struct hostfs_fs_info *fsi = dentry->d_sb->s_fs_info;
+	char *root = fsi->host_root_path;
+	size_t len = strlen(root);
 
-	strscpy(name, root, PATH_MAX);
-	if (len > p - name) {
+	if (IS_ERR(p) || len > p - name) {
 		__putname(name);
 		return NULL;
 	}
 
-	if (p > name + len)
-		strcpy(name + len, p);
+	memcpy(name, root, len);
+	memmove(name + len, p, name + PATH_MAX - p);
 
 	return name;
 }

