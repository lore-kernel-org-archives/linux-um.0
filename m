Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhsY0-0003GY-DB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jul 2004 09:11:56 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BhsXz-0000zq-OY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jul 2004 09:11:56 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407061320.17815.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Using madvise()/ioctl() instead of /dev/anon?
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
Date: Tue, 6 Jul 2004 13:20:17 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Well, you have started implementing /dev/anon, but you where also looking for 
a better interface.

I saw the description of madvise(MADV_DONTNEED), and it seemed to be what we 
needed, but it was not, sadly (it would discard data only from anonymous 
memory); but that gave me an idea of how to go.
What you need is to discard a dirty page from a mmap'ed tmpfs file (it is not 
worth implementing it for any other case: who wants performance needs tmpfs 
anyway); that could become a new ioctl on the file.

There are two ways:
1) A ioctl meaning "discard this page", to call onto a munmap()ed page: this 
separates the munmap() and the discard, but also increases the number of 
syscalls a little. I don't know if this increase is at all harmful: I 
consider this of low importance, since this is not performance critical IMHO.
2) A ioctl meaning "discard pages on munmap from this file": this requires 
adding file_operations-> munmap, but actually seems better for us.

The problem, in both cases, is about implementing them: it's harder than 
/dev/anon, since you need to hack tmpfs, but it will be probably more stable.

By the way: have you made sure that /dev/anon memory is swappable?

I also saw one bug: shmem_file_setup is called always with "dev/anon" as 
parameter: am I overlooking something or that will break when there are 
multiple UMLs running?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
