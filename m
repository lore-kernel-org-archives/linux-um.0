Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXg1U-0004HL-4F	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 06:52:44 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DXg1P-0000Mw-Qe	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 06:52:44 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505152044.44400.blaisorblade@yahoo.it>
Subject: [uml-devel] Removing call to function pointer in inner loop of
	copy_from_user()
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
Date: Sun, 15 May 2005 20:44:44 +0200
To: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

copy_from_user() loops, in SKAS mode, calls do_op inside the inner loop; do_op 
acts on 4k at once, so with modern pipelines, the potential cost of the 
function call can be very big.

Beyond that, we also call setjmp_wrapper, which simply puts a sigjmp_buf on 
the stack.

Wouldn't the code be cleaner if we rip that out, together with the va_arg() 
calls, and do everything inside do_buffer_op? Doh, those are from userspace 
headers. However it looks they would be includable from kernel code (no 
reference to kernel headers), by adding them at the end of the include search 
path.

Also, could I then turn it into a macro taking a param, and then inline the 
do_op calls (which are very little ones), or at least turn them into normal 
calls (i.e. faster ones). I feel like the resulting code could even be 
cleaner to read. Yes, more wasted space, but I think we win in the trade-off.

What's your opinion? I'm ready to work on this.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
