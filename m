Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zL3A-0000t7-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 11:59:44 -0700
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19zL3A-0003xe-9o
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Sep 2003 11:59:44 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Cannot see stack after add-symbol-file
References: <3F621741.4000606@bezeqint.net>
In-Reply-To: <3F621741.4000606@bezeqint.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200309162101.02464.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Sep 2003 21:01:02 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:58, venerd=EC 12 settembre 2003, Etay Meiri wrote:
> Hi,
>
> I have a strange problem when debugging my module under uml.
> When the module crashes, I go into the debugger and display
> the stack trace. There are several frame and there is one named
> "????". I assume this is my module so I add the symbol file according
> to the howto. The symbols load ok but the next time I do 'bt' I get
> only the frame of the panic.

>
> <<< another backtraced >>>
>
> (gdb) bt
> #0  panic (fmt=3D0xa01ef540 "Kernel mode fault at addr 0x%lx, ip 0x%lx")
>      at panic.c:52
> (gdb)
>
>
> The host is RH9 running kernel 2.6.0-test4. The uml is 2.4.22. This also
> happened when I loaded the symbols before the module crashed.
>
> Any idea?
What version of GDB are you running? Some time ago, there were various thre=
ads=20
in both lists(devel/user) about GDB showing only the last frame in all=20
backtraces. The bug was tracked down... and it came from binutils, IIRC(the=
=20
proposed fix was a workaround in GDB). Maybe it is appearing here in a=20
different form.
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
