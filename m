Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H79lj-00005T-OG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 04:19:56 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H79lf-0003WE-Qy
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 04:19:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 17 Jan 2007 13:19:13 +0100
References: <20070110102857.9bzdrhzh8g0s04og@webmail.flonatel.org>
	<20070110214620.GB6062@ccure.user-mode-linux.org>
In-Reply-To: <20070110214620.GB6062@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701171319.13990.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Configuration problem with UML in kernel 2.6.19.1
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
To: user-mode-linux-devel@lists.sourceforge.net, Matt Willsher <matt@monki.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>

On Wednesday 10 January 2007 22:46, Jeff Dike wrote:
> On Wed, Jan 10, 2007 at 10:28:57AM +0100, uml@flonatel.org wrote:
> > Hello!
> >
> > I had some problems running linux 2.6.19.1 as client UML.  When
> > starting 'mapping mmap stub failed, errno = -12' is printed - with an
> > additional Kernel panic. In the file arch/um/Kconfig.i386 the
> > definition of STUB_CODE and STUB_DATA depend on the configuration
> > symbol HOST_2G_2G which has gone sometimes in between 2.6.18.6 and
> > 2.6.19.1.
> >
> > The applied patch solves the problem for me.
>
> Excellent, thanks for chasing that down.

This means that running UML under Xen should be retested! Setting HOST_VMSPLIT 
does not fully work without this patch!

Matt, you were reporting a problem about this, can you try this patch (should 
also apply on 2.6.18 kernels)?
After applying the patch, do not forget to give a "make silentoldconfig 
ARCH=um" before recompiling.
If you have lost interest just say that, so we'll know we can't test that for 
now.

Bye!
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
