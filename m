Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjO0N-00083U-NK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 11:27:11 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AjO0N-0007kF-5P for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 11:27:11 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: First shrinkage of *_user.c files
References: <200401202026.19785.blaisorblade_spam@yahoo.it>
	<200401202034.i0KKY4DG004042@ccure.user-mode-linux.org>
In-Reply-To: <200401202034.i0KKY4DG004042@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401212029.44947.blaisorblade_spam@yahoo.it>
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
Date: Wed, 21 Jan 2004 20:29:44 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 21:34, marted=EC 20 gennaio 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > I've started removing some functions from the user_objs, and here
> > there are  the two first patches. Any comment on the style of these
> > changes is highly  appreciated. The next thing I'm going to do is to
> > remove entirely  hostaudio_user.c (I've already started this, but I've
> > not got a successful  test yet, since I also did a little fix in
> > this).
>
> Yeah, that's the style I'm looking for.  The goal should be to eliminate
> anything outside of arch/um/os needing any libc headers.
>
> Try to extract the essence of the libc dependency into arch/um/os rather
> than just moving large chunks of code there, which looks like what you're
> doing.
I added a function to os- and moved some other ones away from _user files.

The first is not too tiny because some other system could not have the=20
termios.h abstraction, so it must be more abstract (for Windows it will=20
probably be a no-op, since there is no support in the OS IMHO).

The moved functions didn't depend on userspace so I just moved them (they a=
re=20
tiny wrappers but are needed for some structures).

However, see the next patches I posted for more changes.

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
