Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zjDp-0005cC-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 13:48:21 -0700
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zjDo-00006H-DG
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 13:48:20 -0700
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <200309172018.h8HKIjNu020871@ccure.karaya.com>
Message-ID: <Pine.GSO.4.53.0309172138570.6877@altair.dur.ac.uk>
References: <Pine.GSO.4.53.0309102139120.9641@altair.dur.ac.uk>
 <Pine.GSO.4.53.0309122031300.4368@altair.dur.ac.uk> 
 <Pine.GSO.4.53.0309161720480.4325@algedi.dur.ac.uk> 
 <200309172018.h8HKIjNu020871@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: uml segfaults on redhat beta "severn"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 17 Sep 2003 21:47:59 +0100 (BST)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Wed, 17 Sep 2003, Jeff Dike wrote:

> m.a.young@durham.ac.uk said:
> > The exec-shield code appears to have been modified in the latest
> > redhat beta kernel with the result that uml kernels no longer crash -
> > presumably the memory allocations aren't stirred up quite so much.
> > Hence patching this problem may now be unnecessary.
>
> Excellent.  I looked at mingo's original description briefly, and didn't see
> anything which would obviously break UML.

Actually what upsets uml is the memory randomization, it still breaks with
the right exec-shield configuration (exec-shield=2,
exec-shield-randomization=1), but it isn't the default configuration, so
there is no urgency, assuming we need to fix it at all.

The patch I posted preiviously fixes the immediate crash, though there is
a second crash that happens sometimes but not always - (something like
insufficent physical memory - I have more details elsewhere).

	Michael Young


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
