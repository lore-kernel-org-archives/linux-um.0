Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrhAJ-0007R7-3L for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 11:04:03 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BrhAI-0003nJ-H6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 11:04:02 -0700
From: Allen Chan <alydar@users.sourceforge.net>
Subject: Re: [uml-devel] Re: Incremental patches available
References: <200407301924.04914.alydar@users.sourceforge.net>
	<20040731050251.GA4909@ccure.user-mode-linux.org>
In-Reply-To: <20040731050251.GA4909@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408021404.08282.alydar@users.sourceforge.net>
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
Date: Mon, 2 Aug 2004 14:04:08 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

The multple-includes patch for 2.4.26-2um has the same issue for the 
file um/arch/um/os/drivers/ethertap_kern.c file.

On Saturday 31 July 2004 01:02 am, Jeff Dike wrote:
> > (2)  time - one of the patches included here attempts to modify
> > um/arch/um/os/Makefile.  However, that file does not exist.  It
> > looks like that file should be um/arch/um/os-Linux/Makefile.
>
> Oops, /me will fix.  I didn't notice that because I'm playing with
> a built pool which has the symlinks there.  I was trying to make
> sure I got these right, but I missed that.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
