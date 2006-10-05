Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVb0v-0006lk-01 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:44:21 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVb0r-0002gJ-FJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:44:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 5 Oct 2006 23:41:13 +0200
References: <11600785071661-git-send-email-blaisorblade@yahoo.it>
	<20061005213754.GC6790@ccure.user-mode-linux.org>
In-Reply-To: <20061005213754.GC6790@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610052341.13341.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] uml: use DEFCONFIG_LIST to avoid reading host's config
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
To: Jeff Dike <jdike@addtoit.com>
Cc: stable@kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thursday 05 October 2006 23:37, Jeff Dike wrote:
> On Thu, Oct 05, 2006 at 10:01:47PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > This should make sure that, for UML, host's configuration files are not
> > considered, which avoids various pains to the user. Our dependency are
> > such that the obtained Kconfig will be valid and will lead to successful
> > compilation - however they cannot prevent an user from disabling any boot
> > device, and if an option is not set in the read .config (say
> > /boot/config-XXX), with make menuconfig ARCH=um, it is not set. This
> > always disables UBD and all console I/O channels, which leads to
> > non-working UML kernels, so this bothers users - especially now, since it
> > will happen on almost every machine
> > (/boot/config-`uname -r` exists almost on every machine). It can be
> > workarounded with make defconfig ARCH=um, but it is non-obvious and can
> > be avoided, so please _do_ merge this patch.
> >
> > Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>
> Acked-by: Jeff Dike <jdike@addtoit.com>
>
> Paolo - send this to Andrew as well so it doesn't get lost.
Yep, doing that separately in next batch - I'm sending to Andrew 14 patches, 
this one is still in the queue with other 10 patches, then there are the UBD 
ones (about 10 right now, will shrink the number maybe).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
