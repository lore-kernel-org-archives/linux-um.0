Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AikKn-0007xk-ML for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 17:05:37 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AikKn-0008Rr-3n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 17:05:37 -0800
Message-Id: <200401200127.i0K1RKVW025557@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0 
In-Reply-To: Your message of "Tue, 20 Jan 2004 00:19:37 GMT."
	<Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk> 
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
	<20040118235730.GC21046@ccure.user-mode-linux.org>
	<20040119075351.GA4088@elte.hu> <20040119082805.GA4412@elte.hu>
	<Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 19 Jan 2004 20:27:20 -0500
To: M A Young <m.a.young@durham.ac.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net

mingo@elte.hu said:
> hm, beffe018 - shouldnt that be the stack? 

No.  In tt mode, that's in the middle (close to the end, really) of the UML
kernel.  In this case, the process stack ends at 0xa0000000.

This is what befuddled me during my libc upgrade in tt mode.  I couldn't see
what was inducing userspace to access memory up there.

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
