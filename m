Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahwdb-0001ih-7o for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 12:01:43 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ahwda-0005h9-Nd for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 12:01:42 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<200401172009.38339.blaisorblade_spam@yahoo.it>
	<20040117195019.GA7405@ccure.user-mode-linux.org>
In-Reply-To: <20040117195019.GA7405@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401172103.26457.blaisorblade_spam@yahoo.it>
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
Date: Sat, 17 Jan 2004 21:03:26 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Alle 20:50, sabato 17 gennaio 2004, Jeff Dike ha scritto:
> On Sat, Jan 17, 2004 at 08:09:38PM +0100, BlaisorBlade wrote:
> > Do the apply_alternatives + constants silly fix posted 1000 times and
> > compile without CONFIG_MODVERSIONS. Then you don't get the kernel panic,
> > and everything works.
> >
> > I've succesfully built kernel with CONFIG_MODVERSIONS, but *maybe* the
> > Makefile patch is needed for that (since files are post-processed with
> > genksyms). However, I have fixed some other things which could interact
> > with this, especially for the link scripts.
>
> Did you actually get modules to work?  I was under the impression you
> hadn't got that far yet, just getting UML to build with CONFIG_MODULES
> endabled.

First (answering the other message): thanks for starting merging them!

Modules work perfectly without Modversions (and even /proc/kallsyms works 
well); with the USER_OBJS thing even modversions works perfectly, even if you 
don't like it (but I hadn't been clear about the fact the kernel runs with 
it).

If you are interested in it, I could do a trivial change (i.e. adding to each 
makefile include arch/um/Makefile.special) to avoid changing the whole 
Kbuild.

I do remember your discussion about the os- change, but it's a lot longer and 
I didn't start it. Also, I must check exactly the API to create (i.e. how to 
abstract os-specific details, which is hard since I've never programmed on 
Cygwin or Freebsd). And also, if you assume that a file handle is an integer 
(which is true only on POSIX), why do you wrap open inside os_open_file 
(which always works on POSIX)? The same question could go for other calls.

Bye
-- 
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
