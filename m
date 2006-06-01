Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fm9zc-0005mW-JO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 06:47:13 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fm9za-00017m-TX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 06:47:10 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fm9za-00084O-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 06:47:11 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 1 Jun 2006 21:07:33 +0200
References: <20060526032424.GA8283@ccure.user-mode-linux.org>
	<200605261236.26814.ak@suse.de>
	<20060526141345.GA4152@ccure.user-mode-linux.org>
In-Reply-To: <20060526141345.GA4152@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606012107.34676.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [discuss] [RFC] [PATCH] Double syscall exit traces
	on x86_64
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
Cc: discuss@x86-64.org, Steven James <pyro@linuxlabs.com>, Jeff Dike <jdike@addtoit.com>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>

On Friday 26 May 2006 16:13, Jeff Dike wrote:
> On Fri, May 26, 2006 at 12:36:26PM +0200, Andi Kleen wrote:
> > I believe this patch is the correct fix. Can you confirm it works for
> > you?
>
> Looks good, thanks.
>
> 		Jeff
Sorry for the question, but has this been sent to -stable (since it's a 
-stable regression, it should be)? To 2.6.17 -git?

And have you tested it (somebody should have, but it's not sure)?
Sorry for not helping myself, I'll be back at work ASAP.
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
