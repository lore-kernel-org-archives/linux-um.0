Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ct6uI-0004LM-PJ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 08:17:38 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Ct6uH-0006Ub-83 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 08:17:38 -0800
Message-ID: <41F52128.6080202@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<200501240111.j0O1BtoI004687@ccure.user-mode-linux.org>
	<200501240010.23514.rob@landley.net>
	<Pine.LNX.4.61.0501241103350.5934@filer.marasystems.com>
	<41F4DC94.7030900@fujitsu-siemens.com>
	<200501241811.j0OIBYXk002874@ccure.user-mode-linux.org>
In-Reply-To: <200501241811.j0OIBYXk002874@ccure.user-mode-linux.org>
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
Date: Mon, 24 Jan 2005 17:24:08 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>, Doug Dumitru <doug@easyco.com>

Jeff Dike wrote:
> bstroesser@fujitsu-siemens.com said:
> 
>>But that's not all, what's needed to have *support* for big memory.
>>Linux needs to have one struct page for each physical mem page, which
>>in the simple case of UML are placed in one memmap array. 
> 
> 
> The original poster is interested in the memory scalability of Linux, so
> presumably he'll be looking into things like this :-)
> 
> And it's not only this.  It's the kernel stacks and page tables you'll have
> for all the processes you'll be running on this large machine, inodes and other
> file system data for all the files they have open, etc.
Yes. That's the reason, why I estimated 1GB of memory for kernels internal use,
additionally to the memmap.

> 
> 				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
