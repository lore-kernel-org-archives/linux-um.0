Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMxaX-0002fc-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 14:47:49 -0800
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AMxaX-0007Ez-6X
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 14:47:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 70BD41D73B3
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 23:47:38 +0100 (CET)
Received: from lepidus.kulnet.kuleuven.ac.be (lepidus.kulnet.kuleuven.ac.be [134.58.240.72])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 0684D1D7326
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 23:47:38 +0100 (CET)
Received: from bakvis.kotnet.org (bakvis.kotnet.org [10.67.73.87])
	by lepidus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id B4E36380002
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 23:47:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by bakvis.kotnet.org (Postfix) with ESMTP id A08815F7C5
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 23:47:37 +0100 (CET)
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
Subject: Re: [uml-devel] Host panic when UML reads host /dev/shm
References: <200311201915.29188.blaisorblade_spam@yahoo.it> <200311202037.14480.blaisorblade_spam@yahoo.it> <200311202332.56549.Frank.dekervel@student.kuleuven.ac.Be>
In-Reply-To: <200311202332.56549.Frank.dekervel@student.kuleuven.ac.Be>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311202347.37312.Frank.dekervel@student.kuleuven.ac.Be>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 20 Nov 2003 23:47:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Op Thursday 20 November 2003 23:32, schreef Frank Dekervel:
> > Only an oops on linux or the same oops? If the second, it's useful news
>
> the second ... exactly the same backtrace iirc. i'll try to find the oops,
> but i'm almost sure. i've posted here to uml-devel once (subject
> hostfs-crash i believe) but google cannot find it.
>
> > In fact, I'm seeing now 4:40, the time the oops happens, is when the
> > slackware every day runs updatedb.
>
> a-ha ! exactly the same, my oops also happent when doing updatedb...

my original post was here
http://sourceforge.net/mailarchive/forum.php?thread_id=2984656&forum_id=3648

but contrary to what i tought, it is not exactly the same oops. 
 Trace; c0149048 <sys_getdents+90/98>
 Trace; c0139ea4 <sys_read+5c/100>
 Trace; c01089f3 <system_call+33/38>
if ksymoops is right. i also sent it to lkml, without response. And i was also 
using tmpfs then (for uml memory as described in howto)

greetings,
frank



-- 
Frank Dekervel
Mechelsestraat 88
3000 Leuven
frank.dekervel@student.kuleuven.ac.be, (nieuw) 0473/94.34.21


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
