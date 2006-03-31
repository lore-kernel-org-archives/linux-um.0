Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FPRxE-0003tw-BN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Mar 2006 14:18:52 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FPRxB-0003t2-Ha
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Mar 2006 14:18:52 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Kernel panic - not syncing: Kernel mode signal 7
References: <442DA85B.1060804@theshore.net>
In-Reply-To: <442DA85B.1060804@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604010018.42600.blaisorblade@yahoo.it>
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
Date: Sat, 1 Apr 2006 00:18:42 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>

On Saturday 01 April 2006 00:08, Christopher S. Aker wrote:
> I'm posting this for posterity.  I've asked the user to upgrade to
> 2.6.16.1-bs1 for now.  He's hit this twice in the last month...

> http://www.theshore.net/~caker/uml/kernels/2.6.15-linode16

> Kernel panic - not syncing: Kernel mode signal 7

SIGBUS, aka /tmp (or wherever the memory is hosted, i.e. $TMP) full on the 
host.

> 89ae3778: [<8001f41c>] bus_handler+0x59/0x5b

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
