Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7eqL-00024X-LB for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 10:17:09 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B7eqJ-00017H-Gg for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 10:17:07 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] I/O-Request Token Bucket Limiter
References: <004901c414a3$f4d28a80$0201a8c0@hawk>
	<002b01c414ca$5f439370$0201a8c0@hawk>
	<0c3e01c414e0$58c21240$2000000a@schlepptopp>
In-Reply-To: <0c3e01c414e0$58c21240$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403282026.39253.blaisorblade_spam@yahoo.it>
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
Date: Sun, 28 Mar 2004 19:26:39 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 18:18, domenica 28 marzo 2004, roland ha scritto:
> thanks for explanation!
>
> that`s a great feature :)
>
> is it (generally) possible to have something similar for cpu or other
> "ressources" like network bandwidth , too?
Try "nice" for CPU; for the network, you can use the "traffic shaper" (to 
enable on the host); search on Google and in the Kernel configuration to 
discover more about it (I just read something about this time ago); at least 
it should work easily when you use the tun/tap interface, since you have an 
interface to monitor.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
