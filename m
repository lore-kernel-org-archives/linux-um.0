Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KBJ6w-0004IW-8P for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 17:43:46 -0700
Received: from an-out-0708.google.com ([209.85.132.250])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KBJ6u-0000uZ-VP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 17:43:46 -0700
Received: by an-out-0708.google.com with SMTP id b21so766576ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 24 Jun 2008 17:43:44 -0700 (PDT)
Message-ID: <804dabb00806241743v72bbfa0fx8a555d8d2f500a08@mail.gmail.com>
Date: Wed, 25 Jun 2008 08:43:44 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <20080623033400.GA3822@teal.hq.k1024.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00806221905q676e9fa8k6e8c97eb0a547681@mail.gmail.com>
	<20080623033400.GA3822@teal.hq.k1024.org>
Subject: Re: [uml-devel] How to trace early booting in 64bit Linux Kernel?
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
To: Iustin Pop <iusty@k1024.org>, user-mode-linux-devel@lists.sourceforge.net

Sorry for my mistake - I just read the source code for kqemu and they
do compile for x86_64, so the 64bit host version is supported.

My mistake.


On Mon, Jun 23, 2008 at 11:34 AM, Iustin Pop <iusty@k1024.org> wrote:
> On Mon, Jun 23, 2008 at 10:05:37AM +0800, Peter Teoh wrote:
>> QEMU running on 64bit host is still not available yet, although it can
>> emulate 64bit kernel.
>
> Uh, why do you say so? Unless I'm mistaken, I've been running qemu in
> 64bit mode for a couple of years now (the binary is called
> qemu-system-x86_64).
>
> thanks,
> iustin
>



-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
