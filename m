Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiTuR-0006SR-TL for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 23:33:19 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiTuR-0005KS-G6 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 23:33:19 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040119073405.GA3175@elte.hu>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu> <20040118210605.GA23259@elte.hu>
	<20040119000802.GF21046@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119000802.GF21046@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: uml 2.6.1 kbuild simplifications
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
Date: Mon, 19 Jan 2004 08:34:05 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


* Jeff Dike <jdike@addtoit.com> wrote:

> > parallel make still does not work though - doing 'make -j10' after a
> > 'make clean' fails. Couldnt figure out a solution, the dependencies are
> > really nasty.
> 
> Yeah, it's a mess.  It has sort of evolved over time, with local fixes
> adding up to a horror show.

i think kbuild needs to be improved too in some cases. Eg. another
problem: lib-y could be used to clean up munmap_fin.o library linking in
arch/um/kernel/tt/Makefile, but unlike host-progs, the CFLAGS_ override
is not good enough to replace the normal flags with $(UNMAP_CFLAGS). The
dual compilation space ('user code' and 'kernel code' compilation)
within UML is not yet fully expressable via kbuild.

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
