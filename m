Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhxkW-00072M-Q7 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 13:12:56 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AhxkW-0006gy-At for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 13:12:56 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0 
In-Reply-To: <200401161727.i0GHRKVW002726@ccure.user-mode-linux.org>
Message-ID: <Pine.GSO.4.58.0401172102270.14178@altair.dur.ac.uk>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org> 
	<Pine.GSO.4.58.0401160957210.23807@algedi.dur.ac.uk> 
	<200401161727.i0GHRKVW002726@ccure.user-mode-linux.org>
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
Date: Sat, 17 Jan 2004 21:12:45 +0000 (GMT)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 16 Jan 2004, Jeff Dike wrote:

> m.a.young@durham.ac.uk said:
> > Actually, I am no longer convinced the lack of these syscalls cause
> > the problem directly; I think there is something else in recent glibcs
> > that cause the kernel to hang, at least in tt mode, though it is
> > probably related.
>
> Maybe, but it's a definite problem.  However, the segfaults people were seeing
> with 2.6.1 may be gone since that was a separate problem which is fixed in
> the 2.6.1 patch.

I have been trying to debug the problem with tt mode and very recent
glibcs, and what seems to be happening is that early on in the glibc start
up code for /sbin/init (after 3 syscalls), there is a segv signal;
handle_page_fault returns -14, probably becuase the fault address
(beffe018) is bogus, but the segfault seems to repeat endlessly. I am not
sure if this is a glibc or a uml issue, or something else.

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
