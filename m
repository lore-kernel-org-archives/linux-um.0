Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhQp4-0005pR-Ij for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 02:03:26 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AhQp4-0005xm-3M for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 02:03:26 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0 
In-Reply-To: <200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
Message-ID: <Pine.GSO.4.58.0401160957210.23807@algedi.dur.ac.uk>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org>  <87y8sbbrup.fsf@bytesex.org> 
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
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
Date: Fri, 16 Jan 2004 10:03:11 +0000 (GMT)
To: Jeff Dike <jdike@addtoit.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net

On Thu, 15 Jan 2004, Jeff Dike wrote:

> kraxel@bytesex.org said:
> >  * what is the status of kernel modules in 2.6 kernels?
>
> They still don't work.  I still haven't got around to fixing it.

But see the patches at
http://web.tiscali.it/no-redirect-tiscali/blaisorblade/

> >  * Any known issues with 2.6.1 kernels?
>
> Fewer, now that I got the 2.6.1 patch out.  UML lacks [gs]et_thread_area
> still, so 2.6 UMLs won't boot new libcs.

Actually, I am no longer convinced the lack of these syscalls cause the
problem directly; I think there is something else in recent glibcs that
cause the kernel to hang, at least in tt mode, though it is probably
related.

	Michael Young


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
