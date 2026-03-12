Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E3C106FD61
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mtJ/saZCLiCxFDNQljniHYoFSU4uzdwtWsgXO8zNDIk=; b=BDwXKfyTRj6sMYEmrGWhtdrGZP
	36MalE62EOxnx3I3gLSAQh8LARwbGD2eJcYt09U/6DdKoLw1B31NLCAr1MG3vXW4A8VM0e+OF7CK4
	NLWSCyupORkN9njPKr+1SEilm4qlo7TgAEfX+4TjE1N5YF7h7b5116SfCn6Bi7P/56rf2/75J8Wvn
	XHXHwl+3isBm0YfXmt/rLP7/Urcvm0liToEx++4IMBTsRQu36bu3NEiz4d1upaEOePqgh3Q20arJj
	TIs6xxLkSYlIcasYCpV10+IU2cD4RhkpW6QMRs2JU12b8GtNygpbVQd37EFz3k2ENPAPTm/lLhMcl
	iKI4l3Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qcX-0000000Fxpr-0N8v;
	Fri, 13 Mar 2026 00:43:17 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qcU-0000000FxpE-3Lyw;
	Fri, 13 Mar 2026 00:43:15 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 1863C1301B1D;
	Thu, 12 Mar 2026 20:43:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362590;
	 x=1773369790; bh=mtJ/saZCLiCxFDNQljniHYoFSU4uzdwtWsgXO8zNDIk=; b=
	evZBO/FT5uLkrmbp/p/bKHGn86ivpuWIB8uwzomHLGU6kH6lhmmlCRwiDJoWV39q
	TXhehd3v184kz2tKDZFnYt3nMYpGYs0FHIDP5P1WpT7DuL/s4rQw/xsDTsgE9QLg
	/164043xlTxtGbkRkgPLxopa5nRZXLGdKExiyrVeEWQB7Z6SjppifuMa+H+nAnt/
	Y9UIllgVcpdMC3ryQir69hasMs4sAzed4op96lB/0i6WUn6Uhf0fVcGFEXiSJozk
	InAA9BqTgm3htPeeddGMpXgGFTZior38m4S57df0DQ4nN26Wz6Bnup7omFSZuA/V
	bXDsxk1oRwy+oBWG8yzDjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362590; x=1773369790; bh=m
	tJ/saZCLiCxFDNQljniHYoFSU4uzdwtWsgXO8zNDIk=; b=tlm7pJXgvMRnwrzqw
	361ob53tdiymOgQgABOTedImHhfzfyXrgBfCei5K7ic4kOntEU7/s+f5sGh5Urct
	yi6RhxZa9AKNdjteFK4EVVHFzPhf0rBHY7+D36NQKzOYqyDZTXwjWo75g7RIoUOt
	+1Y24Dtef108V7gC/hPAOKuoKHxLQb6ez/GO9OthDEETcJ7ke8mp144qJcMLu188
	7QoX5KdxhtTAeNLGhB9EFu+7bHr1B8GbxO8xT5UwDkDbvUE6Kv/LXlywzoVIfx8H
	5/sPhbm9H87cFjM4xoYFeNlJ51RwpxBUAAY7/b3qCojyfoXALXgP5SiZxeMBLz3U
	TvcfA==
X-ME-Sender: <xms:nV2zaf-NnCpb3HI-jpnIeaMEX78RNQjZehsLTDQASvyJLmVZkQdgfg>
    <xme:nV2zafZJ7mvrmpO-gcToxfMKwcMc5Q_rFX10NZl8_LR-rje39CCVNCfpHij589i8x
    F8Ot_R8pRFhAt1hFRsQ_wy6CVw51XS3cVTIlX1zcPm_ZZvJPw>
X-ME-Received: <xmr:nV2zaYGPAoTTcGmEks6mZrihRO7DEzSJQTLVP_2o9xNxWYeVqZvQjDfXGA3yqw1n6XZ5fGvyGTUhxFiRqIqqc-pGG5s2HTIOOgdySI1Z0kbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:nV2zaY7faWbXQHLIpd0SYafA-iMAWHAFfnW2ShinVhLAUGrEfx07iA>
    <xmx:nV2zaZvgDZlHyejqPasp60C6LyxeD80AFwab7f1aj4miUyVx-K4aCA>
    <xmx:nV2zaaBryqgkdrCkCXjeDM2uqFf7SAUNres7R_12QlIkQ3RduF7YvQ>
    <xmx:nV2zaZvraRlGVqoe9uMDqj0rk0wlwP-X2N2IrOVEi5yN04lSuh4s-Q>
    <xmx:nl2zadJN25sW9Jik8_kJDmuvga-QlrXGx2xisz4qYzgk4C1wnxRkBwfU>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:42:56 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,	Carlos Maiolino <cem@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,	Tyler Hicks <code@tyhicks.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	coda@cs.cmu.edu,
	linux-mm@kvack.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 37/53] cephfs: Use d_alloc_noblock() in ceph_readdir_prepopulate()
Date: Fri, 13 Mar 2026 08:12:24 +1100
Message-ID: <20260312214330.3885211-38-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174314_883938_AF9AE068 
X-CRM114-Status: GOOD (  14.63  )
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

cephfs uses the results of readdir to prime the dcache.  Using d_alloc()
is no longer safe, even with an exclusive lock on the parent, as
d_alloc_parallel() will be allowed to run unlocked.  The safe interface
is d_alloc_noblock().  In the rare case that this blocks because there
is a concurrent lookup for the same name there is little cost in not
completing the allocating in the directory code.

It it still possible to create an inode at this point so we do that even
when there is no dentry.

So change to use d_alloc_noblock() and handle -EWOULDBLOCK.  Also use
QSTR_LEN() to initialise dname, and try_lookup_noperm instead of
full_name_hash() and d_lookup().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ceph/inode.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 0982fbda2a82..8557b207d337 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2011,9 +2011,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 		struct ceph_vino tvino;
 
-		dname.name = rde->name;
-		dname.len = rde->name_len;
-		dname.hash = full_name_hash(parent, dname.name, dname.len);
+		dname = QSTR_LEN(rde->name, rde->name_len);
 
 		tvino.ino = le64_to_cpu(rde->inode.in->ino);
 		tvino.snap = le64_to_cpu(rde->inode.in->snapid);
@@ -2029,20 +2027,24 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		}
 
 retry_lookup:
-		dn = d_lookup(parent, &dname);
+		dn = try_lookup_noperm(&dname, parent);
 		doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
 		      parent, dname.len, dname.name, dn);
-
-		if (!dn) {
-			dn = d_alloc(parent, &dname);
-			doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
+		if (IS_ERR(dn)) {
+			err = PTR_ERR(dn);
+			goto out;
+		} else if (!dn) {
+			dn = d_alloc_noblock(parent, &dname);
+			doutc(cl, "d_alloc_noblock %p '%.*s' = %p\n", parent,
 			      dname.len, dname.name, dn);
-			if (!dn) {
-				doutc(cl, "d_alloc badness\n");
-				err = -ENOMEM;
+			if (dn == ERR_PTR(-EWOULDBLOCK)) {
+				/* Just handle the inode info */
+				dn = NULL;
+			} else if (IS_ERR(dn)) {
+				doutc(cl, "d_alloc_noblock badness\n");
+				err = PTR_ERR(dn);
 				goto out;
-			}
-			if (rde->is_nokey) {
+			} else if (rde->is_nokey) {
 				spin_lock(&dn->d_lock);
 				dn->d_flags |= DCACHE_NOKEY_NAME;
 				spin_unlock(&dn->d_lock);
@@ -2069,7 +2071,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		}
 
 		/* inode */
-		if (d_really_is_positive(dn)) {
+		if (dn && d_really_is_positive(dn)) {
 			in = d_inode(dn);
 		} else {
 			in = ceph_get_inode(parent->d_sb, tvino, NULL);
@@ -2087,21 +2089,22 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		if (ret < 0) {
 			pr_err_client(cl, "badness on %p %llx.%llx\n", in,
 				      ceph_vinop(in));
-			if (d_really_is_negative(dn)) {
+			if (!dn || d_really_is_negative(dn)) {
 				if (inode_state_read_once(in) & I_NEW) {
 					ihold(in);
 					discard_new_inode(in);
 				}
 				iput(in);
 			}
-			d_drop(dn);
+			if (dn)
+				d_drop(dn);
 			err = ret;
 			goto next_item;
 		}
 		if (inode_state_read_once(in) & I_NEW)
 			unlock_new_inode(in);
 
-		if (d_really_is_negative(dn)) {
+		if (d_in_lookup(dn) || d_really_is_negative(dn)) {
 			if (ceph_security_xattr_deadlock(in)) {
 				doutc(cl, " skip splicing dn %p to inode %p"
 				      " (security xattr deadlock)\n", dn, in);
-- 
2.50.0.107.gf914562f5916.dirty


