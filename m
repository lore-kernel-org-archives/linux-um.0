Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Ady2d-0007XT-LW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 12:43:07 -0800
Received: from deliver.epitech.net ([163.5.0.25])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Ady2c-0002JK-WC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 12:43:07 -0800
From: jeremie le-hen <le-hen_j@epita.fr>
Subject: Re: [uml-devel] UML + skas
Message-ID: <20040106204256.GE7622@carpediem.epita.fr>
References: <20031230183331.GB2845@carpediem.epita.fr>
	<200401060258.i062wYFI023092@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401060258.i062wYFI023092@ccure.user-mode-linux.org>
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
Date: Tue, 6 Jan 2004 21:42:56 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> le-hen_j@epita.fr said:
> > But it think it would not be very difficult to make some #define
> > protection around theses structures to prevent from changing the
> > destination of `/usr/src/linux/' to a source without the SKAS patch
> > applied.
> 
> Maybe, but skas4 doesn't have this problem, and /usr/include/asm should
> point to the distro kernel headers, not whatever you have sitting in 
> /usr/src/linux (and if the distro put a kernel tree there, you should be
> building stuff somewhere else).

Ok, I understand better now.  Altough it's a bit off-topic here, I would
like to know where I can understand these subtleties.  Instinctively, I
would say that /usr/include/{asm,linux}/ need to point to the current
kernel headers in order to use an API in sync with the running kernel :
for example, imagine a kernel patch which adds the incoming and outgoing
interfaces in the tuple used by connection tracking in the NetFilter
framework ; /usr/src/linux/include/linux/netfilter_ipv4/ip_conntrack_tuple.h
would be modified, and so applications including
<linux/netfilter_ipv4/ip_conntrack_tuple.h> for any reason would not
use the correct structure.
I must be missing something, but I can't get what.  Please tell me.

Thanks in advance,
-- 
Jeremie LE HEN aka TtZ/TataZ                          jeremie.le-hen@epita.fr
                                                                 ttz@epita.fr
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
