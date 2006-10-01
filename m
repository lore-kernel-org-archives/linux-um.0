Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GU3Eb-0002Av-90 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:28:05 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GU3EZ-000437-BQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:28:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 1 Oct 2006 17:25:15 +0200
References: <451E9BAB.5030009@linuxbox.cz> <451EEB99.6030406@linuxbox.cz>
	<20060930235752.GA16968@ccure.user-mode-linux.org>
In-Reply-To: <20060930235752.GA16968@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610011725.16069.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest, 
	problems with noprocmm
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nikola Ciprich <nikola.ciprich@linuxbox.cz>, Jeff Dike <jdike@addtoit.com>

On Sunday 01 October 2006 01:57, Jeff Dike wrote:
> On Sun, Oct 01, 2006 at 01:11:37AM +0300, Nikola Ciprich wrote:
> > You have an idea where
> > could be problem with shutting down? (this Virtual timer expired
> > cycling?)
>
> Oops, missed that in your previous message.
>
> Where in the shutdown process is this?  There have been some previous
> reports of hangs during swapoff which I have been unable to reproduce.
> I spent part of a day last week pushing UMLs deeply into swap and
> shutting them down, always successfully.
>
> The SIGVTALRM is normal - that's just the timer.  That strace you sent
> looks like the idle loop, so as far as the kernel is concerned,
> everything is fine.
>
> > and regarding /proc/mm, shouldn't this mm64 file be used? or what's it
> > used for?
>
> /proc/mm64?  What would it do that /proc/mm doesn't?

Well, I'll explain everything (even to Jeff, since I never documented anything 
of this).

The SKAS patch V8 supports well i386 host and i386 guest. That's all.
SKAS patch V9-preX tries to support x86_64 host, with both 32 and 64 bit 
guests:

* 32 bit guests: a bug prevents using full SKAS3, you must pass noprocmm and 
you'll get most performance advantages (because faultinfo works). When I 
worked on the SKAS port to x86_64 I did not discover that something worked, 
and I never tested support for 64bit guests.
I latter discovered the bug is in a different portion of code - Bodo Stroesser 
unveiled it, and I think this is the same bug that hit even Jeff's 1st 
attempt to write SKAS4 (all I know can be found in 
http://user-mode-linux.sourceforge.net/diary.html -> grep skas4 and you'll 
find what I'm talking about on 23 Sep 2004).

* 64bit guests: they do not support SKAS3, but the host patch gives the needed 
support - to do that, the 1st thing to do would be to use /proc/mm64 as you 
point out (and it could even suffice, even if I doubt that), but guest 
kernels still try to use /proc/mm and it does not work. So you must pass 
skas0 on the cmdline (I do not remember whether noprocmm works for this 
case).

-EINVAL is given on purpose: the request struct UML writes on /proc/mm has a 
different layout for 32 and 64bit requests, or better a different size since 
pointers are larger (and there's an explicit check for that - IIRC it has 
always been there). I chose to have a separate /proc/mm64, I did not think to 
try autodetection. And frankly my first impression is that I'd still do it 
this way.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
