Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E09CCF9E3
	for <linux-um@archiver.kernel.org>; Fri,  7 Nov 2025 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1SMRxhNRshB8vecJq42CGMcQSf+tMG9pcOEmrtJR/2o=; b=c3y1UQoG2pRlPzUU0IH6UpFI55
	M+yvFuOInhO8EjkKn0yGi2XXKnmtrJ9Q8i2DYLaEHb6Kmx/ya0nYDJvthlSJZYJ6ul5ltmxbAieVQ
	btdIo1e7jX09kjonksy8xZUxro3+fpLppB/t9npdG4zzD5FLR4+/vahrENROVLf7x+qc7uRbNhFjr
	8c5LiohXgDadSFFaOQakhTpSuq5CXokgHfwuFqkYfVBRoPgRKbbyckEE3e1awa/7X7N2f48yiqj+h
	IKXx6WV/xfeqCQKpLyjgE0ogYMcypNXoM+xm2iQUF6ugK6cjgbl2YexVe6GmizLyDRUHfkm06lJRF
	wAjnlTcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHV3F-00000001MV1-3iuC;
	Fri, 07 Nov 2025 22:35:25 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHV3C-00000001MTE-3Cl1;
	Fri, 07 Nov 2025 22:35:24 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 65A4040AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762554918; bh=1SMRxhNRshB8vecJq42CGMcQSf+tMG9pcOEmrtJR/2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gwskUpuJ4a2g0JY5PiFttMjCeJQuS5S9UEPZocWG6S53nMlyt4gNfosYgLoQ6Jwhj
	 dtsb6S+afpYrUIi0QfyDP5S6e0bDBizWxKwt/uIC0tV/2BUoFA5ZIOjasCC/wOB6C5
	 IvBnQSvlGwdiy84Vv7DtwNnU0ThlI1+rpNmvLMNs2Mlba7j5UvudGA8dWS/wNWoEhb
	 QQZECfmiJHj8aTYEDJFrkXseci/C7M7RQmHvvaOKNnK8EDDOg1KshyEqtA+pwvZFub
	 CJuACGdj/HuNVrTYEYhxm/X8rI6+e/rYpIzGlIZWWTn5T4qJ87Gv51ZI5YPYmAqjvD
	 ATLFFKQC18bmQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 65A4040AED;
	Fri,  7 Nov 2025 22:35:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian
 Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Tigran
 A. Aivazian" <aivazian.tigran@gmail.com>, Chris Mason <clm@fb.com>, Xiubo
 Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
 Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, Namjae Jeon
 <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang
 Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
 <chao@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Miklos
 Szeredi <miklos@szeredi.hu>, Andreas Gruenbacher <agruenba@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Mikulas Patocka
 <mikulas@artax.karlin.mff.cuni.cz>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Amir Goldstein
 <amir73il@gmail.com>, Steve French <sfrench@samba.org>, Paulo Alcantara
 <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam
 Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM
 <bharathsm@microsoft.com>, Zhihao Cheng <chengzhihao1@huawei.com>, Hans de
 Goede <hansg@kernel.org>, Carlos Maiolino <cem@kernel.org>, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew
 Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
 linux-um@lists.infradead.org, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, Jeff Layton
 <jlayton@kernel.org>
Subject: LLM disclosure (was: [PATCH v2] vfs: remove the excl argument from
 the ->create() inode_operation)
In-Reply-To: <176255458305.634289.5577159882824096330@noble.neil.brown.name>
References: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>
 <176255458305.634289.5577159882824096330@noble.neil.brown.name>
Date: Fri, 07 Nov 2025 15:35:17 -0700
Message-ID: <87ikfl1nfe.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251107_143522_811739_888062F8 
X-CRM114-Status: GOOD (  12.45  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

NeilBrown <neilb@ownmail.net> writes:

> On Sat, 08 Nov 2025, Jeff Layton wrote:

>> Full disclosure: I did use Claude code to generate the first
>> approximation of this patch, but I had to fix a number of things that it
>> missed.  I probably could have given it better prompts. In any case, I'm
>> not sure how to properly attribute this (or if I even need to).
>
> My understanding is that if you fully understand (and can defend) the
> code change with all its motivations and implications as well as if you
> had written it yourself, then you don't need to attribute whatever fancy
> text editor or IDE (e.g.  Claude) that you used to help produce the
> patch.

The proposed policy for such things is here, under review right now:

  https://lore.kernel.org/all/20251105231514.3167738-1-dave.hansen@linux.intel.com/

jon

