Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89763106ACEF
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7EkI+1dYSsaNPhaQL4RFoi/L2xXEeUvFR4/hMXQ6Tv8=; b=cSfr7Gb7T0ZV6uI0+4OCChteWg
	F8bMy3Ev/OXiHvBDlaTxzEWK446/iPS/pLqouq7ieboAS5kaLICz5g6g8b43fxjjsKCYrFbPDffVX
	3XzycaotkkWakySwTDlCN9FQ9rmaeZ9Yi5+RN3zpjxTgfBxiLmJJZOWTP8nRZ7mC9E67klfgApDb6
	8xH+hEc/n/ac1HC81b9ynOO5+L0jUXOUxT+uNBBpRpSg6MewgxkLvfQhY1PqMxG0u8OKQZjqoI9sB
	RCgq0LxgHaKXrkpKnOwDFVETvNfjoMiuoalQW8UASU6NNGoEvBfg/cEG8V6IesOu1tVVnYwktSJO4
	viubNkaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o0N-0000000FYRs-3TX6;
	Thu, 12 Mar 2026 21:55:43 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o0L-0000000FYQm-2wco;
	Thu, 12 Mar 2026 21:55:43 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id CDE231301BB9;
	Thu, 12 Mar 2026 17:55:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 17:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352539;
	 x=1773359739; bh=7EkI+1dYSsaNPhaQL4RFoi/L2xXEeUvFR4/hMXQ6Tv8=; b=
	QWDEme8qECmbVrBBbWwkEiohStbLaNDmXHMhulBhyoA2EG4o9Klb1AYQqUq0RNC5
	nnDBs7m1PE9pcBUM4WeYuhcvjHqs2D1sE3ayPHMrX+/DMifhX2vb081xbm0s9sZH
	mib0fDRiW0EL75WUrBvfmIo4P6lq0ic+WO0ZWZ8D8u+hNI7/c8FRPA77w+chdZzE
	UNDIwkYV33dYEKHCTqgO3B6LmvhzAMLUTNWy7hxZ7MgeWCKtOCauLjv6EqU11gPw
	tc5/24EPJ5Rau0RWMcN9eJrYwG62vPk+uinTSI6AUMf/cUl/7nrsHyBW2HJN+hJ/
	KjRxJq02GMx1+LsJkMOlHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352539; x=1773359739; bh=7
	EkI+1dYSsaNPhaQL4RFoi/L2xXEeUvFR4/hMXQ6Tv8=; b=uCftpOHJU6GQPgjyP
	BqLIbZVvlgXlUB00MfOPgAaUi6FoFzPi9wFTBubNPoKakH+qqHCAOZOlPS/LAOUy
	2/3De6yOkuPvYWRD68s+R8O8NOgbqOF81JlMqBfjjNF1p0HfN7PxORtuutOGgl9h
	uZ1t6widneeTd+8IGNXM/3F5qx8YOdgd4tNglwZJ+Rzk/id4c6PbCQxG8mGaTQ5U
	tKJ0yapFVfywZIR6KJRe0o9D6eR1gitNNNnyItQ78W5P9/nxAFKWWaudljMP03sa
	j2NvKpJYMrCX1uXLOSrf6IaPTyPZe2mcHof6Yt4e2dWNk77qwKbPdbVaRlkN4WxB
	0dF8g==
X-ME-Sender: <xms:WzazaZi4hKudtguizjeyiXfodZw7Us9Z5TlrZIfUJ3BK76SDx9ljhw>
    <xme:WzazaRvjGdhLe-FsYCIbBqkhtkSj8mSAyqrsSIdUzQPO4gl2UF_sP4tPTLASWEile
    1rpmDjjs_Lcc8KvGYCmEn7GXlMvc4ES8AD67HcaujvX8UF_>
X-ME-Received: <xmr:WzazaUICRgJIkDTfpPnwiHMg1l1HCv9bk1S7kn4_pqjnYMXSyuJoKCwK7Ig8EM5d20TRJxl2MPYdV3TvOmA5o7e_y0p52XvN7x3Qj4ix1xAS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WzazabshJ-q_9wgV6KgTAqXTmtx-b1AsTy2w3f7q6pCvLcT4_skiHA>
    <xmx:WzazacR7k8GqjyOEzAUJqIcIRh_zTSch0uWR1cjLR0IRJXvMjo7PsQ>
    <xmx:WzazaRVS4Io-MY8lFU9j0xRoGXrLk7Z0raOKVZ0SsKRmQKPTmSLB-A>
    <xmx:WzazaWwppvOs-RxpcSIPxRmcmuSyBX1k0cC_WAmlITduW1bS83gNiA>
    <xmx:Wzazaf_E-7jZSi11Dz83gTvIASs6ravc4L_sRo9bzrYz1jx1268FZeht>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:55:26 -0400 (EDT)
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
Subject: [PATCH 42/53] fuse: don't d_drop() before d_splice_alias()
Date: Fri, 13 Mar 2026 08:12:29 +1100
Message-ID: <20260312214330.3885211-43-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_145541_824151_3818EA87 
X-CRM114-Status: UNSURE (   8.84  )
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

create_new_entry() is used to finalise the creation of various
objects (mknod, mkdir, symlink etc).

It currently uses d_drop() which will be a problem for a proposed
new locking scheme.

d_splice_alias() now works on hashed dentries so the d_drop() isn't
needed.  Drop it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/fuse/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7ac6b232ef12..a659877b520a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1020,7 +1020,6 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 	}
 	kfree(forget);
 
-	d_drop(entry);
 	d = d_splice_alias(inode, entry);
 	if (IS_ERR(d))
 		return d;
-- 
2.50.0.107.gf914562f5916.dirty


