Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200407131934.i6DJYMGu003420@ccure.user-mode-linux.org>
Subject: Re: [uml-user] Re: [uml-devel] Fixing the 2.4 bugs - patches against
	2.4.24-1um 
In-Reply-To: Your message of "Wed, 07 Jul 2004 14:51:02 MDT."
	<Pine.LNX.4.58.0407071420550.9924@tuxrocks.com> 
References: <200407012050.14867.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.58.0407071420550.9924@tuxrocks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 13 Jul 2004 15:34:22 -0400
To: Frank Sorenson <frank@tuxrocks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

frank@tuxrocks.com said:
> The configuration program will either set CONFIG_GPROF to 'y', or it
> will  put "# CONFIG_GPROF is not set" into the .config file.
> CONFIG_GPROF will  never be 'n', at least in my understanding. 

Jeez, thanks for finding that.

> I believe this bug may affect stability for a number of people, and it
> has existed since 2.4.24-2um first came out.  It may not solve any
> underlying problems, but I'd like to hear if it helps anyone else. 

I don't think it should, unless you're profiling.  The problem is that -pg
and regparam(3) don't (or didn't) interact nicely.  The -pg code trashed
the arguments that regparam was passing in registers, and you'd get strange
panics early in boot.

Have you checked that this actually fixes anything?  It looks like just a 
stupid typo to me.

				Jeff



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
