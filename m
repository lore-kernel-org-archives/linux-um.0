Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYQ5Y-0006Ad-7R for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 09:08:32 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FYQ5W-0005gX-PQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 09:08:32 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060425150913.GA21247@ccure.user-mode-linux.org>
References: <200604242237.52295.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604242237.52295.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Running uml on 2.6.16.x kernels
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
Date: Tue, 25 Apr 2006 11:09:13 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 24, 2006 at 10:37:51PM +0200, Blaisorblade wrote:
> I can't run a 64 bit UML on a 2.6.16.9 kernel. I get constantly this error 
> with various binaries, some of which I'm sure worked on 2.6.15 host (I'm 
> going to retest):
> 
> VFS: Mounted root (ext3 filesystem) readonly.
> Warning: unable to open an initial console.
> Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, 
> errno = 0, status = 2943

The ptraced process is getting a segfault instead of a trap.  Smells like
ptrace...

> I went looking for ptrace commits in -stable (I didn't check yet between 
> 2.6.15 and 2.6.16) and found that in 2.6.16.6 this was added: 

Obviously, revert these and see if they make a difference.

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
