Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ct135-0004Az-4p for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 02:02:19 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Ct133-0002jS-6w for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 02:02:19 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] memory
In-Reply-To: <200501231325.10021.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0501241049100.5934@filer.marasystems.com>
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<41F36014.7050905@easyco.com>
	<Pine.LNX.4.61.0501231605440.20896@filer.marasystems.com>
	<200501231325.10021.rob@landley.net>
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
Date: Mon, 24 Jan 2005 11:02:14 +0100 (CET)
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Henrik Nordstrom <uml@hno.marasystems.com>, Doug Dumitru <doug@easyco.com>, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>

On Sun, 23 Jan 2005, Rob Landley wrote:

> The client kernel's highmem suport is unlikely to do much, I'd think. 
> Not unless it's unmapping and remapping multiple mmaps. (There's large 
> file support, but trying to mmap a 5 gig chunk out of a large file can't 
> work: what would that mean?  How could you generate an offset into the 
> last meg? What would the pointer _be_?)

off_t is 64 bits in 64-bit file pointer mode, so there is no problem to 
mmap portions of an multi-gigabyte "ram" file within a 32-bit address 
space.

> The parent kernel's highmem support still doesn't provide more than 4
> gigabytes per application, and the UML kernel is one application.

Yes, but with HIGHMEM UML in theory can provide as as much ram to each 
single process running below it as it can for a single process. So yes, 
each process in the UML would still be limited, but the total RAM usage of 
UML would be practically unlimited. And in addition a very good 
environment for debugging HIGHMEM in general as you could set up things to 
only provide a very limited directly addressible address space with the 
rest remapped by HIGHMEM.

With HIGHMEM the host process size limitations has an direct effect on the 
maximum process size possible within the UML, but not on the RAM size of 
UML. In addition running an UML with HIGHMEM support does not depend on 
the host HIGHMEM support, but performance will obviously suffer if UML 
needs to swap..

> (And that's with the 4 gig kernel/4 gig user patches from...  Ingo 
> Molnar, I think.)  Highmem lets the system as a whole use PAE (up to 64 
> gigs physical memory), but the kernel is basically doing something very 
> like the old DOS expanded memory behind the scenes, swapping around page 
> tables so each process sees a different set of physical memory. pages 
> (The overhead isn't quite so bad since it's doing that anyway as part of 
> protecting process's memory from each other...)

Exctaly, and UML can do something very similar with the help of mmap().

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
