Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1Wvg-00083m-P9 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:09:36 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C1Wve-00036n-Td for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:09:36 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] SKAS on AMD 64-Bit
References: <LEEIJGBJEEABAGOFFGAHCEHMCBAA.brocka@sterlingcgi.com>
In-Reply-To: <LEEIJGBJEEABAGOFFGAHCEHMCBAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-15"
Message-Id: <200408231758.16810.blaisorblade_spam@yahoo.it>
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
Date: Mon, 23 Aug 2004 17:58:16 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anthony Brock <brocka@sterlingcgi.com>

Alle 01:13, luned=EC 16 agosto 2004, Anthony Brock ha scritto:
> It would probably help if I included the patch! :)
Hmmm... are you trying to run a normal UML binary, I guess, i.e. a 32-bit a=
pp=20
which would also run onto a x86 pc, right? 64bit UMLs don't support well th=
e=20
SKAS mode (actually, I never tested this, but there are some significant=20
changes in the SKAS code in the x86_64-UML patch).

I wrote a patch for this, applying onto a vanilla 2.4 kernel tree, but I ne=
ver=20
tested it (not even if it compiled). And I'm rechecking it, and there are=20
some bugs in it.

About your patch, there is just a big bug in your patch (if you want to run=
 a=20
*32* bit UML): when a 32 bit app invokes a syscall, let's say mmap, actuall=
y=20
it calls the sys32_ version of it, if that one exists, in this case=20
sys32_mmap. You can check the name of the syscall functions in=20
arch/x86_64/ia32/ia32entry.S. There are some such bugs in my patch, too, in=
=20
fact. However, when I come back (I'm on holidays and far from Internet -=20
today is 23 August), if you want to help (i.e. actually test the patches), =

just email me and I'll finish the porting and publish it.

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
