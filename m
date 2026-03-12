Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB7106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHdWWLZAUXsN0K/gS8foO1rQ+cBpiHFflrFfn6k5mho=; b=K8egjBSZp/dNI5WFWxlCDTjE4Y
	PIrPuma7HGJANhKLLMp3Y9Rbraqqpwo8S0OXGsaSy/Ud+YO/Mg9EzD0tnop0Y2QayIbCWXIFG00Tt
	mQ0s5gGuhTt2bnXvu1TWxGO2tx3ao9tHHjuxVJ2fn7P34vi22Z80mOfAbB26/GAcfloHhbefDEYwk
	ScZjFMrtju2khPuF2Hn2s0W6GpQ7w55gR88y9pXLyd8EvoOkQatpaG5cYi/fMvaJ2JtepCYQmyQZW
	LhiV+WL7Wk2KVH8WOxTkLrSfdJrTr5lVXN6f9Wi51Fj8J54QJtuexuzUAHVmToXd7vgM4uPF1B6ho
	PQ5rhDAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o2I-0000000FZ1C-4BMM;
	Thu, 12 Mar 2026 21:57:43 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o2G-0000000FYzn-21xJ;
	Thu, 12 Mar 2026 21:57:41 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id A5ED31301B5F;
	Thu, 12 Mar 2026 17:57:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 17:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352658;
	 x=1773359858; bh=WHdWWLZAUXsN0K/gS8foO1rQ+cBpiHFflrFfn6k5mho=; b=
	H/xdszBdpajXQlqvP2h9f8bRrmPuJ0E3HbSIi1+FvDbmXu5Tffa39rTheWtfGwZR
	07K9XTAAEu7QaoJDNNdeV8FPwp7VsZ05tBCbGNERpgIPXvnUh4Dh11eHvup8m6vs
	E5AWfQHX37M7Oed9OovK3Y5b84TTp6vRaxqOKav5UXzJr4jRcIi0QkXwPhN4kZYV
	LZoFa/W1oz8zPHi+tqAL3COCNVGwcsFSYb9+rQJTG37CHQI159wRjqpP0tBXNsNq
	WKVSfQ7Vrk7fhCT55o9UbvASICeM8pa8jCAA7V/OugQhNLLKoEUUVDh26eeB6pU0
	w+PQtmIUZsNeWl/pHFJh2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352658; x=1773359858; bh=W
	HdWWLZAUXsN0K/gS8foO1rQ+cBpiHFflrFfn6k5mho=; b=UIuUs5vUUmD7NwmW0
	yb8NDgNHItXo1Ks/l/WxZ+fc3iPeAPnbXAz/dyah4o+3nxPXgyyTjMIsM+QVnZP+
	YrT1OE6Q7kMuq0FQpMmfD5M3YNYv+ja9g16SXRCe54Y8qn2v2Rv3Fx3JjasZy4Wg
	UEOHHaKmxENT6dRF9frTgZLL7RQ62rZhSzqZV+3ehBY2yK051jf/wLAtOKbzZxck
	oOCPIJW9D0oqj7rnHP94IfAhWhex0ZcyYxBDYhqGoYVxAV21pRS44vfgPWtBBbbw
	4XQOqgI+qyun3wABEJ24wxhbpqXk5pq7ME0lbxnSNrBtvCLwBnmyKv5pz1oNHiw7
	QHz7Q==
X-ME-Sender: <xms:0jazaSy8bXpWpPsaPX1E6VAPF25eFtNUoJuhfM6E6DvIgBXZeDvK6Q>
    <xme:0jazaV2G0RNn_BRqnE2PE-VjHdIf6JJIiteQEz6hIGZfeZfr65GcDPKsQiMmLA3Hy
    eBNoXKsoiKkvNl0paA5xRLSNO8N3TZuVLesMTJo84VjvJS_-g>
X-ME-Received: <xmr:0jazab7g4darHFJA-SCIA5F6MXzidX8T9V3YZD16QZt-SsfFkLX5Ub_x5kNHV7EtiTMQYwU_2nhZAmFQd5V_j1v79PJAWdXX3WHLUpxf8sBX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:0jazaYfsce6kv1VLx4j5HYSDkDJDWLXIzfT4KuG2qT7lIXautdNOdQ>
    <xmx:0jazafZXf2ZbWmY1gwph635TbUyC-MTdZ1P4qT982CsVse9m1MpE-w>
    <xmx:0jazaaFOVBMAmCt30GIJBXbAW3DqDj5BUiJ1cbQx9CzarA2KS1okjA>
    <xmx:0jazaY0YaOBPy7S5FOPpP5VNijeMTySTyB5LHakGXV8VuIzZWSbT_w>
    <xmx:0jazafMd78AdCgo3Yq2WUdF6y1n7vTQFPDeto_tswQS3a4MdLzMaJVae>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:57:25 -0400 (EDT)
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
Subject: [PATCH 49/53] VFS: remove d_rehash()
Date: Fri, 13 Mar 2026 08:12:36 +1100
Message-ID: <20260312214330.3885211-50-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_145740_628685_116EA07D 
X-CRM114-Status: GOOD (  11.14  )
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

d_rehash() is no longer used.  Is existence implies that it might be
safe to unhash and rehash ad dentry, and with proposed locking changes
that will no longer be the case.
So remove it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  7 +++++++
 fs/dcache.c                           | 15 ---------------
 include/linux/dcache.h                |  5 -----
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 4712403fd98e..154a38cd7801 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1389,3 +1389,10 @@ from an internal table when needed.
 d_alloc() is no longer exported as its use can be racy.  Use d_alloc_name()
 when object creation is controlled separately from standard filesystem interface,
 and d_alloc_parallel() or d_alloc_noblock() when standard interfaces can be used.
+
+---
+**mandatory**
+
+d_rehash() is gone. It should never be needed.  Only unhash a dentry if
+you really don't want it.
+
diff --git a/fs/dcache.c b/fs/dcache.c
index 4ebbbcc5aec4..abb96ad8e015 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2627,21 +2627,6 @@ static void __d_rehash(struct dentry *entry)
 	hlist_bl_unlock(b);
 }
 
-/**
- * d_rehash - add an entry back to the hash
- * @entry: dentry to add to the hash
- *
- * Adds a dentry to the hash according to its name.
- */
- 
-void d_rehash(struct dentry * entry)
-{
-	spin_lock(&entry->d_lock);
-	__d_rehash(entry);
-	spin_unlock(&entry->d_lock);
-}
-EXPORT_SYMBOL(d_rehash);
-
 #define PAR_LOOKUP_WQ_BITS	8
 #define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
 static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_aligned;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 31b4a831ecdb..eb1a59b6fca7 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -277,11 +277,6 @@ extern struct dentry *d_find_alias_rcu(struct inode *);
 /* test whether we have any submounts in a subdir tree */
 extern int path_has_submounts(const struct path *);
 
-/*
- * This adds the entry to the hash queues.
- */
-extern void d_rehash(struct dentry *);
- 
 /* used for rename() and baskets */
 extern void d_move(struct dentry *, struct dentry *);
 extern void d_exchange(struct dentry *, struct dentry *);
-- 
2.50.0.107.gf914562f5916.dirty


