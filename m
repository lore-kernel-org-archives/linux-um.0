Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZE07-0006jl-Sy
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 10:44:55 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZE07-0003Eq-75
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 10:44:55 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312241943.37474.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] UML build system: patch ready
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 24 Dec 2003 19:43:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: M A Young <m.a.young@durham.ac.uk>

Hey, I've finally fixed what I had to fix. So, if you have linux-2.6.0, and 
the -test9 UML patch(I've not tested against Ingo Molnar patches), go here:

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/index.html

follow THE link and download all patches (not A-04-User_obj_makefiles.patch, 
which is old and broken). I was able to build the whole kernel with them all 
applied! There are still some special files that use their specific rules, 
but that should be no problem for now. Next I'll fix them, too and try to fix 
CONFIG_MODVERSIONS(which for now must be disabled).

Michael, maybe you'd like to add it to your bug-list web page... the A-04 fix 
is not necessary for modules themselves, but it is a needed part of the 
ModVersions fix.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
