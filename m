Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GGvqY-0001bA-AK for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 03:57:02 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GGvqS-0005Av-IX
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 03:57:02 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 26 Aug 2006 12:56:36 +0200
References: <20060821215641.GQ11651@stusta.de>
In-Reply-To: <20060821215641.GQ11651@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608261256.36654.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@karaya.com, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>

On Monday 21 August 2006 23:56, Adrian Bunk wrote:
> arch/um/sys-i386/setjmp.S contains two #ifdef _REGPARM's.
>
> Even if regparm was used in i386 uml (which isn't currently done (why?)),
> I don't see _REGPARM being defined anywhere.
>
> Is this a bug waiting for happening when regparm will be used on uml or
> do I miss anything?
Can anybody explain me how can we use REGPARM if we have to link with host 
glibc?
If we are going to use klibc instead of glibc that's ok (and this is not the 
case I'm talking about), but I do not know that plan (and nobody discussed 
the implications).
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
