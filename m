Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B10DC87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 04:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xdU/0zwSMH2y0O1TRA9YmJ5Fw0UxuvH5pkvmlwTE5W4=; b=oCcoJHhnG3WckfRWebDegG2j2t
	LM8658eD/cU42Vwekutco3QmkzhvtalzsQ7E7puW4sTauKaOkGXQRApPJjazEuT/MxNRu+SRfHrRw
	vfReJO+LYnTk226S2E+uqXBtgfkRinioNefvg0gKPMSStpCGP847EtbeCv3/1vbHapGUcP+sBoaTQ
	vzrlSJ1e1/eJ6lxf59Y8947j3tEYI3BY7KqU9L42aPHlz0OAKogb7h+hD515KiiLl0sJf73zMKXaB
	peFFZ4+sW2vBJNPFbOVJ0dH7rvkybkOYOf7NFc/m/AYjvp7pymXmRkI80oRCwmcdi34ZKT9Y3kvuE
	nf/CgYFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um31B-0000000CZte-19B7;
	Wed, 13 Aug 2025 04:23:17 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um307-0000000CZiL-0MeQ;
	Wed, 13 Aug 2025 04:22:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xdU/0zwSMH2y0O1TRA9YmJ5Fw0UxuvH5pkvmlwTE5W4=; b=E+YLf8qvXLfxYK0as6o9jTXHlV
	yV1NRjXLvW9S0R51j1f3lLc0CGwYDCeWM7y/ylMOtQm9Jx2ANDc9nb+S+roZZ7ANg1Myuq0go4ZR1
	Z+zJpGFlqLoT3GF0gU1JVh+h459QD9szlEO+8ULWb9wPt5XR9Go9ehuUZEike+kKFfYZxzwA2JovI
	OWx1fqHFlkh6c9KE8pGaNxB7aN0eqFbkARwEvK3rACEuaDUiKtCBGKXNWP90A8UpYtw1tAMjG1b/Y
	HsCWforfyvrltzOcXDT9AapZpUs3yCk6YpcxDcZIYg3osY9wQcz6z4BAkW9+MUEp7h3sUGYpc5Q0L
	Gl0P2Sbw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2zy-00000005WTr-37Ng;
	Wed, 13 Aug 2025 04:22:02 +0000
Date: Wed, 13 Aug 2025 05:22:02 +0100
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
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
Message-ID: <20250813042202.GA222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-5-neil@brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-5-neil@brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_212211_122844_CBA5C03E 
X-CRM114-Status: GOOD (  19.64  )
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

On Tue, Aug 12, 2025 at 12:25:07PM +1000, NeilBrown wrote:
> A few callers operate on a dentry which they already have - unlike the
> normal case where a lookup proceeds an operation.
> 
> For these callers dentry_lookup_continue() is provided where other
> callers would use dentry_lookup().  The call will fail if, after the
> lock was gained, the child is no longer a child of the given parent.
> 
> There are a couple of callers that want to lock a dentry in whatever
> its current parent is.  For these a NULL parent can be passed, in which
> case ->d_parent is used.  In this case the call cannot fail.
> 
> The idea behind the name is that the actual lookup occurred some time
> ago, and now we are continuing with an operation on the dentry.
> 
> When the operation completes done_dentry_lookup() must be called.  An
> extra reference is taken when the dentry_lookup_continue() call succeeds
> and will be dropped by done_dentry_lookup().
> 
> This will be used in smb/server, ecryptfs, and overlayfs, each of which
> have their own lock_parent() or parent_lock() or similar; and a few
> other places which lock the parent but don't check if the parent is
> still correct (often because rename isn't supported so parent cannot be
> incorrect).

I would really like the see the conversion of these callers.  You are
asking for a buy-in for a primitive with specific semantics; that's
hard to review without seeing how it will be used.

