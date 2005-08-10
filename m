Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ZEM-0003tm-01	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 06:05:50 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E3ZEL-0001sy-DB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 06:05:50 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508102136.43763.blaisorblade@yahoo.it>
Subject: [uml-devel] madvise(DONTNEED) on tmpfs pages instead of /dev/anon
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
Date: Wed, 10 Aug 2005 21:36:43 +0200
To: Jeff Dike <jdike@addtoit.com>, Rik van Riel <riel@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

UML would need to free file-backed pages anonymously mapped from the host 
memory. In all relevant cases, those pages are file-backed from tmpfs (or 
ramfs, but that can also be excluded)

About this, I was thinking back to what Rik said in Ottawa at the OLS. He said 
"just use madvise(DONTNEED) on it", but I remarked that the pages were 
file-backed.

Actually, however, since backing store for tmpfs is just pagecache/swapcache 
memory,

I have the doubt that madvise(DONTNEED) already does what we need, and if not 
that it might be easily fixed (since zap_page_range->unmap_vmas -> 
unmap_page_range accept a range of pages to be flushed - that was a recent 
change from Hugh Dickins).

For UML, the patch to use this support should be trivial (given in 
pseudocode):

+//remember virt, is an address in the (guest) kernel page range
int physmem_remove_mapping(void *virt)
{
        struct phys_desc *desc;

        virt = (void *) ((unsigned long) virt & PAGE_MASK);
        desc = find_phys_mapping(virt);
-        if(desc == NULL)
-                return(0);
+        if(desc == NULL) {
+                madvise(virt, PAGE_SIZE, MADV_DONTNEED);
+                return 0;
+       }

        remove_mapping(desc);
        return(1);
}

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
