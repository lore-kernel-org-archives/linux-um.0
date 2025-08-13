Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A8CCA0EE0
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 10:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkzYlmfde0nKK/uV8sLnldQ8PHSjHQtZnTKNxpjhafo=; b=mSZ4KTljx38LpjsWhWEidGXD9s
	Y1K6cscIduZAD/W9tKlBbcL8iXlcd7MEgTxFI/yOoCAbMMhCB6CZ/zlt9lJvW270R4kTEzcH5cOzS
	MOUGHZ8X7tEXkOZh1fuE3tWu6Kqf6cAZPj7F8Eclr13DIahWjJKBGk9M1CEqUL5eFU0MJsCEw040f
	MVPQGIz0kHppXH6MYPIJ/TKqpH2m1JDYQkkKoO+sblAtJhMoNSAw2/jhqTUIsrsywZ3Kt9/ikw4e/
	WKXgeAdrezT9KPeYF8PAztVLmbORfrxiuYqq3bedNkHgls4NotwlUVHbaZiHLRInJN2RGicUGeorU
	dNd75R/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um8Wi-0000000DLaW-1tJu;
	Wed, 13 Aug 2025 10:16:12 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6Fw-0000000CzMz-3rPv;
	Wed, 13 Aug 2025 07:50:45 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1um6FT-005auZ-1H;
	Wed, 13 Aug 2025 07:50:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 netfs@lists.linux.dev, ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] VFS: add dentry_lookup_killable()
In-reply-to: <20250813041506.GZ222315@ZenIV>
References: <>, <20250813041506.GZ222315@ZenIV>
Date: Wed, 13 Aug 2025 17:50:16 +1000
Message-id: <175507141618.2234665.4849620982329749562@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_005044_954821_72D1F905 
X-CRM114-Status: GOOD (  12.93  )
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

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:06PM +1000, NeilBrown wrote:
> > btrfs/ioctl.c uses a "killable" lock on the directory when creating an
> > destroying subvols.  overlayfs also does this.
> > 
> > This patch adds dentry_lookup_killable() for these users.
> > 
> > Possibly all dentry_lookup should be killable as there is no down-side,
> > but that can come in a later patch.
> 
> Same objections re lookup_flags and it would be better to do that
> at the same point where you convert the (btrfs and overlayfs?) callers.
> 

I had trouble deciding whether it would be better to merge the patches
for easy review, or keep them separate in case they needed to go through
different trees.. I guess I decided wrongly.

NeiBrown

