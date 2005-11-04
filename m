Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYAnb-0004pE-RO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 15:16:43 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EYAnX-0000sY-3G
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 15:16:43 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20051101170633.GB6448@ccure.user-mode-linux.org>
	<20051101203721.26156.11021.stgit@zion.home.lan>
	<20051104144632.55b92ea4.akpm@osdl.org>
In-Reply-To: <20051104144632.55b92ea4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511050021.48331.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PATCH] uml: fix hardcoded ZONE_* constants in zone
	setup
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
Date: Sat, 5 Nov 2005 00:21:47 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Friday 04 November 2005 23:46, Andrew Morton wrote:
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Remove usage of hardcoded constants in paging_init().

> An earlier patch from Jeff (below) already changed this code.

Andrew, yes indeed: quoting from my changelog (yep, I should have made it 
clearer):
> > By chance I spotted a bug in zones_setup involving a change to ZONE_*
> > constants, due to the ZONE_DMA32 patch from Andi Kleen (which is in -mm).
> > So, possibly, instead of zones_size[2] you will find zones_size[3] in the
> > code, but that change is wrong and this patch is still correct.
I'm talking exactly of this Jeff's change, and I did exactly what you did...

Thanks anyway for spending some time caring about this, it's nice to see 
attention on UML (sorry, no kidding and no complaining).

> Jeff's change looks rather wrong:
The original reason was done for -mm and ZONE_DMA32.

> #define MAX_NR_ZONES            3       /* Sync this with ZONES_SHIFT */
> 	zones_size[3] = highmem >> PAGE_SHIFT;
>
> which overindexes the local array.

> The above change is unmentioned in Jeff's changelog and I'll just drop that
> part.  Please confirm.
Yep, ACK.
> There are other parts of this patch whci are unchangelogged.  Please
> double-check the whole thing.

I will re-check again later, but the unchangelogged changes seem to be just 
long -> long long conversions.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
