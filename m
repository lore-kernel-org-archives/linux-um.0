Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsqXD-0002XM-5b for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 14:48:43 -0800
Received: from pool-151-203-197-142.bos.east.verizon.net ([151.203.197.142]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CsqXA-00045B-Ba
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 14:48:43 -0800
Message-Id: <200501240111.j0O1BtoI004687@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] memory 
In-Reply-To: Your message of "Sun, 23 Jan 2005 12:16:34 +0530."
	<267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com> 
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Sun, 23 Jan 2005 20:11:55 -0500
To: "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>, Doug Dumitru <doug@easyco.com>

Vaibhavs@noida.hcltech.com said:
> I have to build a simulator, to check the scalability limits in memory
> management of linux. For this, the simulator  will provide a large
> amount of RAM (in GBs), even if the amout of physical memory is only
> 512MB. 
>
> Can UML be used for this purpose? I had seen the "mem" option in the
> kernel switches option of UML. Can UML simulate such a case? 

Yes, it should be fine for what you want.

> If it
> does, how UML handles this? Specifically, can the UML kernel allocate
> all this amount of memory

It'll allocate a temp file of the appropriate size.  If it's larger than what
it can use for physical memory, the rest will be allocated as highmem.  If
you leave 2-level pagetables on, then you're limited to 4G. If you turn on
3-level pagetables, then you get up to 128G.  

doug@easyco.com said:
> UML runs the client using a single user mode memory block as  the
> entire client's core.  Thus the clients core size is limited to what
> a single task can allocate as plain memory.

No, it only maps the physical memory as a block.  The highmem part is mapped
on demand, as with i386.

rob@landley.net said:
> You could run out of virtual address space, though.  Trying to map
> more than a  few gigabytes on a 32 bit machine is unlikely to work. 

With highmem, it's not all mapped at once.

rob@landley.net said:
> Not  unless it's unmapping and remapping multiple mmaps.  

It is.

> (There's
> large file  support, but trying to mmap a 5 gig chunk out of a large
> file can't work:  

It does it a page at a time.

> what would that mean?  How could you generate an
> offset into the last meg?   

The LFS interfaces take 64-bit offsets.

> What would the pointer _be_?)

What pointer?

> The parent kernel's highmem support still doesn't provide more than 4
> gigabytes per application, and the UML kernel is one application.

The host kernel's highmem support is totally irrelevant.  There doesn't even
need to be highmem support on the host.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
