Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHB6B-0002j3-OU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 18:05:07 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CHB6A-0006kw-IU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 18:05:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120305.24675.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [patch 0/17] UML updates,
	which must be merged before 2.6.9
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
Date: Tue, 12 Oct 2004 03:05:24 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Andrew, sorry for sending these patches so late, but they are (mostly 
one-liners) needed to fix either warnings in compilation (the patches are 
safe) or probable bugs which are created by these warnings.

The Makefile patch are of another kind: actually, when I send that couple of 
patches merged before -rc3, they were against my tree and absolutely 
incorrect against Linus tree; sorry for not checking that; in fact UML does 
not link with neither -rc3 nor -rc4 (also due to a compilation bug I already 
fixed for -rc3). However, this Makefile fixes fix everything, have been 
longly tested in public (hanging both in my tree, in SuSE UML tree and in 
Jeff Dike's tree).

Finally, I'm sending a patch for a network corruption which is very nasty; 
it's a one-liner, a resync against the copied original code and I've actually 
tested it works perfectly.

So, please, even if now we are in a hurry after -rc4, merge them. It's the 
only possibility for UML to actually work "out of the box".

Oh well, and sorry for sending "[uml-devel] [patch 4/6] uml: don't declare 
cpu_online - fix compilation error" - I just noticed it's included in 
2.6.9-rc4-mm1. All the rest applies without even any offsets to that tree, 
too.

Thanks a lot for your help.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
