Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKcoc-0002IP-JL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 07:58:34 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HKcoY-0005EG-4G
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 07:58:31 -0800
Date: Fri, 23 Feb 2007 10:50:31 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070223155031.GD5198@ccure.user-mode-linux.org>
References: <20070221181811.GA5845@ccure.user-mode-linux.org>
	<20070223031903.A55241800E4@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070223031903.A55241800E4@magilla.sf.frob.com>
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
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 22, 2007 at 07:19:03PM -0800, Roland McGrath wrote:
> Your replacement patch still has utrace_regset stuff in it, so it doesn't
> compile without the later patches in the series.  Try applying only
> utrace-tracehook.patch from the series, then get it to build and make your
> utrace-tracehook-um.patch.  Then apply only utrace-regset.patch on top of
> that, and get that building to make utrace-regset-um.patch.  Then apply
> utrace-core.patch and utrace-ptrace-compat.patch to get ptrace finally
> working again and make utrace-ptrace-compat-um.patch.

Ah, I was building with all of utrace, and observing that it didn't compile
without all the bits in that patch.  I'll back out the bits of utrace
I don't need yet and send another patch.

> You'll still find this insufficient when you get to biarch support (x86_64).
> At least you'll have to add another one elsewhere too, and make
> utrace_native_view refer to both.

OK, I'll deal with that when I get to it.

> Ok.  We do seem to have a problem when the host has CONFIG_PREEMPT=y, which
> makes me suspect it might be a race problem that could also hit with enough
> hardware parallelism.  If you get a chance to try that and can characterize
> the way it misbehaves at the level of specific ptrace/wait calls, that
> would be a great help.  Otherwise I'll try to look into it when I get some
> time, but it's falling down the queue a bit since people don't seem too put
> out about it right now.

I'll turn on preempt and see what happens.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
