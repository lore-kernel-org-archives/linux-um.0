Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6Ftn-0002ne-Bj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 13:26:55 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B6Ftl-0002WL-T0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 13:26:54 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [RFE] con=port
In-Reply-To: <050901c411db$33d65110$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0403242223140.2485-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 24 Mar 2004 22:26:49 +0100 (CET)
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, =?iso-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>

On Wed, 24 Mar 2004, roland wrote:

> hi ! i think specifying a tcp-port on a commandline should generally be
> possible by specifying the interface adress,too.

Agreed, and is pretty trivial to add. see port_init and port_listen_fd in 
arch/um/drivers/port_user.c.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
