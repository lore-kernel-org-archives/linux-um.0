Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GlC7x-0005aq-VN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 14:24:06 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GlC7u-00028q-9s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 14:24:02 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 17 Nov 2006 23:23:53 +0100
References: <45486636.3020808@panasas.com>
In-Reply-To: <45486636.3020808@panasas.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611172323.54171.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML and SCSI
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

On Wednesday 01 November 2006 10:17, Boaz Harrosh wrote:
> I have searched the archives and seen some old posts about SCSI not
> compiling with UML. Since than I have seen some post on the net of the
> like http://lkml.org/lkml/2006/9/12/200. (which does not apply but the
> Idea is clear and can be done by hand).
> Now when carefully configured I can compile the SCSI and iSCSI layers.
>
> [Q] I have worked on below patch but now SCSI is on by default. (As in
> the regular kernel). Is there a way to include the original Kconfig from
> drivers/scsi but override it's defaultness?

Not directly - but you can patch it to read:
	default y if !UML
such patches get accepted without problems, at least when approved by Jeff or 
me.

> [Q2] Are there more deeper implication than meet the eye, why SCSI-iSCSI
> cannot run in a UML? It might have good performance 2.

I cannot see any conceptual ones, since iSCSI works over the network, unless 
there is any dependency on a hardware device which I cannot see.

> <um_2.6.19-rc1_Kconfig.patch>
>
> diff -Nup /tmp/tmp.19763.0
> /home/bharrosh/p4.local/pub/linux-2.6.19-rc1/arch/um/Kconfig -L
> a/arch/um/Kconfig -L b/arch/um/Kconfig
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -285,21 +285,7 @@ source "crypto/Kconfig"
>
>  source "lib/Kconfig"
>
> -menu "SCSI support"
> -depends on BROKEN
> -
> -config SCSI
> -       tristate "SCSI support"
> -
> -# This gives us free_dma, which scsi.c wants.
> -config GENERIC_ISA_DMA
> -       bool
> -       depends on SCSI
> -       default y
> -
> -source "arch/um/Kconfig.scsi"
> -
> -endmenu
> +source "drivers/scsi/Kconfig"
>
>  source "drivers/md/Kconfig"
>
> </um_2.6.19-rc1_Kconfig.patch>

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
