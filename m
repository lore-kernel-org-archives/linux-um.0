Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aijf0-0006oI-KC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 16:22:26 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aijex-0003pV-7q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 16:22:23 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040120002301.GA5708@elte.hu>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
	<20040118235730.GC21046@ccure.user-mode-linux.org>
	<20040119075351.GA4088@elte.hu> <20040119082805.GA4412@elte.hu>
	<Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk>
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
Date: Tue, 20 Jan 2004 01:23:01 +0100
To: M A Young <m.a.young@durham.ac.uk>
Cc: Jeff Dike <jdike@addtoit.com>, Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net


* M A Young <m.a.young@durham.ac.uk> wrote:

> I have found in tt mode with an FC1 image the system hangs after 3
> syscalls (uname, brk, open), before any set/get_thread_area calls, so
> I suspect there is another problem. The hang consists of repeated
> segfault signals with fault address (beffe018) which returns -EFAULT.
> Is there any setup for tls/nptl normally done by the kernel that might
> be missing in UML, such as allocating some high up memory?

hm, beffe018 - shouldnt that be the stack?

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
