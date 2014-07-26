Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1XB8A2-0003aB-Tp
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Jul 2014 20:01:43 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XB8A0-0001cn-Ub
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Jul 2014 20:01:42 +0000
Message-ID: <53D40919.8040803@gmx.de>
Date: Sat, 26 Jul 2014 22:01:29 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <53613E96.2030006@gmx.de>
	<CAFLxGvyyMMSajwOtS1O6R-_XnJv7dc_61k3Hx9JJB7nmVLNWng@mail.gmail.com>
	<536221F4.6000405@gmx.de> <53623EFE.3040603@nod.at>
In-Reply-To: <53623EFE.3040603@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] trinity commit 23dc478aba breaks syscall "mremap"
 at a 32 bit user mode linux
To: Richard Weinberger <richard@nod.at>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On 05/01/2014 02:33 PM, Richard Weinberger wrote:
> BTW: If you hit "BUG: failure at mm/filemap.c:202/__delete_from_page_cache()!",
> this is a known issue https://lkml.org/lkml/2014/4/15/577

Since I do exclude the "madvise" syscall from fuzz testing I do no longer run into this issue
(at least with recent git tree).

But there's still this unsolved issue in the kernel, or ?
--
Toralf


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

