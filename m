Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATVPv-0003eZ-AB
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 16:07:55 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ATVPu-00082H-NO
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 16:07:54 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [PATCH] provide asm/ldt.h 
In-Reply-To: <200312082338.hB8NcCAv030482@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0312090101020.14902-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 9 Dec 2003 01:07:45 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: Steve Bennett <steveb@snapgear.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 8 Dec 2003, Jeff Dike wrote:

> How are these kernel-dependent (in the sense that they have to be built against
> a UML /usr/include/asm or they won't work under UML)?

They are kernel dependent in that they need to be build to a
/usr/src/linux/include tree matching the kernel used. The "kernel"  
headers in /usr/include/ should not be used when compiling kernel
dependent applications, those are just there from historic reasons to make
glibc happy.

It is true that in all cases I know of building the tools to a kernel tree
configured for the host arch with the same kernel configuration options as
the UML kernel will work and this is how we build our tools, but for some
this might be quite some hassle to set up. Luckily most tools build fine 
to the UML headers.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
