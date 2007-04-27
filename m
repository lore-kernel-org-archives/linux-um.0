Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhTKZ-0003ju-Ke for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:29:59 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhTKX-0007zP-SL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:29:59 -0700
Message-ID: <463224F8.6080009@nagafix.co.uk>
Date: Fri, 27 Apr 2007 17:29:44 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <462BACC9.7010303@nagafix.co.uk>
	<20070425204849.GA9505@c2.user-mode-linux.org>
	<462FC142.1010907@nagafix.co.uk>
	<200704261612.40356.blaisorblade@yahoo.it>
	<20070427151051.GB6019@c2.user-mode-linux.org>
	<463214E7.5080605@nagafix.co.uk>
	<20070427155024.GA8329@c2.user-mode-linux.org>
In-Reply-To: <20070427155024.GA8329@c2.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Jeff Dike wrote:
> On Fri, Apr 27, 2007 at 04:21:11PM +0100, Antoine Martin wrote:
>> Question remains as to why the mac address was the same until 2.6.20 and
>> is now different.
> 
> We started providing randomized MACs at bootup instead of deriving
> them from the IP when the interface was brought up.  The old behavior
> broke when distros started bringing interfaces up without assigning
> IPs to them.
> 
>> Except, pcap doesn't have the option.
> 
> Hmmm that would be a problem.
:)
I've got a patch - coming soon (tm)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMiT4GK2zHPGK1rsRCuDUAJ46JsqrHWxmo2FfxRsmasKpi0VIZACfRtzP
dsp1RvyxpqNX8qK2wANFI4g=
=vSOe
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
