Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhySt-0005P2-I2 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 13:58:47 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AhySt-0002Fd-6Y for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 13:58:47 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AhySs-0000Iu-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2004 22:58:46 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <bucb6k$pck$1@sea.gmane.org>
References: <bua04l$6uo$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <bua04l$6uo$1@sea.gmane.org>
Subject: [uml-devel] Re: cannot compile 2.6.1 uml-kernel, NPTL?
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
Date: Sat, 17 Jan 2004 22:57:42 +0100
To: user-mode-linux-devel@lists.sourceforge.net

> gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free 
> -Wl,--wrap,calloc \
>         -o linux arch/um/main.o vmlinux -L/usr/lib -lutil

Since the only file that's included is /usr/lib/libutils.so and this 
file is part of glibc, i believe that it's my NPTL-patched glibc.

Can somebody with installed NPTL confirm the problem?

BTW: i'm using glibc 2.3.2



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
