Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFeYf-00008u-UJ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 12:35:57 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BFeYf-0007kr-G5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 12:35:57 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Problems with the SKAS patch and 2.6
References: <20040418185548.22259.qmail@praize.com>
In-Reply-To: <20040418185548.22259.qmail@praize.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404192133.32492.blaisorblade_spam@yahoo.it>
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
Date: Mon, 19 Apr 2004 21:33:32 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:55, domenica 18 aprile 2004, gboutwel ha scritto:

> I tried this patch.  I'm able to compile the host fine, but I've
>
> attached what happens when I try to compile the uml guest.

Well, what you did is correct (you had to apply both the UML patch and that 
version of the SKAS patch); the problem is that for 2.6.6-rc1 you need one 
more fix for the UML patch (it was posted here by Jeff Chua and it's 2 thread 
before this one).

You must undo your changes to the Makefile since that patch already contains 
it.

> The steps.

Thanks, it is always important to post them, so that the help can be more 
detailed.

> // I had to modify /arch/um/Makefile-i386 to add the word basic
>
> // after scripts/ like before on 2.6.5

The patch from Jeff Chua did this work and also fixed the problems you have.

> The 2.6.6-rc1 host is doing good though.

Thanks for this test: the SKAS patch is very well tested, but I absolutely did 
not have the time to test that little change (2 lines, so don't worry).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
