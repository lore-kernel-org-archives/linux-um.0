Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I18km-00046X-9H for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2007 15:34:20 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1I18kh-0001Hr-Hg
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2007 15:34:20 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Date: Wed, 20 Jun 2007 22:20:15 +0200
References: <20070619184245.GA10567@c2.user-mode-linux.org>
	<200706201606.58331.blaisorblade@yahoo.it>
	<20070620151753.GA6728@c2.user-mode-linux.org>
In-Reply-To: <20070620151753.GA6728@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706202220.15777.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH 2/2] UML - Add stack usage monitoring
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On mercoled=EC 20 giugno 2007, Jeff Dike wrote:
> On Wed, Jun 20, 2007 at 04:06:58PM +0200, Blaisorblade wrote:
> > Oh, it's exactly what CONFIG_DEBUG_STACK_USAGE does for i386... (not su=
re
> > if you were still wondering...).
>
> Where?  The only usage in i386 that I see is thread_info.h zeroing stacks
> as they are allocated.

I only looked at docs. But Andrew Morton said:

"Your new code should really be generic, utilising the
stack-page-zeroing which CONFIG_DEBUG_STACK_USAGE enables."

In fact, the other reference is in kernel/sched.c. You may (or may not) joi=
n =

the two stack walking (I would) and match a bit descriptions.

Personally, I'd put the Kconfig option in lib/Kconfig.debug and have a Kcon=
fig =

flag named DEBUG_STACK_USAGE_SUPPORT, much like LOCKDEP_SUPPORT (defined on=
ly =

by architectures supporting the option), but have no time right now.

Bye
-- =

Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
