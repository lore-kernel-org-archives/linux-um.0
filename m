Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fo1uy-0005Iq-08 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 10:34:08 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fo1uu-0005p4-1m
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 10:34:07 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 7 Jun 2006 19:33:28 +0200
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
	<200606042020.00120.blaisorblade@yahoo.it>
	<20060605154017.GA24405@ccure.user-mode-linux.org>
In-Reply-To: <20060605154017.GA24405@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606071933.28456.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 2/8] UML - Define jmpbuf access constants
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
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Monday 05 June 2006 17:40, Jeff Dike wrote:
> On Sun, Jun 04, 2006 at 08:19:59PM +0200, Blaisorblade wrote:
> > What about #ifdef'ing out the offending code #ifndef one of these
> > constants (they'll be defined or not altogether). As expectable, this
> > wasn't yet implemented - let's give the right priority to things.
> > (I've just met this on my SuSE, btw, which prompted me to write this
> > email).
>
> I think hpa just came to our rescue.  There's a setjmp/longjmp
> implementation in klibc.  If we pull that in and use it, we don't need
> our own copy.

Ok - but we can merge something before 2.6.17, and we should. Any of them. 
Guess which one...

Not merging hacks is sometimes ok, and guarantees better code. But we're 
exceeding in this :-)
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
