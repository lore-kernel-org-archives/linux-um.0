Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ai4Vm-0006Rx-9X for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 20:26:10 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Ai4Vl-0000j6-OT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 20:26:10 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040118044759.GC8571@ccure.user-mode-linux.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<Pine.GSO.4.58.0401160957210.23807@algedi.dur.ac.uk>
	<200401161727.i0GHRKVW002726@ccure.user-mode-linux.org>
	<Pine.GSO.4.58.0401172102270.14178@altair.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401172102270.14178@altair.dur.ac.uk>
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
Date: Sat, 17 Jan 2004 23:47:59 -0500
To: M A Young <m.a.young@durham.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jan 17, 2004 at 09:12:45PM +0000, M A Young wrote:
> I have been trying to debug the problem with tt mode and very recent
> glibcs, and what seems to be happening is that early on in the glibc start
> up code for /sbin/init (after 3 syscalls), there is a segv signal;
> handle_page_fault returns -14, probably becuase the fault address
> (beffe018) is bogus, but the segfault seems to repeat endlessly. I am not
> sure if this is a glibc or a uml issue, or something else.

I saw something like that during a glibc upgrade going from stable to testing
in tt mode.  Running it in skas mode avoided the problem.  I never figured
out what was happening.

				Jeff


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
