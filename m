Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KXss7-0000qf-TA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 00:21:47 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KXss4-0004z2-Vl for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 00:21:47 -0700
Message-ID: <48B3AED8.5040904@meduna.org>
Date: Tue, 26 Aug 2008 09:20:56 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4898AC10.3010602@meduna.org>
	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
	<48995D1A.6030203@meduna.org> <489AC525.3060305@meduna.org>
	<489AE6DD.2000200@meduna.org> <489C3D9B.7070605@meduna.org>
	<20080825215124.GB12626@c2.user-mode-linux.org>
In-Reply-To: <20080825215124.GB12626@c2.user-mode-linux.org>
Subject: Re: [uml-devel] FP registers corruption
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:

>> Did this or equivalent patch get into the mainline kernel?
>> Browsing through the source I don't think so :( If not,
>> where is the best place to fetch the UML tree with the
>> patches that the developers seem to find necessary,
>> applied?
> 
> It's there.  I just eyeballed the source.  It's commit
> 2f56debd77a8f52f1ac1d3c3d89cc7ce5e083230 - the only way you wouldn't
> have it is by having a too-old version of UML.

Yes, you're right - sorry. I probably looked at the wrong
version (I used some diff-ing web interface) :( However,
the problem is still here.

I tried to isolate the exact version, but I was not able
to compile/run all the UML versions in my test environment
(current Ubuntu) - obviously the UML is quite sensitive
to the host kernel as well.

So the only thing I can say is that I cannot reproduce
it with neither 2.6.24.7 nor 2.6.26.2 guest in my environment.
The only instance I am seeing it is the 2.6.26 guest on
2.6.23.17 host at my provider :(

The owner of the host machine where the problem is easily
reproducible is back from the vacation, so I hope to have
some more information soon; however I am not sure I will
be able to convince him to update the host kernel too
(that means scheduled downtime etc., ...).

Any hint what should I grep and code-review for? The
symptoms of the bug look very similar to the page-fault
induced one, so the cause is maybe also similar/the same.
I played with the scheduler (sched_yield) etc and it does
not seem that it is the 'normal' context switch who is
corrupting the registers, more like it is some interrupt
handler or something like that.

Any other folks seeing ssh or spache/ssl crashing: could
you please post the UML and host versions and any other
relevant informatio such as number of the UML kernels
running, whether the machine is under memory pressure,
devices used (e.g. heavy networking usage), ...?

Thanks
-- 
                                      Stano

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
