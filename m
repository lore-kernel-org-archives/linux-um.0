Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ayi9y-0005Ys-So for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 18:00:26 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AyhdT-0007iO-6v
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 17:26:51 -0800
Message-Id: <200403040216.i242GLWo009037@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4 
In-Reply-To: Your message of "Tue, 06 Jan 2004 20:40:06 +0100."
	<a0602040dbc20be564c59@[192.168.1.10]> 
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com><200401061718.i
	06HILtd002620@ccure.user-mode-linux.org><a0602040abc20a9f6862e@[192.16
	8.1.10]><200401061918.31447.blaisorblade_spam@yahoo.it>
	<a0602040bbc20b325acfd@[192.168.1.10]>
	<33261.193.212.97.12.1073406789.squirrel@pluto.nixia.no>
	<a0602040cbc20b788b425@[192.168.1.10]>
	<a0602040dbc20be564c59@[192.168.1.10]> 
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
Date: Wed, 03 Mar 2004 21:16:21 -0500
To: Johannes Formann <johannes@formann.de>
Cc: stian@nixia.no, BlaisorBlade  <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

johannes@formann.de said:
> Starting kernel log daemon: klogd.
> Breakpoint 1, panic (fmt=0x800d17c0 "Kernel mode fault at addr 0x%lx,

Thanks to clues from BlaisorBlade, this should be fixed now.  It'll be in the
next patch.

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
