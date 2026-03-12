Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2DC106FD62
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hkrbz7rqb+Pf2fLQdUTn4dR7TTJgxGfMaCdEXnGBb3Y=; b=aQ8O9CGgkRrXyuTicYDdipnVK9
	u5zT4U0BbWE9raLGt/KFAp+P3KzwqSbwTfrz17pibD6/lLxXKSri5OBdo0zrJn4F3WYWMj9EC7eGS
	IYLvMNpaAk+dsPZtO+As/18oLuHMoIf+4UEerzp6vx1uE1wUKehyAcB+97zmY6eUVSkB6kJwD63sw
	av6M8W8nzasmahBww1HLJ8XMo21JEFh0eH3LPFDCUbORU+UwhXR6DMToX/hT1BaEiK6ccuVmY41su
	Vxn7RAQO6pr1ZLqiB7Zxt3woykn2Vbjq6MsfeRBifXKI0SZwdTjiLbCe0G6EZ+4BSoBGhK/K3LTZG
	cQR9ce3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qd5-0000000FxzP-1p9H;
	Fri, 13 Mar 2026 00:43:51 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qd2-0000000FxyM-1YfF;
	Fri, 13 Mar 2026 00:43:49 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 7B8D91301B2A;
	Thu, 12 Mar 2026 20:43:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 20:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362626;
	 x=1773369826; bh=hkrbz7rqb+Pf2fLQdUTn4dR7TTJgxGfMaCdEXnGBb3Y=; b=
	HjfBkdDoAYwQQJLASCTx4N7D2Oi1gBPTlgkcYOo+WwQly3gu8BxcWETej8E7Y+vC
	7v0fubBGopf7L6qgpale0ldkZ1B3u5NVTNvg1/TUjoqYZU5l0RND/fCU926UE1Cf
	dU52J1R3IvMMwiwCn7OkqthnAbmNeQY0wfFveismXYFlK1lQkp1m9AISmvS7p8Ph
	2303a7f6K5Jlx6zDz19ofnGSqPmwovGDcXYodslmNv0d7WdUJtB9eTYsL8UW0U11
	0GUIOw1bNhAiMgqZY0i4MGRQ55IZgV8SiwsyP0fNcsShifYyYJOt+wEA1ov7f0eD
	PdnJa8hSTogxexnc9oafsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362626; x=1773369826; bh=h
	krbz7rqb+Pf2fLQdUTn4dR7TTJgxGfMaCdEXnGBb3Y=; b=OJg/U+At7OucCvylK
	iUzd6DL7jCUcyjQlX78GwqJ/I6vv5ihkeS435nBM5355zdePzGM36LT4OexR0MRH
	4lFKw8lzT25lxABE9ocUZMJqYrflNdpOeF742itP/1xqaMnbimOGJbINuPn3DCB6
	78lFrxBVAc+TEEOa/aL4peQFYcNfkDvkayfMDVZVCJTVMXnAR+QqmP+X6jPGUX48
	4eQs5VFQkcGcKjiIlmezH2hMkyivHCkm6/sZZuVlnduqKbI9sW3ivQ1XUkRrPQMs
	UX4u0qKhx023bdinP+vM4JzLq51NNl99ZTh37MUoQxcyxT2cDqefqczEqOVUaQb9
	MTpFg==
X-ME-Sender: <xms:wV2zaV802bTgJpgWGm7m58j8ialKu0Zt4maKIV9i4YHWWaGwICxAlw>
    <xme:wV2zadZgu2XwPg_o3YWrT5Anv88yZ7bnYqGCtV0_V4WJBvt4XpxYLozwCXYSJ1Dru
    hY-DVUIj8R6Y0RkLBQtcBmkmR5oFpyZ9WR_a_sQSkuqNx6Z4w>
X-ME-Received: <xmr:wV2zaeGMYnl9QYZx90hgpCUlWxvQ1rd8mBQO5-ss5KhrcVNyC2PIGpsH8rtolKGh19qOuChHoIrcz0o2s-anm5mlsN-kYi6yfy57pp24OHOP>
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
X-ME-Proxy: <xmx:wV2zaW4BbfLTb9uqAjy_X2cVeXfLP5nvICabjW1EC5wZ_-63JqfrEA>
    <xmx:wV2zafuMUoHnM_LxJ0SjB2wIbOy3qY0O87D6n9Ur7x1RFFWg_aJHtw>
    <xmx:wV2zaYAQZmmbH-UHw-cQ8jEX7A7Z38PfFVmYuiTDjpSLuYRJQdmsCw>
    <xmx:wV2zafteUDDwcmQNw5yQwNwpG9lEyX5qJBk0f8Bik16DaVWpZokoMA>
    <xmx:wl2zaTKap7N99sDnE0QEkre4DOsyOIg54jMHgmGQWKBxlmwTU7TXbmgm>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:43:32 -0400 (EDT)
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
Subject: [PATCH 35/53] cephfs: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:22 +1100
Message-ID: <20260312214330.3885211-36-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174348_455798_2BB3870E 
X-CRM114-Status: GOOD (  10.16  )
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
function.  d_add() often works and is not incorrect in tracefs, as the
inode is always NULL, but as it is planned to remove d_add(), change to
use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ceph/dir.c   | 5 ++---
 fs/ceph/inode.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 86d7aa594ea9..c7dac71b55bd 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -769,7 +769,7 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 				d_drop(dentry);
 				err = -ENOENT;
 			} else {
-				d_add(dentry, NULL);
+				d_splice_alias(NULL, dentry);
 			}
 		}
 	}
@@ -840,9 +840,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 			spin_unlock(&ci->i_ceph_lock);
 			doutc(cl, " dir %llx.%llx complete, -ENOENT\n",
 			      ceph_vinop(dir));
-			d_add(dentry, NULL);
 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
-			return NULL;
+			return d_splice_alias(NULL, dentry);
 		}
 		spin_unlock(&ci->i_ceph_lock);
 	}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d76f9a79dc0c..59f9f6948bb2 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1773,7 +1773,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				d_delete(dn);
 			} else if (have_lease) {
 				if (d_unhashed(dn))
-					d_add(dn, NULL);
+					d_splice_alias(NULL, dn);
 			}
 
 			if (!d_unhashed(dn) && have_lease)
-- 
2.50.0.107.gf914562f5916.dirty


