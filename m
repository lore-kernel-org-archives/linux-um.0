Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<BATV+ce7eb84930190412d116+4160+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1YB9ol-000684-82 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2015 22:20:07 +0000
Received: from bombadil.infradead.org ([198.137.202.9])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YB9oj-0001sk-SU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2015 22:20:07 +0000
Date: Tue, 13 Jan 2015 14:19:58 -0800
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20150113221958.GA27739@infradead.org>
References: <1421187358-32600-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1421187358-32600-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] hostfs: Use noop_fsync for directories
To: Richard Weinberger <richard@nod.at>
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 13, 2015 at 11:15:58PM +0100, Richard Weinberger wrote:
> Daniel reported that dpkg(1) dies if the root filesystem is a hostfs
> because it does not expect fsync(2) to fail with EINVAL on directories.
> While fsync(2) is allowed to fail with EINVAL if the filesystem does not
> support it we can do better and use noop_fsync() to not confuse userspace
> further.

Shouldn't hostfs pass the fsync through to the host filesystem?

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

