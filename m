Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzwDf-0008SD-8X for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 03:13:19 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AzvcG-000180-IC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 02:34:40 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] adding a system call
References: <20040305044252.33005.qmail@web21408.mail.yahoo.com>
In-Reply-To: <20040305044252.33005.qmail@web21408.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403071203.08619.blaisorblade_spam@yahoo.it>
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
Date: Sun, 7 Mar 2004 12:03:08 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nick Weber <shinwa8@yahoo.com>

Alle 05:42, venerd=EC 5 marzo 2004, Nick Weber ha scritto:
> I've been having some trouble getting a system call to
> work in uml.  I've gotten it to work on my host
> kernel.  Here's my setup:
> system: Debian
> host: 2.6.3 tried with and without patch from
> www.user-mode-linux.org/~blaisorblade/
> uml: 2.6.3
>
> I first tried a simple printk just to see if I could
> get a system call to work.  The test program calls the
> sytem call and exits normally with no indication of an
> error. On the host system the printk shows up in
> /var/log/syslog.  Doesn't show up anywhere in uml.
> Then I tried a system call that uses a put_user and
> get_user to modify a number I give it in a test
> program.  Part of the test code looks like this:
>
> int ret =3D new_sys1(&user_space_int);
>   if (ret !=3D 0) print error information.
>
> The system call does a printk to let you know it
> worked and modifies the number you give it and returns
> 0 on success -EFAULT on error.  The value of ret is
> -1.  Anyone have any ideas as to what is going wrong?

That is correct behaviour if you passed a wrong address. Notice in man open=
=20
that it returns -1 on error while sys_open returns -errno, read=20
include/asm-i386/unistd.h, understand that any negative return value is mov=
ed=20
onto errno and that -1 is returned instead, understand you must print errno=
=20
in your test case and you'll have got the clue.

If you did already understand what I said (it did not seem anyway), post=20
actual code that someone can understand; if you got the exact code working =
on=20
the host, in means that your syscall does not get the correct address becau=
se=20
it is not reading the correct registers - print &user_space_int in the test=
=20
case and printk the arg in the syscall - they possibly do not match.

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
