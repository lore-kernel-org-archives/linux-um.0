Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BK1eY-0007EB-80 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 May 2004 14:04:06 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BK1eX-0002cS-MF for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 May 2004 14:04:05 -0700
Message-ID: <005b01c42fc0$a48b37b0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0405011439220.30233-100000@tuxrocks.com>
Subject: Re: [uml-devel] UML kernel panic
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
Date: Sat, 1 May 2004 23:09:50 +0200
To: Frank Sorenson <frank@tuxrocks.com>, user-mode-linux-devel@lists.sourceforge.net

hi!
yesterday in installed tomcat on a uml 2.6.4 with suse9 rootfs.
tomcat needs jre1.4 and jdk1.4 rpm`s.
all demo jsp`s and demo servlets run fine - so basically java works.
are there any known uml java issues besides the ones reported by frank ?
i would like to create an development environment for some programmers, 
where everybody should have his own machine with his own tomcat - so 
i`m a little bit unsure, if it is stable enough. 

regards
roland


----- Original Message ----- 
From: "Frank Sorenson" <frank@tuxrocks.com>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Saturday, May 01, 2004 10:49 PM
Subject: [uml-devel] UML kernel panic


> I'm getting a UML kernel panic whenever I run the j2eesdk (Java with EJB -
> http://java.sun.com/j2ee/1.4/download.html#sdk) installer.  The panic is 
> "Segfault with no mm".
> 
> I tried running the latest supported version (2.4.24-2), and I got several
> backtraces of the crash:
> http://sco.tuxrocks.com/uml/trace5.txt
> http://sco.tuxrocks.com/uml/trace6.txt
> http://sco.tuxrocks.com/uml/trace7.txt
> 
> The config file is at http://sco.tuxrocks.com/uml/config
> 
> Any ideas or suggestions?  Any help would be greatly appreciated.
> 
> Thanks,
> 
> Frank
> ---------------------------------------------------------------------------
> Frank Sorenson - KD7TZK
> Systems Manager, Computer Science Department
> Brigham Young University
> frank@tuxrocks.com
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE. 
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
