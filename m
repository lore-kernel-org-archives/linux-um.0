Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiaOS-0001zL-5T for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 11:14:36 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiaOO-0006YL-0Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 11:14:36 -0700
Date: Mon, 30 Apr 2007 14:10:42 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070430181042.GA8599@c2.user-mode-linux.org>
References: <20070425204849.GA9505@c2.user-mode-linux.org>
	<462FC142.1010907@nagafix.co.uk>
	<200704261612.40356.blaisorblade@yahoo.it>
	<20070427151051.GB6019@c2.user-mode-linux.org>
	<463214E7.5080605@nagafix.co.uk>
	<20070427155024.GA8329@c2.user-mode-linux.org>
	<463224F8.6080009@nagafix.co.uk> <463228E5.6080904@nagafix.co.uk>
	<20070427202053.GA10598@c2.user-mode-linux.org>
	<46362500.7000202@nagafix.co.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46362500.7000202@nagafix.co.uk>
Subject: Re: [uml-devel] regression: pcap broken in 2.6.20.x
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 30, 2007 at 06:18:56PM +0100, Antoine Martin wrote:
> Full marks for number of lines of code changed! (1!)

Yeah, I thought that was a plus.

> On the plus side, it only adds the parameter at the end, but it does
> keep some code in there to deal with variable number/order for
> [no]promisc and [no]optimized options, so I would prefer something like
> this one - not just because I wrote it ;)
> http://uml.nagafix.co.uk/pcap-macaddr.patch
> Where the only required option is the pcap filter (which is harder to
> move around since it doesn't have a fixed set of options - or does it?).

On the negative side -
I dislike assumptions like this:
	+			//a mac address is always 17 characters long
Suppose someone uses 2:1:2:3:4:5 (11 chars), which I did for testing?
This is also conflating a MAC address with a pcap option, which it
isn't.

So what happens when someone adds more options to libpcap and UML
users start wanting to use them?  I would say that we add
'eth0=pcapv1,if,mac,filter,opt1,opt2,...' and futureproof this wrt
pcap options.  People will have to rearrange their command lines in
order to use this, but they already are in order to use the new
options.  Everyone else will stick with the current 'eth0=pcap,...'
format.

So, unless you have strenuous objections, I think I will stick with my
patch and wait for pcap to come up with more options.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
