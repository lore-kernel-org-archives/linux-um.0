Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUXSw-0006Bk-Ce	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:40:22 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EUXSt-0003FV-Vd
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:40:22 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
	<20051025221351.21106.57194.stgit@zion.home.lan>
	<200510260022.28095.ak@suse.de>
In-Reply-To: <200510260022.28095.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260044.17184.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PATCH 6/6] x86_64: enable xchg optimization for
	x86_64
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 26 Oct 2005 00:44:15 +0200
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 26 October 2005 00:22, Andi Kleen wrote:
> On Wednesday 26 October 2005 00:13, Paolo 'Blaisorblade' Giarrusso wrote:
> > I.e. the implementation was written, is present in the tree, but due to
> > this:
> >
> > #ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
> > #include <linux/rwsem-spinlock.h> /* use a generic implementation */
> > #else
> > #include <asm/rwsem.h> /* use an arch-specific implementation */
> > #endif
> >
> > it was probably _NEVER_ compiled!!!

> Actually it was, but we switched it back because there were some doubts
> on the correctness of the xchg based implementation and the generic
> one looked much cleaner. So far nobody showed a significant performance
> different too.

> I should probably remove asm/rwsem.h.
That's fine too, the current situation is clearly bogus.
Thanks for the quick answer.

> Don't apply please.
Agreed.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
