Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsmTI-0001gd-Nm for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 10:28:24 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CsmTG-0000UN-Pn for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 10:28:24 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] memory
In-Reply-To: <41F36014.7050905@easyco.com>
Message-ID: <Pine.LNX.4.61.0501231605440.20896@filer.marasystems.com>
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<41F36014.7050905@easyco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Sun, 23 Jan 2005 19:27:53 +0100 (CET)
To: Doug Dumitru <doug@easyco.com>
Cc: "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>, user-mode-linux-devel@lists.sourceforge.net

On Sun, 23 Jan 2005, Doug Dumitru wrote:

> What you are trying to do will work, but not for large amounts of memory. 
> UML runs the client using a single user mode memory block as the entire 
> client's core.  Thus the clients core size is limited to what a single task 
> can allocate as plain memory.

It should be possible to work around this using the kernel HIGHMEM 
support. Would also be a good environment to verify the HIGHMEM support in 
the kernel in general.

In HIGHMEM mode the kernel doen't have the whole physical RAM mapped in 
it's address space, remapping memory as required. This doesn't increase 
the per-process limitations, but allows for the total sum or processes + 
kernel memory to be much greater.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
