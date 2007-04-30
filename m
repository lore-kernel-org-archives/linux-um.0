Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HidXj-0003lt-1c for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 14:36:23 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HidXh-0008QY-Fk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 14:36:22 -0700
Date: Mon, 30 Apr 2007 17:32:09 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070430213209.GB9773@c2.user-mode-linux.org>
References: <200704261612.40356.blaisorblade@yahoo.it>
	<20070427151051.GB6019@c2.user-mode-linux.org>
	<463214E7.5080605@nagafix.co.uk>
	<20070427155024.GA8329@c2.user-mode-linux.org>
	<463224F8.6080009@nagafix.co.uk> <463228E5.6080904@nagafix.co.uk>
	<20070427202053.GA10598@c2.user-mode-linux.org>
	<46362500.7000202@nagafix.co.uk>
	<20070430181042.GA8599@c2.user-mode-linux.org>
	<463643F3.4050809@nagafix.co.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <463643F3.4050809@nagafix.co.uk>
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

On Mon, Apr 30, 2007 at 08:30:59PM +0100, Antoine Martin wrote:
> > Suppose someone uses 2:1:2:3:4:5 (11 chars), which I did for testing?
> I thought that was an invalid mac address?(I've never seen mac addresses
> specified that way on any software or hardware - yet)

A valid MAC is 6 binary bytes - I haven't seen anywhere that "02" is
the only valid ASCII representation of one of those bytes.

> Yeah, I preferred that too, it is also more consistent with the way the
> other transports do it, but it needed to be backwards compatible. Which
> can still be done, but only as long as:
> pcap-options!='[no]promisc!'='[no]optimize!'=mac-address='pcap'
> Isn't it the case already?

The original pcap specification would remain, and that would be your
backward compatibility.

> Acked-by: Antoine Martin <antoine@nagafix.co.uk>
> works for me (tm)

Cool, I'll send it in.

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
