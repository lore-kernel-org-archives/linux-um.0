Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2xVB-0002wE-Bo for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 11:11:53 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B2xVA-0007ay-Gv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 11:11:52 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] noexec /tmp & uml
Message-ID: <20040315194459.GG23741@ccure.user-mode-linux.org>
References: <20040312225437.GB622@terix.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312225437.GB622@terix.fokus.gmd.de>
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
Date: Mon, 15 Mar 2004 14:44:59 -0500
To: Cristian CONSTANTIN <constantin@fokus.fraunhofer.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Mar 12, 2004 at 11:54:37PM +0100, Cristian CONSTANTIN wrote:
> don't know if anyone else saw it / knew it before, but I found it out
> the hard way...
> so, my /tmp is mounted with noexec option. when I start uml (2.4.23) it
> stops booting, barking like:
> 
> Kernel panic: map_memory(0xa2800000, 3, 0x8dc000, 4096, 1, 1, 1) failed,
> err = -1

Good find.  I'll stick in a check for that and put out a better error
message.

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
