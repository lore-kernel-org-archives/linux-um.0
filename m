Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVYr3-00060X-S3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 13:30:34 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVYr2-0000uf-BT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 13:30:33 -0700
Date: Wed, 12 Sep 2007 16:30:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070912203002.GA9725@c2.user-mode-linux.org>
References: <46DDAD83.4030004@cttc.es>
	<20070904214521.GB5417@c2.user-mode-linux.org>
	<46DE8F70.4070404@cttc.es>
	<20070910160238.GC14112@c2.user-mode-linux.org>
	<46E71F58.6050301@cttc.es> <46E85FA0.9040405@cttc.es>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46E85FA0.9040405@cttc.es>
Subject: Re: [uml-devel] [uml-user] Hanging using 'iptables -L' in UML vm
	booted with con0=pts
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: =?iso-8859-1?Q?Ferm=EDn_Gal=E1n_M=E1rquez?= <fermin.galan@cttc.es>
Cc: UML-user <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Sep 12, 2007 at 11:52:32PM +0200, Ferm=EDn Gal=E1n M=E1rquez wrote:
> This is the trace (as you can see I're repeated the experiment twice, =

> the result is basically the same), hoping it could be useful to diagnose =

> the problem and fix eventual bugs in the UML kernel. See below regarding =

> the test procedure.
> =

> (gdb) bt
> #0  0xb7f9d7f2 in ?? () from /lib/ld-linux.so.2
> #1  0xb7f19ab0 in tcsetattr () from /lib/i686/cmov/libc.so.6
> #2  0x080610d5 in generic_console_write (fd=3D7,
>     buf=3D0x828fc13 "ip_tables: (C) 2000-2006 Netfilter Core Team\n", n=
=3D45)
>     at arch/um/drivers/chan_user.c:37
> #3  0x0806096e in console_write_chan (chans=3D0x82756f0,
>     buf=3D0x828fc13 "ip_tables: (C) 2000-2006 Netfilter Core Team\n", len=
=3D45)
>     at arch/um/drivers/chan_kern.c:352

Are you capturing UML output with a script or something?  This is the
signature of the script not reading from the pty, so everything just
backs up, waiting for the pty to clear up.

				Jeff

-- =

Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
