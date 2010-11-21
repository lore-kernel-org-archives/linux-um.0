Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <renzo@cs.unibo.it>) id 1PK999-0001GQ-Cg
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Nov 2010 12:35:55 +0000
Received: from leb.cs.unibo.it ([130.136.1.102])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PK998-00022y-6w
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Nov 2010 12:35:55 +0000
Date: Sun, 21 Nov 2010 13:35:47 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
Message-ID: <20101121123547.GB589@cs.unibo.it>
References: <20101118114143.GB23698@cs.unibo.it>
	<AANLkTimYG1jLwJ2tWLonFcoMWaQtaR9RG7HWJDbdE4cS@mail.gmail.com>
	<4CE8F332.3050205@meduna.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CE8F332.3050205@meduna.org>
Subject: Re: [uml-devel] "New Challenges in Virtualization" devroom @	FOSDEM
	2011
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Stanislav Meduna <stano@meduna.org>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Pros=+ Cons=- Pros(umview/kmview can be used instead)=++
Richard:
- IMHO it's dead as virtualization technology.
+ But it's still used as playground for kernel developers.
+ You can easily implement and test new kernel features.

Geert:
+ It's easy to get it running
++ I can run it without needing root access, so I can run it on any
Linux machine I have an account on
++ I can use it to do things that are limited to root-only
+ I even use it to debug/develop code for the Amiga Zorro bus

Stanislav:
- From a plain user's view: basically dead:
- SKAS3 is against 2.6.23 and unmaintained
- SKAS4 is against 2.6.24 and marked as experimental
+ As a help tool to run at the workstation, yes
- As a serious tool to virtualize services: no

--------
>>From this overview you can see that user-mode linux is still
useful but there are new problems to address.

I think that this is a good topic for a brainstorming session on
user-mode linux at FOSDEM 2011.

You are all invited to join the "new challenges in virtualization"
dev-room, proposing talks and new ideas.

nciv2011.v2.cs.unibo.it

ciao
	renzo

PS: I beg your pardon for the wrong subject in the first message of this thread.
copy&paste (middle button of the mouse for X) is a powerful tool but
sometimes creates damages...

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

