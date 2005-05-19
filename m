Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYlIC-0005XB-Q2	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 06:42:28 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DYlIB-000815-11	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 06:42:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] copy_from_user in SKAS mode
References: <3524bf1f0505171633edddc7@mail.gmail.com>
	<20050518150802.GB18740@ccure.user-mode-linux.org>
	<3524bf1f0505181534a2436e7@mail.gmail.com>
In-Reply-To: <3524bf1f0505181534a2436e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505191541.54932.blaisorblade@yahoo.it>
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
Date: Thu, 19 May 2005 15:41:54 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 19 May 2005 00:34, Young Koh wrote:
> Ok, let me have an example.
>
> suppose a user argument has virtual address 0xa0, corresponding UML
> physical address 0xb0, and real physical address 0x10. so, when the
> user process tries to access 0xa0 for the first time, the UML kernel
> should let host kernel know there will be 0xa0 -> 0x10 mapping.
Yes, and we only need to know the 0xa0 -> 0xb0 mapping... We currently use a 
2/3-level page table mechanism to do this lookup, to answer the latter 
question, even if we could choice any lookup mechanism, even a hash table if 
there were the need.

Also note that these numbers are unrealistic since we map one page (4k) at a 
time.
> how 
> does the UML kernel make another process's address map to the same
> physical page it has?
UML physical address are actually the offsets inside the memory backing file. 
Then the guest has simply to execute an mmap from this file with the "Uml 
physical address" as the offset; in TT mode it's done directly, in SKAS3 mode 
this is done by writing a MM_MMAP request into host's /proc/mm, in SKAS0 this 
is executed by the stub calling mmap() directly.

> and how does the UML kernel keep track of 0xa0 
> -> 0xb0 mapping? maybe the same page table mechanism as host Linux? (i
> guess so, though)

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
