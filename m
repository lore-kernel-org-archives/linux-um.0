Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200312060005.hB605SAv008268@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Linux-abi and UML? 
In-Reply-To: Your message of "Fri, 28 Nov 2003 17:21:53 PST."
             <20031129012153.GA20038@ice.mudshark.org> 
References: <20031129012153.GA20038@ice.mudshark.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 05 Dec 2003 19:05:28 -0500
To: jack@mudshark.org
Cc: linux-abi-devel@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

jack@mudshark.org said:
> I'm curious as to whether it is worthwhile to pursue using Linux-ABI
> under UML, or if there is too much low level x86 evil to make it
> worthwhile. 

One issue is that lcall system calls can't be intercepted.  Fix that, and
translating the low-level x86 stuff into UML shouldn't be too hard.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
