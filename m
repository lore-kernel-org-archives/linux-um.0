Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FfU0Z-00049B-Bh for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2006 20:44:35 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FfU0Z-0005XR-FA for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2006 20:44:35 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FfU0Z-00055o-1k
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2006 20:44:35 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Bug#366915: user-mode-linux: fails when host
	kernel is linux-image-2.6.16-1-k7
Message-ID: <20060515034427.GE21383@ccure.user-mode-linux.org>
References: <20060512035019.18151.73446.reportbug@doof.home>
	<20060512200806.GA27800@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512200806.GA27800@inferi.kami.home>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 14 May 2006 23:44:27 -0400
To: Mattia Dongili <malattia@linux.it>
Cc: Paul Dwerryhouse <paul@dwerryhouse.com.au>, 366915@bugs.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, May 12, 2006 at 10:08:06PM +0200, Mattia Dongili wrote:
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> > VFS: Mounted root (ext3 filesystem) readonly.
> > mapping mmap stub failed, errno = 12
> > Kernel panic - not syncing: start_userspace : expected SIGSTOP, got status = 256

Hummmm, is this a 2G/2G host, by any chance?

The French report is complaining about this happening after a host
kernel upgrade, and I would assume that this wouldn't spring a 2G/2G
split on you without asking.

UML is trying to map a page at the top of its address space (which it
assumes to be 0xc0000000 unless you are running a 2.6.16-rc4 UML and
enabled host 2G/2G support).  We need to figure out why that doesn't
work.  If it's not the host split, then I don't have any other ideas
off the top of my head.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
