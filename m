Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8] helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVsBW-0006yW-F3
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 15 Dec 2003 04:50:50 -0800
Message-ID: <3FDDAE15.6020409@timesys.com>
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] ANNOUNCE: SKAS patch for SuSE 8.2 (linux-2.4.20.SuSE) available
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
Date: Mon, 15 Dec 2003 07:50:29 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: timesysgpl-developers@lists.sourceforge.net

I have put a revised version of skas-2.4.21.patch.bz2 on the TimeSysGPL 
site at SourceForge:

https://sourceforge.net/tracker/index.php?func=detail&aid=860308&group_id=89531&atid=590444

This was built against  kernel-source-2.4.20.SuSE-100.i586.rpm.

The .config I used for my kernel is here:

https://sourceforge.net/tracker/index.php?func=detail&aid=860309&group_id=89531&atid=590444

Why a SuSE-specific version of the patch?  The kernel for SuSE 8.2 
already includes an earlier version of the SKAS patch, so the patch from 
Jeff does not apply cleanly.

Warning: even with this patch I have trouble using gdb.  It fails to 
identify the threads as they are created and frequently jumps from 
function to function with no discernable rationale--not unlike an 
undecected source/object mismatch.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
