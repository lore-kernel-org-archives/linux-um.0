Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA3B106FD60
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uW0rtLXFkbaBWXfGN4/JFrVlhcpfsZme8A1/pyxgR7Q=; b=Rr59h7rN0LqNoeSKMVcDjDwc/N
	55gxBIpYj8e0dOBoKwUSdnAsPoc7/gfrXKHbkzAFxx1LrQhPJMhi1a//SvUOoCHi5MhxvnPd0BXNB
	6zLtOCEdJ/nkfUqt4MJFKtcbaUHhVceMccbE+b/1JeefNNFBdJ8jjmah9TMWsZZwg1i90vzmpemWu
	jF9EFBVrWRoghD/phXa0qoT93Cy8DaHvdgr+jG83zxpBr/dnkcor9sBKvgtVhIWBH7Swq2+sXpl4o
	P/mcEhhceAJocH9qrPTis0o95fAUf43QehDvKWqUeueXRH8rsfn3GJa7gtChmzppXk/1RwNWYc4fE
	vY/Nh+3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qfq-0000000Fyj3-1lBy;
	Fri, 13 Mar 2026 00:46:42 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qfo-0000000FyiR-0S85;
	Fri, 13 Mar 2026 00:46:41 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 36F521301B63;
	Thu, 12 Mar 2026 20:46:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 20:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362798;
	 x=1773369998; bh=uW0rtLXFkbaBWXfGN4/JFrVlhcpfsZme8A1/pyxgR7Q=; b=
	mRnZ0YGCx3gLm0wWBHdN72SdQLIjJRWNHgfmRzo1EeqngvhpXsIr4of+UqGu9OeW
	pUmJLqiIiGQHyeSyktpTCMTAETBXWvPA3OSWBncolVh/nheFGMbFXBXOVYOkqc7j
	FlCEobV9Mp281to+TUFV3T7YHeRK8mPY35N/T7oIyDl6/vfGeOlanFxYy27FByF0
	Wz8wZEy8G8xWc1POLg6uW+P54Kao4gR50BRmV33zpljxSDZ2XKTOWwnbzyaHHJgQ
	q/l/0Jn3R6TRw9lfxXdwBt4cADGARrgvooLknBc3Pk8nLE8+yFY5yj8xeo7zbuLn
	MvAJD9QttjXchwHdcv0txA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362798; x=1773369998; bh=u
	W0rtLXFkbaBWXfGN4/JFrVlhcpfsZme8A1/pyxgR7Q=; b=Viy4tpkswwmJzmT/i
	EILuXqKRFNSgtS2iM9oKc6cjwsKTDd4DN8r1iNUHTfMZqZQOoA27qlLOy+aNCqfl
	scyU5vWIq+dNNVGQzb6L4jTw0gApXgrVxp0OlD5OFr2m2WRVBn5F82cAVUn53wKR
	Rh8CbSYEov+8EEP9iox4dX9pctgJyfOQIu8fkTixZcVobtZOl9otr4gzkcB2LYhN
	q62Ie+fo1atQQJKNJwG6CvWqL3NiRqbZG2j0AlP0L1gKhb7vwzLiXxVsR9jCHSo4
	JHgWRp7aaCFWITa39njjDD5hka9V7wBP3GzeawT/o7YxiSRL8CvJFxM180AOUpkX
	pAkMA==
X-ME-Sender: <xms:bV6zaZ0TCkmKV2ZwVBToDWEWC4jOzc_x0nlMkb5ni-SVAxCRUXniGg>
    <xme:bV6zaTwiRPiTv8mpE101Dr3w-YJr9yJbIee2tX-EQt8kF4ZvwO3Zlwv1PTpAtIv7y
    dWWpP-Hwshx3Zru2-rj7xWwVkSg7R7ang8JVWd7UAdgm8sy>
X-ME-Received: <xmr:bV6zaU-JZnk6IIzo2_kDBG8GVZQm_eDRGKO2eDo6ChrnCuVTi-nTfMPX7AJOwVLG82zOMWUbhwJWVQ6lhxLICbUADyYaBqXAGM4vtSBppUFL>
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
X-ME-Proxy: <xmx:bV6zaURQUqK7qStcEfBYEQoAD1P18ucpMwXvlr-DL_YTmyo7L2VCEQ>
    <xmx:bV6zaRliEawSSwBZEwMHHG8pZKoVeVe6fhRQtiX7dooLuJttvoGjrw>
    <xmx:bV6zaUbCx4vBc_niiX7uOGRwHKN2ZFDRChpwvluVOhl7nwRzhzSSXA>
    <xmx:bV6zaUn0KDBxgyFjvzFEL1i1RlIoxe2Y3rIXUnDbkfKcTMCUjOAtEA>
    <xmx:bl6zaTDkJoQfeWw1TkJRJdYZcxYzB-qvjzkaSUG4eGEgydjZFqIno2Zg>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:46:24 -0400 (EDT)
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
Subject: [PATCH 25/53] smb/client: use d_time to store a timestamp in dentry, not d_fsdata
Date: Fri, 13 Mar 2026 08:12:12 +1100
Message-ID: <20260312214330.3885211-26-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174640_249314_BB768D6E 
X-CRM114-Status: GOOD (  11.07  )
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

smb/client uses d_fsdata is exactly the way that d_time is intended to
be used.  It previous used d_time but this was changed in
  Commit: a00be0e31f8d ("cifs: don't use ->d_time")
without any reason being given.

This patch effectively reverts that patch (though it doesn't remove the
helpers) so that d_fsdata can be used for something more generic.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/smb/client/cifsfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index e320d39b01f5..5153e811c50b 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -30,12 +30,12 @@ cifs_uniqueid_to_ino_t(u64 fileid)
 
 static inline void cifs_set_time(struct dentry *dentry, unsigned long time)
 {
-	dentry->d_fsdata = (void *) time;
+	dentry->d_time = time;
 }
 
 static inline unsigned long cifs_get_time(struct dentry *dentry)
 {
-	return (unsigned long) dentry->d_fsdata;
+	return dentry->d_time;
 }
 
 extern struct file_system_type cifs_fs_type, smb3_fs_type;
-- 
2.50.0.107.gf914562f5916.dirty


