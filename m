Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A0lla-000128-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 20 Sep 2003 10:43:30 -0700
Received: from panoramix.vasoftware.com
	([198.186.202.147] helo=externalmx.vasoftware.com ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A0llZ-00033M-7J
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 20 Sep 2003 10:43:29 -0700
Received: from mout1.freenet.de ([194.97.50.132]:50919)
	by externalmx.vasoftware.com with esmtp (Exim 4.22 #1 (Debian))
	id 1A0llW-0005Mw-Ih
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 20 Sep 2003 10:43:26 -0700
Received: from [194.97.50.136] (helo=mx3.freenet.de)
	by mout1.freenet.de with asmtp (Exim 4.23)
	id 1A0llO-0001Dg-A2
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 20 Sep 2003 19:43:18 +0200
Received: from b96e2.pppool.de ([213.7.150.226] helo=home.petschge.de)
	by mx3.freenet.de with esmtp (Exim 4.23 #2)
	id 1A0llK-0001jO-VV
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 20 Sep 2003 19:43:18 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id CAF183BCE9
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 20 Sep 2003 19:35:19 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with SMTP id 521B03BCE7
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 20 Sep 2003 19:35:18 +0200 (CEST)
From: "Patrick \"Petschge\" Kilian" <petschge@web.de>
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu> <20030919095020.294F93BCE4@home.petschge.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030920173518.521B03BCE7@home.petschge.de>
Subject: [uml-devel] Re: compile problem with uml-patch-2.4.22-4
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
Date: Sat, 20 Sep 2003 19:35:18 +0200
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

[CONFIG_UML_WATCHDOG]
>> Could we borrow one of the descriptions from the main kernel watchdog
>> drivers?
> No, because there is CONFIG_WATCHDOG which has a help text and
> CONFIG_UML_WATCHDOG which doesn't have a help text and depends on
> CONFIG_WATCHDOG. Does anyone know what CONFIG_UML_WATCHDOG does?
It looks like UML_WATCHDOG is a software watchdog which only exists on the 
um arch. Perhaps it should not have a own CONFIG_ option but should be 
triggerd by CONFIG_SOFT_WATCHDOG. Jeff, is there a specific reason to give 
UML_WATCHDOG a own option?


mfg,
Patrick "Petschge" Kilian

-- 
"If certain acts of violation of treaties are crimes, they are crimeswhether 
the United States does them or whether Germany does them, and
we are not prepared to lay down a rule of criminal conduct against
others which we would not be willing to have invoked against us."  
--Robert Jackson, American prosecutor in the Nuremberg War-Crimes Trial



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
