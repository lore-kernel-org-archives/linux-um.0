Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkQfc-00067L-Pk for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jul 2004 10:02:20 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BkQfc-0008V0-9E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jul 2004 10:02:20 -0700
Message-Id: <200407131757.i6DHvZGu003047@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Sun, 04 Jul 2004 12:56:32 +0200."
	<20040704105632.DC0B378A@zion.localdomain> 
References: <20040704105632.DC0B378A@zion.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [patch 1/1] Fix malloc-use-vmalloc
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
Date: Tue, 13 Jul 2004 13:57:35 -0400
To: blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> * Avoid allocating more than one page at once: that can require moving
> pages around to have two contiguos pages, so we're better with
> vmalloc. 

Yup, makes sense.

> * Make sure we free() someway, inside __wrap_free. 

This isn't exactly right.  In the case that a buffer was allocated by kmalloc 
(through malloc), but freed when the system is coming down, and kmalloc is no 
longer operating, then you just want to do nothing. It would be very bad to
try to free it using libc free.

So, what I did is this:

	if((addr >= uml_physmem) && (addr <= high_physmem)){
		if(CAN_KMALLOC())
			kfree(ptr);
	}
	else if((addr >= start_vm) && (addr <= end_vm)){
		if(CAN_KMALLOC())
			vfree(ptr);
	}
	else __real_free(ptr);


				Jeff



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
