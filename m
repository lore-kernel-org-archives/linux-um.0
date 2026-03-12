Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2C3106FD61
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j63R+vGSqFIeC0SCj0jcb9BcsciO20wok4YExEEnIuU=; b=aRQkZiqQTkYtYg4Gf6hVFqLGwl
	ehPsy1BEAPvSTY8i6kZztTPsrSUq49/esIBywwfc8NuieingTfmA16G+J/YR4XC/vFL0hPkWY4Q+i
	7MM2LMyFdfQoOfXvM2zs+jqYAGzChLWaL0G45BCnBNVuCKCM4xhLP3snrAdyQXLInyJynIEAZJ3gs
	Lz3MD+GZOB9epXOfPDkgRtsBK01/WWdiFQGBUazCwlGfXjt1NDDBB9iMaShJXoLceZUEGTV8AJHXr
	tzGm8FKqGg7ZpZxy9cfRvMzUvcXuu814e/GNM4e4VZjrnZk/s/W+JDC+CX3Ot2M3SFQhL/Q6RI00n
	2ivcjEww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qdM-0000000Fy3b-0cvL;
	Fri, 13 Mar 2026 00:44:08 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qdJ-0000000Fy2w-37vv;
	Fri, 13 Mar 2026 00:44:06 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 9997B1301B2F;
	Thu, 12 Mar 2026 20:44:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362643;
	 x=1773369843; bh=j63R+vGSqFIeC0SCj0jcb9BcsciO20wok4YExEEnIuU=; b=
	eCvS91w+DhWkcI9jjJdNUADcxRGhElzytgMJasgIzKJtuooXaIh3KKja0pUFfX6O
	fgYAReRrX9HpVO7F12hftQ0cSIl24yo01gvuoWwgQ+0LBkoLFsR05RvwjsbQ/xGe
	TARIB8LZx92xUD+U+XYJVZBaPlMp/mwNUr6o9DINS6+42ydzcFDjycZgH68WWE6o
	C3GjVtvxBt81M8NGL0of9lLYsOHaaCljR0612e0zlQfV27RuAQZNtF61tH98aa3Y
	SztxAesntkfAUiZ3e07BF5twMFIeG7LcYeif3ZUiOH9o5O91dPmpaZ9mcvHyC7F5
	pzd5Q75S3kEWTz9D7gVIYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362643; x=1773369843; bh=j
	63R+vGSqFIeC0SCj0jcb9BcsciO20wok4YExEEnIuU=; b=VOKUtq/0Ox3dCym8N
	La/hchRjt+rNU/iyTLG4kwEHuMKD4y3a/JkwzJH9LuB11f5JIetBBVHMt9ViJypU
	UjyLlnUHckM8bh9QjAY4Jyd/C7N5jwudw1JHDUa9iXFd7am+GANyEnLlgi/obehc
	ULSfiEhaSLtneM7w7UNW2TpbgbwcaZ5Y83VVFAz+dm25dDXamEX/5/azTn0wR4rH
	T5eikG9cF+xC+X5DUfa2srcny2SiEQpjWf7Wv50KDnPD1IC+BRLh5gtaUkd0Xqxn
	q7lCrpBBSd1OGWFQIKyOZeBKLnQT8rrdPD3KtmKkTnMRm+b0/M3MehJ+STL1Wogh
	t4YJw==
X-ME-Sender: <xms:012zaShtjFWHYv9HOGnqTxWKzw1vnA7StjckJwiN2A5XojBB-F9JCA>
    <xme:012zact3Dt6TPh_zjEgrQwDsyr4DDxrfYJ6cn9riTs_e14ePaC1C59ywk8575wtIx
    oCoyXSmpvc2QJ7FHiKkN9vyQBEYv-8vxOZoFw9Pf5SKSJTBfw>
X-ME-Received: <xmr:012zaRBDZsBNJH0PilDgngT1D_tzQ8ozHN_bDcdw-FMo3b04ruKTCh0syXRWeolXCoApwXWT2_5U1Kk96nnuomeQn0TR05_drdDWBLwveY1h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:012zafUKwyL0OuJClu15Puc2ys4KgwTiMGJwcET4JsKEaucWrW0l3Q>
    <xmx:012zafJP8iVeo9UK7ccWbWNQm9a4nXPYhx2VbUK7ny3vfppuOu7x9A>
    <xmx:012zaYXOH9KU6qbd-du9diTet8tT6m4DrmZSp1YTRJNc9aQpNYykwQ>
    <xmx:012zaYRD_17YWDi-EKB18x17U_SFvVAUAN1Enot0fJD4HVRO11zFbw>
    <xmx:012zaYIlDd2v2et1x5yz_VJ7tc4OmMkzO-PwjDx9T6vNixAjsjCKsyLB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:43:49 -0400 (EDT)
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
Subject: [PATCH 34/53] tracefs: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:21 +1100
Message-ID: <20260312214330.3885211-35-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174405_847985_3A24645C 
X-CRM114-Status: UNSURE (   8.17  )
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

"Best practice" is to use d_splice_alias() at the end of a ->lookup
function.  d_add() often works and is not incorrect in tracefs, but as
it is planned to remove d_add(), change to use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/tracefs/event_inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8e5ac464b328..c30567b5331e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -393,8 +393,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	// Files have their parent's ei as their fsdata
 	dentry->d_fsdata = get_ei(parent_ei);
 
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 };
 
 /**
@@ -424,8 +423,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 
 	dentry->d_fsdata = get_ei(ei);
 
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 }
 
 static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char *name)
-- 
2.50.0.107.gf914562f5916.dirty


