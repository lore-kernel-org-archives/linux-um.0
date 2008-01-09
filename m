Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCj1M-0004G7-Su for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:03:36 -0800
Received: from odyssey.analogic.com ([204.178.40.5])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JCj1M-0005VV-4X
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:03:36 -0800
MIME-Version: 1.0
Content-class: urn:content-classes:message
Date: Wed, 9 Jan 2008 17:01:52 -0500
Message-ID: <Pine.LNX.4.61.0801091659060.29624@chaos.analogic.com>
in-reply-to: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
References: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: [uml-devel] uml and -regparm=3
Reply-To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, akpm@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


On Wed, 9 Jan 2008, Miklos Szeredi wrote:

> FASTCALL is defined empty in -mm, but UML is not compiled with
> -mregparm=3D3 and so this breaks things (I noticed problems with
> rwsem_down_write_failed).
>
> Tried recompiling UML with -mregparm=3D3, but that resulted in a strange
> failure immediately after startup:
>
> |=1B%G=FF=FF=FF=FF=FF=FF=1B%@: Invalid argument
>
> What's up?
>
> Miklos
> --

UML gets linked with the 'C' runtime library. It doesn't
pass parameters in registers unless you get the source and
recompile the whole thing --and then you would have to
recompile all your applications, too. Yikes!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.22.1 on an i686 machine (5588.29 BogoMips).
My book : http://www.AbominableFirebug.com/
_

****************************************************************
The information transmitted in this message is confidential and may be priv=
ileged.  Any review, retransmission, dissemination, or other use of this in=
formation by persons or entities other than the intended recipient is prohi=
bited.  If you are not the intended recipient, please notify Analogic Corpo=
ration immediately - by replying to this message or by sending an email to =
DeliveryErrors@analogic.com - and destroy all copies of this information, i=
ncluding any attachments, without reading or disclosing them.

Thank you.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
