Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90EB606A326
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WNOjhVyl;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=gy8gyfZ4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=02i952YD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AzPOlMVHZqiqc4/SgqzoQdQv5n3zt50otXb6Pd/4k7k=; b=WNOjhVylHhJWOX3F5WfbKOstQZ
	EZRnRENDVWcR2nDKC4+1vNIpwBEbi7c1fTaz63zvApGtapMB5Q6vFFvMw3t8mt9tr3ufYuAdx2PMF
	2UPGt+9Op3iqHUhcZPFzXa9TzQeFbMQG1fyADTJLTmvrVHzbxGvdmtpqu0ihqcjGCvkFytuPJVrbM
	ojcobulcZcPPFn4KxQltK8P/wc0hMPxAXhRKbY0ahCNsI5NQX2XmnWq538w5CBRB7swGq0KYpljTN
	Aq4yaYSA0JBl/gkb6+7UVVhmrm/1BvyYArzUkjUX3ua5eFndnPwdHN4rTnsXH9w4/cGZQpss6UMW+
	63+00T4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3yW-00000008Lht-2ouT;
	Wed, 25 Nov 2026 03:47:16 +0000
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3yT-00000008Lfp-0OL4
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 03:47:15 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A912EC0A77
	for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 22:47:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 22:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578432;
	 x=1795664832; bh=AzPOlMVHZqiqc4/SgqzoQdQv5n3zt50otXb6Pd/4k7k=; b=
	gy8gyfZ4IsAyiyhdZpu+AAcnon6FxbvcKZAH67uCOhevq4EBx6ingwn1NFNduwmB
	lSFGlF9S8zDmX+nl3BAOSmcbp1rv9+1ZwX4zwAmjHvHwcmId6xUxACMW8QjaNVRz
	33CaP6hqh6G2dCESZAgi5UcKgQZL1W61thRUHjPbHI5dmqmmvoswKs/8GAMvAFyk
	67xu6GcRNT09oADMoLLRhfolZxxOggjXmYRQATAON2UfWD1qyWywqdHkkN0j6WTJ
	F45weesc8BJGHBBIpzkoAr0dF2ceCRibOCFiw9f3leIwjCep4Lm3nQs0NkKUltrm
	FoFGQGYf9UG3yBVkCp0Nzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578432; x=1795664832; bh=A
	zPOlMVHZqiqc4/SgqzoQdQv5n3zt50otXb6Pd/4k7k=; b=02i952YDBlWC7Y20J
	6z0OnWAX/5jCN8q8R9n4UNhS4e1Ilpr1mK5AU9nJyRpLBxdbVTYFIc3dYn1mS5HY
	2hlMa66OcgOevp6LW1metaJTkhW30boHrjmS47M8XLT/VSRwFvHr+m4QP9Im/cQ3
	Byvk4nn3Xy9XBlmwTF1PQ/7ksGxDSIAhbfFioSeLLPkVpTQ2ByHSOqe18K1VrDPP
	+N2eeDl14iOT3sK8AFeu7Psx3SqrB9hf1k2Gg+Tpkxiug4ZFCLLJWW2VVidlSKNc
	9zHjh85zUHUkXrUExA8q+2PkzG912OS6+LVO0Twsepg3qI9P0wwhhTQqBAQAjpyL
	7ay+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578432; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:hfuQr4VO4rh2oFBkCMYSIX7vfXPv6t/DvNkDA30aZ904rIr
	XfM4oJha/HHGndo9Ibjdla4VtG9AtEQ/4uYMsThUMhY3597zIqGpBoAgSwWGKi2y
	sHECtdnEBmgLRpGajiiqgmV9XqDtnZTqavMhKoPv0Arks07477uNkA9rocoeD3Rl
	wZgnPdorQvrxDHM5jUTtANGFRLndBKiGj05/CbD9j6MOhrAZgp0t9Nm2/HfW3Ohy
	aAtYlxxg4337pGEa2E7jlzWbpmW6XZ6GlhH0P8s320/iV2pYGU10dvthJETaXvGR
	PvjArrJex6EN1uuakwlH8ny3q5XMU3/2CeDd1jA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:RD0FEtnSzWfH+vKgEHpbzbmLQC/tAjD/w3+E25bb39s=:7URP8i6yCyfjAojTIW7hW0N69jYbi2sSG0eZznjZ5rs=;
X-ME-Sender: <xms:P1oGa1e34C6GE5-NHRQ4AwTmMKL7d9mYUYfbV2h_dmf6DHDcRTagkA>
    <xme:P1oGa6KXfWU2FmqYEUTCkVa3vxWnPp7R3QwpsB8Ei5RkjNr2u0aGl7BD7i2snNldX
    _MCXIChMFJ0DVc5bcnAdgW2ttMNzkctU0PyO9KlEvDsNjuUYQ>
X-ME-Received: <xmr:P1oGazlu_AOoySPq_CRSc2atF7B7Ug9ePM4OJNZyBaekp592NpcR9YemYWjZXAsAYQDcHmXgilxLfVkLw8pglVK_eIVrNys>
X-ME-Proxy-Cause: dmFkZTEgJWZqpeB1G6uHGGBU6x40PrNG27hQ+jt9Lh/fFZDifRYVox/yFszE97r/YEtkaJ
    KRb3hWZBDeHiP3IXgYpP+sgktOTZkGMiRowoA6X7MFDbKSIb68Rj8vtaZPNrSaRg/gDxs/
    F+sW5WPeitMItRuWH5tRIxy1ko0NkBH3Bq8qy6P20upVNgxiUUYO3j/DJmI0CsQEpHI0Gv
    TKZrQCtr784YSLr69vVucN5VgKQBLOyKB5D7OOwSjEXCKn5Tq+GGsGCcZ9yvfN2rh8H3HL
    ajpmllZ0Cec+MdVbVECc+rKqe0c63zkgsLFEqTKRY2xmzJRQct9vlP6JYIKJxxkuZBYTWH
    lL24OS8tOC0qeAI5D0MTTzKjVM7zBArhkmFht6NnRRRxjR2tMG/d5eWLX5Q5q0lQh1Zhzy
    KXSkRYBIbeActZsP7jvWZPtO270txyn2QCoDrNo8UPjkc10jFcp8EEGU77OlmKYO3ZdCbe
    Ft4oCvJJKEiNTLHxVL521nEGlrNcrNobB/v3AhD3dsj0tDNXIOoA0ufhpcJMRXS/AE0wQ6
    QYnMk8TpDAbDtHk1SvdB4kFE6sMT96/zIHH/pa0Z7eQWF3TEYkwc22vHADye66DCmM51ra
    HA4FVnlTeLq74pf3IkduO16ncf6wp5qxlq2c0QrKrAlz1nhrac8yIloAaU8w
X-ME-Proxy: <xmx:P1oGa2FcxKy82SCEbXl88bPVsd5mze1QbhUxL9cftauw0ZRIt0agVw>
    <xmx:P1oGa8dvZVwblR6zPFjnUdp943JSM5rP2GRMeUXc4I9RWqXwqAL3XQ>
    <xmx:P1oGazE545O8xgJKUHbipJKA4aiLUqwy-k-Ycj11UTqnngsJsNRJqg>
    <xmx:P1oGa2GomYevlOQVyGEpQ3OEJT2wRGUpqWap4G7MB_rCPq9UdET8lQ>
    <xmx:QFoGa3o436QseuGE6ze2itzssSFUBgbAgmEt_jmRO1R3eERDa3hfL0PI>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:47:07 -0500 (EST)
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
Subject: [PATCH v3 10/11] procfs: drop parent lock for d_alloc_parallel() in iterate_shared()
Date: Wed, 25 Nov 2026 14:16:48 +1100
Message-ID: <20261125034543.4084039-11-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_194713_911606_B3009E3F 
X-CRM114-Status: GOOD (  18.84  )
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
 fs/proc/base.c        | 41 +++++++++++++++++++------------
 fs/proc/proc_sysctl.c | 57 ++++++++++++++++++++++++++-----------------
 2 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7685660c3624..cdf0a869f26b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2104,26 +2104,33 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	struct qstr qname = QSTR_INIT(name, len);
 	struct inode *inode;
 	unsigned type = DT_UNKNOWN;
+	bool must_relock = false;
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
+		must_relock = true;
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
@@ -2131,6 +2138,8 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	type = inode->i_mode >> 12;
 	dput(child);
 end_instantiate:
+	if (must_relock)
+		inode_lock_shared(dir->d_inode);
 	return dir_emit(ctx, name, len, ino, type);
 }
 
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index eeebf813668e..ea3287ab9d21 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -687,38 +687,49 @@ static bool proc_sys_fill_cache(struct file *file,
 	struct inode *inode;
 	struct qstr qname;
 	ino_t ino = 0;
+	bool must_relock = false;
+	bool ret = false;
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
+		must_relock = true;
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
+	}
+	if (IS_ERR(child))
+		goto out;
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
+				goto out;
+
+			child = res;
 		}
 	}
 	inode = d_inode(child);
 	ino  = inode->i_ino;
 	type = inode->i_mode >> 12;
 	dput(child);
-	return dir_emit(ctx, qname.name, qname.len, ino, type);
+	ret = dir_emit(ctx, qname.name, qname.len, ino, type);
+out:
+	if (must_relock)
+		inode_lock_shared(dir->d_inode);
+	return ret;
 }
 
 static bool proc_sys_link_fill_cache(struct file *file,
-- 
2.50.0.107.gf914562f5916.dirty


