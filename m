Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiMTF-0007yo-FS for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 15:36:45 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AiMTE-00050U-Tf
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 15:36:45 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040118235730.GC21046@ccure.user-mode-linux.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118162112.GA15509@elte.hu>
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
Date: Sun, 18 Jan 2004 18:57:30 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net

On Sun, Jan 18, 2004 at 05:21:12PM +0100, Ingo Molnar wrote:
> hm, are you sure this is the reason why they dont boot? At least the
> ones in Fedora fall back to LinuxThreads if set_thread_area is -ENOSYS. 
> Old 2.4 kernels work just fine - UML ought to work fine too.

No, I'm not.  But I am seeing -ENOSYS from one of [gs]et_thread_area right 
before things go haywire.  But I haven't looked at it closely enough to
see if that's the real problem.

2.4 UMLs work fine with these libcs.  I had been assuming (without any 
evidence) that there was some other capability check (like uname), and 
libc gets horribly confused when it sees a 2.6 kernel that doesn't have
the thread_info stuff.

If the compatibility check is -ENOSYS from one of those syscalls, then
this theory goes right out the window, and something else is wrong in UML.

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
