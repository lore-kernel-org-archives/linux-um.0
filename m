Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CfQRP-0003W7-BS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Dec 2004 14:19:15 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CfQRN-0003UD-OZ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Dec 2004 14:19:15 -0800
Message-ID: <41C35B58.9000406@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] More split-arch patches
References: <41C35164.7020001@fujitsu-siemens.com>
In-Reply-To: <41C35164.7020001@fujitsu-siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 17 Dec 2004 23:19:04 +0100
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Bodo Stroesser wrote:
> Attached are the next 4 patches, that are needed for my s390 port.
> I have done some short tests on i386 in 2.6.10-rc2-mm4 + incremental
> patches and didn't see errors.
> 
> The last patch called "faultinfo-rework is quite invasive. Thus,
> it needs further testing.
> 
> Bodo
Patch faultinfo-rework adds to userspace() in file
arch/um/kernel/skas/process.c the line

    "memset( &regs->skas.faultinfo, 0, sizeof(struct faultinfo));"

This line doesn't harm, but is useless and should be removed.
I only forgot to delete it after debugging.

Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
