Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTh54-0004ll-7m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 06:07:26 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BTh53-0004RE-Id for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 06:07:25 -0700
Message-ID: <142701c444b5$ba3ee570$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [BUG?] - Network Problem - ifconfig eth0 up fails
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
Date: Fri, 28 May 2004 15:14:36 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: hno@marasystems.com, Jeff Dike <jdike@addtoit.com>

hi !

if i do a 

ifconfig eth0 down
ifconfig eth0 up

inside uml, i get:

SIOCSIFFLAGS: Device or resource busy

and kernel log says:
TUNSETIFF failed, errno = 16 (16 is Device or ressource busy)

most of the time it seems to behave like this - but i`m sure that a was able to up/down 
the interface and didn`t get this error. i don`t know, under which circumstances this 
effect doesn`t happen.

i have 2.6.6-um/suse9.1 running on suse9.0/2.6.6-vanilla/skas
i`m using bridged networking (tuntap) with dedicated tap-device for each uml

seems to be a bug wich exists for some time:
http://marc.theaimsgroup.com/?l=user-mode-linux-user&w=2&r=1&s=TUNSETIFF+failed+16&q=b

any hints to dig into this further ?

stracing the ifconfig shows:
ioctl(4,0x8913,0xbffff540)    = 0
ioctl(4,0x8914,0xbffff540)    = -1 EBUSY (Device or resource busy)

regards
roland




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
