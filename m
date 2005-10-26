Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUYeU-0001CM-U5	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 16:56:22 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EUYeS-00048q-KY
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 16:56:23 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 4/6] x86_64: fix L1_CACHE_SHIFT_MAX for
	Intel EM64T [for 2.6.14?]
References: <20051025221105.21106.95194.stgit@zion.home.lan>
	<200510260044.26138.blaisorblade@yahoo.it> <200510260133.03425.ak@suse.de>
In-Reply-To: <200510260133.03425.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260200.16501.blaisorblade@yahoo.it>
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
Date: Wed, 26 Oct 2005 02:00:15 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 01:33, Andi Kleen wrote:
> On Wednesday 26 October 2005 00:44, Blaisorblade wrote:
> > For what I see, that's based on the tradeoff between space and contention
> > - for instance there are few zones only, so there's no big waste.

> If space is precious it shouldn't be padded at all.
Ah, when the structure has many instances padding should be reduced, you mean. 
But well, I think slab itself adds some padding to separate instances, for 
this effect and for cache colouring (I guess that means to prevent too many 
different things from being allocated on addresses matching on the low-order 
bits, so that inserting one in the cache means evicting another of the two - 
it's something I guessed when I studied set-associative caches).

> > In  practice, interpreting !X86_GENERIC as "I will run this kernel on
> > _this_ processor" could also be done.
>
> That is what it always meant yes.
>
> > However, in case you didn't note, max_align is never enough on EM64T
> > currently, right?
>
> I will prepare patches for .15 to remove it completely, that should fix
> that problem.
Making L1_CACHE_SHIFT_MAX and L1_CACHE_SHIFT match, right? Or forcing all 
architectures to support something like X86_GENERIC?

Also, 

#define L1_CACHE_BYTES  (1 << L1_CACHE_SHIFT)

should probably be made general, while at it.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
