Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AizWE-0000IG-M7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 09:18:26 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AizWE-0005mq-5G
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 09:18:26 -0800
Message-Id: <200401201740.i0KHeWDG003215@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Mon, 19 Jan 2004 08:34:05 +0100."
	<20040119073405.GA3175@elte.hu> 
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu> <20040118210605.GA23259@elte.hu>
	<20040119000802.GF21046@ccure.user-mode-linux.org>
	<20040119073405.GA3175@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 20 Jan 2004 12:40:32 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net

mingo@elte.hu said:
> The dual compilation space ('user code' and 'kernel code' compilation)
> within UML is not yet fully expressable via kbuild.

In my opinion, it doesn't need to be.  BlaisorBlade and I have been having
an argument about it.  

He thinks kbuild should support it.

I consider it to be an artifact of UML containing intermingled OS-dependent
and OS-independent code.  With the OS-dependent code separated out into 
arch/um/os, the rest of UML becomes nice, normal kernel code.  The stuff
under arch/um/os is then pure userspace code, and I have no problem with
sticking some special CFLAGS mangler in the Makefile (or Makefiles) there.

Then, the code, and the special make magic that it needs are all in one
place, and we don't need to fiddle kbuild.

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
