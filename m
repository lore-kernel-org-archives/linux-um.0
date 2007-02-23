Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKQy7-0002KV-HC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 19:19:35 -0800
Received: from [206.18.177.51] (helo=alnrmhc11.comcast.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKQy5-0000of-DP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 19:19:35 -0800
MIME-Version: 1.0
From: Roland McGrath <roland@redhat.com>
In-Reply-To: Jeff Dike's message of  Wednesday, 21 February 2007 13:18:11 -0500
	<20070221181811.GA5845@ccure.user-mode-linux.org>
Message-Id: <20070223031903.A55241800E4@magilla.sf.frob.com>
Date: Thu, 22 Feb 2007 19:19:03 -0800 (PST)
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

> OK, I'll do it this way.

Your replacement patch still has utrace_regset stuff in it, so it doesn't
compile without the later patches in the series.  Try applying only
utrace-tracehook.patch from the series, then get it to build and make your
utrace-tracehook-um.patch.  Then apply only utrace-regset.patch on top of
that, and get that building to make utrace-regset-um.patch.  Then apply
utrace-core.patch and utrace-ptrace-compat.patch to get ptrace finally
working again and make utrace-ptrace-compat-um.patch.

> Yup, I'll leave this here, with .name initialized as SUBARCH, with the
> regsets defined in sys-$(ARCH) somewhere.

You'll still find this insufficient when you get to biarch support (x86_64).
At least you'll have to add another one elsewhere too, and make
utrace_native_view refer to both.

> Fixed.  block-step is hardware-trap-on-branch or something similar?

Correct.

> No, this is with preempt off.

Ok.  We do seem to have a problem when the host has CONFIG_PREEMPT=y, which
makes me suspect it might be a race problem that could also hit with enough
hardware parallelism.  If you get a chance to try that and can characterize
the way it misbehaves at the level of specific ptrace/wait calls, that
would be a great help.  Otherwise I'll try to look into it when I get some
time, but it's falling down the queue a bit since people don't seem too put
out about it right now.


Thanks very much,
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
