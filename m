Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRiCU-0005pr-99 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 18:54:54 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BRiCT-00082L-Qq for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 18:54:53 -0700
Message-ID: <064d01c44069$ef2416c0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040522104051.40285.qmail@web40507.mail.yahoo.com>
Subject: Re: [uml-devel] UML hangs at "INIT: Entering runlevel: 3"
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
Date: Sun, 23 May 2004 04:01:58 +0200
To: Cheng yong <cheng_lucia@yahoo.com>, user-mode-linux-devel@lists.sourceforge.net

hi lucia, 

- make sure your rootfs is ok - fsck it from outside the uml
- recompile your uml-kernel after changing "-O2" to "-O1" in 
all makefiles. (see: https://p0lar.dot1q.net/SuSE-UML-2.6.6-instructions.html)
- try again
- report :)

hth
roland

 

----- Original Message ----- 
From: "Cheng yong" <cheng_lucia@yahoo.com>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Saturday, May 22, 2004 12:40 PM
Subject: [uml-devel] UML hangs at "INIT: Entering runlevel: 3"


> Hi, everybody,
> 
> my UML hangs at " INIT: Entering runlevel: 3". If I
> kill the process and restart it, UML will be started
> with following errors:
> 
> fsck.ext2 /dev/ubd0 failed.
> ...
> modprobe: modprobe: Can't open dependencies file
> /lib/modules/2.4.26-1um/modules.dep (no such file or
> directory) /etc/init.d/kbd: line 274: /dev/tty8: No
> such device
> 
> ... and so on.
> 
> 
> All of these started after I updated my software
> online. My operating system is Suse 9.0. I compiled
> the uml kernel with linux-2.4.26.tar.bz2 and
> uml-patch-2.4.26-1.bz2. The root filesystem was
> created by uml-install-suse.
> 
> I'd appreciate that if you can help me.
> 
> best regards
> 
> lucia
> 
> 
> 
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Domains - Claim yours for only $14.70/year
> http://smallbusiness.promotions.yahoo.com/offer 
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
