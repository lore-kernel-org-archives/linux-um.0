Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AkwyJ-000677-EY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jan 2004 18:59:31 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AkMqn-0007zq-Ew for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jan 2004 04:25:21 -0800
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <Pine.GSO.4.58.0401232342360.24271@altair.dur.ac.uk>
Message-ID: <Pine.LNX.4.58.0401241215200.21419@vega.dur.ac.uk>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
	<20040118235730.GC21046@ccure.user-mode-linux.org>
	<20040119075351.GA4088@elte.hu> <20040119082805.GA4412@elte.hu>
	<Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk>
	<20040120002301.GA5708@elte.hu>
	<Pine.LNX.4.58.0401232125410.8188@vega.dur.ac.uk>
	<Pine.GSO.4.58.0401232342360.24271@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: tt mode tls/glibc crash with 2.6 (Was: Re:
	uml-patch-2.6.0)
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
Date: Sat, 24 Jan 2004 12:25:04 +0000 (GMT)
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Dike <jdike@addtoit.com>, Gerd Knorr <kraxel@bytesex.org>

On Fri, 23 Jan 2004, M A Young wrote:

> Further checking shows that _rtld_global._dl_sysinfo_dso is set from the
> value of AT_SYSINFO_EHDR passed by the kernel. So UML tt mode is broken
> because it doesn't seem to pass this value. However glibc is also broken,
> because it should set _rtld_global._dl_sysinfo_dso=NULL by default in case
> AT_SYSINFO_EHDR isn't passed to it by the kernel.

Actually it turns out glibc is innocent as it implicitly initializes the
value I thought it wasn't initializing, and we are passing it a value for
AT_SYSINFO_EHDR for it to use for its vsyscall stuff, but we don't ever
allocate the associated memory. A possible workaround which seems to
work (but I have too much debugging turned on to be sure yet) is to set
AT_SYSINFO_EHDR to be NULL in include/asm/archparam-i386.h, though clearly
the ultimate aim would be to get the vsyscall stuff working properly.

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
