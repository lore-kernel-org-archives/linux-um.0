Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ct2LJ-0007bk-AO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 03:25:13 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Ct2LI-0002T6-MV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 03:25:13 -0800
Message-ID: <41F4DC94.7030900@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<200501240111.j0O1BtoI004687@ccure.user-mode-linux.org>
	<200501240010.23514.rob@landley.net>
	<Pine.LNX.4.61.0501241103350.5934@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0501241103350.5934@filer.marasystems.com>
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
Date: Mon, 24 Jan 2005 12:31:32 +0100
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>, Doug Dumitru <doug@easyco.com>

Henrik Nordstrom wrote:
> On Mon, 24 Jan 2005, Rob Landley wrote:
> 
>> Interesting.  I wonder how that works?  (PAE on x86 only lets you have 
>> 64G.)
> 
> 
> Thats only an limitation of the CPU support for PAE. As UML is using 
> mmap() other limits apply and these limits is mainly set by the UML 
> pagetable structures.
> 
>> But an individual process running under UML can still only have 4 
>> gigabytes.
> 
> 
> Not even that as we do not have a 4GB/4GB split in UML.
> 
>>>> What would the pointer _be_?)
>>>
>>>
>>> What pointer?
>>
>>
>> The virtual or physical address used to access memory.  (I'm guessing
>> userspace programs running under UML are limited to 4 gigs, and UML is 
>> using
>> page indexes and is thus limited to 4 billion pages, not 4 billion 
>> bytes.)
> 
> 
> In theory UML HIGHMEM could be made to support even more pages, but it's 
> besides the point.
I agree with nearly all of your good explanations, but have to write my
objection to this one.
Yes, using 3-level pagetables and mmap64, uml can access very much pagetables.
But that's not all, what's needed to have *support* for big memory.
Linux needs to have one struct page for each physical mem page, which in the
simple case of UML are placed in one memmap array.
This array needs to be accessible permanently to the kernel, i.e. it
has to be in low-mem. AFAIK, one struct page is 44 bytes in size, thus the
array is about 1% of the entire physical mem in size.
Assume we are using skas3 on a 3GB/1GB host that provides 3GB address space
for user processes (i.e. 3GB address space for UML-Kernel, too). Let the UML
kernel need about 1GB for code, vmalloc-area and data, that also need to reside
in lowmem. Then, there remain 2GB space for the page-structures, which limits
supportable memory to about 200GB.
That still is very much compared to i386, where on a 3GB/1GB host kernels
address space is 1GB only. Since memmap shouldn't use more than about one third
of this, i386 can support max. about 32GB of physical memory (some people talk
about 16GB only).
BTW: This is the reason for having the 2GB/2GB option in i386.

      Bodo
> 
>> Just large file support, and the ability to mmap up to 4 gigs of 
>> memory at a
>> time (with a starting offset potentially above 4 gigabytes), and unmap 
>> it and
>> map a different 4 gigs when you switch to the next process...
>>
>> Makes my brain hurt just thinking about it, but that could be caffeine
>> withdrawl...
> 
> 
> Thinking of HIGHMEM does hurt by design as you no longer have the 
> equivalence of pointers to userspace in kernel land and must explicitly 
> ask to have the needed userspace areas mapped/unmapped as needed, giving 
> you the required pointers..
> 
> Most of this is dealt with automatically in copy_to/from_user, but some 
> parts of the kernel uses other means to access userspace data and thus 
> need to be very careful.
> 
> Regards
> Henrik
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
