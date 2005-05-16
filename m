Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXnyr-0001w1-Gd	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 15:22:33 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DXnpl-0003vc-BW	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 15:16:50 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200505170005.43629.blaisorblade@yahoo.it>
Subject: [uml-devel] uml-general-protection-fault even more kludgy but
	mergeable
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
Date: Tue, 17 May 2005 00:05:43 +0200
To: Gerd Knorr <kraxel@bytesex.org>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

About 2.6.11-rc4/uml-general-protection-fault:

Ok, today I was looking a bit more to this patch and I even looked in the 
Intel manuals.

I effectively verified that, in case of a page fault (do_page_fault) the 
kernel only sends a SIGSEGV to the process if (error_code & 4 != 0), as 
expected.

So, if (!(error_code & 4)), we cannot be handling a page fault at all.

However, the comment in the patch is a bit misleading (or misleaded) because 
error_code has a different format for everything else than protection faults. 
(See section 5.13, Error code, of manual "Intel System Programming Guide - 
253668 -15.pdf", order number 253668-15).

In that case, in fact, it will be unused (and hence, probably, set to 0) when 
the error code references the IDT descriptor, it will be clear when the GDT 
is referenced, it will be set when the LDT is referenced (always by the error 
code).

So, in practice, it's correct to call bad_segv() as done in the patch, but we 
miss some cases. Only this time I've verified this well enough that I feel we 
could merge your patch. However, I've not found any possible *realistic* 
source of general protection faults. Especially I didn't find what expected 
(i.e. I/O errors).
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
