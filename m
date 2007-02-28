Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMW7p-0008Hy-MW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 13:14:14 -0800
Received: from smtp.andrew.cmu.edu ([128.2.10.85])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HMW7p-0003i5-7j
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 13:14:13 -0800
In-Reply-To: <20070223214058.GB7051@ccure.user-mode-linux.org>
References: <16D2BFFB-B00F-4C9D-82E4-9194D37FA95D@cmu.edu>
	<20070223214058.GB7051@ccure.user-mode-linux.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <2C6BA3F0-60D0-4DC7-80B6-D1E0C49F5924@cmu.edu>
From: Bryan Parno <parno@cmu.edu>
Date: Wed, 28 Feb 2007 16:13:28 -0500
Subject: Re: [uml-devel] Kernel access to user memory in SKAS
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Feb 23, 2007, at 4:40 PM, Jeff Dike wrote:

> On Fri, Feb 23, 2007 at 01:36:12PM -0500, Bryan Parno wrote:
>> 	I'm interested in mediating accesses by the UML guest kernel to
>> memory used by the UML guest processes.  At present, I'm looking at a
>> scenario using SKAS3, so the kernel has an address space distinct
>> from that of the user processes.  I guess I'm a bit confused as to
>> how the guest kernel actually manages to touch guest process memory
>> (e.g., for copying system call arguments).  Looking through /arch/um/
>> kernel/skas/uaccess.c, it appears that all of these accesses devolve
>> to performing a strncpy or memcpy, but I don't see a translation from
>> an address in the user's address space to one in the kernel's address
>> space.  Does this happen somewhere else, or am I misunderstanding
>> SKAS?
>
> So far, you're fine.  What you're missing is, i.e.:
>
> int copy_from_user_skas(void *to, const void __user *from, int n)
> {
> 	if(segment_eq(get_fs(), KERNEL_DS)){
> 		memcpy(to, (__force void*)from, n);
> 		return(0);
> 	}
>
> 	return(access_ok(VERIFY_READ, from, n) ?
> 	       buffer_op((unsigned long) from, n, 0, copy_chunk_from_user,  
> &to):
> 	       n);
> }
>
> The buffer_op case handles userspace memory.  It does the following:
> 	figures out where in kernel physical memory the userspace data is
> 	breaks the operation across pages if necessary
> 	wraps enough state around the operation to be able to handle
> page faults and finish it after the page has been faulted in
>
> 				Jeff
>
> -- 
> Work email - jdike at linux dot intel dot com
>


   Cool, thanks for the pointer.



                        Bryan



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
