Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9x8g-0002l4-FQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 19:18:06 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9x8e-000540-TT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 19:18:06 -0800
Message-Id: <200503120548.j2C5m8Jp006911@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] RE: uml_switch security fixing 
In-Reply-To: Your message of "Mon, 07 Mar 2005 04:42:19 GMT."
	<BAY24-F21573D60D3DDE776FDC27C835F0@phx.gbl> 
References: <BAY24-F21573D60D3DDE776FDC27C835F0@phx.gbl> 
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
Date: Sat, 12 Mar 2005 00:48:08 -0500
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: blaisorblade@yahoo.it, kraxel@bytesex.org, user-mode-linux-devel@lists.sourceforge.net

steve_schmidtke@hotmail.com said:
> Attached are two patches.  The first one, uml_net-slip.diff, is the
> minimal  patch to apply to uml_net.  The second one, uml_net-uml.diff,
> applies to  2.4.27-1um (note the half-hearted attempt to plug a FD
> leak in there as  well).  As a nice bonus, a UML with this patch still
> works with an unpatched  uml_net binary. 

Thanks, applied except for the slip_tramp() bit, which I already had.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
