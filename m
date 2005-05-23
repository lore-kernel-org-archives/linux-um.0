Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DaDjW-0003Gn-J3	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 07:16:42 -0700
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]
	helo=dorka.pomaz.szeredi.hu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DaDjU-00040e-Mf	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 07:16:42 -0700
In-reply-to: <200505231609.48425.blaisorblade@yahoo.it> (message from
	Blaisorblade on Mon, 23 May 2005 16:09:47 +0200)
Subject: Re: [uml-devel] [PATCH] UML - 2.6.12-rc4-mm2 Compile error
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
	<4290E1C6.9070709@gmail.com> <200505231609.48425.blaisorblade@yahoo.it>
Message-Id: <E1DaDj3-0002Xf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
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
Date: Mon, 23 May 2005 16:16:13 +0200
To: blaisorblade@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net, eric.begot@gmail.com, jdike@addtoit.com, akpm@osdl.org, linux-kernel@vger.kernel.org

> > Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for uml.
> > At the compilation of init/main.c, it complains because it doens't find
> > the 2 constants FIXADDR_USER_START and FIXADDR_USER_END
> Why deleting FIXADDR_START? Also FIXADDR_USER_* are defined, just in a 
> different way (and the patch below is IIRC uncorrect).

I've seen this error too after 'make menuconfig ARCH=um' on a clean
tree.

The following fixes it:

  cp .config /tmp
  make mrproper ARCH=um
  cp /tmp/.config .
  make ARCH=um

So there's definitely something wrong with the build on UML.

Miklos


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
