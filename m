Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vXpJ-0004BR-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 06 Sep 2003 00:49:45 -0700
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101] helo=sparrow.stearns.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vXpI-0005pb-6c
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 06 Sep 2003 00:49:44 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] Hi All.
In-Reply-To: <20030906050017.95333.qmail@web11005.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0309060347120.9326-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 6 Sep 2003 03:49:39 -0400 (EDT)
To: Maltesh Badiger <malteshbadiger@yahoo.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good day, Maltesh,

On Fri, 5 Sep 2003, Maltesh Badiger wrote:

> I am using User Mode Linux (UML).
> I want to know the following :
> 
> 1) How the uml kernel is possible to run in user mode
> (user space).

	It's a _second_ kernel running on the system on top of the 
original kernel.  It's compiled just like any other program; it is loaded 
from the command line, initializes itself, and exits.

> 2) When, we apply the patch to a kernel image,
> Actually what happens to the original kernel?
> I want to know what changes takes place to the kernel
> code.

	The original kernel is left just as it is.  We take a complete 
secnd copy of the kernel sources, apply this patch, and compile that into 
the UML executable.
	Take a look at some of the UML documentation; it explains this 
stuff pretty well.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"... being a Linux user is sort of like living in a house
inhabited by a large family of carpenters and architects. Every morning
when you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." 
	-- Unix for Dummies, 2nd Edition
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
