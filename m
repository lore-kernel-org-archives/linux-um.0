Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiFfJ-0000mV-5f for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 08:20:45 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiFfI-0006zw-NY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 08:20:44 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040118162112.GA15509@elte.hu>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
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
Date: Sun, 18 Jan 2004 17:21:12 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net


* Jeff Dike <jdike@addtoit.com> wrote:

> >  * Any known issues with 2.6.1 kernels?
> 
> Fewer, now that I got the 2.6.1 patch out.  UML lacks
> [gs]et_thread_area still, so 2.6 UMLs won't boot new libcs.

hm, are you sure this is the reason why they dont boot? At least the
ones in Fedora fall back to LinuxThreads if set_thread_area is -ENOSYS. 
Old 2.4 kernels work just fine - UML ought to work fine too.

(libcs built without compatibility wont fall back. Are there such
distros?)

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
