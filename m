Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO2Zc-00081D-Nd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 15:51:36 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BO2Zc-0002mz-Be for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 15:51:36 -0700
Message-ID: <104601c43874$a5735f60$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] uml 2.6.6 - minor issue ( IO memory driver compile fails)
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
Date: Thu, 13 May 2004 00:58:27 +0200
To: blaisorblade_spam@yahoo.it, Jeff Dike <jdike@addtoit.com>
Cc: glonnon@ridgerun.com, user-mode-linux-devel@lists.sourceforge.net

hi !
compiling the the example IO memory driver in 2.6.6 (blaisorblade patch)
(->Block Devices -> Example IO memory driver) fails  - regardless if it`s 
compiled statically or as a module. don`t know if it was broken before - 
but i think it`s at least worth being mentioned.

if it`s generally broken and not expected to be fixed in the near future, 
maybe it makes sense to change arch/um/Kconfig_block to:

-----snipp-----
config MMAPPER
        tristate "Example IO memory driver"
        depends on !CLEAN_COMPILE               <- insert this line
        help
-----snippp------

???

regards
roland





-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
