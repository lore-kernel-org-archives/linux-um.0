Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVKPr-0002uQ-Fq	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 19:24:11 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DVKPp-000115-Ur
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 19:24:11 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050509192324.14ab86ae.akpm@osdl.org>
In-Reply-To: <E1DVKHF-0004w9-Ua@be1.7eggert.dyndns.org>
References: <42q12-7bE-5@gated-at.bofh.it>
	<42rTb-fj-11@gated-at.bofh.it>
	<E1DVKHF-0004w9-Ua@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/6] uml: remove elf.h [ compile-fix, for
	2.6.12 ]
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
Date: Mon, 9 May 2005 19:23:24 -0700
To: 7eggert@gmx.de
Cc: blaisorblade@yahoo.it, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

"Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de> wrote:
>
>  Andrew Morton <akpm@osdl.org> wrote:
> 
>  > hmm, that's exciting.  How to tell diff and patch to remove a zero-length
>  > file?
> 
>  $ md a b c
>  $ touch a/a
>  $ echo .>c/a
>  $ diff -purN a c
>  diff -purN a/a c/a
>  --- a/a 2005-05-10 04:08:14.000000000 +0200
>  +++ c/a 2005-05-10 04:09:17.972505331 +0200
>  @@ -0,0 +1 @@
>  +.
>  $ diff -purN c b
>  diff -purN c/a b/a
>  --- c/a 2005-05-10 04:09:17.972505331 +0200
>  +++ b/a 1970-01-01 01:00:00.000000000 +0100
>  @@ -1 +0,0 @@
>  -.
>  $ cd a
>  $ patch -p1   # < both patches (c&p)
>  <snip>
>  $ ls -l
>  total 0

That's cheating!


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
