Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A9606A321
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lHy/gkhK;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=D3z9PhsR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OiBXUgTn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UBXcku4BANKUZbouEAZSdvrf1Tj7sDqkutD5xhyaTdU=; b=lHy/gkhKLq40nrEz38Lt3i339G
	fQUxpAvRLoFLgZT27cX6jhSfDwNOjv/sXR6mWoc+hStZlqrzmZgaUMLeWRAqpnUmW6EleF7J0aEQu
	3CGnB2HY8t/BYvd/a78lsjow8B5ZfZXhjUsGiYNwAos4EvgEj+ClyiErWPg6QklO2Lgk6TPmypKEo
	xA+Ap+lTgYU/bNPWH9btphHawExTfCRo9Amqq2c3YIzV+8CqjSLIjZStR8gipOUh25BYWgiRUChlu
	KHto4fBEK09F8kYQIFlWsmfzK5SKm5d51hvB52OR/WedG0yCAn7UBnrF882X2ldQRsx9VErYLhyRU
	ybReE5GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3yD-00000008LZD-27WC;
	Wed, 25 Nov 2026 03:46:57 +0000
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3y7-00000008LWQ-0DyN
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 03:46:55 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 425FC1400368
	for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 22:46:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 22:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578410;
	 x=1795664810; bh=UBXcku4BANKUZbouEAZSdvrf1Tj7sDqkutD5xhyaTdU=; b=
	D3z9PhsRibw/jyqnbd/8dr8DJKN+MwbzBNR2DYz6yI7s6PJhWjN95ZMc3t9QevST
	fgUANP+XeTEKYRHXXPV0Su+JQ3TA9nQpBm+Alij+YJ+O25ispInHAJNKVfon2iEp
	ZATaQkZq5GtxckU/qeGHHSr4asGmVtJg33ofoQS3Dj7ynzVv2+5c2MRMbBq8wEtn
	Auzu11LyMAOuFLpWtjdP3hEXLB15gAbnl0q9U13kCXGSmu/VZ6MndrYmYiF7ffsU
	mg1EIl3dlSud2LyGPevtQnZOfOHFwvcx0maCU1QZA2jIuMB2QzIYUE7MG9e/SSCD
	Wjk34Clz9rxVi1//dv9X8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578410; x=1795664810; bh=U
	BXcku4BANKUZbouEAZSdvrf1Tj7sDqkutD5xhyaTdU=; b=OiBXUgTntQ5FeIDi9
	n76km4wA9oBDeWcYm1cIGPkHZRGW6N6ApFlJU2BdUWqvjo8OgCB0lO3sluWhLIoy
	TtE0XNZoD0Yhk4QvGAGlNdJ2VIpljleK6bLVpjGm2LbGV0H7W/kzQeCJN/IHNQJh
	0Zo4VdEjUPkeXASS/Oyysy75ra0GQufJ+fMIW8cr9cifFziDc7Y5+oUQAP46QYpa
	7oDLRqiKMq2lZwQ202e/fsftpMndRdE+BZtT2kV/gOX81z59XOqjNPYkp2YAsxrJ
	K/eq7a91d5mkPQtPVotIekz+73IzxbRoUWt0Yz/JlAu1JWKBYgzMSrs3fv35+N+u
	0j2Lw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578410; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:VU8+nE0qeWB86ty67K9U6WNTYm1Un5yc2MM35VrGPOyMato
	hBh++Nzqmh83AFaAzAPLAYdXFTB5u/6YKrYvIyXEqJhUCNcZF0FBYzf6ZdAeHE2t
	8u8+wc7CKxPY0HgWaqlRb10HbaH2yhp5gcxKchLjYfTCm2jN/pGLwX4n+GvZwlbW
	beVWskchqzfC9DWUUYHG3ophixpzXQmCVBu+lxtv1RbcXHfaZtBtM6A4EltsPZCb
	63q5YVZ3E2fpXu4lDyfqxMhju7tbz6bxBPiuCLIQRaXS2IGuPgTUdSiLUex4wnxJ
	cdSS+hBBkggH88WcVawwsLqJ37iUy1xUMGeZDFQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:qhXvgrzkw6Ruu030e3itkJdTYm3rUf3nAGH3FAeMnfA=:zA9GEHp1eIGnK4tGy8YN/9i+8sZXWBuy1Zpf109ei4Q=;
X-ME-Sender: <xms:KloGa4dlKkVE_dG8XPuSoMuqSZJhxKE8LVXIwM8nhzTCzh9e7hE-Ew>
    <xme:KloGa7rWp-acdw7zo7AC15Gf6Q1kR04aPLtlL2RLLlSePe7bgUfKxpDZUUsIYSTDp
    69QBAvoAuxPKiqexoOAhEp6EwpvMkBmDdLqYicAjfPrTeuSwAg>
X-ME-Received: <xmr:KloGa07Bj2QLpFy4Y5-S0MK4lM8NEImoSveoZT3EFD1RWFxywhwl4D81VdvGJrjfbHUZhe_CvCcfWvIys-t3sQMFRqeWqTQ>
X-ME-Proxy-Cause: dmFkZTE4HtNMS82oETeKxjFsMonchsNmutSXRF8P4Wz/gL5NuR+PmnhI7BdBjNpxinbAbR
    gE9fr8C0GNc0SnxE2B+IXDaaoddndfcEJfJtcWeI4ytNiRF08hWb9RlxFjA1qgM4oFyoJi
    /AdIhJNfEVO0oVTJtQVCvv+X67aNRews2LQwnM5uAbOmmoGahsFhP1aXSbisfk+ds7cJJ0
    OsFbDOPt7ZICh4tniydbOvMlt1+f+7jVXUCHPaOJHWPFgfTUvPivbmMoJSDdfil0VmV1q/
    2QMjPNE1ltm0/CAvjxy3k0MqWfenoOEUWjyOM0HmgbohwH+N/2hScfzSSITnIBzePDS5Dt
    vrEJcWcGcRscohUpQEDjaTWG/IdAvCa37ziXe2Z5To667kLN9lI4AOPPZ2QW3dS//toHMK
    M1ZwFdOXHsGSc3ILp2vVgN6Zc0Rkf4su6sUUDh4gm4bljoZot9WVcaW8assVGalY3Mx5xy
    RHBkQoEgztQZteoFdBmQqEVrNeySVqmG9iqsBHAETgtxlenWh/IjSSYwuGxEchmnvirT9m
    Tt/iNJJmAWzf7iIRk8j9UUolVxg8xm0WEWqTdg1n+tStAFvodxq6NnaZH//ztqcokpBMB4
    2B0N0duNgIhRcYVqYezcO16d6fUZznULSH+l2w9Kw44fr3YMz1HIVPJQFTsg
X-ME-Proxy: <xmx:KloGa7BWKOvNskizRjLpWVYYlNQZm7-TmGn_etbYgKwDv7hDWDEZXA>
    <xmx:KloGa2bgIGVo5fyO04sueOhVd-BUXqae89IPsFLbsR1u4kTPMf_tpA>
    <xmx:KloGa_J37x2RkPpO7f2UopAcjHH2nIoO2FHLKG-EcfumSFjILyvCAg>
    <xmx:KloGa_DM1C90JgLs3zpRQomBAnIcAS1pGlEaCn7QtFBRBiFnLyZ4tA>
    <xmx:KloGaxi9rO0OvJP2zbbRNDcFR028vlWe-RrO3BaalUaHDKeMQKoKGh5m>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:45 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-afs@lists.infradead.org
Subject: [PATCH v3 07/11] Revert "VFS: Add LOOKUP_SHARED flag."
Date: Wed, 25 Nov 2026 14:16:45 +1100
Message-ID: <20261125034543.4084039-8-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_194651_313671_63F4E150 
X-CRM114-Status: GOOD (  13.08  )
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
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: NeilBrown <neil@brown.name>

This reverts commit cc47a1ba1983116ee7a720a79197eb5299ae5d31.

It turns out that we need to make all ->lookup calls happen under shared
lock *before* the places where I planned to use LOOKUP_SHARED.
So LOOKUP_SHARED won't be needed.  Let's discard it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 20 +++++++++-----------
 include/linux/namei.h |  3 +--
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 925aeb63bfa1..6d63a4c08495 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1939,7 +1939,7 @@ static noinline struct dentry *lookup_slow(const struct qstr *name,
 	struct inode *inode = dir->d_inode;
 	struct dentry *res;
 	inode_lock_shared(inode);
-	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
+	res = __lookup_slow(name, dir, flags);
 	inode_unlock_shared(inode);
 	return res;
 }
@@ -1953,7 +1953,7 @@ static struct dentry *lookup_slow_killable(const struct qstr *name,
 
 	if (inode_lock_shared_killable(inode))
 		return ERR_PTR(-EINTR);
-	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
+	res = __lookup_slow(name, dir, flags);
 	inode_unlock_shared(inode);
 	return res;
 }
@@ -4446,14 +4446,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	int error, create_error;
 	umode_t mode;
 	bool got_write;
-	unsigned int shared_flag;
 
 retry:
 	open_flag = op->open_flag;
 	got_write = false;
 	mode = op->mode;
 	create_error = 0;
-	shared_flag = (open_flag & O_CREAT) ? 0 : LOOKUP_SHARED;
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
@@ -4462,10 +4460,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		 * a different error; we'll be dropping this one anyway.
 		 */
 	}
-	if (shared_flag)
-		inode_lock_shared(dir_inode);
-	else
+	if (open_flag & O_CREAT)
 		inode_lock(dir_inode);
+	else
+		inode_lock_shared(dir_inode);
 
 	if (unlikely(IS_DEADDIR(dir_inode))) {
 		dentry = ERR_PTR(-ENOENT);
@@ -4534,7 +4532,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
-							     nd->flags | shared_flag);
+							     nd->flags);
 		d_lookup_done(dentry);
 		if (unlikely(res)) {
 			if (IS_ERR(res)) {
@@ -4582,10 +4580,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (file->f_mode & FMODE_OPENED)
 			fsnotify_open(file);
 	}
-	if (shared_flag)
-		inode_unlock_shared(dir_inode);
-	else
+	if ((open_flag & O_CREAT) || create_error)
 		inode_unlock(dir_inode);
+	else
+		inode_unlock_shared(dir_inode);
 
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index c4436e5c2ba6..da5b4ccca1b5 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -32,9 +32,8 @@ enum { MAX_NESTED_LINKS = 8 };
 #define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
 #define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
 #define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
-#define LOOKUP_SHARED		BIT(20) /* Parent lock is held shared */
 
-/* 3 spare bits for intent */
+/* 4 spare bits for intent */
 
 /* Scoping flags for lookup. */
 #define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
-- 
2.50.0.107.gf914562f5916.dirty


