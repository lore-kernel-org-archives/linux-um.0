Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AopdY-0000Xj-3z
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 11:58:08 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AopW4-0001xP-H0
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 11:50:24 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040205195054.GA8248@elte.hu>
References: <20040120002301.GA5708@elte.hu> <Pine.LNX.4.58.0401232125410.8188@vega.dur.ac.uk> <Pine.GSO.4.58.0401232342360.24271@altair.dur.ac.uk> <Pine.LNX.4.58.0401241215200.21419@vega.dur.ac.uk> <200401241820.i0OIKHY3002399@ccure.user-mode-linux.org> <Pine.LNX.4.58.0401241923510.27438@vega.dur.ac.uk> <20040205123057.GA23555@elte.hu> <Pine.GSO.4.58.0402051236350.5177@algedi.dur.ac.uk> <20040205183624.GA5236@elte.hu> <20040205191558.GA6580@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205191558.GA6580@elte.hu>
Subject: [uml-devel] Re: tt mode tls/glibc crash with 2.6 (Was: Re: uml-patch-2.6.0)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 5 Feb 2004 20:50:54 +0100
To: M A Young <m.a.young@durham.ac.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> the crash here seems to be that after fork() the contents of GS are
> lost and the next %gs access segfaults due to the #GPF. (which UML
> mistakes for a pagefault and thus gets into an infinite loop.)

ok, ignore this crash for the time being - it's probably caused by one
of my changes. I'm investigating it.

	Ingo


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
