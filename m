Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9E4106FD61
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=epUsWlAclv1DX2KFvnl7YFoPpzqQm77MgVOFM+B8UxU=; b=jEyJoVQ1RluISvrujUBmTHLhbc
	6OTFhww+CwRPJvohMnSh4YA9nTJWXq5ylS2+xsNrQkWU5GEfolunT/0jvu1X0VokbJW29cBveI78P
	9RK5RdnU4rMjZAVrl+kU1kr/tz1EQGEXoCI9P/AeTZjxbN7TtVNmvu3EqvY2CIVot0Zbif2bjxMD7
	dBPuti7ogkEd6UPUYhh1eQCF2ahpfrnUSNPG9gtPRponfmz90U0ZrJ1nEJuSvOgnMJOmZ7AsoQT2C
	NG/Qy9y+4NstYwjvHxGB7XGV1L0sFUVwrVa5mqirkxk6M9wBV8Xl0QWBZiPu8UEQ4/bUQT4+em4eJ
	tE+UmifQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qeC-0000000FyIf-0xS0;
	Fri, 13 Mar 2026 00:45:00 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qe9-0000000FyHo-05XL;
	Fri, 13 Mar 2026 00:44:59 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 273051301B3C;
	Thu, 12 Mar 2026 20:44:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 20:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362695;
	 x=1773369895; bh=epUsWlAclv1DX2KFvnl7YFoPpzqQm77MgVOFM+B8UxU=; b=
	CqROUpl0SFgdLYM+5S4HfZslkqN7s5xdFeJrWFhMGpiUdyODd7Z+7ZvN1Cp31hpK
	ZT7KdwX8nus+Re9RyFZ7Lmx2HS/y4aAbuKPyjNSlyG4QT9GlQP35c7Qc/wveUpJc
	R6fyTEJL1SYXniLv5tJqSk0lVP4TG9izP0Z5673lCC1cVr3QRjNHb2xuAnovPDIN
	SWebynoCqykrPAnihTtAf4L4HNSaXCdZDUwo3lrKJrbCjD9/oexYvaM0MJCepNAl
	UAzWnRabXqQJKdQ+UqQhD+TSINUJmdz5L/8VPRv5cvG/4/0ylXxVgi/4RB5tBewr
	q+8rr17BgBMChmtR+WIx8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362695; x=1773369895; bh=e
	pUsWlAclv1DX2KFvnl7YFoPpzqQm77MgVOFM+B8UxU=; b=z24mIuT+M2aYx8BDn
	/SvHK2UeiuT9Zv020rqyHMZx6iwO9BhUEN4xj0P9wfCsYHthOQ7I3eXW+qtsed2n
	/hGxBGJFKKkTmgXNYq9tJp1zytp6kg+1P5x0LuPwfGAY/urC++X+Rh/67vfy5hZl
	DF1pkcDi9UQPUY2J1H/YNQzRgxd7MjUUl8aQvK/mKz5IoPlHl9bi+l9YIlwoaZgH
	Zk1LmrrSqNDSvYiABRJ2cxUaljb/oxyhp6EmBjDzWaeW+e+D8vTq2jf3ic7Ke1iv
	RjnCU9b8SvZ4hBQDdVmd8EVd30w+Luquz27gPL6jEjG5gzX9KlTD0SzRez021FFn
	iosiw==
X-ME-Sender: <xms:Bl6zaStXJ9WAw-16S3bYaCz_RnS8tYIFCyfwjxNZHNrhQ9Ae5W9-Xg>
    <xme:Bl6zabJ5U1axuX6nlB6VWQLXTnvvS2mY7Jgk-rmULAb0W5ZhgWxydmDeaAFefR9aW
    TEl-nDM2wCNr6XpJ9HBJO6rHcSSiZmkWgKeXXxmS55kQhKFIA>
X-ME-Received: <xmr:Bl6zaY3KSkPbpdXhtNRFclXHaXrF71EMYZcvCFtn3vRjXfFhyhDzrAo3wC1O5tXXPk3IWimgPTOXKMOae_kBFPhBSEbSvIB5v8w_BH0Myp5z>
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
X-ME-Proxy: <xmx:Bl6zaarLR5ShQVdaOoWUVtIhXP2j0-a8MHXe_bBheeqOXSt1kFPCYw>
    <xmx:Bl6zaYeQfHS5JnVFj1qQxZXh5cdBT39G07cL5E5Dm-e7x3pBmT-Rgg>
    <xmx:Bl6zaRxbiV781OoMd07m9PkrWVRBBoGMyd0NWxXe_GpCM4BzatSIGA>
    <xmx:Bl6zaWdLL1WOPvL9MrrQBGVzVZJ-LjPPQ0X0uOHzWW3JziVEDBVF8Q>
    <xmx:B16zab6RlMl90xxVmmES_1mzBODI5Ga6UsScuDL74A1RJ5HwqAPRxTmx>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:44:41 -0400 (EDT)
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
Subject: [PATCH 31/53] configfs: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:18 +1100
Message-ID: <20260312214330.3885211-32-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174457_164311_0B9AC968 
X-CRM114-Status: UNSURE (   8.66  )
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
function.  d_add() often works and is not incorrect in configfs, but as
it is planned to remove d_add(), change to use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/configfs/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index c82eca0b5d73..6ec589b6b8a4 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -501,8 +501,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	}
 	spin_unlock(&configfs_dirent_lock);
 done:
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 }
 
 /*
-- 
2.50.0.107.gf914562f5916.dirty


