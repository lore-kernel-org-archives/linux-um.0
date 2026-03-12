Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56415106FD61
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8aHffWYVzxlbvh037JlVhR8ERE/IxGWBZRv5qHj7bJk=; b=p22Wyhh7zUKvh2i/9WJJe5Bt41
	MmKh4CxHHv+mF+3nKdxbV1qDIyWFgBWFG2DAN5IxZABFEV538sr1f5vR0lAYCgWF/LRIL1rLWK/X7
	XDjrst0mA7S7EowVd8CazYPZoPjOruQ/adsg7WawrltGxPbCjmMVMu7aBXVY5l3PKZhzMDArMyJea
	P4G/qZtQ5mh+h/HlxK+q3GFkd0jmsHIddaOSVn1D6Hgy0gLeRMX7rlyrUB6cmSbAjO0I77H4qc82j
	UsKjGNNDNbA3mcmQEbYVdMy/dRQ1yukNkCPDF+LAz2X2SvFJBEZgHiklFY/j1n60bhJJNf5WJFXo8
	SSHJ0d0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qcn-0000000Fxte-0Nmd;
	Fri, 13 Mar 2026 00:43:33 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qck-0000000Fxso-2zQ8;
	Fri, 13 Mar 2026 00:43:31 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id DDA261301B24;
	Thu, 12 Mar 2026 20:43:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362608;
	 x=1773369808; bh=8aHffWYVzxlbvh037JlVhR8ERE/IxGWBZRv5qHj7bJk=; b=
	WX7c3DKPx+tVVhFVjUW8//0VWvS4las6XMedU6aTYpr242woaOIcqjdZZVJ4yVnC
	P88WJrijdCqh71ZQjfLl+xhjGoQMg/F8wZ7GNOHUOS+3PK7l64Z9RcJfHzu3EJx+
	9kiGTP3jc4KeZly7RqBISMFoHeUWIhyiLSOgatDGNqU+ils1tsCxI9p7zB3O39nq
	cROINYPyREvgD1SKVCYqH32NWAcedBFxE+Wuyiva088VcFlPPudW1EKncv3fsuaA
	BShtlQMTfihkHb/wYJyVBjIX251wX3ueq3TmnmoWiRxo/NGW66kYiWp2sylnh++s
	bFkFlicATpGbeU9QOA95Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362608; x=1773369808; bh=8
	aHffWYVzxlbvh037JlVhR8ERE/IxGWBZRv5qHj7bJk=; b=TKoMfHHkIQcef4oL9
	WCvsrpW+mTxjtA3eu9J9hQdlSACakLolIy62RydRB3PnAitR2M2UBSxOg6u41jAQ
	orR8E5pfwsu4X5hri4xNT6JK2donC1MWsL/u0WbE7rRdrQQpndWHCmOLcrn85w5q
	SI+HqYSuDNwoKNY/0GBR6Pi4KU3xLzz6Q+JVFC40HVtSP3UyiF03OUmeTa8dDPt6
	DcuHCt92Cd2YJ7SYU+vMYMh3KnIdv8pfwE/90UpO7I3xohC3Jy56VaPbigBQF9ob
	6qBILVQxLXuHVd9mMl4KuNfCKXc+3cO+4irgJurxJUSavrvBRuwB40RYu4N6E0i6
	RGNjg==
X-ME-Sender: <xms:sF2zafwU5O7EET5F6K-aQw7jkWz_ixnHMn4V0xMGQaiLTVepCp0tRw>
    <xme:sF2zae02wD0x5bh-9IIDWH0SxbeC0VpY18ApLPS8IXDYBqpRjLeeJzPqp01_9lfY7
    8Jv0uyAVrBjp1-Aj-tSe7O8R_xxkSMDF1paMjxYStXEtm2zyrM>
X-ME-Received: <xmr:sF2zaQ5u5MiWf_c7DuHg5fbpvIKQer-qUWUomzqvDd3cFUmdR7Z_2wQrinuTZ7IkyU0CpPNKTH5Q0vb0CvuRdpmuwc7ZgXvaIhhtyMu5Yb9C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:sF2zaZf3Per3LZEdp2WRei0ix5aAERTBM0In42j2nkjtAIqVFKBUPA>
    <xmx:sF2zacZtEAEXc0iiBzy42igNRtM_Pt7PbdtzWmXxrPKB5Q8Y4_JQgw>
    <xmx:sF2zaTF4c7hbyoPU2SzpbJB5q6gWv9QUr2hNyV-ZxscAn7v4SDrPRA>
    <xmx:sF2zad0qxF5Ms1PY3l5bG_FSgiwxJyCVizNYRzREyDx2EYRsA7FshQ>
    <xmx:sF2zacNj0BpnAMzEYFy9m-DUQPdAneviKyB1uWslBDL8eNGoPKzEt0nM>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:43:15 -0400 (EDT)
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
Subject: [PATCH 36/53] cephfs: remove d_alloc from CEPH_MDS_OP_LOOKUPNAME handling in ceph_fill_trace()
Date: Fri, 13 Mar 2026 08:12:23 +1100
Message-ID: <20260312214330.3885211-37-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174330_796712_0DEC0EB4 
X-CRM114-Status: GOOD (  13.77  )
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

When performing a get_name export_operation, ceph sends a LOOKUPNAME op
to the server.  When it gets a reply it tries to look up the name
locally and if the name exists in the dcache with the wrong inode, it
discards the result and tries again.

If it doesn't find the name in the dcache it will allocate a new dentry
and never make any use of it.  The dentry is never instantiated and is
assigned to ->r_dentry which is then freed by post-op cleanup.

As this is a waste, and as there is a plan to remove d_alloc(), this
code is discarded.

Also try_lookup_noperm() is used in place of full_name_hash() and
d_lookup(), and QSTR_LEN() is used to initialise dname.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ceph/inode.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 59f9f6948bb2..0982fbda2a82 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -15,6 +15,7 @@
 #include <linux/sort.h>
 #include <linux/iversion.h>
 #include <linux/fscrypt.h>
+#include <linux/namei.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -1623,33 +1624,17 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				ceph_fname_free_buffer(parent_dir, &oname);
 				goto done;
 			}
-			dname.name = oname.name;
-			dname.len = oname.len;
-			dname.hash = full_name_hash(parent, dname.name, dname.len);
+			dname = QSTR_LEN(oname.name, oname.len);
 			tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
 			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
 retry_lookup:
-			dn = d_lookup(parent, &dname);
+			dn = try_lookup_noperm(&dname, parent);
 			doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
 			      parent, dname.len, dname.name, dn);
-
-			if (!dn) {
-				dn = d_alloc(parent, &dname);
-				doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
-				      dname.len, dname.name, dn);
-				if (!dn) {
-					dput(parent);
-					ceph_fname_free_buffer(parent_dir, &oname);
-					err = -ENOMEM;
-					goto done;
-				}
-				if (is_nokey) {
-					spin_lock(&dn->d_lock);
-					dn->d_flags |= DCACHE_NOKEY_NAME;
-					spin_unlock(&dn->d_lock);
-				}
-				err = 0;
-			} else if (d_really_is_positive(dn) &&
+			if (IS_ERR(dn))
+				/* should be impossible */
+				dn = NULL;
+			if (dn && d_really_is_positive(dn) &&
 				   (ceph_ino(d_inode(dn)) != tvino.ino ||
 				    ceph_snap(d_inode(dn)) != tvino.snap)) {
 				doutc(cl, " dn %p points to wrong inode %p\n",
-- 
2.50.0.107.gf914562f5916.dirty


