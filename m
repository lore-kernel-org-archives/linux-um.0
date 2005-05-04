Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTPC5-0003LO-2z	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 12:06:01 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DTPC3-00065h-WA	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 12:06:00 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/1] Uml: kludgy compilation fixes for
	x86-64 subarch modules support [for -mm]
References: <20050501184515.F1AA48D835@zion>
	<20050502165103.6d76f394.akpm@osdl.org>
In-Reply-To: <20050502165103.6d76f394.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505042101.30458.blaisorblade@yahoo.it>
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
Date: Wed, 4 May 2005 21:01:30 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, linux-kernel@vger.kernel.org, ak@suse.de

On Tuesday 03 May 2005 01:51, Andrew Morton wrote:
> blaisorblade@yahoo.it wrote:
> > These are some trivial fixes for the x86-64 subarch module support. The
> > only potential problem is that I have to modify
> > arch/x86_64/kernel/module.c, to avoid copying the whole of it.
> >
> > I can't use it verbatim because it depends on a special vmalloc-like area
> > for modules, which for now (maybe that's to fix, I guess not) UML/x86-64
> > has not. I went the easy way and reused the i386 vmalloc()-based
> > allocator.
>
> Why is this "for -mm" and not for -linus?
That's a report on the current "review/testing" status, in this case because I 
wanted an ACK from Andi Kleen. Which acked it for himself but warned about 
the possible breakage for other archs.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
