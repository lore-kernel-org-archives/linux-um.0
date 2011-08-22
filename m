Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QvcCr-0007hy-7n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 21:38:53 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvcCp-0008Hf-Pq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 21:38:53 +0000
Message-ID: <4E52CC63.5070201@nod.at>
Date: Mon, 22 Aug 2011 23:38:43 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
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
Subject: [uml-devel] [RFC] UML/x86_64 module loader
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, vapier@gentoo.org, user-mode-linux-devel@lists.sourceforge.net, jbaron@redhat.com, x86@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org

Hi!

UserModeLinux is using the arch specific module functions from 
arch/x86/kernel/module.c.
On i386 this works perfectly fine but on x86_64 it causes problems.

apply_relocate_add() assumes modules compiled with -mcmodel=kernel 
because the kernel lives in the negative 2GiB of the address space.
This assumption is not true for UML.
On an UML instance with more than 512MiB of memory no modules can be 
loaded because vmalloc() locates the module near the 2GiB limit and the
ELF relocations causes an overflow. (Detected by "if ((s64)val != *(s32 
*)loc)" in apply_relocate_add()).

Now I'm not sure how to fix this.
Mostly because I'm not a module loader nor an ELF expert. 8-)

Is there an easy way to adjust the current x86_64 module loader to deal 
with UML "positive" relocations?

Thanks,
//richard

P.s: Just removing the overflow-check does not fix the problem. ;-)

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

