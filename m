Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vJCp-0000sH-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 09:13:03 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vJCo-000618-UD
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 09:13:03 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19vJCo-0006IW-00
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 12:13:02 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19vJCn-0007u2-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 12:13:01 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] hostfs as root
Message-ID: <20030905161301.GT11825@alcor.net>
References: <20030905140119.GM11825@alcor.net> <31667.1062777050@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31667.1062777050@marajade.sandelman.ottawa.on.ca>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 5 Sep 2003 12:13:01 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 05, 2003 at 11:50:50AM -0400, Michael Richardson wrote:

> >>>>> "Matt" == Matt Zimmerman <mdz@debian.org> writes:
>     Matt> Sounds like a recipe for lots of race conditions.
> 
>   Uh, how?
>   Remember, this is in the kernel. We have locks.

There is not currently a lock held by hostfs_file_open that I see; this does
not seem like sufficient reason to make it impossible to do two opens
simultaneously.

>   If two UMLs come along, using the same rootfs, well, that's a different
> problem. 

It's the same problem, and it affects any shared hostfs, not only root
(unless you were planning to add a test for that).

>     Matt> You must have already worked around some other problems in order to
>     Matt> run potato in this configuration; it wouldn't work out of the box
>     Matt> with a 2.4 kernel.  How are you managing device nodes?  Loading any
>     Matt> kernel modules?
> 
>   Works fine for me.
>   It has been working fine for two years now.

What works fine?  The modutils in potato doesn't support 2.4 kernels,
only root is allowed to create device nodes in the host filesystem, and the
paths in /etc/inittab and everywhere else won't exist with devfs unless
devfsd is running.  You're obviously working around these problems.

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
