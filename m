Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Nicholas Nethercote <njn25@cam.ac.uk>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind
In-Reply-To: <200408030517.i735HZUE026250@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
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
Date: Tue, 3 Aug 2004 10:31:22 +0100 (BST)
To: Jeff Dike <jdike@addtoit.com>
Cc: "D. Bahi" <dbahi@enterasys.com>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

On Tue, 3 Aug 2004, Jeff Dike wrote:

> dbahi@enterasys.com said:
>> Executable is mapped outside of range (nil)-0x52c00000 valgrind:
>> do_exec(/local/dbahi/kernels/linux-2.4.26_uml-patch-2.4.26-2um/linux)
>> failed: Cannot allocate memory
>>
>> How does one get around this sudden valgrind exit?
>
> If I remember right, there is a hard-coded address in valgrind.  If the process
> loads above that you get that error.  Changing it and rebuilding doesn't seem
> to hurt anything.

It's not quite hard-coded, but close -- that address depends on another 
address that is hard-coded, unfortunately.  Programs that have to load 
pieces at high addresses don't interact well with Valgrind, which 
partitions the address space, the low part for the client program, the 
high part for Valgrind.

What address was UML trying to load something at?  Is that adjustable?

N


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
