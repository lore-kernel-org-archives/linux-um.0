Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXkRM-0001fT-6O
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 08:58:56 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AXkRK-0004NR-7T
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 08:58:54 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031220171450.GB10692@ccure.user-mode-linux.org>
References: <20031220011323.GW18100@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220011323.GW18100@alcor.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 20 Dec 2003 12:14:50 -0500
To: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, 224502@bugs.debian.org

On Fri, Dec 19, 2003 at 05:13:23PM -0800, Matt Zimmerman wrote:
> There definitely seems to be something awry here, even in skas mode.  I am
> getting a lot of ENOSYS errors inside UML:
> 
> /usr/lib/apt/methods/http: error while loading shared libraries: libc.so.6: cannot map zero-fill pages: Error 38
> 
> dpkg: error processing /var/cache/apt/archives/debhelper_4.0.2_all.deb (--unpack):
>  failed to rmdir/unlink `/usr/share/man/man1/dh_compress.1.gz.dpkg-tmp': Function not implemented
> 
> basename: write error: Function not implemented
> 
> etc.
> 
> Downgrading to user-mode-linux 2.4.22-6um-1 still has the problem,
> downgrading further to 2.4.22-5um-1 (the old binary) fixes it.  The
> following things changed from 2.4.22-5um-1 to 2.4.22-6um-1, most of which
> were outside of UML itself:

These changes look OK.  I looked through the -5 to -6 diffs and saw nothing
that would cause stuff to start returning -ENOSYS.  The only thing that 
seemed remotely relevant is the unistd.h change, which fixes a bug in the
case of an error in an internally called system call.  You can try reverting 
that and see what happens.

Beyond that, if you can find a system call that reproducably fails, then
just step through it, and see where the -ENOSYS comes from.  This shouldn't
be too difficult.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
