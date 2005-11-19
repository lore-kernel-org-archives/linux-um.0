Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdcJj-0000tV-Eq for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Nov 2005 15:40:23 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EdcJf-00045x-BX
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Nov 2005 15:40:23 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Re: merge status
In-Reply-To: <200511180241.33265.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511200029570.16557@filer.marasystems.com>
References: <20051109133558.513facef.akpm@osdl.org>
	<200511180117.03742.rob@landley.net>
	<200511180851.38683.blaisorblade@yahoo.it>
	<200511180241.33265.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Sun, 20 Nov 2005 00:40:08 +0100 (CET)
To: Rob Landley <rob@landley.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 18 Nov 2005, Rob Landley wrote:

> was going on.  (And #2 was the case: once I found out it was the 0 length
> files, I could fix that.  I didn't expect 0 length files screwing up the
> #include search paths.  The #include search paths are confusing, I'm still a
> bit fuzzy on the difference between include and include2, actually...)

0-length files after patching is generally due to slightly incorrectly 
formatted patches, and can screw up a lot of things.

From the patch man page:

   you can remove a file by sending out a context diff that compares
   the file to be deleted with an empty file dated the Epoch.  The
   file will be removed unless patch is conforming to POSIX and the
   -E or --remove-empty-files option is not given.

A few other formats also works, but what is said above is the safest patch 
format for removal of files.

If you find patches which removes files using a format not complying with 
the above then it may be wise to ask the person who published the patch to 
change his routines to make correctly formatted patches. On the sad side 
there is a number of widespread tools not generating such patches 
correctly (CVS is one.. have a cleanpatch script at devel.squid-cache.org 
fixing this and a few other CVS diff -u stupidities)

Regarding the include path, Compliers, make etc just searches their paths 
until a file is found, no attempt in verifying the validity of the file is 
made. If the found file is empty then in the input at that stage is 
empty, and if the actual file which was supposed to be found is in a later 
element in the search path then you get screwed.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
