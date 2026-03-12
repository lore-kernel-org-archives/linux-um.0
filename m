Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D6B106FD60
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PvJJgAoi6+6/iAinwR5eAmiVL7AkcVBlOABk7/2rYco=; b=GbH/Xo/g2EqNMCj6KFruAu41r5
	yVNBKsh4zlKTOrdiVmsffM5nkTuu5pml44Ki+x7e9BXzYw9kfre0DTS3D0Us058o+X4SG0+R0WVUk
	PaVjcbUeVmQGkfqdwX/i8TTm9fVUcdXrDXyrvOWD45Rgi0M6OSrNgvfQS7y0QKnob9TD6H+ww8zLQ
	nejwkM4ZwULeflwDtEPz/kboahNRRPqIGT1peiwuZt4M0IsIrf+MfEvnbfhjDJSh3vZk3Ck5rsg7m
	fAwUTMqvFlJuXqlTzTdX/mDv683FihxyuHjvXbDpumPRj+3/CgvVVsAwTe7erAOx0vVS9BLpDIUaE
	z1e+KtaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qfH-0000000Fyb3-3yoc;
	Fri, 13 Mar 2026 00:46:07 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qfF-0000000FyaX-3767;
	Fri, 13 Mar 2026 00:46:06 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id C57AE1301B4C;
	Thu, 12 Mar 2026 20:46:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362763;
	 x=1773369963; bh=PvJJgAoi6+6/iAinwR5eAmiVL7AkcVBlOABk7/2rYco=; b=
	gKwSPNrDp/Lh0K2AdmDPuP81x/xKJYynieIS613cuyIap5TJBGt5zoBJQkcnLx+P
	wIIpre2IzG82z5AyDZagtjjr4EtLFHuY+3ew5fDab1/yIPB/uUEieMSrkA3SAGQh
	0hw7ulI7fDK+6bhU0r4qO4EEemUcLLydcBXxhaWveI05xHIYigrT2kv6HGB22iDl
	Pm7Z70iYJsrxhQm/lNa8SebZsdmRrivu1M2XBRDOdTP/LlqHocEGRvESnBiNX92B
	JLUzL7W8K2qPLuHSJfmCX21NPVd1NhNhOrW+1abIUaEPZHtwCQuWsFmoxcxpcZoQ
	s9OP3WR1HmclPU7UtiAU5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362763; x=1773369963; bh=P
	vJJgAoi6+6/iAinwR5eAmiVL7AkcVBlOABk7/2rYco=; b=lBx8/it30WvLfM1Ut
	4V40yFC8YMQTxuozALmQF1Kz8GrZRjYHh0SEma52k1oUapkTo/R08AT0F53b9/VY
	xdwzYS7PxHPQqsugkTC7WGac+zdsWTTGVKW6btlA+rILgtb5JxhC04Vy/65L2Xdv
	gVJcdhH41QdzdnSyemJSUkWvzFljqohC48EoOSDQD2TO/gvb0ZljX3XBCb38KUN/
	K+Vr6CN7cP5atIEEGvmRRks84tlmL3uGXzUXmKCpw01j5H5hJwsVnCDxu6xxFoYd
	SqpnoXrKs1sjPLo+NcbXGxHzrmCTuu76BPw50bfweWvA1mDAr7hV9ogvlDfmv7zI
	1xFmw==
X-ME-Sender: <xms:S16zaUATOTAdUJHvPn1j8hALIFcGRTY7CqUc16mh-7kpVKdUNqbudA>
    <xme:S16zaaNsN6WULJMEZEYNHEfjGUNLg3TOo3eaDKIpm1RTVN3yGVRWZAvSMGgaIa2it
    zCE8_z9EZtPihlV_knN9gyoauJDoLEX_bOdCZHU5Lxo9MKjdNc>
X-ME-Received: <xmr:S16zaSrByZrWq7H4eUim4f3MNHov96sAFzfyid3OWyvok-ilizmXdhDBXHbVUd_PivqzLTCOghaD0LUru-wo-Mt2CSaRzfWYgxwjiDiN0QJ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:S16zaYPao2XJJDUhQdklcQ-SsDGTxjCkGZDxZQnFX_-wWOM18mzM3g>
    <xmx:S16zaezYESx1jpjLQkq2IsSCH2hcX8BGl2KDNnw-JHk3TIaPIkf8aw>
    <xmx:S16zaR3sP_vaX_rkdTjpttWUBD6HoQ2X8iZG1g7atODF1WCyli2TtA>
    <xmx:S16zadTuHaCPpH1HtOdIocFwfnH-uWVUynbgpiYtByM0WOqO3X63lg>
    <xmx:S16zaSPV1vYMjAglL0pfAPcfhz6A-1ky5mxg6OKIh6zA3xacPhk5bBc3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:45:50 -0400 (EDT)
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
Subject: [PATCH 27/53] smb/client: use d_splice_alias() in atomic_open
Date: Fri, 13 Mar 2026 08:12:14 +1100
Message-ID: <20260312214330.3885211-28-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174605_837590_DF604BD5 
X-CRM114-Status: UNSURE (   8.26  )
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

atomic_open can be called with a hashed-negative dentry or an in-lookup
dentry.  Rather than d_drop() and d_add() we can use d_splice_alias()
which keeps the dentry hashed - important for proposed locking changes.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/smb/client/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index cecbc0cce5c5..361a20987927 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -439,8 +439,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 			goto out_err;
 		}
 
-	d_drop(direntry);
-	d_add(direntry, newinode);
+	d_splice_alias(newinode, direntry);
 
 out:
 	free_dentry_path(page);
-- 
2.50.0.107.gf914562f5916.dirty


