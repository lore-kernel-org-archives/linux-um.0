Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bpa85-0007Va-9E for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jul 2004 15:09:01 -0700
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bpa84-0002SL-V5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jul 2004 15:09:01 -0700
Message-ID: <20040727220852.11227.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] uml-2.6.8-rc2 (2.6.8-rc2 w/ uml-patch-2.6.7-01)
Content-Type: Text/Plain;
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
Date: 27 Jul 2004 22:08:52 -0000
To: user-mode-linux-devel@lists.sourceforge.net



> > Probably something simple, but I wanted to discuss with folks

> > more in the now on if the above (stdio_console) fix was the
right

> > one, and to find out if anyone else has an idea of how to
fixe

> > the find_next_zero_bit error.



> Yes, I saw that error in -mm and I agree that renaming is right;
about the 

> other one, the reported fix (below) is correct; also, it would
be nice to 

> delete include/asm-um/bitops.h (which includes the i386 version
of the 

> include; since those funcs were moved to out-of-line ones,
the trick must be 

> done that way).



When I delete include/asm-um/bitops.h I can nolonger compile
(main.o complains aobut implicit definition of find_next_bit
& find_next_zero_bit).



What am I supposed to replace include/asm-um/bitops.h with? 
Am I somehow supposed to symlink it to an SUBARCH?



> Note however that we must not hardcode that we steel things
from i386 arch, 

> but we must use $(SUBARCH) - or it will break for any other
archs (the only 

> working one, at the moment, is the x86_64 one).



I've tweaked my 2.6.8-rc2-1um to use $(SUBARCH), as well..  If
I can figure out how to handle bitops.h similarly, I'll post
an patch of my changes vs an vanilla 2.6.8-rc2 tree.



George



----------------------------------------

Single? Find Christian Singles like you!

http://www.praize.com/singles/





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
