Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsdWd-0000aG-UR
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 23:50:43 -0800
Received: from osiris.silug.org ([64.240.156.225])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AsdTH-0007Sq-Ec
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 23:47:15 -0800
From: Steven Pritchard <steve@silug.org>
Subject: Re: [uml-devel] Segfault of UML-TT on FC1
Message-ID: <20040216074701.GA6310@osiris.silug.org>
References: <20040215232525.7c2f38a8.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040215232525.7c2f38a8.zaitcev@redhat.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Feb 2004 01:47:01 -0600
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, mingo@redhat.com, jdike@karaya.com

On Sun, Feb 15, 2004 at 11:25:25PM -0800, Pete Zaitcev wrote:
> I'm trying to run uml-patch-2.6.3-rc2-1 under Fedora Core 1, kernel
> 2.4.22-1.2149.nptl, glibc 2.3.2-101.1. The uml runs in TT mode (FC1 doesn't
> have SKAS) and segfaults while trying to do
>  remap_data(UML_ROUND_DOWN(&__bss_start), UML_ROUND_UP(brk_start), 1);

Isn't this the exec-shield bug?

  http://toast.debian.net/~may/umlproject/bugs.html

It runs fine just using "i386".

Steve
-- 
Steven Pritchard - K&S Pritchard Enterprises, Inc.
Email: steve@kspei.com             http://www.kspei.com/
Phone: (618)398-7360               Mobile: (618)567-7320


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
