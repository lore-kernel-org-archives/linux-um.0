Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AH5kg-00019E-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 04 Nov 2003 10:18:02 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AH5kf-0007np-BX
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 04 Nov 2003 10:18:01 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Partitioning scheme for ubd's
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311041921.09084.blaisorblade_spam@yahoo.it>
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
Date: Tue, 4 Nov 2003 19:21:09 +0100
To: user-mode-linux-devel@lists.sourceforge.net

This should have gone to the list, but I sent it to Matt only. Sorry for this.

Alle 23:46, sabato 1 novembre 2003, Matt Zimmerman ha scritto:
> On Sat, Nov 01, 2003 at 11:59:11AM +0100, BlaisorBlade wrote:
> > But there is a problem here:
> > 1) device names are not consistent: if you want to use ubd[a-z], decide
> > so and start the change(for 2.6 there's a lot more changes anyway, so it
> > is a good occasion...)
>
> Are you talking about /proc/partitions or something else?

No, about the command line and the device file names.

> > 2) if I do an install, I can partition the ubd's; but then, I won't be
> > able to loop mount the file on the host(and if I'm in trouble, this
> > ability is worth a lot). In fact, I've never partitioned the ubd's, but
> > this meant a lot of trouble even to run Slackware install.
>
> Of course you can; use losetup -o (or mount -o loop,offset=).  But I don't
> see what this has to do with partition support for ubd.  You can use
> partitions or not, depending on what you prefer, just as with a real block
> device.

This was meant as intro for the 3). But there is losetup -o, so it's useless.
Sorry for not knowing it. Maybe it could be added inside UML docs.

> > 3) so, I thought this: since partitioning schemes are pluggable, it would
> > be possible to fool it and turn the ubd's into partitions of a single
> > disk. I.e. if I setup udb0, ubd1 and so on, they would be seen as three
> > partitions of a single disk. But they are still different files,
> > loop-mountable on host.
> >
> > Would you ever accept this?
>
> I can't think of any instance where I'd want this mixed solution, instead
> of the existing options with partitions and multiple ubd devices.

Ok. You're just right.

> > The other possible solution(which would be
> > cleaner) would be to teach, if possible, to the host kernel Device
> > Manager to read a file as a bunch of partition with its table(I've heard
> > of DM about COW files these days), and then to mount the partitions, but
> > I don't know if it's possible.

Would instead this one(or another way to do this) be interesting? So that the
kernel could guess by itself the offsets of partitions, rather than requiring
the user do more passages(i.e. use fdisk to read partition table) to handle
this.
Bye and sorry for my big mistake.
--
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
