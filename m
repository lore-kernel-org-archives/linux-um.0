Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200402132057.i1DKvWsq003387@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Fri, 30 Jan 2004 21:44:49 +0100."
             <401AC241.1080205@darkman.de> 
References: <401AC241.1080205@darkman.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [uml-user] [PATCH] mconsole log doesn't work correctly
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
Date: Fri, 13 Feb 2004 15:57:32 -0500
To: Sven 'Darkman' Michels <sven@darkman.de>
Cc: UML devel list <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net

sven@darkman.de said:
> a small patch for the mconsole_log function: just add an \n at the end
> of every line cause otherwise sys/klogd won't notice the line (at
> least not immedially). 

Fixed, in a slightly different way, thanks.  This will require the next
version of uml_mconsole as well, since I mostly fixed it there.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
