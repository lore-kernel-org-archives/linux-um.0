Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Tue, 31 Oct 2006 16:11:55 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061031211155.GA6824@ccure.user-mode-linux.org>
References: <8764elbcrj.fsf@glaurung.internal.golden-gryphon.com>
	<20061025122339.GA23127@SteX> <20061031075238.GB17198@SteX>
	<200610311225.16874.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200610311225.16874.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Pkg-uml-devel] Re: [Pkg-uml-pkgs] Bug#393263:
	uml-utilities: New version uml_utilities_20060622 has humsify,
	please update
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Pkg-UML developers <pkg-uml-devel@lists.alioth.debian.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, 393263@bugs.debian.org, user-mode-linux-user@lists.sourceforge.net, stefano.melchior@openlabs.it

> About this, I'd have one question to pose to Jeff: when are you going to 
> include humfs in mainline? Last time I asked you this you said "ok", so I can
> guess you'll send for next cycle (2.6.20). Is that right?

Yeah, I was going to do it a couple of weeks ago, but then I decided to bang
on it a bit.  I fixed the inode refcount bugs that turned up, but you still get
still some interesting link counts when removing directories.

See the gory details in yesterday's diary entry.

When I stop finding bugs, I'll send it in.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
