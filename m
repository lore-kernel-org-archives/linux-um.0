Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] PATCH -- Was: link error MODE_SKAS and ! MODE_TT in
	2.4.26-2 + uml.sf.net patches 
Message-ID: <C28780ABC637504896EB86B4FB75FFBFA26E71@MAANDMBX1.ets.enterasys.com>
From: "Bahi, David" <dbahi@enterasys.com>
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
Date: Mon, 9 Aug 2004 18:13:01 -0400
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

right. clean tree builts w/o MODE_TT just fine.

had previously built with _BOTH_ modes; and then:

    make ARCH=um xconfig   # turn MODE_TT off
    make ARCH=um dep
#   make ARCH=um clean     # failed to do this. doh!
    make ARCH=um linux

given the chance, the macro does the job it should.

i don't suppose there is some depencency checking 
that could be improved to fix this - requiring a 
clean seems obsessive-compulsive <grin>.

pardon the noise.

> -----Original Message-----
> From: Jeff Dike [mailto:jdike@addtoit.com] 
> Sent: Monday, August 09, 2004 5:29 PM
> To: Bahi, David
> Cc: user-mode-linux-devel@lists.sourceforge.net; 
> user-mode-linux-user@lists.sourceforge.net
> Subject: Re: [uml-devel] PATCH -- Was: link error MODE_SKAS 
> and ! MODE_TT in 2.4.26-2 + uml.sf.net patches 
> 
> dbahi@enterasys.com said:
> > this patch fixes the unresolved link time error with a conditional
> > around the definition of CAN_KMALLOC 
> 
> I don't see that here.  If you look at the definition of 
> CHOOSE_MODE, you'll
> see that it's conditional on CONFIG_MODE_TT and 
> CONFIG_MODE_SKAS in such a
> way that if a mode is configured out, any code associated 
> with it disappears.
> 
> I think you didn't do that build from a clean pool.
> 
> 				Jeff
> 
> 


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
