Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [uml-user] Re: [uml-devel] Fixing the 2.4 bugs - patches against
	2.4.24-1um 
In-Reply-To: <200407131934.i6DJYMGu003420@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.60.0407131416490.28985@tuxrocks.com>
References: <200407012050.14867.blaisorblade_spam@yahoo.it> 
	<Pine.LNX.4.58.0407071420550.9924@tuxrocks.com> 
	<200407131934.i6DJYMGu003420@ccure.user-mode-linux.org>
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
Date: Thu, 15 Jul 2004 09:39:39 -0600 (MDT)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Tue, 13 Jul 2004, Jeff Dike wrote:
> I don't think it should, unless you're profiling.  The problem is that -pg
> and regparam(3) don't (or didn't) interact nicely.  The -pg code trashed
> the arguments that regparam was passing in registers, and you'd get strange
> panics early in boot.
>
> Have you checked that this actually fixes anything?  It looks like just a
> stupid typo to me.

Yes, it is definitely a stupid typo, and I don't think this alone fixes 
anything significant, but there appears to be another bug underneath. 
Without -DUM_FASTCALL, I've been seeing the kernel panics we previously 
discussed.  There appears to be some other bug that exists at least as 
early as 2.4.24-1um, triggered when UM_FASTCALL is not defined.  I've 
verified that this is the case with the following versions:

2.4.24-1um
2.4.24-2um
2.4.24-3um
2.4.25-1um
2.4.26-1um

The panic I'm getting is very repeatable--every time I run the j2eesdk 
installer, it'll panic, but if UM_FASTCALL is defined, it runs just fine.

Frank
---------------------------------------------------------------------------
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
