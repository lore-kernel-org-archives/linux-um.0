Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ct93r-00032k-0J for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 10:35:39 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Ct93n-0008BV-8S for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 10:35:38 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<200501231325.10021.rob@landley.net>
	<Pine.LNX.4.61.0501241049100.5934@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0501241049100.5934@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501241952.53795.blaisorblade@yahoo.it>
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
Date: Mon, 24 Jan 2005 19:52:53 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Rob Landley <rob@landley.net>, Doug Dumitru <doug@easyco.com>, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>

On Monday 24 January 2005 11:02, Henrik Nordstrom wrote:
> On Sun, 23 Jan 2005, Rob Landley wrote:
> > The client kernel's highmem suport is unlikely to do much, I'd think.
> > Not unless it's unmapping and remapping multiple mmaps.
It does this, indeed and sadly (that's why it's so slow).
> > (There's large 
> > file support, but trying to mmap a 5 gig chunk out of a large file can't
> > work: what would that mean?  How could you generate an offset into the
> > last meg? What would the pointer _be_?)

> off_t is 64 bits in 64-bit file pointer mode, so there is no problem to
> mmap portions of an multi-gigabyte "ram" file within a 32-bit address
> space.

Offset can sure be 64-bit wide, but he refers to mmaping a 5G-wide chunk of 
memory, and to a "pointer offset"... you cannot mmap more than 4G in memory 
even with 4G/4G. Yes, you can do it like he says (i.e. mmapping back and 
forth).

> > The parent kernel's highmem support still doesn't provide more than 4
> > gigabytes per application, and the UML kernel is one application.

> Yes, but with HIGHMEM UML in theory can provide as as much ram to each
> single process running below it as it can for a single process. So yes,
> each process in the UML would still be limited, but the total RAM usage of
> UML would be practically unlimited. And in addition a very good
> environment for debugging HIGHMEM in general as you could set up things to
> only provide a very limited directly addressible address space with the
> rest remapped by HIGHMEM.

This point holds actually.

I think however that Henrik will agree that this is not yet implemented, and 
(maybe) nor in sight... about this, I would add somebody suggested 
using /proc/mm to this aim: since a single address space is not enough to map 
all the 64 Giga on a PAE system, he suggested using multiple address spaces 
and switching between them to use memory as cache for MySQL (IIRC)... this 
was also posted on this list.

Also, since x86_64 systems are so cheap (I'm writing from one of them), x86_64 
UML is going to be a reality soon, and we're in short of manpower, the 
logical conclusion is that this is unlikely to be implemented... unless it's 
very simple; do you think that making sure the offset inside /tmp/vm_file-*** 
is 64-bit wide would be enough?

> With HIGHMEM the host process size limitations has an direct effect on the
> maximum process size possible within the UML, but not on the RAM size of
> UML. In addition running an UML with HIGHMEM support does not depend on
> the host HIGHMEM support, but performance will obviously suffer if UML
> needs to swap..

> > (And that's with the 4 gig kernel/4 gig user patches from...  Ingo
> > Molnar, I think.)
I confirm
> > Highmem lets the system as a whole use PAE (up to 64 
> > gigs physical memory), but the kernel is basically doing something very
> > like the old DOS expanded memory behind the scenes, swapping around page
> > tables so each process sees a different set of physical memory. pages
> > (The overhead isn't quite so bad since it's doing that anyway as part of
> > protecting process's memory from each other...)

> Exctaly, and UML can do something very similar with the help of mmap().
Which is too slow, though...
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
