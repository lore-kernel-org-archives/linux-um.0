Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDMTd-0003FF-P5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 09:43:41 -0700
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDMTc-0003Es-Ba
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 09:43:41 -0700
Date: Mon, 30 Jun 2008 19:43:24 +0300
From: Adrian Bunk <bunk@kernel.org>
Message-ID: <20080630164324.GA1536@cs181140183.pp.htv.fi>
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
	<20080627162645.GC8381@c2.user-mode-linux.org>
	<7225594ED4A1304C9E43D030A886D221050BE1@daytona.int.panasas.com>
	<48673A9B.8050907@panasas.com>
	<20080630162201.GC6643@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080630162201.GC6643@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] fix extern inline errors with gcc 4.3.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Benny Halevy <bhalevy@panasas.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Jun 30, 2008 at 12:22:01PM -0400, Jeff Dike wrote:
> On Sun, Jun 29, 2008 at 10:32:43AM +0300, Benny Halevy wrote:
> > Note that the crash happened with gcc 4.1.2 and it will get the
> > -fno-unit-at-a-time flag with the proposed patch.
> > 
> > That said, this option or the lack of it ought not to cause any
> > runtime crashes.  If it does, I'd feel much more comfortable to know
> > exactly what the root cause is before deciding to use the flag to
> > workaround^hide it.
> 
> I agree.
> 
> The constraints on [no-]unit-at-a-time that I see are:
>...
> 	x86_64 uses unit-at-a-time always
>...

The only gcc versions that ever supported unit-at-a-time without 
enabling it by default was some patched gcc 3.3 that included a
backport of unit-at-a-time to gcc 3.3.

Just as a note that I doubt this matters in practice today.

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
