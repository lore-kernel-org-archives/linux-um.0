Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90992106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TcDuCufZRxJixrcfGFygV+aETR7o0fZBVzJe26rF96E=; b=jRk0nx08BzeGNoZnXIOMhTVJoN
	6wcXgyVWFEhp8pE+7rEhcdQ2qPDu9Sn/56JY+myaATZV4MDxzoRfMuajbK8P3Z7C4+cQTyWgOev+x
	jTgLblFu+Ki10yRLAbn51SY3mwekhWJkx1hBEl4z3mhVG5vsJDC1vcN+tP+1hUI3HSbTMhoyjQHr4
	dxiH+Sw2K0qBBAkZ8WVY0lceS3VLBwnqtjqUOehaCqqN4TmjYojhZwcFd1F2EcqTMXV63VlY7FYOF
	u+4+xY0XfsUAleHlugnDAM5gPxVKPStNWJRTRJP6m0NWHSQCYnthBuY938noBd8FKKa3Wqn9a03Qg
	WGoKuAeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o21-0000000FYvH-164H;
	Thu, 12 Mar 2026 21:57:25 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o1z-0000000FYum-37KE;
	Thu, 12 Mar 2026 21:57:24 +0000
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 8380A1301B63;
	Thu, 12 Mar 2026 17:57:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 12 Mar 2026 17:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352641;
	 x=1773359841; bh=TcDuCufZRxJixrcfGFygV+aETR7o0fZBVzJe26rF96E=; b=
	nvIfh2aV2uCnP5fbNBD0+p+cy5dGDLvwuz7s3Y2ug0pE9ASziUJZDIeLE56guz56
	/o5mTdgRuBry13nfhP1Q6ljFE8dK90mkT3TGfExLnEDQmbbJ4Dd5dIswurNNrHRG
	qGYhyGNzBYe1eg7Wv4tqzkAxFgmyldVz0qJd1mhHWbQli6lUFt9JSJiI5gyfnnfm
	57b4oV9ELFNsGFG3SMNAeCDK4TTz5aO3+SYbXmhxZKK0+IiiAUY8/N6+jkCPR+pd
	4dpuFNZj/O88RcKYROJtoFUZ9hP5f5ew2YzSgcaYhUFxonj7LcTlhEjqBbo59CfP
	1Bx00rDdV5Kc8MhWJ7JNLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352641; x=1773359841; bh=T
	cDuCufZRxJixrcfGFygV+aETR7o0fZBVzJe26rF96E=; b=xlwDjQbH9C1hyWYTk
	qKwHe5IPsQr+iN4dxQjz1i3OO4hnW9JvPTqO9DlXAuYx/EU4usiTZf+yBPoL8+fp
	v/v6ZaEjHOByIDbkNYrbdJWbNWeuewez+R4OXr/Xw9Qyo+x/FkLR79SrLLtJK3d3
	3mf0I+ElHTZ5v25Gr2YAJD3rYwupgT1B6fSTpAvQYmWkEZXCpYWUVl/GMo584Do+
	OCWpoJvv3lLzJ5rwqiPmcnhbTPLew/JpKRHjScaMdrDKoT/wZLzFfO4XO/ABZ5D/
	u0cy237zNWkEclRAhZkLsXOULDttuM2SX9t6Y/c5mpNLkRskDDrpctYmuSOGGgpj
	IdArg==
X-ME-Sender: <xms:wDazafdO_sWmGhWD6154c9XN-js9DNlJSejXhjsPLSLhzF2tW7ppPA>
    <xme:wDazae6WP7w6MULrdQaFCcRVtULw3Y7MWcWXAitpbINf0gpHinB9l76NFAp9R3ud6
    RB4dpzj87qnkxj_U4OdBaVw3In1ut-s--0rHPkEKyshYsCY>
X-ME-Received: <xmr:wDazaff2jYtQMUMv9jiPp3U3_pL_Qyu4MAGP1jAbw-8ts5m8XsCM-D0VpPenhsz9BGYuWjErsQG9g397hHc0xvCSqiukdGirvqWJ27D7kx7s>
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
X-ME-Proxy: <xmx:wDazaVAuQHn5C2dPy2Z6RtnXGYui5i3IkWQro_KarsGBRGti7OYaQA>
    <xmx:wDazabEf4uiVOaOx62aACayZTusJrh-zsFGKwToEWfSjuae36C7qtg>
    <xmx:wDazadjc9GxUmAxpfWyoSqBYdHbU04U8SCrZ2NeJ1FBeztiTngr6VQ>
    <xmx:wDazadvuGOVPBQxad0umw1vk5OPWk8rux78NWpwYaI80YZgoEPwTig>
    <xmx:wTazadWAt_VLN_gSlwcbgrDREjkhIl2uauPOa9jebByPwtSF2xeXUZZx>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:57:07 -0400 (EDT)
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
Subject: [PATCH 48/53] VFS: remove d_add()
Date: Fri, 13 Mar 2026 08:12:35 +1100
Message-ID: <20260312214330.3885211-49-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_145723_894217_8DC4F385 
X-CRM114-Status: UNSURE (   9.80  )
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
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: NeilBrown <neil@brown.name>

d_add() has been supplanted by d_splice_alias(), d_make_persistent() and
others.  It is no longer used and can be discarded

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 19 -------------------
 include/linux/dcache.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 23f04fa05778..4ebbbcc5aec4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2979,25 +2979,6 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 		spin_unlock(&inode->i_lock);
 }
 
-/**
- * d_add - add dentry to hash queues
- * @entry: dentry to add
- * @inode: The inode to attach to this dentry
- *
- * This adds the entry to the hash queues and initializes @inode.
- * The entry was actually filled in earlier during d_alloc().
- */
-
-void d_add(struct dentry *entry, struct inode *inode)
-{
-	if (inode) {
-		security_d_instantiate(entry, inode);
-		spin_lock(&inode->i_lock);
-	}
-	__d_add(entry, inode, NULL);
-}
-EXPORT_SYMBOL(d_add);
-
 struct dentry *d_make_persistent(struct dentry *dentry, struct inode *inode)
 {
 	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 18242f9598dc..31b4a831ecdb 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -282,8 +282,6 @@ extern int path_has_submounts(const struct path *);
  */
 extern void d_rehash(struct dentry *);
  
-extern void d_add(struct dentry *, struct inode *);
-
 /* used for rename() and baskets */
 extern void d_move(struct dentry *, struct dentry *);
 extern void d_exchange(struct dentry *, struct dentry *);
-- 
2.50.0.107.gf914562f5916.dirty


