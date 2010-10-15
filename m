Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <toralf.foerster@gmx.de>) id 1P6gfb-0006pU-M1
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2010 09:33:47 +0000
Received: from mailout-de.gmx.net ([213.165.64.23] helo=mail.gmx.net)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1P6gfa-0005KT-Ao for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2010 09:33:47 +0000
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Fri, 15 Oct 2010 11:33:37 +0200
References: <201010131328.06465.toralf.foerster@gmx.de>
In-Reply-To: <201010131328.06465.toralf.foerster@gmx.de>
MIME-Version: 1.0
Message-Id: <201010151133.38170.toralf.foerster@gmx.de>
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
To: user-mode-linux-devel@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

Hello,

git bisect gave :

tfoerste@n22 ~/devel/linux-2.6 $ git bisect bad
365b18189789bfa1acd9939e6312b8a4b4577b28 is the first bad commit           =
                                             =

commit 365b18189789bfa1acd9939e6312b8a4b4577b28                            =
                                             =

Author: Christoph Hellwig <hch@lst.de>                                     =
                                             =

Date:   Wed Jul 7 18:53:25 2010 +0200                                      =
                                             =

                                                                           =
                                             =

    add f_flags to struct statfs(64)                                       =
                                             =

                                                                           =
                                             =

    Add a flags field to help glibc implementing statvfs(3) efficiently.   =
                                             =

                                                                           =
                                             =

    We copy the flag values from glibc, and add a new ST_VALID flag to     =
                                             =

    denote that f_flags is implemented.                                    =
                                             =

                                                                           =
                                             =

    Signed-off-by: Christoph Hellwig <hch@lst.de>                          =
                                             =

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>                       =
                                             =

                                                                           =
                                             =

:040000 040000 92f04bf96f0c6bb2df3ddea83a4a27c35985bdcc =

e702d8dd95a3897e085bf3fe4919e2dd30a57b47 M      arch            =

:040000 040000 5705bba0e9a2a61112281f7bb1a1030ef9eb337e =

34fc3ea912581ae7923a15246291387bfc354e47 M      fs              =

:040000 040000 578a5bb0743aa85adfec7a25f82d440b2ea4db27 =

7e96f95b6f1d6ccc9e004b560670638db66b8a93 M      include         =



BTW is UML dead ?
(I'm asking b/c there're so many different issues - compile errors or the U=
ML =

kernel crashes during start or during shutdown, independent of the result o=
f =

the wget issue I was investigating - there are 120 skip'ed commits within t=
he =

git bisect log beside 46 good and 15 bad commits and I didn't saw any chanc=
e =

to fully automate the bisect)

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

