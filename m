Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeDz9-0000Hq-Nb for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 08:58:12 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeDz4-0004h7-N2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 08:58:11 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 18:57:58 +0100
References: <45433D3E.3070109@0Bits.COM>
In-Reply-To: <45433D3E.3070109@0Bits.COM>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610291857.58707.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] More uml build failures on 2.16.19-rc3 and 2.6.18.1
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Mitch <Mitch@0bits.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org

On Saturday 28 October 2006 13:21, Mitch wrote:
> Hi Jeff, all,
>
> Sorry for the dealy but i've been out of the country.
>
> Anyhow i did some investigation and i've figured out the bug.
>
> Essentially if you try to compile a UML kernel on a 2.6.18.1 or above
> *host* kernel

> it will fail with the error messages shown (essentially 
> offsetof macro undefined) because between 2.6.18 and 2.6.18.1 that macro
> in /usr/include/linux/stddef.h is now wrapped in a #ifdef __KERNEL__ .
> However since UML doesn't build it's sources with that defined we get an
> undefined macro and a build failure.

Ok, we have one bug and one mistake on your part:
1) we should include <stddef.h> instead of <linux/stddef.h> in files using 
host headers (I don't have the error message at hand, so please handle this 
yourself, Jeff)
2) /usr/include/{linux,asm} being symlinks inside /usr/src/linux/include is an 
unsupported configuration since ages. #1 is still a valid bug because when a 
distribution will distribute glibc and kernheaders based on 2.6.18.1+/2.6.19 
ones we'll break anyway.

> So i'm partly right and partly wrong in my statement below. Yes i did
> compile a guest UML kernel 2.6.18 fine on host kernel of 2.6.18, and i
> believe i will be able to compile 2.6.18.1 and above also on a host
> kernel of 2.6.18 but if i change my host kernel to 2.6.18.1 or above all
> UML guest builds will fail.
>
> Can someone confirm they can build guest UML kernels on a host kernel >=
> 2.6.18.1 ??
>
> Thanks
> M

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
