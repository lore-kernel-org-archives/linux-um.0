Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRuJu-0000F1-HM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 07:51:22 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BRuJs-0007er-R1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 07:51:21 -0700
Message-ID: <084601c440d6$67d64090$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <40AFB5AB.2060204@mvpsoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] Sources of entropy?
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
Date: Sun, 23 May 2004 16:58:26 +0200
To: Chris Snyder <csnyder@mvpsoft.com>
Cc: Jeff Dike <jdike@addtoit.com>, blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

hi, 
afaik, uml still has a general problem with /dev/random entropy.
please read:
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107914271712404&w=2

proxying /dev/random from the host sounds like a good solution.
is there work in progress ?

regards
roland


----- Original Message ----- 
From: "Chris Snyder" <csnyder@mvpsoft.com>
To: <user-mode-linux-user@lists.sourceforge.net>
Sent: Saturday, May 22, 2004 10:18 PM
Subject: [uml-user] Sources of entropy?


> I'm having a problem with a UML that I have set up as a Kerberos server: 
> starting the Kerberos Admin Daemon takes around ten minutes because 
> there is very little entropy available in the UML, making reads from 
> /dev/random block. Has anyone else ran into this problem? How can I most 
> effectively deal with this? Thanks in advance.
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
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
