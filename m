Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C5AC87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 04:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGFlvnNAi/Tl7nNsEWG2qsCanGGPDT6DKS+ZvemjV5o=; b=35UvB6POU7PnF0352W2L4UZEHd
	cBSxWXoP4HnaEYC3YBVVYbgpdXfM1E0wbZBGVkxCzspAbwHl/4Y1GA1ghxnE0TOkuA7ppiuO9LmOL
	3Nl0eTJsqL1j2zMPivyZf4L65pM1f/zKpX6hMbzcDLUaAxvQiHT++/0gesvqtRgqQy2fHwYrhNeqP
	4TREnMsaHajqKOJk9cu2/jbOJ31BXNvPNhYnNgt4wOV4CdT+RN4VCoEq45UcD0ToLAAkXUD4R8GSQ
	1hX7jw2Ll9Re2uQ+peTNNZ/g0m55dUYd0tUMbOToGYemyDhTdaGR5V0hKTcXVKt5I2XrHwUyFlZNJ
	406pp3cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2tS-0000000CZJQ-0V5z;
	Wed, 13 Aug 2025 04:15:18 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2tP-0000000CZIb-3To7;
	Wed, 13 Aug 2025 04:15:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mGFlvnNAi/Tl7nNsEWG2qsCanGGPDT6DKS+ZvemjV5o=; b=ZVkRJfHgEHCeXHIbXJ1rESudU6
	thRh1RQkyDWCEzipzEmpweoNke5WA2w7PIb8rrshD9j1gudgyh0P+mekEtlO8xV9OdXB4XVVZ+HDx
	fgfWBOHyTHhQ6AxToVRTAifMjbEr7rK16KK4zRdXmnjOoTB2gAgOnHf0C6ryNFFuIEEKr2mB0Z7YJ
	4jy6xB2tleJ5hykFw28TkBDDtoZZrAqkAGRkGw9seWWd8uvdiFdAr0nMJSso+TWnJy/OUVRSmVYsc
	VRnEh6YqdZtpTJi8r8qD0bgUk8cc8uyfTgPsjWiSV1g9qsmSbOKjXj7BuQ4k+P0Pj6aGQ4EWD/aAO
	oqv0joyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2tG-00000005RsT-0Enk;
	Wed, 13 Aug 2025 04:15:06 +0000
Date: Wed, 13 Aug 2025 05:15:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] VFS: add dentry_lookup_killable()
Message-ID: <20250813041506.GZ222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-4-neil@brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-4-neil@brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_211515_870714_6DAEC01F 
X-CRM114-Status: GOOD (  11.23  )
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

On Tue, Aug 12, 2025 at 12:25:06PM +1000, NeilBrown wrote:
> btrfs/ioctl.c uses a "killable" lock on the directory when creating an
> destroying subvols.  overlayfs also does this.
> 
> This patch adds dentry_lookup_killable() for these users.
> 
> Possibly all dentry_lookup should be killable as there is no down-side,
> but that can come in a later patch.

Same objections re lookup_flags and it would be better to do that
at the same point where you convert the (btrfs and overlayfs?) callers.

