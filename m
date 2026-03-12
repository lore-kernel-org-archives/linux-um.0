Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71167106FD60
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WEn/ifGqMa6Ax93LDCMof9WVE/J3cBfFQIVVntI4FSU=; b=d0PmxLOVrVnFBfDD4ER2J4T3bE
	21H55HNlvO/YFTH5vm1orHUMuoTk8iWCep7Et2aVUkmyqUTBp3yUK9fwaSJ5TfySgcrVap4x5++vt
	Xk4QX5VOuMYC/mwO4r6/M7JSbIvfdDxn4IIXpZxXzveYImOicfER2+GN0Aq0KriN+VAaKrhuCDwVD
	DFECmkhfD2T54jCjyGNHihr4MF96w8XJcw9ILyuFpzZEAGYcU3vWKaeLmrpUX4T78YOjudlArKwU6
	083pF7jRtxYavjSogCjzS0Jhb6XJuUhiOfChTCkWM9sopoxcYb8TGj8/FWGXuyB+m6P5mmiU/ZBsg
	DAr5C74A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qeS-0000000FyNx-0o5S;
	Fri, 13 Mar 2026 00:45:16 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qeQ-0000000FyNH-0m9R;
	Fri, 13 Mar 2026 00:45:15 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 4ED741301B42;
	Thu, 12 Mar 2026 20:45:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 20:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362712;
	 x=1773369912; bh=WEn/ifGqMa6Ax93LDCMof9WVE/J3cBfFQIVVntI4FSU=; b=
	gZ+8j40UJfd35YHLEn8GltXBxrkHPPJuG8UzNQ3aeCppl0Bx/G/7pz2k7GhTJmjj
	mMkAf0dDw+XbG44/22ZHnC0JRrXwzH8q+b82+ON+NK+C1ecJu5I0G6cz+Vt/yust
	YtInsQcWto7IBJEOT8YxmPsZCQpX3QkE4fAQTc0qcS4tV0zoArACYwrCYiAcYuR2
	IU3IwRQR4aA2y5hgvfqRNgHlsCxk0iBegjLC050ZkP1ZyWpg+OZEQdX1QuP/ytZl
	/kpi2YCwgiIZQX+OdMfzYWmhsrdWZfMNXzIpSMtOnpwWF/EVPknBbGGcynUfDN8U
	DaCcDEvlgv1AfZcLYJmQlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362712; x=1773369912; bh=W
	En/ifGqMa6Ax93LDCMof9WVE/J3cBfFQIVVntI4FSU=; b=zzfvAvPPEd2RUPFHZ
	l0AGY0rUFybvZ//8GerfoYDoJ/RiOp618aTFUWOlyRcqPbjs+TwRL0gLxxsIgn9B
	9D19+ZiWTLY6YmJghBQ0EtLyi32bLsLapT86+x3V0Oyr4WcdSP8ViASeFCxFlipW
	+h2cuSFfiKsYtmGkwNjMFh5Wks22+oCYAhUFbfGjj9uat3x3i2ZjM/1YiaEpE+e8
	nv5myRHW2Ieskf5HzoPTOIZ08+j8wF95yGOTtnv4tZUYVtQggkg0IQjwJNs9fLnp
	cK+VOUlhixrvzRekBrrG3Sdeah9seF20NJJD+piNW3SbCTgj0k1feZCLF4BxGTMl
	+rclw==
X-ME-Sender: <xms:F16zad072LGVm4nNLtXOrAE0R4MHeFys17F8aeOgTGGFFsxEqmoKvw>
    <xme:F16zadwY6MqKqvxEVnzjXXhu7yGKdN8mP1ZYLTT82CbpvlqHQLwBO6PUewUXY56Z4
    w_T6uLZaMp1MNL1uJYJMMEsjNPZEnmlMzDtz_GAFuTpukfY5IY>
X-ME-Received: <xmr:F16zaU0dcVnke18uj6A9ullyKRr_uxRR96urzCzwQghQnjqU3W37o55JhZUAG9djAg834APpoywNrQ9x-erMjL6ihxt3rxm9oYrK8MIg3Qtx>
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
X-ME-Proxy: <xmx:F16zae7EsCLuKwBwXpUVK-Wp3nq9hST10o2DtFm4ZdVUHUDoH0CyuA>
    <xmx:F16zafc0zBIwpnROPq_jVe_3OyVNu6Wd_Kvb5bA0x0ZLMd_ZIBFK6g>
    <xmx:F16zaabPROXdG8W7YqgtteFTEoudtOzuCKNyVM0SFp6wLn5_edfCfA>
    <xmx:F16zaZFkMG282SjUNBy4FH7U4gLvxD_T1KDRXugWgu8krhv9pGNr4A>
    <xmx:GF6zaeGFHDmk1taakt1v2R44Go7b4oaB3SIGvOOEo_CQeTBJb9IsLDae>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:44:58 -0400 (EDT)
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
Subject: [PATCH 30/53] configfs: remove d_add() calls before configfs_attach_group()
Date: Fri, 13 Mar 2026 08:12:17 +1100
Message-ID: <20260312214330.3885211-31-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174514_288942_50B6AD35 
X-CRM114-Status: GOOD (  10.37  )
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

These d_add() calls cannot be necessary.  The inode given is NULL so all
they do is attach the dentry to the hash table.

If configfs_attach_group() fails, then d_drop() is called so the dentry
will be detached.
If configfs_attach_group() succeeds, then
 configfs_attach_group -> configfs_attach_item ->configfs_create_dir
must have succeeded, so d_instantiate() will have been called and the
dentry hashed there.

So the only effect is that the dentry will be hashed-negative for a
short period which will allow a lookup to find nothing without waiting
for the directory i_rwsem.  I can find no indication that this might be
important.

Adding a dentry as negative, and then later making it positive is an
unusual pattern and appears to be unnecessary, so it is best avoided.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/configfs/dir.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 362b6ff9b908..c82eca0b5d73 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -706,8 +706,6 @@ static int create_default_group(struct config_group *parent_group,
 	ret = -ENOMEM;
 	child = d_alloc_name(parent, group->cg_item.ci_name);
 	if (child) {
-		d_add(child, NULL);
-
 		ret = configfs_attach_group(&parent_group->cg_item,
 					    &group->cg_item, child, frag);
 		if (!ret) {
@@ -1904,8 +1902,6 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	err = -ENOMEM;
 	dentry = d_alloc_name(root, group->cg_item.ci_name);
 	if (dentry) {
-		d_add(dentry, NULL);
-
 		err = configfs_dirent_exists(dentry);
 		if (!err)
 			err = configfs_attach_group(sd->s_element,
-- 
2.50.0.107.gf914562f5916.dirty


