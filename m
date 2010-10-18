Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <toralf.foerster@gmx.de>) id 1P7ler-0003WC-Qs
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 09:05:29 +0000
Received: from mailout-de.gmx.net ([213.165.64.23] helo=mail.gmx.net)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1P7leq-0007vq-Du for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 09:05:29 +0000
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Mon, 18 Oct 2010 11:05:16 +0200
References: <201010131328.06465.toralf.foerster@gmx.de>
	<201010171555.40453.toralf.foerster@gmx.de>
	<20101017201837.GA16458@lst.de>
In-Reply-To: <20101017201837.GA16458@lst.de>
MIME-Version: 1.0
Message-Id: <201010181105.17077.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>

Well, in addition to my last mail the following patch isn't a fix, but it =

might point to the culprit.
If I apply this patch against latest tree, then the crash doesn't occur :

diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 0166d32..e336e70 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -15,8 +15,8 @@ struct kstatfs {
        __kernel_fsid_t f_fsid;
        long f_namelen;
        long f_frsize;
-   long f_flags;
        long f_spare[4];
+ long f_flags;
 };



Christoph Hellwig wrote at 22:18:37
> On Sun, Oct 17, 2010 at 03:55:39PM +0200, Toralf F?rster wrote:
> > I bisected it again w/ a fixed test script, got the same bad commit
> > script and double checked, that this commit is really the culprit which
> > crashes a user mode linux kernel at my 32bix x86 stable Gentoo running
> > 2.6.35.6 vanilla kernel as host system and 2/ gcc version 4.4.3 (Gentoo
> > 4.4.3-r2 p1.2) and glibc-2.11.2-r1 in the tool chain.
> =

> I really can't see any relation to the patch.  Can you try the some
> things in the following order, please:
> =

>  (1) git-revert 365b18189789bfa1acd9939e6312b8a4b4577b28 on current
>      Linus tree and see it it works.
>      If it works try the next, else the bisect must have been a weird
>      conicidence and I can't really help more.
>  (2) re-apply only the changes to include/asm-generic/statfs.h from
>      365b18189789bfa1acd9939e6312b8a4b4577b28 and see if that still
>      boots.
>  (3) re-apply the arch/mips/include/asm/statfs.h and
>      arch/s390/include/asm/statfs.h changes and see if it still boots
>  (4) re-apply the include/linux/statfs.h changes and see if it still
>       boots
>  (5) re-apply the fs/statfs.c changes, and by now it really shouldn't
>      boot anymore
>  (6) verify the code really is the same again as in current Linus' tree


-- =

MfG/Kind regards
Toralf F=F6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3


---------------------------------------------------------------------------=
---
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly =

Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

