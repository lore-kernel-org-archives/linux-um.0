Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiUl3-0002up-Je for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 00:27:41 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AiUl3-0004If-7g for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 00:27:41 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040119082805.GA4412@elte.hu>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
	<20040118235730.GC21046@ccure.user-mode-linux.org>
	<20040119075351.GA4088@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119075351.GA4088@elte.hu>
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
Date: Mon, 19 Jan 2004 09:28:05 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net


* Ingo Molnar <mingo@elte.hu> wrote:

> > 2.4 UMLs work fine with these libcs.  I had been assuming (without any
> > evidence) that there was some other capability check (like uname), and
> > libc gets horribly confused when it sees a 2.6 kernel that doesn't
> > have the thread_info stuff.
> 
> ok, i talked to Ulrich, and it turns out that ld.so in Fedora uses the
> set_tid_address() syscall to find out whether the kernel has NPTL or
> not [and thus whether to use the TLS glibc or the standard one]. [...]

unfortunately, this is only the case if the kernel is below 2.5.69 and
has 'nptl' in the uname. Otherwise ld.so assumes full NPTL support.

so the only compatible solution seems to be to implement
set/get_thread_area() within UML. Since UML itself is linked statically,
which causes the non-TLS glibc to be linked, i think it should be safe
to just shadow the TLS descriptors in the UML process and call
set_thread_area() for every new thread that has TLS descriptors not
equal to the previous thread's TLS descriptors.

but wrt. LinuxThreads - it doesnt seem UML skas mode implements LDT
state properly - does it?

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
