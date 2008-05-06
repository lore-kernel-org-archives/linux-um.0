Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtWZq-0005i4-CV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 16:28:06 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JtWZp-0002EG-2s
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 16:28:06 -0700
Date: Tue, 6 May 2008 16:27:27 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <200805062304.m46N4h6d007206@devserv.devel.redhat.com>
Message-ID: <alpine.LFD.1.10.0805061625090.32269@woody.linux-foundation.org>
References: <200805062304.m46N4h6d007206@devserv.devel.redhat.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] fix UML on x86-64
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@linux-foundation.org, mingo@elte.hu, tglx@linutronix.de, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net



On Tue, 6 May 2008, Ulrich Drepper wrote:
>
> This patch breaks UML for me on x86-64 running Fedora 8 (gcc 4.1.2):

It breaks things how?

Because on x86, the cut-off is gcc4 vs pre-4. See arch/x86/Makefile:

        KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0400 ] ; then \
                echo $(call cc-option,-fno-unit-at-a-time); fi ;)

and it's a bit distressing that these compiler flags are set two different 
ways (in fact, I was already bothered by the fact that UML sets it totally 
independently of x86 in the first place).

So what is the UML failure behaviour with gcc-4.1.2?

			Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
