Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4xKF-0002jI-1j for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 05:15:15 -0700
Received: from an-out-0708.google.com ([209.85.132.248])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4xKD-0002J3-Ix
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 05:15:14 -0700
Received: by an-out-0708.google.com with SMTP id b21so318224ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 07 Jun 2008 05:15:12 -0700 (PDT)
Message-ID: <fc593b510806070515i312bf405g9c93ab3f13f13bb0@mail.gmail.com>
Date: Sat, 7 Jun 2008 14:15:12 +0200
From: "Laurent Wandrebeck" <l.wandrebeck@gmail.com>
In-Reply-To: <fc593b510806061602y1683c6c1u21b97ccaeb01520@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <fc593b510806061602y1683c6c1u21b97ccaeb01520@mail.gmail.com>
Subject: Re: [uml-devel] updated SKAS4 patch for 2.6-git 58e852d..929d053
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
To: user-mode-linux-devel@lists.sourceforge.net

2008/6/7 Laurent Wandrebeck <l.wandrebeck@gmail.com>:
> Hi,
>
> This is my first attempt to update the latest SKAS4 patch Jeff posted.
> Completely untested, as the wonderful gcc included in Fedora 9 ICE in
> front of my face while compiling a kernel (and before UML, of course).
> One thing I'm stuck with is PTRACE_SWITCH_MM in
> arch/x86/kernel/ptrace.c. Can't see what to do there.
> Hope that'll help to lighten your burden, Jeff. (and that I did not
> make too much mistakes).
> Regards,
> Laurent
You can also clone the repo here:
git://gitorious.org/my-unofficial-linux-uml-tree/mainline.git
(almost latest linus linux-2.6 repo - just after a couple UML updates
went in - and SKAS4 update)
PTRACE_SWITCH_MM case is not solved yet.
Help and comments are welcome.
Laurent.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
