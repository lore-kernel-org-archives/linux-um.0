Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCC9106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3if7F0C5AAC1JbkpbjSMCxjLy6rTA44JQ48V382ux68=; b=t9My8afA20w9Vh8+YXDMLLBKoL
	jsf4ukMOvabXRYyK0uCdhSMAvtcsMYCK3r3n2SLoy5QHv1GTFi9LRFtBmrTLxSLF0wg8/0EtF5ISG
	iQ8rTGHCeLoPKGhW1vSga9noAeNu8mlhmW6ylmd/3WVqhsSVb6tR3zci6i63Y8OMkGLzOpO7s1+5p
	E6QHNr8cc11Tjiu+kUiisgxa+TxL/42PH0KmG7FjQzReGX4q8BGMOCqPUSir/sCzukD0ev88J1wl1
	+sVS6HlxUZPbp2Lp+O46sZ7UIK4xKfjG0woV42UtaCk+7Q6bZ6byKHnZYp2enL39sQcLTbFSkCVw1
	SrPUlPFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o06-0000000FYMB-3ZPO;
	Thu, 12 Mar 2026 21:55:26 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o04-0000000FYKz-3adA;
	Thu, 12 Mar 2026 21:55:26 +0000
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id B10021301BB1;
	Thu, 12 Mar 2026 17:55:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 12 Mar 2026 17:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352522;
	 x=1773359722; bh=3if7F0C5AAC1JbkpbjSMCxjLy6rTA44JQ48V382ux68=; b=
	H9EUTHF4r4ntt850sUfeaQwtq1wg4xsapXTK+Bmbed5aBY6rGmecjBhkdb50KJJw
	yozmTs8rF52SI0/+6uErAmNlGCje+eaAeWizSuONzzKl6bXgUCbXrhvC50Ypb7Af
	BuGa9IVDBtnD0iI8cWgMLPEUvMmEROZjn+AsiwMbv31vHNMtLCOR4d07pF0F4Lhg
	SNbbwsak0t8uJDaZE9lEde5l/a/YGjv6Xm4eNNckpbnB0IlGBxn/KhnzKdHNNzFZ
	knquaTl2pgOiMYO5E3YdT59XdMgZ0B1OMFY55kq1VrLl65vHBs54fKiIaiYZmgZO
	fqr3ecAc7MP8Ib5llOeGMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352522; x=1773359722; bh=3
	if7F0C5AAC1JbkpbjSMCxjLy6rTA44JQ48V382ux68=; b=mgyMS/w//zLJozQuG
	iBMTVjEfl0NOrr7Zw66UNwTwbYxizmZhVHmA+lAQV7/jBPswUdXTZ/qZkmNM0DbI
	hKs8be9mTKQLa70XyuohH5vgJkcJ1Lf8CHfRHjX7K138+x0nvdCHx2JEpJOh8Q9K
	b7tWB+BgUW+qbsdIbWL49y0BSSPZZBWkUT/0NROD3UXKrVMw/3e1jvhZvGmRDQPf
	rIucBRKYZcMMA5TWkb9RLF9azs/HYd20sSGyOiiSqcmLp07MuJSg0uO1QiHA+HDc
	kRdsREoMdkfSJ28UBPTNkNY1lteIgQBwopJWj/nyyb32cXnM/7f4uBkmUlEFoI/+
	ZjyBQ==
X-ME-Sender: <xms:SjazachlAWJOSN8lEQ87olBQ4THW8YdF9RlFWlc9v1XRyDGCmGTfvg>
    <xme:SjazaesTvDYRW7k5iGIwjm9wIQkza8VuF4_UiMEvTBY5e4FYpn8LFq750dz1l4Dbi
    5jkSM07bgIUuiPmW8hzI3cpP5dADZ3FHZwwfkLfWGcWx44OaA>
X-ME-Received: <xmr:SjazabB8Fiq6DqmKllIMxsq_KLyOsejW5MZSugEFwbVXYgw_6r5d_7imDhHWM-mTZXu0THro99dT64wYsu4Hzq_iSBjowV-xxI_6AyXiDiTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SjazaRVUEVbr5DICwZBK751qOvfjCumW4QjiWYsKS2grgUvd77XOSg>
    <xmx:SjazaZIyen0EDW-Ii1W8JpDgpqmir2JNlPjLTK8IUePBHyms0uCV8Q>
    <xmx:SjazaaUMF9hRGxMFgBbvbfSm7iXGN_MPHRezxnabrg7dw7H8WZk0EQ>
    <xmx:SjazaSR3lRAk_iK5JZ_cuPeri7l3gQKqEqg_Vuzki0vn4_fQDAwXYw>
    <xmx:SjazaXyIFx6sW7VqeUJx3htwVItRXiIok1LvXEF8SiWSLKfBtXaSuRZS>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:55:09 -0400 (EDT)
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
Subject: [PATCH 41/53] libfs: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:28 +1100
Message-ID: <20260312214330.3885211-42-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_145524_979779_5E3AD386 
X-CRM114-Status: UNSURE (   8.80  )
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
function.  d_add() often works and is not incorrect in libfs, as the
inode is always NULL, but as it is planned to remove d_add(), change to
use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/libfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 63b4fb082435..75f44341f98b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -79,8 +79,7 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
 	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		return NULL;
 
-	d_add(dentry, NULL);
-	return NULL;
+	return d_splice_alias(NULL, dentry);
 }
 EXPORT_SYMBOL(simple_lookup);
 
-- 
2.50.0.107.gf914562f5916.dirty


