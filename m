Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bp0Yf-0000dX-Hx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 01:10:05 -0700
Received: from web52101.mail.yahoo.com ([206.190.39.70])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bp0Ye-0001v4-Rl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 01:10:05 -0700
Message-ID: <20040726080954.43807.qmail@web52101.mail.yahoo.com>
From: =?iso-8859-1?q?Chris=20Epicier?= <seuchato@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] suse 9.1 compilation error: net/ipv4/igmp.c:1192
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
Date: Mon, 26 Jul 2004 10:09:54 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

Hi there

I already posted this one  in the user-mode-linux-user
maillist but had no reply. Is it a beginners error
(possible, sionce I am a newbie in UML)?

I would like to build a safe server using suse 9.1 and
uml. When I try to compile the kernel I get the
following error(s):

...
CC      net/ipv4/igmp.o
  net/ipv4/igmp.c: In function `ip_mc_inc_group':
  net/ipv4/igmp.c:1192: error: `multicast_chain'
undeclared (first use in this function)
  net/ipv4/igmp.c:1192: error: (Each undeclared
identifier is reported only once
  net/ipv4/igmp.c:1192: error: for each function it
appears in.)
  net/ipv4/igmp.c: In function `ip_mc_dec_group':
  net/ipv4/igmp.c:1219: error: `multicast_chain'
undeclared (first use in this function)
  make[2]: *** [net/ipv4/igmp.o] Error 1
  make[1]: *** [net/ipv4] Error 2
  make: *** [net] Error 2 

I use Suse 9.1:
Linux version 2.6.5-7.95-default (geeko@buildhost)
(gcc version 3.3.3 (SuSE Linux)) #1 Thu Jul 1 15:23:45
UTC 2004 

I do the following commands: 
make clean ARCH=um
make mrproper ARCH=um
make xconfig ARCH=um (saved .config)
make linux ARCH=um 

What I tried is to replace -O2 by -O1 compiler option
with exactly same result.

I would appreciat any help thanks


	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
