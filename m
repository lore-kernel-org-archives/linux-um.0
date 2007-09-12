Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVVph-0002iT-OM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 10:16:58 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVVpg-0000pS-Bu
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 10:16:57 -0700
Date: Wed, 12 Sep 2007 10:15:22 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <46E81AC6.3000306@googlemail.com>
Message-ID: <alpine.LFD.0.999.0709121010300.16478@woody.linux-foundation.org>
References: <46E81AC6.3000306@googlemail.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [1/4] 2.6.23-rc6: known regressions
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Len Brown <len.brown@intel.com>, "Adrian Bunk \"\"" <bunk@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>, Stefan Becker <Stefan.Becker@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Markus <lists4me@web.de>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, linux-alpha@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@linux.intel.com>, Ingo Molnar <mingo@elte.hu>



On Wed, 12 Sep 2007, Michal Piotrowski wrote:
> 
> Subject         : x86_64 vdso patch is broken somehow?
> References      : http://lkml.org/lkml/2007/8/29/136
> Last known good : ?
> Submitter       : Chuck Ebbert <cebbert@redhat.com>
> Caused-By       : Andi Kleen <ak@suse.de>
>                   commit 2aae950b21e4bc789d1fc6668faf67e8748300b7
> Handled-By      : ?
> Status          : unknown

This should be fixed now. Just pushed out with commit 
95b08679963c78ce0d675224a6efdb5169f2bf75 ("x86_64: Add missing mask 
operation to vdso").

> Subject         : 2.6.23-rc3-git1 crash/stuck on VIA CN700 system
> References      : http://lkml.org/lkml/2007/8/20/174
> Last known good : ?
> Submitter       : Stefan Becker <Stefan.Becker@nokia.com>
> Caused-By       : Andi Kleen <ak@suse.de>
>                   commit 19d36ccdc34f5ed444f8a6af0cbfdb6790eb1177
> Handled-By      : Andi Kleen <ak@suse.de>
>                   Dave Jones <davej@redhat.com>
> Workaround      : http://lkml.org/lkml/2007/9/5/221
> Status          : problem is being debugged

This *seems* to be a VIA bug. Regardless, it should be fixed by commit 
a534b679180025aa324ebd63c05516e478551cfd ("x86_64: Remove CLFLUSH in 
text_poke()").

> Subject         : console is messed up after resume from s2ram or switching to console from X
> References      : http://lkml.org/lkml/2007/8/4/6
> Last known good : ?
> Submitter       : Jeff Chua <jeff.chua.linux@gmail.com>
> Caused-By       : ?
> Handled-By      : H. Peter Anvin <hpa@zytor.com>
>                   Antonino A. Daplas <adaplas@gmail.com>
> Workaround      : "s2ram --force --acpi_sleep 1 --vbe_mode"
> Status          : problem is being debugged

This needs to be re-tested (was it the BIOS register overwriting, 
perhaps?).

> Subject         : konqueror suddenly vanishing, "konqueror: Fatal IO error: client killed"
> References      : http://lkml.org/lkml/2007/7/22/86
> Last known good : ?
> Submitter       : Markus <lists4me@web.de>
> Caused-By       : ?
> Handled-By      : Ingo Molnar <mingo@elte.hu>
> Status          : problem is being debugged

This should probably be dropped. I don't think we have any new reports on 
it, and nobody else ever saw it.

> Subject         : uml on x86_64 compile error
> References      : http://lkml.org/lkml/2007/9/3/86
> Last known good : ?
> Submitter       : Adrian Bunk <bunk@kernel.org>
> Caused-By       : Jeff Dike <jdike@linux.intel.com>
>                   commit d1254b12c93e1e586137a2ffef71fd33cf273f35
> Handled-By      : ?
> Status          : unknown

This should be fixed by commit 980abe215b861891c39aba0936817c46f372143b 
("UML: Fix ELF_CORE_COPY_REGS build botch").

			Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
