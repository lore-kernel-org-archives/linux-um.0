Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsfMZ-0005oQ-60 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 02:52:59 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CsfMX-00085B-Ky
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 02:52:59 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<41F36014.7050905@easyco.com>
In-Reply-To: <41F36014.7050905@easyco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501230451.19196.rob@landley.net>
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
Date: Sun, 23 Jan 2005 04:51:19 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Doug Dumitru <doug@easyco.com>, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>

On Sunday 23 January 2005 03:28 am, Doug Dumitru wrote:

> Mr. Sharma,
>
> What you are trying to do will work, but not for large amounts of
> memory.  UML runs the client using a single user mode memory block as
> the entire client's core.  Thus the clients core size is limited to what
> a single task can allocate as plain memory.  With x86 architechure cpus,
> this is 2G or 3G depending on how you build a kernel (but usually 2G).
> There are no paging mechanism here so there is no way to make it
> "gigabytes"
>
> Others can correct me if I have the exact numbers wrong.

UML uses mmap (generally of a /tmp file) as physical memory.  This can be way 
bigger than physical memory on the machine, sure, and the parent kernel will 
transparently use the mmaped file as backing store, demand paged and all 
that.  (Just like it would for any other application.)

You could run out of virtual address space, though.  Trying to map more than a 
few gigabytes on a 32 bit machine is unlikely to work.

Might I suggest buying a cheap x86-64 system (you can get 'em at Fry's a 
couple hundred bucks), feed it a cheap 300 gigabyte IDE drive, and have fun.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
