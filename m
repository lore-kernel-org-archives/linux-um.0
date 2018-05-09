Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <richard@nod.at>) id 1fGIiD-0000Sh-8Z
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 09 May 2018 06:36:29 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fGIi8-00Arz1-Qk for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 09 May 2018 06:36:28 +0000
From: Richard Weinberger <richard@nod.at>
Date: Wed, 09 May 2018 08:36:09 +0200
Message-ID: <1621114.mSmC2JOP5I@blindfold>
In-Reply-To: <CAK7LNAQREY=32tX7m8dbJ6a_AhXLF_y-n5VLFBBcvXWaRvTmHg@mail.gmail.com>
References: <CAK7LNAQREY=32tX7m8dbJ6a_AhXLF_y-n5VLFBBcvXWaRvTmHg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [UML] Question about arch/x86/um/vdso/vdso-syms.lds
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jeff Dike <jdike@addtoit.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Masahiro,

Am Mittwoch, 9. Mai 2018, 05:36:18 CEST schrieb Masahiro Yamada:
> Hi Richard,
> 
> 
> Please let me ask a question about vdso-syms.lds
> under arch/x86/um/vdso/.
> 
> This file exists since:
> 
> commit f1c2bb8b9964ed31de988910f8b1cfb586d30091
> Author: Richard Weinberger <richard@nod.at>
> Date:   Mon Jul 25 17:12:54 2011 -0700
> 
>     um: implement a x86_64 vDSO
> 
> 
> So, I think you are the right person
> to reach out to.
> 
> 
> Originally, vdso-syms.lds was linked to vmlinux,
> but it is not since:
> 
> commit 827880ec260ba048f95fe646b96a205c394fa0f0
> Author: Nicholas Piggin <npiggin@gmail.com>
> Date:   Fri Jun 9 15:24:16 2017 +1000
> 
>     x86/um: thin archives build fix
> 
> 
> 
> Something may be missing from my thought,
> but I wonder what vdso-syms.lds is used for.

Hmm, I think we can kill it. In 2011 I used the x86 vdso
code as "template" this is how the file made it into UML.
AFAICT it was forgotten after all the vdso related refactoring
in um and x86.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

