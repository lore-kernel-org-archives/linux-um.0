Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnRKS-0005gi-Ce for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 19:30:00 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FnDoz-0001oc-R7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 05:04:37 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FmyA3-0003s8-LX
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 12:21:23 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 4 Jun 2006 20:19:59 +0200
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
	<a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com>
	<20060208164301.GC5240@ccure.user-mode-linux.org>
In-Reply-To: <20060208164301.GC5240@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606042020.00120.blaisorblade@yahoo.it>
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

On Wednesday 08 February 2006 17:43, Jeff Dike wrote:
> On Tue, Feb 07, 2006 at 11:23:42AM -0800, Ulrich Drepper wrote:
> > If you need this
> > functionality, implement it yourself.  setjmp is most likely overkill
> > anyway.
>
> OK, I'll roll my own version.

What about #ifdef'ing out the offending code #ifndef one of these constants 
(they'll be defined or not altogether). As expectable, this wasn't yet 
implemented - let's give the right priority to things.
(I've just met this on my SuSE, btw, which prompted me to write this email).
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
