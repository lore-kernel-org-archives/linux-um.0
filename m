Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOWrr-0008Cl-G9	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 01:49:15 -0700
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOWrn-00035b-5v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 01:49:12 -0700
Received: from sphinx.mythic-beasts.com ([212.69.37.6])
	by wumpus.mythic-beasts.com with esmtp (Exim 4.44)
	id 1EOWrk-0006T4-U6	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 09:49:08 +0100
From: Chris Lightfoot <chris@ex-parrot.com>
Message-ID: <kn7Kw6UlJKHZ.4niY2yJ60VjcB1b/7Ij+3Q@sphinx.mythic-beasts.com>
References: <z/jPSbKkgHHL.jbObjJNOGZsiVW/jm0lNOg@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z/jPSbKkgHHL.jbObjJNOGZsiVW/jm0lNOg@sphinx.mythic-beasts.com>
Subject: [uml-devel] Re: UBD performance
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
Date: Sun, 9 Oct 2005 09:49:08 +0100
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 08, 2005 at 05:32:10PM +0100, Chris Lightfoot wrote:
    [...]
> ... while the same experiment on a 2.6.13.3 UML kernel
> (booting with parameters ubd0s=filesystem mem=128M)
> running on the same hardware gives the following less
> impressive results:
> 
>     # time dd if=/dev/zero of=testfile bs=1M count=32
>     32+0 records in
>     32+0 records out
>     33554432 bytes transferred in 0.761825 seconds (44044809 bytes/sec)
> 
>     real    0m0.770s
>     user    0m0.000s
>     sys     0m0.240s
>     # time rm testfile
>     
>     real    1m20.808s
>     user    0m0.000s
>     sys     0m0.120s
> 
> (in this case the filesystem is from Debian `sarge', but
> there's no reason this should make a significant
> difference). Note that in both cases I've run the test
> several times in order until the timings stabilise a bit.

So, the reason this is so slow is that if you do the
unlink immediately after the dd command completes, the IO
for the unlink has to wait until all of the IO for the dd
has been completed. While in principle that should be
pretty quick (and the timings from the dd confused me into
thinking it was) in fact under stock UBD those writes take
*minutes* to complete; the elapsed time for the unlink is
all spent waiting for the queue to drain. If you wait for
that to happen then do the unlink it takes a fraction of a
second, as expected.

-- 
``Is `colons' the plural of `semi-colon' if you know
  you have an even number of them?'' (David Richerby)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
