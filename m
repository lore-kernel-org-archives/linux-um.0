Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDu39-0006Uc-W9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 16:44:11 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BDu39-0003gk-2b for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 16:44:11 -0700
From: Henrik Nordstrom <hno@marasystems.com>
In-Reply-To: <20040414222451.GL19707@erizo.shearer.org>
Message-ID: <Pine.LNX.4.44.0404150125390.31850-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Subject: [uml-devel] Re: UML
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
Date: Thu, 15 Apr 2004 01:43:58 +0200 (CEST)
Content-Transfer-Encoding: quoted-printable
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 15 Apr 2004, Dan Shearer wrote:

> I have found your contributions to the UML list to be very interesting.

Thanks.

> How do you use UML in practice?

We use UML for kernel and appliance software development. Perfect tool for =

debugging kernel problems (not hardware related) and for testing.

 + A single host can run any number of simulated nodes

 + The simulated nodes run from a functional perspective the same kernel
as our target systems, just another kind of "CPU".

 + There is virtual networking with multiple ethernet segments connecting
the virtual UML nodes together in any way one desires. We an very quickly
build up a virtual lan mesh with multiple routers, bridges, firewalls,
proxies etc, all running on a single host with no extra cables ;-)

 + This virtual network is also connected to the host, allowing tests with
"live" traffic.

 + By proxy-arp the (selected) simulated nodes can even exist directly in
our local LAN as if they for all practical purposes was directly
connected. If real transparent Ethernet connectivity is needed then
bridgeing on the host is an option but so far IP connectivity has been
sufficient for us.

 + Whenever we hit a kernel problem which is not too uncommon while
developing a new network function we can easily inspect what is going
wrong with a standard debugger (gdb), significanly shortening the
development cycle.

> I am interested in it for hosting purposes. Looking at your email
> address I wonder if you have incorporated it into your company's
> products?

We have UML integrated in our product development, but it is not part of
our products.

There has been some discussion about maybe provide UML demo images for
customer preview of what the products look and feel like, but for the type
of products we make it so far works better using a x86 image loaded on a
real box..

Regards
Henrik Nordstr=F6m
MARA Systems AB, Sweden



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
