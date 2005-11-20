Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdryU-00053V-8E for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Nov 2005 08:23:30 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EdryN-0002FG-4p
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Nov 2005 08:23:30 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: merge status
References: <20051109133558.513facef.akpm@osdl.org>
	<200511180241.33265.rob@landley.net>
	<Pine.LNX.4.61.0511200029570.16557@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0511200029570.16557@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511201732.45180.blaisorblade@yahoo.it>
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
Date: Sun, 20 Nov 2005 17:32:44 +0100
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net

On Sunday 20 November 2005 00:40, Henrik Nordstrom wrote:
> On Fri, 18 Nov 2005, Rob Landley wrote:
> > was going on.  (And #2 was the case: once I found out it was the 0 length
> > files, I could fix that.  I didn't expect 0 length files screwing up the
> > #include search paths.  The #include search paths are confusing, I'm
> > still a bit fuzzy on the difference between include and include2,
> > actually...)

> 0-length files after patching is generally due to slightly incorrectly
> formatted patches, and can screw up a lot of things.

> From the patch man page:

>    you can remove a file by sending out a context diff that compares
>    the file to be deleted with an empty file dated the Epoch.  The
>    file will be removed unless patch is conforming to POSIX and the
>    -E or --remove-empty-files option is not given.

> A few other formats also works, but what is said above is the safest patch
> format for removal of files.

> If you find patches which removes files using a format not complying with
> the above then it may be wise to ask the person who published the patch to
> change his routines to make correctly formatted patches. On the sad side
> there is a number of widespread tools not generating such patches
> correctly (CVS is one.. have a cleanpatch script at devel.squid-cache.org
> fixing this and a few other CVS diff -u stupidities)

Hmm, quilt, git (and IIRC BitKeeper) don't comply with the above format, but 
they use /dev/null and it seems to work in practice. Jeff's version of quilt 
seems to be broken on this (he said he's using 0.32).

> Regarding the include path, Compliers, make etc just searches their paths
> until a file is found, no attempt in verifying the validity of the file is
> made. If the found file is empty then in the input at that stage is
> empty, and if the actual file which was supposed to be found is in a later
> element in the search path then you get screwed.

This case is a little different as I already explained...

In this case the 0-lenght file, when missing, would trigger make "building 
it" (i.e. creating it as a symlink with correct content).


-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
