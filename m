Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXrqC-00028P-Pu
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 16:53:04 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXrqC-0000qn-Gf
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 16:53:04 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031221005257.GF9354@alcor.net>
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220171450.GB10692@ccure.user-mode-linux.org>
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
Date: Sat, 20 Dec 2003 16:52:57 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, 224502@bugs.debian.org

On Sat, Dec 20, 2003 at 12:14:50PM -0500, Jeff Dike wrote:

> Beyond that, if you can find a system call that reproducably fails, then
> just step through it, and see where the -ENOSYS comes from.  This shouldn't
> be too difficult.

Unfortunately, I can't seem to find a system call that reproducibly fails.
There's something weird and racy going on.  With exactly the same UML
invocation, twice in a row, the first will panic:

Kernel panic: Segfault with no mm
In idle task - not syncing

and the second will boot successfully.  Even within an invocation, things
aren't normal:

sh-2.05a# apt-get source -b hello
apt-get: error while loading shared libraries: /lib/libm.so.6: cannot read
file data: Error 38
sh-2.05a# 
sh-2.05a# apt-get source -b hello
Reading Package Lists... Done
Building Dependency Tree... Done

And of course, I haven't been able to get this to happen in the debugger
(yet).

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
