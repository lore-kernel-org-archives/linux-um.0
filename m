Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsRvQ-00044B-7y
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 11:27:32 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AsRsM-0000hJ-GQ
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 11:24:22 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] need help , uml .....
References: <20040214183745.20159.qmail@web60103.mail.yahoo.com>
In-Reply-To: <20040214183745.20159.qmail@web60103.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402151715.53930.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 15 Feb 2004 17:15:53 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: kenz kenz <kenz260@yahoo.fr>

Alle 19:37, sabato 14 febbraio 2004, kenz kenz ha scritto:
> hello, i'm a student trauing to use uml in my project , i have a P4
> processor ; i install linux redhat 9 in my computer .

See http://toast.debian.net/~may/umlproject/bugs.html, the first section under 
Fedora specific bugs. That could be maybe the solution, but it could also be 
not.

> i try to install uml
> in it but i didn't succeed . i have done this :
> 1- i unzip linux-2.4.20......tar.bz2
>    tar -jxvf linux......
> 2- i have patch this kernel
>     bunzip uml-patch...bz2|patch 1
>    (in this commande i was obligede to create a new directory um in
> linux-2.4.20/arch so the patch functions correctly )
Strange, if you do bzcat uml-patch....bz2|patch -p1 you should not need that 
(bunzip uml-patch..bz2|patch 1 cannot work at all).
 3- i done make xconfig
> ARCH=um
> 4- make dep

Not needed at all.

> a window appeared , i save an exsit this window
Ehh? You mean that after make xconfig ARCH=um you pressed "save and exit"? Do 
you know what make xconfig is about? It seems you should really read the 
"Kernel HOWTO" (Google is your friend in finding it).

> 5- make uml-linux ARCH=um

You mean "make linux ARCH=um", right?

> 6- when trying to run the binary with
>     uml-linux ubd0=path-of-file-system
> it dosen't work complitly , it ended with a message like :
> kernel panic ...........line 603

You must post the exact messages it prints out, with copy-and-paste to the 
mail.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
