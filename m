Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkS6A-0000KR-Kr for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jul 2004 11:33:50 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BkS6A-0005tL-1T
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jul 2004 11:33:50 -0700
Message-Id: <200407131929.i6DJT2Gu003407@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Using madvise()/ioctl() instead of /dev/anon? 
In-Reply-To: Your message of "Tue, 06 Jul 2004 13:20:17 +0200."
	<200407061320.17815.blaisorblade_spam@yahoo.it> 
References: <200407061320.17815.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 13 Jul 2004 15:29:01 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> There are two ways: 
> 1) A ioctl meaning "discard this page", to call
> onto a munmap()ed page: this  separates the munmap() and the discard,
> but also increases the number of  syscalls a little. I don't know if
> this increase is at all harmful: I  consider this of low importance,
> since this is not performance critical IMHO. 
> 2) A ioctl meaning
> "discard pages on munmap from this file": this requires  adding
> file_operations-> munmap, but actually seems better for us. 

ioctls are frowned upon since they are inherently unstructured.  If you need
special semantics for something, a new driver/filesystem is generally preferred.

I'm not saying that hacking on tmpfs is the right way to go necessarily, but
I think it's better than adding ioctls to something.

A new madvise option might be a possibility, but I still like a special driver
better.

> By the way: have you made sure that /dev/anon memory is swappable? 

Yeah, tmpfs is swappable, and devanon does nothing to change that.

> I also saw one bug: shmem_file_setup is called always with "dev/anon"
> as  parameter: am I overlooking something or that will break when
> there are  multiple UMLs running? 

Every new open will give you a new devanon instance.  The name is just there
to give /proc/<pid>/maps and /proc/<pid>/fd something to print.

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
