Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1XTt-0005hR-FG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:44:57 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C1XTr-00071S-Re for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:44:57 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] fixing ptrace for ARM
References: <20040827171904.42460.qmail@web12504.mail.yahoo.com>
In-Reply-To: <20040827171904.42460.qmail@web12504.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-15"
Message-Id: <200408292341.10362.blaisorblade_spam@yahoo.it>
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
Date: Sun, 29 Aug 2004 23:41:10 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sam T Sander <ssander@rocketmail.com>

Alle 19:19, venerd=EC 27 agosto 2004, Sam T Sander ha scritto:
> As a first step toward porting UML to ARM, I need to fix ptrace to modify
> system call numbers.  Unfortunately, I don't know where to start.  Can
> anyone point me in the right direction? Has anyone looked into this for A=
RM
> or any of the other ports?  What was changed in the X86 ptrace to fix it?
I think that the work must be done in the stack layout on ptracing (read th=
e=20
handle_trap() function for what UML does). But also see this URL:=20

http://perso.wanadoo.fr/laurent.vivier/UML/

One of the nice thing of those patches is that if you implement something=20
similar (which is a lot easier IMHO) you don't need to be able to change=20
system call numbers.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
