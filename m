Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CX4Ya-0002F7-NL for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 13:20:08 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CX4YZ-0005sI-RT
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 13:20:08 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [PATCH] uml_router: cleanup
Message-ID: <20041124211042.GB27491@bytesex>
References: <BAY24-F27D8548BC9B2976EFF8B3883B80@phx.gbl>
	<874qjfftsz.fsf@bytesex.org> <41A4EE93.9090800@uxu.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A4EE93.9090800@uxu.ch>
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
Date: Wed, 24 Nov 2004 22:10:42 +0100
To: Felix =?iso-8859-1?Q?M=FCri?= <uml@uxu.ch>
Cc: User-mode-linux-devel@lists.sourceforge.net, Steve Schmidtke <steve_schmidtke@hotmail.com>

> long ago I found similar issues with the uml_switch codebase. My 
> problem was not the mac handling, but an missing feature to 
> connect two switches together via an udp-tunnel.

How did you actually implement that?  When using lossy UDP anyway
it should be almost trivial to remove the restriction to two switch
deamons by using IP Multicast for the communication ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
