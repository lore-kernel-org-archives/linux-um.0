Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ct4X4-0004u2-8B for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 05:45:30 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Ct4X3-0001bf-Mi
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 05:45:30 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B7317C@exch-03.noida.hcltech.com>
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB03B7317C@exch-03.noida.hcltech.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501240743.48398.rob@landley.net>
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
Date: Mon, 24 Jan 2005 07:43:48 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>

On Monday 24 January 2005 03:13 am, Vaibhav  Sharma, Noida wrote:
> According to the design of UML, it has its own VM system. If I have to
> check the scalability limits of the "parent kernel" for memory management,
> will UML be useful..?

Jeff Dike already answered this.  (He's the UML maintainer.)  UML _does_ remap 
a different chunk out of the physical memory backing file when it schedules a 
different process.  UML uses mmap to get its memory, so as long as the parent 
kernel has Large File Support (which lets a 32 bit machine use 64 bit file 
offsets, this is pretty widely deployed because people need a single file to 
be larger than INT_MAX, which is 2 gigabytes since file offsets are signed 
for some reason), and the UML instance is configured to use highmem (which is 
what unmaps and remaps the memory on a schedule) and at least 3 level page 
tables (so it doesn't run out of PTEs), UML shouldn't be limited to 32 bits 
of (simulated) physical memory.  Not that I've tried this. :)

An individual process running under a 32-bit UML would still only be able to 
access 4 gigabytes or less.  (It has a 32 bit virtual address space, after 
all...)  And since I'm unaware of any version of UML using the 4 gig/4 gig 
patch, I suspect UML might fill up its kernel memory area with page table 
entries eventually...  (Was Dave Jones's shared page table patch ever 
integrated?  Are linux page tables swappable?)

> When I debug the UML kernel when a process requests a large amount of
> memory, I will only get the flow used by UML for its VM. Is the code/design
> of UML very different from the parent kernel..?

UML uses mmap on a file to simulate an MMU.  It shouldn't care what kind of 
physical memory the parent kernel has.  But Jeff's the expert here.

However running 'find arch/um -name "*.c" | xargs grep mmap' in your linux 
source directory should get you started.

> (I may be totally wrong in this mail, please do correct me...)

I'm not the world's greatest source of info here either, I've only been 
playing with UML for a little while...

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
