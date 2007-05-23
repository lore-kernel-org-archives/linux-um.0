Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hqz1u-0004Vc-5R for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 15:10:02 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Hqz1t-0002aF-DE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 15:10:01 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 24 May 2007 00:09:43 +0200
References: <7694D1D9D7B18142A440B52FA1E4AB9702A207C3@CHN-SNR-MBX01.wipro.com>
In-Reply-To: <7694D1D9D7B18142A440B52FA1E4AB9702A207C3@CHN-SNR-MBX01.wipro.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705240009.43991.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] doubt in debugging.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@karaya.com, rajasekhar.pulluru@wipro.com, user-mode-linux-user@lists.sourceforge.net

On mercoled=EC 23 maggio 2007, rajasekhar.pulluru@wipro.com wrote:
> Hi Guys,
>
> Am a newbie to linux and UML.I have installed UML(mandrake) in my linux
> system. And I started UML from my host linux system using the command:
>
>     ./linux ubd0=3Droot_fs eth0=3Dtuntap,,,10.145.93.183 debug
>
> I get the gdb xterm and another one for uml.
>
> I have written a basic character ram disk driver( which writes n read
> one byte of ram).This .c is in  /root/raj/chardev/ directory

> in uml=20
You see? It's only in UML.
> and =20
> I stored it as chardriver.c and compiled it with proper kernel flags to
> get chardriver.o
>
> This chardriver.o is in uml now.
> Then I insmoded it and it got loaded.
>
> When I typed print *module_list in gdb, it said chardriver is loaded.
> then i typed:
> printf "0x%08x", (int)module_list + module_list->size_of_struct
> it gave me 0xa307b060
> but when i asked gdb to add the symbols by:
> add-symbol-file /root/raj/chardev/chardriver.o 0xa307b060

> adding symbol tabel from file "chardriver.o" at .text_addr =3D 0xa307b060
> (y or n)  yes
> to which it replied
> chardriver.o: No such file or directory
> how to proceed ? kindly help me out.

Your problem seems just that gdb does not find the file chardriver.o, which=
 is=20
probably inside the guest (you say that in the mail). Gdb has no special=20
access to files inside the VM.

Btw, since you have a .o module I assume you are _STILL_ using a 2.4 UML=20
kernel, right?
--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

