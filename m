Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRbPk-000247-RJ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 11:40:08 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BRbPj-0005qZ-2G for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 11:40:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML hangs at "INIT: Entering runlevel: 3"
References: <20040522104051.40285.qmail@web40507.mail.yahoo.com>
In-Reply-To: <20040522104051.40285.qmail@web40507.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405222042.53106.blaisorblade_spam@yahoo.it>
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
Date: Sat, 22 May 2004 20:42:53 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Cheng yong <cheng_lucia@yahoo.com>

Alle 12:40, sabato 22 maggio 2004, Cheng yong ha scritto:
> Hi, everybody,
>
> my UML hangs at " INIT: Entering runlevel: 3". If I
> kill the process and restart it, UML will be started
> with following errors:
>
> fsck.ext2 /dev/ubd0 failed.

> modprobe: modprobe: Can't open dependencies file
> /lib/modules/2.4.26-1um/modules.dep (no such file or
> directory) /etc/init.d/kbd: line 274: /dev/tty8: No
> such device
>
> ... and so on.
It is possible that your virtual root filesystem (the root_fs file) got 
damaged the first time. However try older UML's (2.4.24-1) which are more 
stable.

> All of these started after I updated my software
> online.

You mean the host or the guest? It is possible that it was its fault, but if 
you don't get the list of what you updated we can't help.

> My operating system is Suse 9.0. I compiled
> the uml kernel with linux-2.4.26.tar.bz2 and
> uml-patch-2.4.26-1.bz2. The root filesystem was
> created by uml-install-suse.
Thanks for these info...

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
