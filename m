Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyfId-0004ON-0M for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:06:15 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EyfIb-0007Vj-Ss
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:06:15 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601170120.14836.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] TLS patches compilation fixups
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
Date: Tue, 17 Jan 2006 01:20:14 +0100
To: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>, "D. Bahi" <dbahi@enterasys.com>, Antoine Martin <antoine@nagafix.co.uk>

I've taken TLS patches from Jeff Dike's tree today, and made them compile in 
all SKAS/TT configurations. The errors were easy to fix, however (ever 
because I still remember my code and the comments help).

Btw, D.Bahi, your fixup patch was a bit bogus (doesn't matter when not using 
TT, however).

I've taken (and made apply) these ones:
global-ldt-sem
uml-tls-support-sc-tables
uml-clean-arch_switch
uml-add-tls-support
uml-add-tls-support-flush-empty

And added, on top of them, these ones:

fix-struct-compile (to say user_desc instead of modify_ldt_ldt_s. Will break 
on 2.4 kernel headers on the host)
compile-tt-off-indirect-set-thread-area (make the indirect_* thing compile)
remove-indirect-set-thread-area (remove that thing - should be safe it seems)

I intentionally removed "uml-add-tls-support-debug", as it's debug-only stuff 
IMHO and was used to try to make it work (IIRC).

It never works, it seems, I should check if sometimes it succeeds, indeed, I'm 
doing that with "uml-add-tls-support-debug-check-never-works" (not tested 
yet, don't run yourself unless you really want).

I hadn't written SKAS0 support when I wrote the patches, and they show it 
hasn't been added.

I will shortly publish all the updated patches (against vanilla 2.6.15) under:

http://www.user-mode-linux.org/~blaisorblade/patches/devel-guest/uml-2.6.15-tls-1

in the usual combo + splitout + signature form.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
