Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard@nod.at>) id 1PASsS-0003V0-EC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2010 19:38:40 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PASsQ-000787-Ol
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2010 19:38:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 25 Oct 2010 21:38:26 +0200
References: <1288020273-31161-1-git-send-email-richard@nod.at>
	<20101025122936.56d0370f.akpm@linux-foundation.org>
In-Reply-To: <20101025122936.56d0370f.akpm@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <201010252138.27096.richard@nod.at>
Subject: Re: [uml-devel] [PATCH] um: Fix IRQ flag handling naming
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
To: Andrew Morton <akpm@linux-foundation.org>, xiyou.wangcong@gmail.com
Cc: dhowells@redhat.com, jkosina@suse.cz, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Am Montag 25 Oktober 2010, 21:29:36 schrieb Andrew Morton:
> On Mon, 25 Oct 2010 17:24:33 +0200
> 
> Richard Weinberger <richard@nod.at> wrote:
> > Commit df9ee292 changed the IRQ flag handling naming scheme
> > and broke UML.
> > This patch brings the new scheme to UML and makes it work again.
> 
> Please always fully describe a bug when fixing it.  Something more than
> "broke".  In the case of compilation errors or warnings, that means
> quoting the compiler error output and, if necessary, the means of
> reproducing it (config, compiler version, etc).

Sorry!
I forgot to add the LKML-Reference to my initial report.

LKML-Reference: <201010190141.10365.richard () nod ! at>
 
> I did an allnoconfig uml build and saw this:
> 
> In file included from /usr/src/25/arch/um/include/asm/fixmap.h:5,
>                  from /usr/src/25/arch/um/include/shared/um_uaccess.h:10,
>                  from /usr/src/25/arch/um/include/asm/uaccess.h:41,
>                  from /usr/src/25/arch/um/include/asm/thread_info.h:13,
>                  from include/linux/thread_info.h:56,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:50,
>                  from include/linux/seqlock.h:29,
>                  from include/linux/time.h:8,
>                  from include/linux/stat.h:60,
>                  from include/linux/module.h:10,
>                  from init/main.c:13:
> /usr/src/25/arch/um/include/asm/system.h:11:1: warning: "local_save_flags"
> redefined
> 
> which I shall assume is the error which this patch addresses.

Yes, this is the error.

Thanks,
//richard

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

