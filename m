Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsoXc-00007u-PQ
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:36:28 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AsoOM-00050N-Mp
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:26:54 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Re: Segfault of UML-TT on FC1
In-Reply-To: <Pine.LNX.4.58.0402160248320.3114@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0402161916440.8742@vega.dur.ac.uk>
References: <20040215232525.7c2f38a8.zaitcev@redhat.com>
 <Pine.LNX.4.58.0402160248320.3114@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Feb 2004 19:32:30 +0000 (GMT)
To: Ingo Molnar <mingo@redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com

On Mon, 16 Feb 2004, Ingo Molnar wrote:

> On Sun, 15 Feb 2004, Pete Zaitcev wrote:
>
> > The &__bss_start at this point is a01c6000, abd brk_start is a1f33000,
> > and so memcpy segfaults when it steps on the hole.
> >
> > Does anyone have a suggestion what to do about this?
>
> the workaround is to install the setarch rpm, and then do:
>
> 	i386 ./linux <args>
>
> (but it would be nice to find the brk assumption in UML and change it to
> work with the FC1 brk changes.)

See
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107564046216529&w=2
The first two segments of the patch there are in the latest 2.4 uml kernel
patch. The problem is that for exec-shield the program area and data
segment aren't adjacent. The remaining issue which the final part
addresses is that a later routine that reserves area to act as physical
memory still assumes the areas are adjacent, and you get a random amount
less memory reserved than you expect (something like 16M), and this might
not leave you with enough memory to use.

	Michael Young


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
