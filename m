Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hch@lst.de>) id 1P80kI-0003z3-Jm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2010 01:12:06 +0000
Received: from verein.lst.de ([213.95.11.210])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps
	(TLSv1:DES-CBC3-SHA:168) (Exim 4.69) id 1P80kH-000082-6a
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2010 01:12:06 +0000
Date: Tue, 19 Oct 2010 03:11:25 +0200
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20101019011125.GA3905@lst.de>
References: <1287419814-20086-1-git-send-email-richard@nod.at>
	<20101018114039.503233da.akpm@linux-foundation.org>
	<201010182053.58496.richard@nod.at>
	<20101018130208.7b552527.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101018130208.7b552527.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH 1/1] hostfs: fix UML crash
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, user-mode-linux-devel@lists.sourceforge.net, toralf.foerster@gmx.de, jdike@addtoit.com, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>

On Mon, Oct 18, 2010 at 01:02:08PM -0700, Andrew Morton wrote:
> > > 
> > > Is there any reason for hostfs to be playing with the f_spare field at all?

No, there is no reason at all.  do_statfs is only called by
hostfs_statfs, which is the hostfs implementation of ->statfs.  zeroing
of the spare fields is done by common code (vfs_statfs_native).

Can you submit a patch to just remove the spare_out argument to do_statfs?

> 365b1818 added f_flags to `struct statfs' but didn't carry that over to
> `struct compat_statfs' and hence didn't copy f_flags over into
> compat_statfs.  Deliberate, or oversight?

Oversight.

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

