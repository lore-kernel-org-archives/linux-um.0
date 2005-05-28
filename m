Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbzLK-0002XQ-0B	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:19:02 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbzLI-0004OR-GE	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:19:01 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050527003843.433BA1AEE88@zion.home.lan>
	<200505270306.09425.blaisorblade@yahoo.it>
	<20050527033126.GH1329@linux-sh.org>
In-Reply-To: <20050527033126.GH1329@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281321.03246.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 4/8] irq code: Add coherence test for
	PREEMPT_ACTIVE
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
Date: Sat, 28 May 2005 13:21:02 +0200
To: Paul Mundt <lethal@linux-sh.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org, dhowells@redhat.com

On Friday 27 May 2005 05:31, Paul Mundt wrote:
> On Fri, May 27, 2005 at 03:06:09AM +0200, Blaisorblade wrote:
> > On Friday 27 May 2005 02:38, blaisorblade@yahoo.it wrote:

> > Ok, a grep shows that possible culprits (i.e. giving success to
> > grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as
> > PREEMPT_ACTIVE, as given by grep PREEMPT_ACTIVE
> > include/asm-*/thread_info.h) are (at a first glance): frv, sh, sh64.

> Yeah, that's bogus for sh and sh64 anyways, this should do it.

> It would be nice to move PRREMPT_ACTIVE so it isn't per-arch anymore,
> there's not many users that use a different value (at least for the ones
> using generic hardirqs, ia64 seems to be the only one?).

Then in the generic headers
#ifndef PREEMPT_ACTIVE
#define PREEMPT_ACTIVE <the right value>
#else
<do the above coherence test>
#endif
Would be ok, right?
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
