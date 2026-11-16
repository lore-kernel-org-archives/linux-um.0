Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7B606A31C
	for <linux-um@archiver.kernel.org>; Tue, 17 Nov 2026 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YUMPNQdP;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=LrAEGOut;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=G/991CMp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YDOCxCJWDJqJIkf3L73TGXB4ljsEc/eId8XIHFekXOM=; b=YUMPNQdPQGOFfhczZnzfml74Cy
	gXKFRd922En9KCWHcsEtA7cDqgZm+MiRThtNYBT5BnSqYhQR9uxTfguIpatqIo6BGtf54JtfQ6/0v
	RdFCsG4K6kGCXd0+/MdFIuUMn2D6sw7LLoEmMHfOEEhpgk4NVkqzABqgIxQJQboMsQ6Xil0MGZvI2
	+AEmzNNIh7jx6lwvHz6HlDbAv9v6Des1i2aDzZ8FRKzLvHjrsH/eBvmPlDUh5wcRDPzpslf8JgeAh
	UUFmbnDr+1WJqwh1REyVvp5tVKhmvoMaQCRZTnhbXsWCi3j4vhw6MSdpQkIvlVei2jfUtJZD155PJ
	MXqa5wEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6eH-00000004ED3-3OFp;
	Tue, 17 Nov 2026 00:02:09 +0000
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6eD-00000004EBi-36T9
	for linux-um@lists.infradead.org;
	Tue, 17 Nov 2026 00:02:07 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68AF214000D4
	for <linux-um@lists.infradead.org>; Mon, 16 Nov 2026 19:02:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 16 Nov 2026 19:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1794873724;
	 x=1794960124; bh=YDOCxCJWDJqJIkf3L73TGXB4ljsEc/eId8XIHFekXOM=; b=
	LrAEGOutj/fEDpkherYfjRcba5B+qwjNIX2drnjuqOtUadqAK1cDPbFLXAqOx00Y
	idok/AqqHTHgFjHfbnf/FzaqzP5kpQ3jzNtcHB9MAXFxnB5Q7MTxEaDk4bVonOHD
	SLono/S+WXJvu7MwRg6c47KWdWozhbVL0+o4kHkf6HTfk/rMyKnEYjPtBxZaYGeL
	b2Cu9TZIDG872wBM/ynuT0Rb4UAh/24wQtkzacRXYys3qxSCFCb2k/xZdPmISXp5
	SD60CXAqF1W6HllT+joIBc+IQHrv3jMnXTEeczCypO07By/x9MgpH69ZVNI06Kx1
	OWvGwq93bFb5kMQoyQex7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794873724; x=1794960124; bh=Y
	DOCxCJWDJqJIkf3L73TGXB4ljsEc/eId8XIHFekXOM=; b=G/991CMpe+rkygEPv
	MzBLcBAxp89foSKY6imaihFdopM+YoOlI8vapd2ikcySIzej5TT0jU/XrCKcY3nC
	IecimzCfU/hADs05eyRzz778hdulFjC2J0XcybPLi94cAxFx3l5ji5U/NEshO++c
	BPUuOQDnNkKNCgCnwwEiY5sygPnbIhleSuxc4/n1k/CyacCvPFOoogMa35jVw+R5
	CddE5syW7LzK8suIq2U5zqvZSEt67IJQy3qKLCHOQJysBeWLIzVUuwJ69V8nmy5s
	M/ymPSNIn3ilXBhn+CyvtS0uR+qh2J6pUZmZyzlngD+bqvmKNcs51kpGa8niGya2
	Q2l+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794873724; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:zppqfijLyYJWK7XLSsnBa220x/tJFkh8YytbKJBxaG0IUnl
	LblfopPS5wonq9xfy4rWVAKvqv+4CE2zyNw9hC3ZIwIM84gybLj1uxpRwKduoMiB
	KOPYfq2IR3dVKsNIJbA49IZLyYxEkbQiKMQRmd2m0JSNA6iecnCN58Cy9NnhY6+p
	y53uDVjcgollR6tdlm2e3L/0Kb+Su3CmEHzj+22e+EFz2ttzpnJZa+dWb96rg2Ps
	3fMbQzE562yEBTSvuxVEB8VBuY9vsv92geFz+Ls1fbRdEljOZPDHkS6sCeYkOiBD
	PrFNbClvmUasWdkU05GQmkpn1AmGqtqCSs+ajdw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:KLb+aNcrlCIzLw/CrX8F1zNBPXZ5qht9VWLPhGN8oVg=:TyEeQ2WbtApDIcpylAufMXXQHBaC+fnd6qv+WPqAU0M=;
X-ME-Sender: <xms:fJn7auNoB9aStyQlcCU6RoN9U-DdGXVZ1n93vdG5uq07_wfQvu3ZLw>
    <xme:fJn7auRLefInTwjA3wFbimASFMoL41sP0mPHO-sxdH4dJWKRZdWLH-0xpliSbYIx7
    RViZ2hzSQCZ2YrcwLEDkXtWwO_h6yoes1T1LeuJttGruxb1BAE>
X-ME-Received: <xmr:fJn7ap4sM4HNuH6GdI0b7bBmg8qVyEuvRxCohTUS7ayNEzEsuD2kj6RgIrS8gM2Kkn71ACf8PBjNTnpduRNpBelNE909fTQ>
X-ME-Proxy-Cause: dmFkZTGGotaiYc6jX+Efo7FfH08Alfcyz1yUAKcrzpQNrmoLgcPafsnobnYOqLvo4mJtkF
    PYFI+SEpdh6P6uJ+JBWsOFa4gkOXDxkMIr9MIVoGI0JvO5Zg4EqqsXXVOn/H6RRUtAxq+1
    EVKpzTt5GIhYHN6h/oiWbLGUPZ9O05HUQ+tFi7QXtPgWqIYl0AEcRTZ7l/mSUrqw7P2PD7
    qXZfb0N/6DeU6oDLwgqeTlBA3LYqFMc69tkvLyKY6jqun48ZMJ6rvkihuv0ULaVS3/m5JS
    LQN08anR90iFPJyFSW1N/GjCCGU7kBbZsYhkA5zqcEOlthCtJYhrqQZ8vIn9hbHykUS8Si
    HeIVp0lzHFs11mmIwCUiGCECrwD+nd1NUkgH+tOtfevEBaZ9mU68TdMm9b/DlGo0CuDwpU
    33ig+oGYmX/htL/AqJlM25rCxRk4WY0QDq/Z/fgzfvFFlG6vUH8L7nV0PWBNuL3cjK6qui
    RDncO/6czdSPKVdr1Ajr37jjTBQJNJSvel57zUpGPjhcl+YyBjgB68lJz75xXyJ2S3jLIA
    wwiMS7Q+qnx8/cnCtMJU58JatfEde/YRVW2/E4YYB2xbs9fghhDIR1Mitqy7JFpo+vTx4Y
    QgnTzvxQLkbTx9AfEeDxgZACCTrjUN732qQj9IXNfvtGMWrfaVgc18xt08qA
X-ME-Proxy: <xmx:fJn7ahabQ82jeeIorTwdBX8YVpjDp_QTYZb7X_ZanEM69ro2BDUUPQ>
    <xmx:fJn7atZpjHXIeXly0Uqh18LpOQfh1nCOMILdDG0CPl0WhzCIE4UpSQ>
    <xmx:fJn7ak0blHTZNwJAb7hE3FYUq-gIoz_onlYvy5Wj21ixoIzjPDVGnQ>
    <xmx:fJn7alYRUXmC0-Y2gytkaK2JPhjmEt6exOGPEphogTswy3CDURFg5g>
    <xmx:fJn7ajUC_-ipU59tz3CSKSSVMYJCKImAVv7_HlH7FyhpBw3pLkpO3Ebu>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 19:01:58 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [PATCH v2 4/4] procfs: drop parent lock for d_alloc_parallel() in iterate_shared()
Date: Tue, 17 Nov 2026 10:55:01 +1100
Message-ID: <20261117000115.1433875-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261117000115.1433875-1-neilb@ownmail.net>
References: <20261117000115.1433875-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_160206_425253_ACAA7A8F 
X-CRM114-Status: GOOD (  18.85  )
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

When procfs finds a name in iterate_shared() that isn't in the dcache it
*must* add it so that it can have a stable inode number to report
(inodes are only accessible from the dcache in procfs).

It uses d_alloc_parallel().  A planned change to locking will make it
unsafe to call d_alloc_parallel() while holding the directory lock.

Other filesystems which prime the dcache in iterate_shared() use
d_alloc_trylock() which is safe but can fail if it races with ->lookup.
As procfs cannot handle failure we need something better.

procfs doesn't *need* the parent to be locked.  There are no shared data
structures accessed that don't have their own locking.  So it is safe to
drop and re-take the parent lock.  We could do this around the whole
iteration, but as failure of d_alloc_trylock() is rare it is more
efficient to drop and retake it just around a call of d_alloc_parallel()
when d_alloc_trylock does fail.

Other code that drops and retakes the lock in iterate_shared needs to
be careful to check S_DEAD which could be set while the lock is
dropped.  This is not needed in procfs as the flag is never set.

As d_alloc_trylock() calls try_lookup_noperm(), we can skip that call
and simplify the code.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/proc/base.c        | 38 +++++++++++++++++++--------------
 fs/proc/proc_sysctl.c | 49 ++++++++++++++++++++++++-------------------
 2 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7685660c3624..5f9ec524ae2a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2106,24 +2106,30 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	unsigned type = DT_UNKNOWN;
 	ino_t ino = 1;
 
-	child = try_lookup_noperm(&qname, dir);
-	if (IS_ERR(child))
-		goto end_instantiate;
+	child = d_alloc_trylock(dir, &qname);
 
-	if (!child) {
+	if (child == ERR_PTR(-EWOULDBLOCK)) {
+		/*
+		 * Need to drop directory lock, which isn't really
+		 * needed here anyway.  As rmdir never happens in procfs
+		 * we don't need to be concerned about S_DEAD being set
+		 * while unlocked.
+		 */
+		inode_unlock_shared(dir->d_inode);
 		child = d_alloc_parallel(dir, &qname);
-		if (IS_ERR(child))
-			goto end_instantiate;
-		if (d_in_lookup(child)) {
-			struct dentry *res;
-			res = instantiate(child, task, ptr);
-			d_lookup_done(child);
-			if (unlikely(res)) {
-				dput(child);
-				child = res;
-				if (IS_ERR(child))
-					goto end_instantiate;
-			}
+		inode_lock_shared(dir->d_inode);
+	}
+	if (IS_ERR(child))
+		goto end_instantiate;
+	if (d_in_lookup(child)) {
+		struct dentry *res;
+		res = instantiate(child, task, ptr);
+		d_lookup_done(child);
+		if (unlikely(res)) {
+			dput(child);
+			child = res;
+			if (IS_ERR(child))
+				goto end_instantiate;
 		}
 	}
 	inode = d_inode(child);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c0859c66563..08bcda3bbc59 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -686,29 +686,34 @@ static bool proc_sys_fill_cache(struct file *file,
 	ino_t ino = 0;
 	unsigned type = DT_UNKNOWN;
 
-	qname.name = table->procname;
-	qname.len  = strlen(table->procname);
-	qname.hash = full_name_hash(dir, qname.name, qname.len);
-
-	child = d_lookup(dir, &qname);
-	if (!child) {
+	qname = QSTR(table->procname);
+	child = d_alloc_trylock(dir, &qname);
+	if (child == ERR_PTR(-EWOULDBLOCK)) {
+		/*
+		 * Need to drop directory lock, which isn't really
+		 * needed here anyway.  As rmdir never happens in procfs
+		 * we don't need to be concerned about S_DEAD being set
+		 * while unlocked.
+		 */
+		inode_unlock_shared(dir->d_inode);
 		child = d_alloc_parallel(dir, &qname);
-		if (IS_ERR(child))
-			return false;
-		if (d_in_lookup(child)) {
-			struct dentry *res;
-			inode = proc_sys_make_inode(dir->d_sb, head, table);
-			res = d_splice_alias_ops(inode, child,
-						 &proc_sys_dentry_operations);
-			d_lookup_done(child);
-			if (unlikely(res)) {
-				dput(child);
-
-				if (IS_ERR(res))
-					return false;
-
-				child = res;
-			}
+		inode_lock_shared(dir->d_inode);
+	}
+	if (IS_ERR(child))
+		return false;
+	if (d_in_lookup(child)) {
+		struct dentry *res;
+		inode = proc_sys_make_inode(dir->d_sb, head, table);
+		res = d_splice_alias_ops(inode, child,
+					 &proc_sys_dentry_operations);
+		d_lookup_done(child);
+		if (unlikely(res)) {
+			dput(child);
+
+			if (IS_ERR(res))
+				return false;
+
+			child = res;
 		}
 	}
 	inode = d_inode(child);
-- 
2.50.0.107.gf914562f5916.dirty


