Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA23FC87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 08:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9KG8grtGoOSSPcLatxAKyruQ/HAStK9y33z0VNrv3ig=; b=omh1ILITiEMG9sv0Y9fEmhzFC/
	Cy5tDNQ1gnlXkShdRDoA22XT6nPbVwDH1ms5hBb7ATwXFzZOWhm1tktmOy1FQs2/t0yaM8DARMA04
	rbVkxhC5Dm7DziDd4zjhXOFn8smk1YArvwBjySUa+lE/s08lmKAqVF8C0CuO4VqSUmjjeUL278jnr
	TbiX34dQFo1xSoNFMmZG3D9mZ4XAYGiDWXXAE7kFmDuD3+dMHO+u36QfF0oOErBXJaML3VU6NithD
	pXftJZyCM5YlAVWNVzLigyPfODhpmlsb1Md3XmxwMBfiqrjjCboVCrT8LEDnCu3yMOtVg4nr7veFf
	43aNeL1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6UC-0000000D225-22TZ;
	Wed, 13 Aug 2025 08:05:28 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6JB-0000000D04t-1rui;
	Wed, 13 Aug 2025 07:54:06 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1um6Im-005awI-Qw;
	Wed, 13 Aug 2025 07:53:42 +0000
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
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
In-reply-to: <20250813042202.GA222315@ZenIV>
References: <>, <20250813042202.GA222315@ZenIV>
Date: Wed, 13 Aug 2025 17:53:42 +1000
Message-id: <175507162200.2234665.9318589188954309739@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_005405_486627_D9DEF0E4 
X-CRM114-Status: GOOD (  22.54  )
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
> On Tue, Aug 12, 2025 at 12:25:07PM +1000, NeilBrown wrote:
> > A few callers operate on a dentry which they already have - unlike the
> > normal case where a lookup proceeds an operation.
> > 
> > For these callers dentry_lookup_continue() is provided where other
> > callers would use dentry_lookup().  The call will fail if, after the
> > lock was gained, the child is no longer a child of the given parent.
> > 
> > There are a couple of callers that want to lock a dentry in whatever
> > its current parent is.  For these a NULL parent can be passed, in which
> > case ->d_parent is used.  In this case the call cannot fail.
> > 
> > The idea behind the name is that the actual lookup occurred some time
> > ago, and now we are continuing with an operation on the dentry.
> > 
> > When the operation completes done_dentry_lookup() must be called.  An
> > extra reference is taken when the dentry_lookup_continue() call succeeds
> > and will be dropped by done_dentry_lookup().
> > 
> > This will be used in smb/server, ecryptfs, and overlayfs, each of which
> > have their own lock_parent() or parent_lock() or similar; and a few
> > other places which lock the parent but don't check if the parent is
> > still correct (often because rename isn't supported so parent cannot be
> > incorrect).
> 
> I would really like the see the conversion of these callers.  You are
> asking for a buy-in for a primitive with specific semantics; that's
> hard to review without seeing how it will be used.
> 

All, or just some?
I use dentry_lookup_continue() in:
  cachefiles: 4 times
  ecryptfs: once
  overlayfs: twice
  smb/server: once
  apparmor: once

Maybe I could include all in the one patch...

NeilBrown

