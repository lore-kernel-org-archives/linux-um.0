Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO2qm-0003SC-LF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 16:09:20 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BO2qm-0002sT-2f for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 16:09:20 -0700
Message-ID: <105d01c43877$1f70db10$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <104601c43874$a5735f60$2000000a@schlepptopp>
Subject: Re: [uml-devel] uml 2.6.6 - minor issue ( IO memory driver compile
	fails)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 13 May 2004 01:16:13 +0200
To: blaisorblade_spam@yahoo.it, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

hi again, 
the email-address of Greg Lonnon seems to be obsolete.
is he still involved in UML ?
i forwarded that message to him, because he is mentioned on:
http://user-mode-linux.sourceforge.net/iomem.html

the IO memory driver compiles fine (statically/module) for 2.4.26 - 
so it probably needs to be fixed for 2.6.6 only.

regards
roland


----- Original Message ----- 
From: "roland" <for_spam@gmx.de>
To: <blaisorblade_spam@yahoo.it>; "Jeff Dike" <jdike@addtoit.com>
Cc: <glonnon@ridgerun.com>; <user-mode-linux-devel@lists.sourceforge.net>
Sent: Thursday, May 13, 2004 12:58 AM
Subject: [uml-devel] uml 2.6.6 - minor issue ( IO memory driver compile fails)


> hi !
> compiling the the example IO memory driver in 2.6.6 (blaisorblade patch)
> (->Block Devices -> Example IO memory driver) fails  - regardless if it`s 
> compiled statically or as a module. don`t know if it was broken before - 
> but i think it`s at least worth being mentioned.
> 
> if it`s generally broken and not expected to be fixed in the near future, 
> maybe it makes sense to change arch/um/Kconfig_block to:
> 
> -----snipp-----
> config MMAPPER
>         tristate "Example IO memory driver"
>         depends on !CLEAN_COMPILE               <- insert this line
>         help
> -----snippp------
> 
> ???
> 
> regards
> roland
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
> deliver higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
