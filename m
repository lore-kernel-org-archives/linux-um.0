Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsnNq-0003ln-A1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 11:26:50 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CsnNo-00059s-Mb
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 11:26:50 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<41F36014.7050905@easyco.com>
	<Pine.LNX.4.61.0501231605440.20896@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0501231605440.20896@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501231325.10021.rob@landley.net>
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
Date: Sun, 23 Jan 2005 13:25:10 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Doug Dumitru <doug@easyco.com>, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>

On Sunday 23 January 2005 01:27 pm, Henrik Nordstrom wrote:
> On Sun, 23 Jan 2005, Doug Dumitru wrote:
> > What you are trying to do will work, but not for large amounts of memory.
> > UML runs the client using a single user mode memory block as the entire
> > client's core.  Thus the clients core size is limited to what a single
> > task can allocate as plain memory.
>
> It should be possible to work around this using the kernel HIGHMEM
> support. Would also be a good environment to verify the HIGHMEM support in
> the kernel in general.

The client kernel's highmem suport is unlikely to do much, I'd think.  Not 
unless it's unmapping and remapping multiple mmaps.  (There's large file 
support, but trying to mmap a 5 gig chunk out of a large file can't work: 
what would that mean?  How could you generate an offset into the last meg?  
What would the pointer _be_?)

The parent kernel's highmem support still doesn't provide more than 4 
gigabytes per application, and the UML kernel is one application.  (And 
that's with the 4 gig kernel/4 gig user patches from...  Ingo Molnar, I 
think.)  Highmem lets the system as a whole use PAE (up to 64 gigs physical 
memory), but the kernel is basically doing something very like the old DOS 
expanded memory behind the scenes, swapping around page tables so each 
process sees a different set of physical memory. pages  (The overhead isn't 
quite so bad since it's doing that anyway as part of protecting process's 
memory from each other...)

Hence the x86-64 system.  They really are getting cheap these days.  And when 
the PS3 comes out, that's going to be a 64 bit (mutant) Power PC for 
somewhere around $300 fully loaded, which runs Linux internally.  (Probably 
with binary only drivers out the wazoo, but still...)

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
