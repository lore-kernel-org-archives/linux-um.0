Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ct1Cu-0004eE-Lk for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 02:12:28 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Ct1Ct-0003om-Uh for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 02:12:28 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] memory
In-Reply-To: <200501240010.23514.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0501241103350.5934@filer.marasystems.com>
References: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
	<200501240111.j0O1BtoI004687@ccure.user-mode-linux.org>
	<200501240010.23514.rob@landley.net>
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
Date: Mon, 24 Jan 2005 11:12:25 +0100 (CET)
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>, Doug Dumitru <doug@easyco.com>

On Mon, 24 Jan 2005, Rob Landley wrote:

> Interesting.  I wonder how that works?  (PAE on x86 only lets you have 64G.)

Thats only an limitation of the CPU support for PAE. As UML is using 
mmap() other limits apply and these limits is mainly set by the UML 
pagetable structures.

> But an individual process running under UML can still only have 4 gigabytes.

Not even that as we do not have a 4GB/4GB split in UML.

>>> What would the pointer _be_?)
>>
>> What pointer?
>
> The virtual or physical address used to access memory.  (I'm guessing
> userspace programs running under UML are limited to 4 gigs, and UML is using
> page indexes and is thus limited to 4 billion pages, not 4 billion bytes.)

In theory UML HIGHMEM could be made to support even more pages, but it's 
besides the point.

> Just large file support, and the ability to mmap up to 4 gigs of memory at a
> time (with a starting offset potentially above 4 gigabytes), and unmap it and
> map a different 4 gigs when you switch to the next process...
>
> Makes my brain hurt just thinking about it, but that could be caffeine
> withdrawl...

Thinking of HIGHMEM does hurt by design as you no longer have the 
equivalence of pointers to userspace in kernel land and must explicitly 
ask to have the needed userspace areas mapped/unmapped as needed, giving 
you the required pointers..

Most of this is dealt with automatically in copy_to/from_user, but some 
parts of the kernel uses other means to access userspace data and thus 
need to be very careful.

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
