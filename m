Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByClo-0007q7-2n for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 10:01:40 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1ByClm-0001Fj-Fp
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 10:01:40 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [ann] kraxel's 2.6.8 uml patch kit
Message-ID: <20040820165231.GE22734@bytesex>
References: <20040820122445.GA21790@bytesex>
	<Pine.GSO.4.58.0408201512300.6741@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408201512300.6741@waterleaf.sonytel.be>
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
Date: Fri, 20 Aug 2004 18:52:31 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Aug 20, 2004 at 03:14:55PM +0200, Geert Uytterhoeven wrote:
> On Fri, 20 Aug 2004, Gerd Knorr wrote:
> > What is the status if the umlfb/x11/pthread issue, i.e. uml
> > kernel crashing as soon as one tries to link against libpthread
> > (which is needed for libX11)?  Any progress here?
> 
> Use SKAS mode, not TT, so UML is dynamically linked and libpthread is not
> needed.

Ah, ok, thats the trick.  Now I have a X11 window.  I've build kernels
with both skas+tt until now ...

> But no further progress since my last mail on August 2 (which you may
> have missed due to being abroad, check the archives).

Yep, was offline at that time due to holidays.

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
