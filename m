Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AizEw-0003F7-I7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 09:00:34 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AizEv-00079x-Sx
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 09:00:34 -0800
Message-Id: <200401201722.i0KHMWDG003192@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0 
In-Reply-To: Your message of "Mon, 19 Jan 2004 09:28:05 +0100."
	<20040119082805.GA4412@elte.hu> 
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
	<20040118235730.GC21046@ccure.user-mode-linux.org>
	<20040119075351.GA4088@elte.hu> <20040119082805.GA4412@elte.hu>
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
Date: Tue, 20 Jan 2004 12:22:31 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net

mingo@elte.hu said:
> unfortunately, this is only the case if the kernel is below 2.5.69 and
> has 'nptl' in the uname. Otherwise ld.so assumes full NPTL support.

So, it uses uname to figure out if the kernel has NPTL support?

> so the only compatible solution seems to be to implement set/
> get_thread_area() within UML. Since UML itself is linked statically,
> which causes the non-TLS glibc to be linked, i think it should be safe
> to just shadow the TLS descriptors in the UML process and call
> set_thread_area() for every new thread that has TLS descriptors not
> equal to the previous thread's TLS descriptors.

In tt mode, this is true.  A skas-only UML will be dynamic, but then
userspace is in a separate process, and someone was thoughtful enough to
add PTRACE_[GS]ET_THREAD_INFO.  So, this will be fine in either case.

The problem is on 2.4.  I suspect that this can't be emulated on 2.4 hosts,
so a 2.6 UML can't boot a NPTL system on a 2.4 host.  This is annoying since
host version independence is a nice thing about UML.

> but wrt. LinuxThreads - it doesnt seem UML skas mode implements LDT
> state properly - does it? 

As far as I know, it does.  LinuxThreads was introduced in RH8 or so, I think,
and RH8 filesystems have run in UML for a long time.

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
