Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBXK4-0003gR-41 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 04:03:52 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BBXK3-0003wU-Lk
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 04:03:51 -0700
Message-Id: <200404081141.i38BfdB6001907@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] A quick humfs HOWTO 
In-Reply-To: Your message of "Thu, 08 Apr 2004 12:07:38 +0200."
	<Pine.LNX.4.44.0404081201120.8462-100000@filer.marasystems.com> 
References: <Pine.LNX.4.44.0404081201120.8462-100000@filer.marasystems.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 08 Apr 2004 07:41:39 -0400
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: Nick Craig-Wood <ncw1@axis.demon.co.uk>, user-mode-linux-devel@lists.sourceforge.net

uml@henrik.marasystems.com said:
> Eh? Why a loop mounted filesystem for humfs? The whole point of humfs
> is to be able to emulate full UNIX semantics including ownership,
> permissions, filesystem size etc ontop of a plain file tree without
> requiring root on the host..

humfs was done now because it's the only way to get the memory savings offered
by doing mmap IO.

It turns out that some people need block devices because they repartition
their UMLs, run RAID, etc.  Loop-mounting a disk image located on a humfs
filesystem gives you both.  So, it's more than a transitional thing.

> If you want performance then ubd devices is the path to go. 

That's currently the case (a humfs boot is noticably slower than a ubd boot),
but it's not clear why that should be the case.  There is less code running
inside UML (no block layer or block driver), and it's not obvious to me
that putting stuff in files in a host directory should be slower than 
having it in a disk image.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
