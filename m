Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPRc1-0002Hi-NY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 12:20:09 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CPRbz-0004L8-2s
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 12:20:09 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
Message-ID: <20041103201001.GA29289@bytesex>
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<41884ACC.2020309@vgertech.com> <878y9jib8z.fsf@bytesex.org>
	<200411031659.56887.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411031659.56887.blaisorblade_spam@yahoo.it>
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
Date: Wed, 3 Nov 2004 21:10:01 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Nuno Silva <nuno.silva@vgertech.com>

On Wed, Nov 03, 2004 at 04:59:56PM +0100, Blaisorblade wrote:
> On Wednesday 03 November 2004 09:32, Gerd Knorr wrote:
> > Nuno Silva <nuno.silva@vgertech.com> writes:
> > > Yes, maybe it was me and, FWIW, I never found a solution to make a
> > > dynamic skas uml run under 2.6+libcNTPL.
> >
> > The usual workaround for any nptl issues works here as well:
> > export LD_ASSUME_KERNEL=2.4.21
> You mean 2.4.1 IIRC, right?

The exact version doesn't really matter I think.

> However, that does not work on LinuxFromScratch and Gentoo systems,
> mostly, which miss a non-NPTL glibc version.

Yes, you need a non-nptl glibc version for that, otherwise the dynamic
linker can't use it obviously ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
