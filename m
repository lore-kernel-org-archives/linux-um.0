Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aypb6-0004zs-12 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Mar 2004 01:56:56 -0800
Received: from mail-09.iinet.net.au ([203.59.3.41] helo=mail.iinet.net.au)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AypNf-0006gm-5m for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Mar 2004 01:43:03 -0800
Received: from cameron by cp.yi.org with local (Exim 3.36 #1 (Debian))
	id 1AypGw-0003Vo-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 04 Mar 2004 17:36:06 +0800
From: Cameron Patrick <cameron@patrick.wattle.id.au>
Subject: Re: [uml-devel] Module exploits into the host?
Message-ID: <20040304093605.GA24034@patrick.wattle.id.au>
References: <20040303200937.GK14069@localhost.localdomain>
	<Pine.LNX.4.44.0403032227040.17693-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403032227040.17693-100000@filer.marasystems.com>
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
Date: Thu, 4 Mar 2004 17:36:06 +0800
To: user-mode-linux-devel@lists.sourceforge.net

Henrik Nordstrom wrote:

| If you want to minimize this, run the UML chrooted (and absolutely not as 
| root). The use of process capabilities can also be used to limit the 
| possible damage, or any of the security extensions to Linux.

Also, don't build module support into the kernel, and edit drivers/char/mem.c
to disable writes to /dev/mem and /dev/kmem.

Cameron.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
