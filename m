Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZ5Qi-0006m9-Rl for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 02:40:20 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CZ5Qh-0001pj-UE
	for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 02:40:20 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041130103255.GB5593@bytesex>
References: <BAY24-F18CD7435AB94FE5A10013283BE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY24-F18CD7435AB94FE5A10013283BE0@phx.gbl>
Subject: [uml-devel] Re: [PATCH] uml_router: cleanup #2
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
Date: Tue, 30 Nov 2004 11:32:55 +0100
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: User-mode-linux-devel@lists.sourceforge.net, uml@uxu.ch

> Patch 11 turns on the packet queue for the tuntap driver.  For technical 
> reasons, it's just too much work to implement on the current sockunix 
> driver.

Guess thats the "one socket for all umls" thingy?  You can create a new
socket for every uml instance connecting, at least with protocol v3 (not
sure about the older ones, but I think support for them can be dropped
without breaking anything by now ...).

> Patch 14 is a fun little UDP packet driver inspired by Felix M?ri for 
> connecting multiple UMLs together.  It's inherently unsecure so you must 
> uncomment the driver in the makefile if you want to play with it.

Why this?  Compile time options are evil.  Runtime option which is off
by default is perfectly fine IMHO.

  Gerd



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
