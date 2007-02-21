Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJpOz-0005Ez-AN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 03:12:49 -0800
Received: from rwcrmhc15.comcast.net ([216.148.227.155])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJpOw-0007B7-OB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 03:12:49 -0800
MIME-Version: 1.0
From: Roland McGrath <roland@redhat.com>
In-Reply-To: Jeff Dike's message of  Tuesday, 20 February 2007 16:21:19 -0500
	<20070220212119.GA8090@ccure.user-mode-linux.org>
Message-Id: <20070221111228.9CEA21800E4@magilla.sf.frob.com>
Date: Wed, 21 Feb 2007 03:12:28 -0800 (PST)
Subject: Re: [uml-devel] [PATCH] UML utrace support, step 1
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> Below is the first step in your Fix-Your-Broken-Arch-HOWTO for UML.

Great!  Thanks for tackling this.

> Do you want incremental patches as I go along, or replacement ones?

The way I've organized my patch series is with the arch support split up
along with the separate infrastructure patches in the series.  That is,
just asm/tracehook.h with no utrace_regset stuff in the first patch so that
the kernel builds with only utrace-tracehook.patch; then the regset stuff
but no arch_ptrace et al in another patch so that it builds with
utrace-regset.patch but without the later patches; then arch_ptrace et al
in the final arch patch.  Your patch is mostly just the first of these
(utrace-tracehook-um), but includes utrace_regset and arch_ptrace stubs
that won't compile without the later infrastructure patches applied.

If you want to divide things up this way, then I'd like just to see a
replacement utrace-tracehook-um.patch followed by utrace-regset-um.patch
and utrace-ptrace-compat-um.patch, replacing each one whole as needed until
it's merged into my trees, and then I can take incremental changes after
that.  If you don't want to bother with dividing things so it compiles in
between patches in the series, then just one big replacement patch is fine.

> +const struct utrace_regset_view utrace_um_native = {
> +	.name		= "um",

This name wants to be the subarch name--it's usually the $ARCH or
UTS_MACHINE, i.e. the canonical arch name (i386 not i686, but ppc64 or ppc,
not powerpc).  In fact, I'm sure you really want to define the
utrace_regset_view structs separately somewhere in arch/um/sys-$SUBARCH.
On biarch platforms you'll need more than one, as the native biarch
platforms have.  (But that is all part of the second step that isn't really
tackled in this patch.)

> +#define ARCH_HAS_SINGLE_STEP	(1)

Note you'll eventually want to define the block-step macro and functions
depending on subarch.  (ia64 supports it, and x86 one day will.)

> +extern const struct utrace_regset_view utrace_um_native;
> +static inline const struct utrace_regset_view *
> +utrace_native_view(struct task_struct *tsk)
> +{
> +	return &utrace_um_native;
> +}

You probably just want an extern decl for utrace_native_view here,
since what it really does with depend on the subarch.

> BTW, UML runs on the utrace in -mm (i.e. utrace on the host), which it
> didn't with several Fedora kernels.

Oh, really?  That's good, but are you sure?  Have you tried a
CONFIG_PREEMPT=y host?  I reproduced a failure with the current code
recently after Alexey Dobriyan reported the problem.  But I didn't get
anywhere debugging it and got busy with other work.  I could use some help
tracking down what ptrace does differently that broke UML, if it does
indeed still come up.  I have plenty of experience debugging ptrace and
users of it, but I don't know much of anything about UML's usage pattern
and got quickly lost in its code trying to tell what it expected to happen.


Thanks,
Roland

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
