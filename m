Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5EDCA5FA1
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 03:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lsKfDwVY/s9QOcVsVfQ184vGtQP89p1qx6OKonmdfWY=; b=RYrTTCWf5Z80OiOVOdIrq9dYsN
	il9ZAAYM2b1K2F5Ccm9dDf9G+6CwI1UiKgF3m506kMzjiZ4EVm494sPmUKiMBPPC90bT/Rqh3ydDk
	xx4ZR3VE9xiXW0WgFJ1E7fHJsMrfTzCKbHieWjdGXerT1fM087WpO9MW6XECMkAh3kUwngjKFYkwr
	ci2cOjP2ps1nunyhxaqeyKBbJZ4lgnwvd9XZcwnn3QLmjjUoD6vfPl5qdEnZIg9LRvHNv42EQfNUJ
	UYbT5KDyhl52ss2eI/omDjkcT4VWNrb5nQftVv4PB+c8j6ah1KDWes2A2SyjgmwDd9S3v7GPbFbSk
	W6iCKUfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOkf-00000002Fq4-0I87;
	Tue, 29 Sep 2026 03:43:33 +0000
Received: from flow-b2-smtp.messagingengine.com ([202.12.124.137])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOkc-00000002FpY-2sBV
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 03:43:32 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 6CE321301954;
	Mon, 28 Sep 2026 23:43:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 23:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790653409;
	 x=1790660609; bh=lsKfDwVY/s9QOcVsVfQ184vGtQP89p1qx6OKonmdfWY=; b=
	Cwxa84pJo7NCVKIxjS98cnuf1G3GApyKdhkfpdCq5ZzQjtwWmtz9R9kx30GoUKRn
	2OspMv6mBz7OqfH30W718sZmL/HlhpLOqI9HOvBwqDcCTZaOx8tr6RRim54NFAal
	+xngEmAQvOPO25Wd66fPvmgxg0AM8F3ml5Q+/FI0Fi8rAyj+z3raP/CkOkkAyhJa
	oQnVL/1xQ3XXGhnhkrn49i2AuOmrQlnSGtfE4iEMwaAZ3ipeILIK6D2kH4BQ/vcH
	+5LCtiM6PPaJ0J669zzSrESTa5VCLsqLBuAxkDRMeKC+jNfQxHZPr5KcLCOiojIK
	MYZquKLRB9H231fg1x6o/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790653409; x=1790660609; bh=l
	sKfDwVY/s9QOcVsVfQ184vGtQP89p1qx6OKonmdfWY=; b=S/0V/WsEs99kvFZu9
	+XY1gSZ64yHrE8DRbyGS7oncnDgnGWU65Nnk9sgIOsHF7Gf5DPQfQx8wbcSc0cWn
	KoX5NG+ehEgC4ZAt3x2oZssi5VLUe96H6HTVJ+Kt1pCTZo9rd4iGWsqx5R9KrhcC
	OG4+qHClD8AmAap2VEL7kbYD5PKz1t/cZOCv2zmUReugjc43scHQhrdowkvjJLfJ
	t2Zpd/Uxqsfh79tRNG2EAON3mvm3hMA7b4/JT1Ppil5kfcSg+UE91qbtBqIOMlqk
	ku2rR87f20g1y2l70AEQu8E3HB76ajzT86zboxcXCWOmbAe/RYo4E6/8WV1ZhlRa
	Dv13g==
X-ME-Sender: <xms:4TO7arolaOHFwXK56Qa6xykR14IrzwemNkzpFDIguv5nMRRVhZPPJw>
    <xme:4TO7aolKtq65vDScMy5_UMgBYjif_VbWjcmJnooQ7HXQlfB1b_DERWRxQZt3xh-8L
    um53PFynUa8tZvjyLgjH_FWDUD7j0vaq0jktY2ivXSDQFKOxK8>
X-ME-Received: <xmr:4TO7agYnqQtKbVg8TnfAvT7BFKR0QCBoNSjKwjELgz_U_mRFyq8CTREX8QhPabar8zn2mF9plyA2VopTwFdFCwMFYygBP7g>
X-ME-Proxy-Cause: dmFkZTFf22swud/kgH+7IFCsdfS5PKwRmLOVVMPsMM0oPEJSrxXomK5MGA2HpoM/4Fayjy
    8t4bbaFpw2j2uTWWtWZZBpnJUdMuyskk1hWd9qXGF45eabe2keg8OPLCDZxOgY/dlPK4Uf
    QMGNQJm9P9MUeaNZkZs6ns50gsKFwCc8XWol2sagqa5lM1ggO/E+N7weoZuVf58v2SDU1z
    oJNwy/LJrQkxx961Dkry0BeNl+v6sGxsoTx0ccz/AOIQhh4NsfwUFrJwksoVGSAcoAhOYU
    GWH6kx36jaIyiQRhXdfFML1Yw6upasUkEITsWtrtlu14hKvTsqzmkbnDRYufVwBOwNEZQo
    T1B4oFJSiHfE5i9loHVwvhK+O2Y5BVb3Dv0iGvqbzQqA9qN7MAhuRpy7uZ8AMY3dfP2DLq
    nvbhs207NBSaa5MDvoBmSdevJXJtKK5Hlt0NVJSsIpNU0NopecJXOW0MfIAOhZU4+jqsip
    x4Wljyqn/g9FYR38Rjhm7LMDLFmhlY1lNIcxOONWExp8BUma7cICS8hD3tc+nEgnqBg/Or
    nNxADsnPDnuyJLFgOdrItdzIYZlwJ+9r4jPnl2FGAjhzcmOtPLr3fcGSTnvIZ5qEsLqmit
    nguUxdpJLF5/eSu32nMJ+qQkmH76GJPJzO/qTwuHVsJN3RUSfT1BjKRxMs8Q
X-ME-Proxy: <xmx:4TO7atullrr627O3cusaGrNIKgU85qn6rncQsX3LDWoUzed2yCE3KQ>
    <xmx:4TO7apq93rdUjA9jN49DV3ARwlkMmify2m0Web5YX443O54h9L8H7g>
    <xmx:4TO7anksVDf-DVzjhpOiOg2FzstokCT-dspNpyK47SNuUo4Zl0X_6A>
    <xmx:4TO7apTC6Lml8eeXrajxP0WH1_weLxIDimYZ4JBuvSDCiB2Sc_DFwQ>
    <xmx:4TO7angk9EneeKswcti_o90s6_OLRNXOoyoRMO4fzAp9wIlIomwtE6OU>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 23:43:21 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	codalist@coda.cs.cmu.edu,
	coda@cs.cmu.edu,
	linux-mm@kvack.org,
	ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [PATCH 6/7] procfs: drop parent lock for d_alloc_parallel() in iterate_shared()
Date: Tue, 29 Sep 2026 13:36:06 +1000
Message-ID: <20260929034158.1455429-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929034158.1455429-1-neilb@ownmail.net>
References: <20260929034158.1455429-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_204330_809590_91870504 
X-CRM114-Status: GOOD (  18.63  )
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
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

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
 fs/proc/base.c        | 36 ++++++++++++++++++-------------
 fs/proc/proc_sysctl.c | 49 ++++++++++++++++++++++++-------------------
 2 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a39de424f62..49939527763d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2106,24 +2106,32 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	unsigned type = DT_UNKNOWN;
 	ino_t ino = 1;
 
-	child = try_lookup_noperm(&qname, dir);
+	child = d_alloc_trylock(dir, &qname);
 	if (IS_ERR(child))
 		goto end_instantiate;
 
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
index 04a382178c65..de96a08a1e64 100644
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


