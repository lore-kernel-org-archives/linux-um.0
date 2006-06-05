Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnRkG-0007tG-4W for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 19:56:40 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FnCvy-0000Le-BF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 04:07:46 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FnCvj-0006aB-Cp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 04:07:33 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 5 Jun 2006 13:06:52 +0200
References: <20060604185212.28436.74951.stgit@memento.home.lan>
	<200606042106.08121.ak@suse.de>
In-Reply-To: <200606042106.08121.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606051306.53234.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] uml: fix signal code x86-64 [for 2.6.15]
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
To: Andi Kleen <ak@suse.de>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On Sunday 04 June 2006 21:06, Andi Kleen wrote:
> > It isn't yet perfect, because we don't yet save floating point context.
> > But that will come later. Additionally, there's a potential problem since
> > RED zones will alternate stacks are used, unlike x86_64, so more stack
> > space (128 bytes more) is used. But this shouldn't be a problem.
> > Instead, having no red zone (like x86_64)
>
> x86-64 has a red zone.

On the alternate stack too? The comment in the below code confused me... even 
if when nesting signal frames sas_ss_flags(rsp) should be 0 and so the 
redzone will be used.
The below "RED-PEN" comment is probably wrong then... or not?

arch/x86_64/kernel/signal.c:
        /* RED-PEN: redzone on that stack? */
        if (ka->sa.sa_flags & SA_ONSTACK) {
                if (sas_ss_flags(rsp) == 0)
                        rsp = current->sas_ss_sp + current->sas_ss_size;
        }
> Is your description confused or your code? 
Sorry for the ambiguity and typos in the desc.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
