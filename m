Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAvG3-0003oQ-AK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 11:57:27 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CAvG1-0004XR-L8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 11:57:26 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [uml-devel] Syscalls breaking out 
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C3B@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Fri, 24 Sep 2004 20:52:12 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

 
Jeff Dike <jdike@addtoit.com> said:

> Bodo.Stroesser@fujitsu-siemens.com said:
> > (It would overlap with my previos patch, should I merge them?)
> 
> I'm looking at your patches and will get back to you on them, but let
me just comment on this issue first.
>
> I'd prefer these patches be split up into as small units as possible.
That'll make it easier to decide whether they are correct.  It's OK if
they overlap and need to be applied in a particular order.
> 
> So, for example, the API changes could be broken out separately.  Even
if it's two lines of change (the caller and the callee), that's a good
way to split it up.  This part of the kernel has some subtleties, so I'd
prefer to be careful here.

O.K., I could create three new patches.

The first will remove the different possibilities to execute a
systemcall on the host, with one exception: if the UML-user directly
calls the vsyscall entry __kernel_vsyscall while being singlestepped, it
will still break out and will be executed on the host.

The second will enable the vsyscall-page in UML, this will remove the
last (known to me) breakout possibility and will enable the
sysenter-syscall for programs that are not linked "-static".

With the third patch UML will use the "restorer"-stubs in the
vsyscall-page. This will *not* change the stack layout for signal
handlers, but will change the restorers address to be from the
syscall-page.

If this is OK for you, I could send the patches next week.

Bodo

> 
> 				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
