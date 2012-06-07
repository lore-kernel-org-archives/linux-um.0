Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1Sccxs-0006Tr-BM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 13:41:28 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sccxr-0002Wt-Se for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 13:41:28 +0000
Message-ID: <4FD0AF72.9040003@panasas.com>
Date: Thu, 7 Jun 2012 16:41:06 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at>
	<4FCF6748.6020005@panasas.com> <4FD059AC.8050808@panasas.com>
	<4FD06A22.6040002@nod.at> <4FD07F14.50902@panasas.com>
	<4FD0802A.1020203@nod.at>
	<20120607115227.6643d1ad@pyramind.ukuu.org.uk>
In-Reply-To: <20120607115227.6643d1ad@pyramind.ukuu.org.uk>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] um: TTY fixes (?)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz, alan@linux.intel.com

On 06/07/2012 01:52 PM, Alan Cox wrote:

>> No, it works fine.
> 
> Not really. You happen to be lucky. Anyway with no tty port the UML code
> will soon cease to function completely so a solution of some sort is
> needed.
>  


This is what I understood. That mainline code moved so far that the current
UML driver was too far behind to properly function and *completely* broke.

If only breakage with new UM-TTY code is old util-linux. And we have a
ready made patch for it.

Would you please reconsider, and point the util-linux users to the fixing
patch.

Because as it stands:

Current code:
util-linux 	-	works
FC12-17		-	Broken (Patch *not* available)
Debain based	-	works

New code:
util-linux	- 	Broken, patch available
FC12-15		-	Works (with issues)
Debain based	-	works

So it is not like I'm sacrificing util-linux People
completely, but I am totally sacrificing FC People by
not committing.

Please reconsider, unless you have a patch for me for FC systems
that I can apply so I can use the old code.

Thanks again for everything, so far
Boaz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

