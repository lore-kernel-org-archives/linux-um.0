Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard@nod.at>) id 1P6oMz-0007gu-00
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2010 17:47:05 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P6oMw-0008U4-J6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2010 17:47:04 +0000
From: Richard Weinberger <richard@nod.at>
Date: Fri, 15 Oct 2010 19:46:53 +0200
References: <201010131328.06465.toralf.foerster@gmx.de>
	<201010151133.38170.toralf.foerster@gmx.de>
In-Reply-To: <201010151133.38170.toralf.foerster@gmx.de>
MIME-Version: 1.0
Message-Id: <201010151946.53402.richard@nod.at>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Christoph Hellwig <hch@lst.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi!

Can you please post more details.
What exactly causes the crash?
phpsysinfo does a lot of stuff.
On my test bed it works fine.

Am Freitag 15 Oktober 2010, 11:33:37 schrieben Sie:
> Hello,
> 
> git bisect gave :
> 
> tfoerste@n22 ~/devel/linux-2.6 $ git bisect bad
> 365b18189789bfa1acd9939e6312b8a4b4577b28 is the first bad commit
> commit 365b18189789bfa1acd9939e6312b8a4b4577b28
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Jul 7 18:53:25 2010 +0200
> 
>     add f_flags to struct statfs(64)
> 
>     Add a flags field to help glibc implementing statvfs(3) efficiently.
> 
>     We copy the flag values from glibc, and add a new ST_VALID flag to
>     denote that f_flags is implemented.
> 
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> :040000 040000 92f04bf96f0c6bb2df3ddea83a4a27c35985bdcc
> 
> e702d8dd95a3897e085bf3fe4919e2dd30a57b47 M      arch
> 
> :040000 040000 5705bba0e9a2a61112281f7bb1a1030ef9eb337e
> 
> 34fc3ea912581ae7923a15246291387bfc354e47 M      fs
> 
> :040000 040000 578a5bb0743aa85adfec7a25f82d440b2ea4db27
> 
> 7e96f95b6f1d6ccc9e004b560670638db66b8a93 M      include
> 
> 
> BTW is UML dead ?
> (I'm asking b/c there're so many different issues - compile errors or the
> UML kernel crashes during start or during shutdown, independent of the
> result of the wget issue I was investigating - there are 120 skip'ed
> commits within the git bisect log beside 46 good and 15 bad commits and I
> didn't saw any chance to fully automate the bisect)

Hmm, I did a lot git bisects on UML 2.6.35 to 2.6.36.
2.6.36-rc1 does not always compile. You need no apply f3c072a first.
I've not seen any crashes during bootup nor shutdown. Can you provide some 
more details?

Thanks,
//richard

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

