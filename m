Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhwPS-0006KK-23 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:47:06 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AhwPR-0005MC-Ha for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:47:05 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <200401130510.i0D5AlS4026784@ccure.user-mode-linux.org>
In-Reply-To: <200401130510.i0D5AlS4026784@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401172048.47847.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] /dev/anon available
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
Date: Sat, 17 Jan 2004 20:48:47 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 06:10, marted=EC 13 gennaio 2004, Jeff Dike ha scritto:
> I released two /dev/anon patches today - one for stock 2.4.23 and one for
> RH8 2.4.8-14.
>
> In short, /dev/anon is a device which UML can map its physical memory from
> and which can free dirty pages back to the host.  In conjunction with
> 'ubd=3Dmmap', this can noticably reduce the memory consumption of UMLs on
> the host.  See http://user-mode-linux.sourceforge.net/devanon.html for mo=
re
> details.
>
> This requires the next version of UML, which will be released shortly.

I've given a look to the page, but yet I cannot see (this can be for my fau=
lt,=20
but I'd really like an explaination of this) why you couldn't just mmap=20
/dev/zero with MAP_PRIVATE to get the behaviour you want to get from=20
/dev/anon (or maybe using MAP_ANONYMOUS). When you munmap a page, that goes=
=20
out of your address space, so it cannot be dirty any more dirty. Also, with=
=20
mmap you cannot modify /dev/zero, as it's a special case (mmap'ing that giv=
es=20
you a COW reference to the zero-filled page).

Beyond, I've checked that munmap works even for partial unmapping of files.=
 So=20
you could even mmap it as a single chunk (or better two chunks, read-only a=
nd=20
read-write memory on i386; it would be harder on other arch's), at the end =

and munmap to free any page (that splits the old mapping into two new ones =

that map the pages around the unmapped ones). The problem is that using thi=
s=20
means you cannot do mremap to enlarge mapped space, since in that case you =

don't know which mapping to remap (if you don't track it by hand, which wou=
ld=20
be actually hard).

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
